From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 17 Jul 2019 21:24:17 +0000
Subject: [RFC PATCH 20/38] blktrace: update blk_add_trace_getrq()
Message-Id: <20190717212435.2990-21-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8fd5b385b5f1..4bca03475336 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1267,14 +1267,23 @@ static void blk_add_trace_getrq(void *ignore,
 				struct request_queue *q,
 				struct bio *bio, int rw)
 {
-	if (bio)
-		blk_add_trace_bio(q, bio, BLK_TA_GETRQ, 0);
-	else {
+	if (bio) {
+		if (q->blk_trace) {
+			blk_add_trace_bio(q, bio, BLK_TA_GETRQ, 0);
+		} else if (q->blk_trace_ext) {
+			blk_add_trace_bio(q, bio, BLK_TA_GETRQ_EXT, 0);
+		}
+	} else {
 		struct blk_trace *bt = q->blk_trace;
+		struct blk_trace_ext *bte = q->blk_trace_ext;
 
-		if (bt)
+		if (q->blk_trace) {
 			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_GETRQ, 0, 0,
 					NULL, NULL);
+		} else if (q->blk_trace_ext) {
+			__blk_add_trace_ext(bte, 0, 0, rw, 0, BLK_TA_GETRQ_EXT,
+					    0, 0, NULL, NULL, 0);
+		}
 	}
 }
 
-- 
2.17.0
