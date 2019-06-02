From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:34 +0000
Subject: [RFC PATCH 25/46] blktrace: update blk_add_trace_bio_remap()
Message-Id: <20190602165055.14424-26-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 23911e969e8b..d94a377fc7b8 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1396,18 +1396,24 @@ static void blk_add_trace_bio_remap(void *ignore,
 				    dev_t dev, sector_t from)
 {
 	struct blk_trace *bt = q->blk_trace;
+	struct blk_trace_ext *bte = q->blk_trace_ext;
 	struct blk_io_trace_remap r;
 
-	if (likely(!bt))
-		return;
-
 	r.device_from = cpu_to_be32(dev);
 	r.device_to   = cpu_to_be32(bio_dev(bio));
 	r.sector_from = cpu_to_be64(from);
 
-	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
-			bio_op(bio), bio->bi_opf, BLK_TA_REMAP, bio->bi_status,
-			sizeof(r), &r, blk_trace_bio_get_cgid(q, bio));
+	if (q->blk_trace) {
+		__blk_add_trace(bt, bio->bi_iter.bi_sector,
+				bio->bi_iter.bi_size, bio_op(bio), bio->bi_opf,
+				BLK_TA_REMAP, bio->bi_status, sizeof(r), &r,
+				blk_trace_bio_get_cgid(q, bio));
+	} else if (q->blk_trace_ext) {
+		__blk_add_trace_ext(bte, bio->bi_iter.bi_sector,
+				bio->bi_iter.bi_size, bio_op(bio), bio->bi_opf,
+				BLK_TA_REMAP_EXT, bio->bi_status, sizeof(r), &r,
+				blk_trace_bio_get_cgid(q, bio), bio_prio(bio));
+	}
 }
 
 /**
-- 
2.19.1
