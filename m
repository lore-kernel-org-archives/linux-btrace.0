From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Thu, 22 Jan 2009 18:55:35 +0000
Subject: [PATCH]  Increased limits to allow for large system runs
Message-Id: <4978C127.3060307@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030106080903040601060402"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------030106080903040601060402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------030106080903040601060402
Content-Type: text/x-diff;
 name="0001-Increased-limits-to-allow-for-large-system-runs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Increased-limits-to-allow-for-large-system-runs.patch"

On 16-way w/ 104 disks and a 32-way w/ 96 disks, I was getting:

$ sudo blktrace -b 1024 -n 8 -I ../files
./cciss_c1d6.blktrace.10: Too many open files
Failed to start worker threads

Due to the nature of our N(cpus) X N(devices) order of file opens, and
our N(cpus) X N(devices) X N(buffers) X (buffer size) amount of mmaps()
going on we're exceeding both the RLIMIT_NOFILE and RLIMIT_MEMLOCK
limits.

This patch raises limits for RLIMIT_NOFILE and RLIMIT_MEMLOCK to
"infinity", and allows blktrace to handle the large(ish) systems. (If
these settings fail, we "guestimate" about how much we really need.)

There is still an underlying blktrace and/or kernel problem: The
directory /sys/kernel/debug/block/<DSF> where <DSF> is the device that
encountered the limit is left behind (not cleaned up correctly). This
stops blktrace from running a second time (even on another device):

$  ls /sys/kernel/debug/block
cciss_c1d6
$ sudo blktrace /dev/sda
BLKTRACESETUP: No such file or directory
Failed to start trace on /dev/sda

and requires a reboot. (Looking into that next, as this patch - whilst
stopping the original problem from happening - does not address the
secondary problem. And there may be some other ways for the secondary
problem to still occur...)

I also fixed a warning concerning ftruncate's return value being
ignored.

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 blktrace.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index 7e27f14..afcc42f 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -43,6 +43,7 @@
 #include <arpa/inet.h>
 #include <netdb.h>
 #include <sys/sendfile.h>
+#include <sys/resource.h>
 
 #include "blktrace.h"
 #include "barrier.h"
@@ -347,6 +348,51 @@ static int net_connects;
 
 static int *net_out_fd;
 
+/*
+ * For large(-ish) systems, we run into real issues in our
+ * N(devs) X N(cpus) algorithms if we are being limited by arbitrary
+ * resource constraints.
+ *
+ * We try to set our limits to infinity, if that fails, we guestimate a max
+ * needed and try that.
+ */
+static int increase_limit(int r, rlim_t val)
+{
+	struct rlimit rlim;
+
+	rlim.rlim_cur = rlim.rlim_max = RLIM_INFINITY;
+	if (setrlimit(r, &rlim) < 0) {
+		rlim.rlim_cur = rlim.rlim_max = val;
+		if (setrlimit(r, &rlim) < 0) {
+			perror(r == RLIMIT_NOFILE ? "NOFILE" : "MEMLOCK");
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ *
+ * For the number of files: we need N(devs) X N(cpus) for:
+ *	o  ioctl's
+ *	o  read from /sys/kernel/debug/...
+ *	o  write to blktrace output file
+ *	o  Add some misc. extras - we'll muliply by 4 instead of 3
+ *
+ * For the memory locked, we know we need at least
+ *		N(devs) X N(cpus) X N(buffers) X buffer-size
+ * 	we double that for misc. extras
+ */
+static int increase_limits(void)
+{
+	rlim_t nofile_lim = 4 * ndevs * ncpus;
+	rlim_t memlock_lim = 2 * ndevs * ncpus * buf_nr * buf_size;
+
+	return increase_limit(RLIMIT_NOFILE, nofile_lim) != 0 ||
+	       increase_limit(RLIMIT_MEMLOCK, memlock_lim) != 0;
+}
+
 static void handle_sigint(__attribute__((__unused__)) int sig)
 {
 	struct device_information *dip;
@@ -659,7 +705,9 @@ static void tip_ftrunc_final(struct thread_information *tip)
 		if (tip->fs_buf)
 			munmap(tip->fs_buf, tip->fs_buf_len);
 
-		ftruncate(ofd, tip->fs_size);
+		if (ftruncate(ofd, tip->fs_size) < 0)
+			fprintf(stderr, "Ignoring error: ftruncate:  %d/%s\n",
+				errno, strerror(errno));
 	}
 }
 
@@ -1924,6 +1972,15 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
+	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
+	if (ncpus < 0) {
+		fprintf(stderr, "sysconf(_SC_NPROCESSORS_ONLN) failed\n");
+		return 1;
+	}
+
+	if (increase_limits() != 0)
+		return 1;
+
 	if (act_mask_tmp != 0)
 		act_mask = act_mask_tmp;
 
@@ -1949,12 +2006,6 @@ int main(int argc, char *argv[])
 		return 0;
 	}
 
-	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
-	if (ncpus < 0) {
-		fprintf(stderr, "sysconf(_SC_NPROCESSORS_ONLN) failed\n");
-		return 1;
-	}
-
 	signal(SIGINT, handle_sigint);
 	signal(SIGHUP, handle_sigint);
 	signal(SIGTERM, handle_sigint);
-- 
1.5.6.3


--------------030106080903040601060402--
