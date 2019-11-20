From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 20 Nov 2019 04:24:51 +0000
Subject: [RFC PATCH 21/39] blktrace: update blk_add_trace_sleeprq()
Message-Id: <20191120042509.12835-22-chaitanya.kulkarni@wdc.com>
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
index 31b4fc636e04..d9c56e6d34f6 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1288,14 +1288,24 @@ static void blk_add_trace_sleeprq(void *ignore,
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
2.22.1
