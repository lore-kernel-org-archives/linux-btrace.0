From: Roman Pen <r.peniaev@gmail.com>
Date: Sat, 23 Apr 2016 11:44:08 +0000
Subject: [PATCH 1/3] btreplay: fix memory corruption caused by CPU_ZERO_S
Message-Id: <1461411850-25443-1-git-send-email-r.peniaev@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Size should be provided, not cpus number.

Signed-off-by: Roman Pen <r.peniaev@gmail.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: <linux-btrace@vger.kernel.org>
---
 btreplay/btreplay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index 6d19564..2a1525e 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -550,7 +550,7 @@ static void pin_to_cpu(struct thr_info *tip)
 
 	assert(0 <= tip->cpu && tip->cpu < ncpus);
 
-	CPU_ZERO_S(ncpus, cpus);
+	CPU_ZERO_S(size, cpus);
 	CPU_SET_S(tip->cpu, size, cpus);
 	if (sched_setaffinity(getpid(), size, cpus)) {
 		fatal("sched_setaffinity", ERR_SYSCALL, "Failed to pin CPU\n");
-- 
2.7.4

