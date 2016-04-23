From: Roman Pen <r.peniaev@gmail.com>
Date: Sat, 23 Apr 2016 11:44:09 +0000
Subject: [PATCH 2/3] btreplay: fix sched_{set|get}affinity
Message-Id: <1461411850-25443-2-git-send-email-r.peniaev@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

getpid() is a pid of a process, at least tid must be provided.
But if zero is passed, then calling thread will be used.
That exactly what is needed.

Signed-off-by: Roman Pen <r.peniaev@gmail.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: <linux-btrace@vger.kernel.org>
---
 btreplay/btreplay.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index 2a1525e..5bf47ff 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -513,7 +513,7 @@ realloc:
 	size = CPU_ALLOC_SIZE(nrcpus);
 	CPU_ZERO_S(size, cpus);
 
-	if (sched_getaffinity(getpid(), size, cpus)) {
+	if (sched_getaffinity(0, size, cpus)) {
 		if( errno = EINVAL && nrcpus < (4096<<4) ) {
 			CPU_FREE(cpus);
 			nrcpus <<= 1;
@@ -552,16 +552,17 @@ static void pin_to_cpu(struct thr_info *tip)
 
 	CPU_ZERO_S(size, cpus);
 	CPU_SET_S(tip->cpu, size, cpus);
-	if (sched_setaffinity(getpid(), size, cpus)) {
+	if (sched_setaffinity(0, size, cpus)) {
 		fatal("sched_setaffinity", ERR_SYSCALL, "Failed to pin CPU\n");
 		/*NOTREACHED*/
 	}
+	assert(tip->cpu = sched_getcpu());
 
 	if (verbose > 1) {
 		int i;
 		cpu_set_t *now = CPU_ALLOC(ncpus);
 
-		(void)sched_getaffinity(getpid(), size, now);
+		(void)sched_getaffinity(0, size, now);
 		fprintf(tip->vfp, "Pinned to CPU %02d ", tip->cpu);
 		for (i = 0; i < ncpus; i++)
 			fprintf(tip->vfp, "%1d", CPU_ISSET_S(i, size, now));
-- 
2.7.4

