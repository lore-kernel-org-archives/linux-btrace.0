From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:23 +0000
Subject: [RFC PATCH 14/46] blktrace: update blk_add_trace_bio()
Message-Id: <20190602165055.14424-15-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index a5e33da53861..52c5b9a5c45c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1174,16 +1174,23 @@ static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
  *
  **/
 static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
-			      u32 what, int error)
+			      u64 what, int error)
 {
 	struct blk_trace *bt = q->blk_trace;
+	struct blk_trace_ext *bte = q->blk_trace_ext;
 
-	if (likely(!bt))
-		return;
-
-	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
-			bio_op(bio), bio->bi_opf, what, error, 0, NULL,
-			blk_trace_bio_get_cgid(q, bio));
+	if (q->blk_trace) {
+		__blk_add_trace(bt, bio->bi_iter.bi_sector,
+				bio->bi_iter.bi_size, bio_op(bio),
+				bio->bi_opf,(u32)what, error, 0, NULL,
+				blk_trace_bio_get_cgid(q, bio));
+	} else if (q->blk_trace_ext) {
+		__blk_add_trace_ext(bte, bio->bi_iter.bi_sector,
+				    bio->bi_iter.bi_size, bio_op(bio),
+				    bio->bi_opf,what, error, 0, NULL,
+				    blk_trace_bio_get_cgid(q, bio),
+				    bio_prio(bio));
+	}
 }
 
 static void blk_add_trace_bio_bounce(void *ignore,
-- 
2.19.1
