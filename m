From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 26 Jan 2021 23:33:30 +0000
Subject: [RFC PATCH 08/38] blktrace: update blk_add_trace_rq()
Message-Id: <20210126233400.31259-9-chaitanya.kulkarni@wdc.com>
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
index 18dde383e083..da0bbc9a699e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1103,24 +1103,36 @@ blk_trace_request_get_cgid(struct request *rq)
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
