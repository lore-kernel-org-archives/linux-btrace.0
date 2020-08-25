From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 25 Aug 2020 22:09:38 +0000
Subject: [RFC PATCH 08/39] blktrace: update blk_add_trace_rq()
Message-Id: <20200825221009.6457-9-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 05cf30bd000f..8ecacd5cbde5 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1108,24 +1108,36 @@ blk_trace_request_get_cgid(struct request_queue *q, struct request *rq)
  *
  **/
 static void blk_add_trace_rq(struct request *rq, int error,
-			     unsigned int nr_bytes, u32 what, u64 cgid)
+			     unsigned int nr_bytes, u64 what, u64 cgid)
 {
 	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
 
 	rcu_read_lock();
 	bt = rcu_dereference(rq->q->blk_trace);
-	if (likely(!bt)) {
+	bte = rcu_dereference(rq->q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
 		rcu_read_unlock();
 		return;
 	}
 
-	if (blk_rq_is_passthrough(rq))
-		what |= BLK_TC_ACT(BLK_TC_PC);
-	else
-		what |= BLK_TC_ACT(BLK_TC_FS);
-
-	__blk_add_trace(bt, blk_rq_trace_sector(rq), nr_bytes, req_op(rq),
-			rq->cmd_flags, what, error, 0, NULL, cgid);
+	if (bt) {
+		if (blk_rq_is_passthrough(rq))
+			what |= BLK_TC_ACT(BLK_TC_PC);
+		else
+			what |= BLK_TC_ACT(BLK_TC_FS);
+		__blk_add_trace(bt, blk_rq_trace_sector(rq), nr_bytes,
+				req_op(rq), rq->cmd_flags, (u32)what, error, 0,
+				NULL, cgid);
+	} else if (bte) {
+		if (blk_rq_is_passthrough(rq))
+			what |= BLK_TC_ACT_EXT(BLK_TC_PC);
+		else
+			what |= BLK_TC_ACT_EXT(BLK_TC_FS);
+		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq), nr_bytes,
+				    req_op(rq), rq->cmd_flags, what, error, 0,
+				    NULL, cgid, req_get_ioprio(rq));
+	}
 	rcu_read_unlock();
 }
 
-- 
2.22.1
