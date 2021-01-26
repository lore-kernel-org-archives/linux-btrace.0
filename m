From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 26 Jan 2021 23:33:46 +0000
Subject: [RFC PATCH 24/38] blktrace: update blk_add_trace_rq_remap()
Message-Id: <20210126233400.31259-25-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 1e1948b6e7b1..05f2d8acc789 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1561,12 +1561,14 @@ static void blk_add_trace_bio_remap(void *ignore, struct bio *bio, dev_t dev,
 static void blk_add_trace_rq_remap(void *ignore, struct request *rq, dev_t dev,
 				   sector_t from)
 {
+	struct blk_trace_ext *bte;
 	struct blk_trace *bt;
 	struct blk_io_trace_remap r;
 
 	rcu_read_lock();
 	bt = rcu_dereference(rq->q->blk_trace);
-	if (likely(!bt)) {
+	bte = rcu_dereference(rq->q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
 		rcu_read_unlock();
 		return;
 	}
@@ -1575,9 +1577,17 @@ static void blk_add_trace_rq_remap(void *ignore, struct request *rq, dev_t dev,
 	r.device_to   = cpu_to_be32(disk_devt(rq->rq_disk));
 	r.sector_from = cpu_to_be64(from);
 
-	__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
-			rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
-			sizeof(r), &r, blk_trace_request_get_cgid(rq));
+	if (bt) {
+		__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
+				rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
+				sizeof(r), &r,
+				blk_trace_request_get_cgid(rq));
+	} else if (bte) {
+		__blk_add_trace_ext(bte, blk_rq_pos(rq), blk_rq_bytes(rq),
+				    rq_data_dir(rq), 0, BLK_TA_REMAP_EXT, 0,
+				    sizeof(r), &r,
+				    blk_trace_request_get_cgid(rq), 0);
+	}
 	rcu_read_unlock();
 }
 
-- 
2.22.1
