From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 20 Nov 2019 04:24:52 +0000
Subject: [RFC PATCH 22/39] blktrace: update blk_add_trace_plug()
Message-Id: <20191120042509.12835-23-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d9c56e6d34f6..51cb190eddea 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1283,7 +1283,6 @@ static void blk_add_trace_getrq(void *ignore,
 	}
 }
 
-
 static void blk_add_trace_sleeprq(void *ignore,
 				  struct request_queue *q,
 				  struct bio *bio, int rw)
@@ -1312,9 +1311,14 @@ static void blk_add_trace_sleeprq(void *ignore,
 static void blk_add_trace_plug(void *ignore, struct request_queue *q)
 {
 	struct blk_trace *bt = q->blk_trace;
+	struct blk_trace_ext *bte = q->blk_trace_ext;
 
-	if (bt)
+	if (q->blk_trace) {
 		__blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, NULL);
+	} else if (q->blk_trace_ext) {
+		__blk_add_trace_ext(bte, 0, 0, 0, 0, BLK_TA_PLUG_EXT, 0, 0,
+				    NULL, NULL, 0);
+	}
 }
 
 static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
-- 
2.22.1
