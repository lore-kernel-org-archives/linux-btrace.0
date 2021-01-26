From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 26 Jan 2021 23:33:47 +0000
Subject: [RFC PATCH 25/38] blktrace: update blk_add_driver_data()
Message-Id: <20210126233400.31259-26-chaitanya.kulkarni@wdc.com>
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
index 05f2d8acc789..c8b5955163ad 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1604,17 +1604,26 @@ static void blk_add_trace_rq_remap(void *ignore, struct request *rq, dev_t dev,
 void blk_add_driver_data(struct request *rq, void *data, size_t len)
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
 
-	__blk_add_trace(bt, blk_rq_trace_sector(rq), blk_rq_bytes(rq), 0, 0,
-				BLK_TA_DRV_DATA, 0, len, data,
+	if (bt) {
+		__blk_add_trace(bt, blk_rq_trace_sector(rq), blk_rq_bytes(rq), 0,
+				0, BLK_TA_DRV_DATA, 0, len, data,
 				blk_trace_request_get_cgid(rq));
+	} else if (bte) {
+		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq),
+				blk_rq_bytes(rq), 0, 0, BLK_TA_DRV_DATA_EXT, 0,
+				len, data, blk_trace_request_get_cgid(rq),
+				req_get_ioprio(rq));
+	}
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(blk_add_driver_data);
-- 
2.22.1
