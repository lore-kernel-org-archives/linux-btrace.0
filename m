From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 17 Jul 2019 21:24:21 +0000
Subject: [RFC PATCH 24/38] blktrace: update blk_add_trace_split()
Message-Id: <20190717212435.2990-25-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8ea8d987eb4b..23911e969e8b 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1361,14 +1361,20 @@ static void blk_add_trace_split(void *ignore,
 				unsigned int pdu)
 {
 	struct blk_trace *bt = q->blk_trace;
+	struct blk_trace_ext *bte = q->blk_trace_ext;
+	__be64 rpdu = cpu_to_be64(pdu);
 
-	if (bt) {
-		__be64 rpdu = cpu_to_be64(pdu);
-
+	if (q->blk_trace) {
 		__blk_add_trace(bt, bio->bi_iter.bi_sector,
 				bio->bi_iter.bi_size, bio_op(bio), bio->bi_opf,
 				BLK_TA_SPLIT, bio->bi_status, sizeof(rpdu),
 				&rpdu, blk_trace_bio_get_cgid(q, bio));
+	} else if (q->blk_trace_ext) {
+		__blk_add_trace_ext(bte, bio->bi_iter.bi_sector,
+				bio->bi_iter.bi_size, bio_op(bio), bio->bi_opf,
+				BLK_TA_SPLIT_EXT, bio->bi_status, sizeof(rpdu),
+				&rpdu, blk_trace_bio_get_cgid(q, bio),
+				bio_prio(bio));
 	}
 }
 
-- 
2.17.0
