From: Nathan Zimmer <nzimmer@sgi.com>
Date: Mon, 15 Apr 2013 14:53:33 +0000
Subject: [PATCH 2/5] btreplay: Machines are now large enough that holes need to be dealt with
Message-Id: <1366037616-20159-3-git-send-email-nzimmer@sgi.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The current method fails if once we hit the first offlined cpu.  This
will correct that case.  However this still underreports the number cpus if
the last cpu are offlined.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Nathan Zimmer <nzimmer@sgi.com>
---
 btreplay/btreplay.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index 20494e0..6f0ba63 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -502,6 +502,7 @@ static inline void start_iter(void)
  */
 static void get_ncpus(void)
 {
+	long last_cpu;
 	cpu_set_t cpus;
 
 	if (sched_getaffinity(getpid(), sizeof(cpus), &cpus)) {
@@ -509,12 +510,11 @@ static void get_ncpus(void)
 		/*NOTREACHED*/
 	}
 
-	/*
-	 * XXX This assumes (perhaps wrongly) that there are no /holes/ 
-	 * XXX in the mask.
-	 */
-	for (ncpus = 0; ncpus < CPU_SETSIZE && CPU_ISSET(ncpus, &cpus); ncpus++)
-		;
+	ncpus = -1;
+	for (last_cpu = 0; last_cpu < CPU_SETSIZE && CPU_ISSET(last_cpu, &cpus); last_cpu++)
+		if (CPU_ISSET( last_cpu, &cpus) ) 
+			ncpus = last_cpu;
+	ncpus++;
 	if (ncpus = 0) {
 		fatal(NULL, ERR_SYSCALL, "Insufficient number of CPUs\n");
 		/*NOTREACHED*/
-- 
1.8.1.2

