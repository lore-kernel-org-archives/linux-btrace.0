From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 20 Nov 2019 04:24:49 +0000
Subject: [RFC PATCH 19/39] blktrace: update blk_add_trace_bio_queue()
Message-Id: <20191120042509.12835-20-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 96d4452d922d..8f89b0ca0053 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1249,7 +1249,14 @@ static void blk_add_trace_bio_frontmerge(void *ignore,
 static void blk_add_trace_bio_queue(void *ignore,
 				    struct request_queue *q, struct bio *bio)
 {
-	blk_add_trace_bio(q, bio, BLK_TA_QUEUE, 0);
+	u64 ta = 0;
+
+	if (q->blk_trace) {
+		ta = BLK_TA_QUEUE;
+	} else if (q->blk_trace_ext) {
+		ta = BLK_TA_QUEUE_EXT;
+	}
+	blk_add_trace_bio(q, bio, ta, 0);
 }
 
 static void blk_add_trace_getrq(void *ignore,
-- 
2.22.1
