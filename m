From: Nathan Zimmer <nzimmer@sgi.com>
Date: Mon, 15 Apr 2013 14:53:34 +0000
Subject: [PATCH 3/5] btreplay: use sysconf to get the number of configured cpus
Message-Id: <1366037616-20159-4-git-send-email-nzimmer@sgi.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

We should use the standard methods for getting the number of cpus in the
system when they are available.  It is good practice to leave the old ways in
place for people stuck on older systems.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Nathan Zimmer <nzimmer@sgi.com>
---
 btreplay/btreplay.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index 6f0ba63..fe6cd80 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -502,6 +502,9 @@ static inline void start_iter(void)
  */
 static void get_ncpus(void)
 {
+#ifdef _SC_NPROCESSORS_CONF
+	ncpus = sysconf(_SC_NPROCESSORS_CONF);
+#else
 	long last_cpu;
 	cpu_set_t cpus;
 
@@ -515,6 +518,7 @@ static void get_ncpus(void)
 		if (CPU_ISSET( last_cpu, &cpus) ) 
 			ncpus = last_cpu;
 	ncpus++;
+#endif
 	if (ncpus = 0) {
 		fatal(NULL, ERR_SYSCALL, "Insufficient number of CPUs\n");
 		/*NOTREACHED*/
-- 
1.8.1.2

