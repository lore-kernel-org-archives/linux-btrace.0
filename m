From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:21 +0000
Subject: [RFC PATCH 12/46] blktrace: update blk_add_trace_rq_requeue()
Message-Id: <20190602165055.14424-13-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index f73c8187cf4f..f51c4de4d953 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1137,7 +1137,14 @@ static void blk_add_trace_rq_requeue(void *ignore,
 				     struct request_queue *q,
 				     struct request *rq)
 {
-	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_REQUEUE,
+	u64 ta = 0;
+
+	if (rq->q->blk_trace) {
+		ta = BLK_TA_REQUEUE;
+	} else if (rq->q->blk_trace_ext) {
+		ta = BLK_TA_REQUEUE_EXT;
+	}
+	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), ta,
 			 blk_trace_request_get_cgid(q, rq));
 }
 
-- 
2.19.1
