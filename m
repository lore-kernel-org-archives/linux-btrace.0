From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 23 Mar 2020 16:30:10 +0000
Subject: [RFC PATCH 27/39] blktrace: update blk_add_driver_data()
Message-Id: <20200323163022.30688-28-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 940783885dab..d5d3f859d448 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1647,17 +1647,26 @@ void blk_add_driver_data(struct request_queue *q,
 			 void *data, size_t len)
 {
 	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
 
 	rcu_read_lock();
 	bt = rcu_dereference(q->blk_trace);
-	if (likely(!bt)) {
+	bte = rcu_dereference(q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
 		rcu_read_unlock();
 		return;
 	}
 
-	__blk_add_trace(bt, blk_rq_trace_sector(rq), blk_rq_bytes(rq), 0, 0,
-				BLK_TA_DRV_DATA, 0, len, data,
+	if (bt) {
+		__blk_add_trace(bt, blk_rq_trace_sector(rq), blk_rq_bytes(rq), 0,
+				0, BLK_TA_DRV_DATA, 0, len, data,
 				blk_trace_request_get_cgid(q, rq));
+	} else if (bte) {
+		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq),
+				blk_rq_bytes(rq), 0, 0, BLK_TA_DRV_DATA_EXT, 0,
+				len, data, blk_trace_request_get_cgid(q, rq),
+				req_get_ioprio(rq));
+	}
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(blk_add_driver_data);
-- 
2.22.0
