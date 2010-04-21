From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 21 Apr 2010 04:00:04 +0000
Subject: Recent changes
Message-Id: <20100421040004.3CB4637A0C9@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 014b0ea19762341e217d463308710c3662d50e9c:

  Merge branch 'master' of ssh://router.home.kernel.dk/data/git/blktrace (2010-04-19 19:15:27 +0200)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Edward Shishkin (5):
      blktrace: avoid device duplication
      blktrace: print correct usage
      blktrace: add back conversion
      blktrace: update blkiomon doc
      blktrace: disable kill option - take 2

 blkparse.c          |    2 +-
 blktrace.c          |   12 ++++++++++--
 btreplay/btreplay.c |   13 +++++++++++--
 btt/args.c          |    3 +--
 doc/blkiomon.8      |    2 ++
 doc/blktrace.8      |   24 ++++--------------------
 6 files changed, 29 insertions(+), 27 deletions(-)

---

Diff of recent changes:

diff --git a/blkparse.c b/blkparse.c
index 9bd8023..ffad9b6 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2702,7 +2702,7 @@ static char usage_str[] =    "\n\n" \
 
 static void usage(char *prog)
 {
-	fprintf(stderr, "Usage: %s %s %s", prog, blkparse_version, usage_str);
+	fprintf(stderr, "Usage: %s %s", prog, usage_str);
 }
 
 int main(int argc, char *argv[])
diff --git a/blktrace.c b/blktrace.c
index b4c919d..b9f9b68 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -442,7 +442,6 @@ static char usage_str[] = \
 	"\t-r Path to mounted debugfs, defaults to /sys/kernel/debug\n" \
 	"\t-o File(s) to send output to\n" \
 	"\t-D Directory to prepend to output file names\n" \
-	"\t-k Kill a running trace\n" \
 	"\t-w Stop after defined time, in seconds\n" \
 	"\t-a Only trace specified actions. See documentation\n" \
 	"\t-A Give trace mask as a single value. See documentation\n" \
@@ -493,7 +492,7 @@ static inline void pdc_nev_update(struct devpath *dpp, int cpu, int nevents)
 
 static void show_usage(char *prog)
 {
-	fprintf(stderr, "Usage: %s %s %s", prog, blktrace_version, usage_str);
+	fprintf(stderr, "Usage: %s %s", prog, usage_str);
 }
 
 /*
@@ -1200,8 +1199,17 @@ static int add_devpath(char *path)
 {
 	int fd;
 	struct devpath *dpp;
+	struct list_head *p;
 
 	/*
+	 * Verify device is not duplicated
+	 */
+	__list_for_each(p, &devpaths) {
+	       struct devpath *tmp = list_entry(p, struct devpath, head);
+	       if (!strcmp(tmp->path, path))
+		        return 0;
+	}
+	/*
 	 * Verify device is valid before going too far
 	 */
 	fd = my_open(path, O_RDONLY | O_NONBLOCK);
diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index 2d122ca..cba099a 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -1314,6 +1314,8 @@ static void reset_input_file(struct thr_info *tip)
  */
 static void *replay_sub(void *arg)
 {
+        int i;
+	char *mdev;
 	char path[MAXPATHLEN];
 	struct io_bunch bunch;
 	struct thr_info *tip = arg;
@@ -1321,8 +1323,15 @@ static void *replay_sub(void *arg)
 
 	pin_to_cpu(tip);
 
-	sprintf(path, "/dev/%s", map_dev(tip->devnm));
-
+	mdev = map_dev(tip->devnm);
+	sprintf(path, "/dev/%s", mdev);
+	/*
+	 * convert underscores to slashes to
+	 * restore device names that have larger paths
+	 */
+	for (i = 0; i < strlen(mdev); i++)
+	        if (path[strlen("/dev/") + i] = '_')
+		        path[strlen("/dev/") + i] = '/';
 #ifdef O_NOATIME
 	oflags = O_NOATIME;
 #else
diff --git a/btt/args.c b/btt/args.c
index 137c2f5..5c5078a 100644
--- a/btt/args.c
+++ b/btt/args.c
@@ -244,8 +244,7 @@ static char usage_str[] = \
 
 static void usage(char *prog)
 {
-	fprintf(stderr, "Usage: %s %s %s", prog, bt_timeline_version,
-		usage_str);
+	fprintf(stderr, "Usage: %s %s", prog, usage_str);
 }
 
 static FILE *setup_ofile(char *fname)
diff --git a/doc/blkiomon.8 b/doc/blkiomon.8
index dbed0df..aa5ece2 100644
--- a/doc/blkiomon.8
+++ b/doc/blkiomon.8
@@ -17,6 +17,8 @@ blkiomon is a block device I/O monitor. It periodically generates per-device
 request size and request latency statistics from blktrace data. It provides
 histograms as well as data that can be used to calculate min, max, average
 and variance. For this purpose, it consumes D and C traces read from stdin.
+Note, that this doesn't work for logical volumes, as high-level drivers
+don't see the completion of the events (C).
 
 There are options for binary output and human-readable output to files and
 stdout. Output to a message queue is supported as well.
diff --git a/doc/blktrace.8 b/doc/blktrace.8
index 58e8f90..ab6a3f3 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -66,19 +66,10 @@ blktrace may also be run concurrently with blkparse to produce
 .TP 2
 \- 
 The default behaviour for blktrace is to run forever until explicitly
-killed by the user (via a control-C, or kill utility invocation).
-There are two ways to modify this:
-
-.TP 5
-  1. 
-You may utilise the blktrace utility itself to kill
-a running trace -- via the \fB\-k\fR option.
-
-.TP 5
-  2.
-You can specify a run-time duration for blktrace via the
-\fB\-w\fR option -- then blktrace will run for the specified number
-of seconds, and then halt.
+killed by the user (via a control-C, or sending SIGINT signal to the
+process via invocation the kill (1) utility). Also you can specify a
+run-time duration for blktrace via the \fB\-w\fR option -- then
+blktrace will run for the specified number of seconds, and then halt.
 
 
 .SH OPTIONS
@@ -119,13 +110,6 @@ Adds \fIdev\fR as a device to trace
 Adds the devices found in \fIfile\fR as devices to trace
 .RE
 
-\-k 
-.br
-\-\-kill 
-.RS
-Kill on-going trace  
-.RE
-
 \-n \fInum\-sub\fR 
 .br
 \-\-num\-sub=\fInum-sub\fR    
