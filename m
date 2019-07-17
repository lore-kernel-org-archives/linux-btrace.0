From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 17 Jul 2019 21:24:24 +0000
Subject: [RFC PATCH 27/38] blktrace: update blk_add_driver_data()
Message-Id: <20190717212435.2990-28-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 1141be3273bf..57c5b5aace08 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1470,13 +1470,18 @@ void blk_add_driver_data(struct request_queue *q,
 			 void *data, size_t len)
 {
 	struct blk_trace *bt = q->blk_trace;
+	struct blk_trace_ext *bte = q->blk_trace_ext;
 
-	if (likely(!bt))
-		return;
-
-	__blk_add_trace(bt, blk_rq_trace_sector(rq), blk_rq_bytes(rq), 0, 0,
-				BLK_TA_DRV_DATA, 0, len, data,
+	if (q->blk_trace) {
+		__blk_add_trace(bt, blk_rq_trace_sector(rq), blk_rq_bytes(rq),
+				0, 0, BLK_TA_DRV_DATA, 0, len, data,
 				blk_trace_request_get_cgid(q, rq));
+	} else if (q->blk_trace_ext) {
+		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq), blk_rq_bytes(rq),
+				0, 0, BLK_TA_DRV_DATA_EXT, 0, len, data,
+				blk_trace_request_get_cgid(q, rq),
+				req_get_ioprio(rq));
+	}
 }
 EXPORT_SYMBOL_GPL(blk_add_driver_data);
 
-- 
2.17.0
