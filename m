From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 20 Nov 2019 04:24:53 +0000
Subject: [RFC PATCH 23/39] blktrace: update blk_add_trace_unplug()
Message-Id: <20191120042509.12835-24-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 51cb190eddea..1813f039f6ec 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1325,17 +1325,30 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 				    unsigned int depth, bool explicit)
 {
 	struct blk_trace *bt = q->blk_trace;
+	struct blk_trace_ext *bte = q->blk_trace_ext;
+	__be64 rpdu = cpu_to_be64(depth);
+	u64 what;
 
-	if (bt) {
-		__be64 rpdu = cpu_to_be64(depth);
-		u32 what;
-
-		if (explicit)
+	if (explicit) {
+		if (q->blk_trace) {
 			what = BLK_TA_UNPLUG_IO;
-		else
+		} else if (q->blk_trace_ext) {
+			what = BLK_TA_UNPLUG_IO_EXT;
+		}
+	} else {
+		if (q->blk_trace) {
 			what = BLK_TA_UNPLUG_TIMER;
+		} else if (q->blk_trace_ext) {
+			what = BLK_TA_UNPLUG_TIMER_EXT;
+		}
+	}
 
-		__blk_add_trace(bt, 0, 0, 0, 0, what, 0, sizeof(rpdu), &rpdu, NULL);
+	if (q->blk_trace) {
+		__blk_add_trace(bt, 0, 0, 0, 0, (u32)what, 0, sizeof(rpdu),
+				&rpdu, NULL);
+	} else if (q->blk_trace_ext) {
+		__blk_add_trace_ext(bte, 0, 0, 0, 0, what, 0, sizeof(rpdu),
+				    &rpdu, NULL, 0);
 	}
 }
 
-- 
2.22.1
