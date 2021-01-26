From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 26 Jan 2021 23:33:45 +0000
Subject: [RFC PATCH 23/38] blktrace: update blk_add_trace_bio_remap()
Message-Id: <20210126233400.31259-24-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 5aed9b0d0c69..1e1948b6e7b1 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1516,11 +1516,13 @@ static void blk_add_trace_bio_remap(void *ignore, struct bio *bio, dev_t dev,
 {
 	struct request_queue *q = bio->bi_disk->queue;
 	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
 	struct blk_io_trace_remap r;
 
 	rcu_read_lock();
 	bt = rcu_dereference(q->blk_trace);
-	if (likely(!bt)) {
+	bte = rcu_dereference(q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
 		rcu_read_unlock();
 		return;
 	}
@@ -1529,10 +1531,18 @@ static void blk_add_trace_bio_remap(void *ignore, struct bio *bio, dev_t dev,
 	r.device_to   = cpu_to_be32(bio_dev(bio));
 	r.sector_from = cpu_to_be64(from);
 
-	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
-			bio_op(bio), bio->bi_opf, BLK_TA_REMAP,
-			blk_status_to_errno(bio->bi_status),
-			sizeof(r), &r, blk_trace_bio_get_cgid(q, bio));
+	if (bt) {
+		__blk_add_trace(bt, bio->bi_iter.bi_sector,
+				bio->bi_iter.bi_size, bio_op(bio), bio->bi_opf,
+				BLK_TA_REMAP, bio->bi_status, sizeof(r), &r,
+				blk_trace_bio_get_cgid(q, bio));
+	} else if (bte) {
+		__blk_add_trace_ext(bte, bio->bi_iter.bi_sector,
+				    bio->bi_iter.bi_size, bio_op(bio),
+				    bio->bi_opf, BLK_TA_REMAP_EXT, bio->bi_status,
+				    sizeof(r), &r,
+				    blk_trace_bio_get_cgid(q, bio), 0);
+	}
 	rcu_read_unlock();
 }
 
-- 
2.22.1
