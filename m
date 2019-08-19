From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 19 Aug 2019 04:40:40 +0000
Subject: [RFC PATCH 09/38] blktrace: update blk_add_trace_rq()
Message-Id: <20190819044109.3405-10-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 75e9303f1342..3a76fb4ae5e9 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1073,21 +1073,32 @@ blk_trace_request_get_cgid(struct request_queue *q, struct request *rq)
  *
  **/
 static void blk_add_trace_rq(struct request *rq, int error,
-			     unsigned int nr_bytes, u32 what,
+			     unsigned int nr_bytes, u64 what,
 			     union kernfs_node_id *cgid)
 {
 	struct blk_trace *bt = rq->q->blk_trace;
+	struct blk_trace_ext *bte = rq->q->blk_trace_ext;
 
 	if (likely(!bt))
 		return;
 
-	if (blk_rq_is_passthrough(rq))
-		what |= BLK_TC_ACT(BLK_TC_PC);
-	else
-		what |= BLK_TC_ACT(BLK_TC_FS);
-
-	__blk_add_trace(bt, blk_rq_trace_sector(rq), nr_bytes, req_op(rq),
-			rq->cmd_flags, what, error, 0, NULL, cgid);
+	if (rq->q->blk_trace) {
+		if (blk_rq_is_passthrough(rq))
+			what |= BLK_TC_ACT(BLK_TC_PC);
+		else
+			what |= BLK_TC_ACT(BLK_TC_FS);
+		__blk_add_trace(bt, blk_rq_trace_sector(rq), nr_bytes,
+				req_op(rq), rq->cmd_flags, (u32)what, error, 0,
+				NULL, cgid);
+	} else if (rq->q->blk_trace_ext) {
+		if (blk_rq_is_passthrough(rq))
+			what |= BLK_TC_ACT_EXT(BLK_TC_PC);
+		else
+			what |= BLK_TC_ACT_EXT(BLK_TC_FS);
+		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq), nr_bytes,
+				    req_op(rq), rq->cmd_flags, what, error, 0,
+				    NULL, cgid, req_get_ioprio(rq));
+	}
 }
 
 static void blk_add_trace_rq_insert(void *ignore,
-- 
2.17.0
