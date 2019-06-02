From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:30 +0000
Subject: [RFC PATCH 21/46] blktrace: update blk_add_trace_sleeprq()
Message-Id: <20190602165055.14424-22-chaitanya.kulkarni@wdc.com>
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
index 4bca03475336..fe1c9d549c0d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1292,14 +1292,24 @@ static void blk_add_trace_sleeprq(void *ignore,
 				  struct request_queue *q,
 				  struct bio *bio, int rw)
 {
-	if (bio)
-		blk_add_trace_bio(q, bio, BLK_TA_SLEEPRQ, 0);
-	else {
+	if (bio) {
+		if (q->blk_trace) {
+			blk_add_trace_bio(q, bio, BLK_TA_SLEEPRQ, 0);
+		} else if (q->blk_trace_ext) {
+			blk_add_trace_bio(q, bio, BLK_TA_SLEEPRQ_EXT, 0);
+		}
+	} else {
 		struct blk_trace *bt = q->blk_trace;
+		struct blk_trace_ext *bte = q->blk_trace_ext;
 
-		if (bt)
+		if (q->blk_trace) {
 			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_SLEEPRQ,
 					0, 0, NULL, NULL);
+		} else if (q->blk_trace_ext) {
+			__blk_add_trace_ext(bte, 0, 0, rw, 0,
+					    BLK_TA_SLEEPRQ_EXT,
+					    0, 0, NULL, NULL, 0);
+		}
 	}
 }
 
-- 
2.19.1
