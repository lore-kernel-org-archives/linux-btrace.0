From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 17 Jul 2019 21:24:19 +0000
Subject: [RFC PATCH 22/38] blktrace: update blk_add_trace_plug()
Message-Id: <20190717212435.2990-23-chaitanya.kulkarni@wdc.com>
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
index fe1c9d549c0d..ebb2de71159a 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1287,7 +1287,6 @@ static void blk_add_trace_getrq(void *ignore,
 	}
 }
 
-
 static void blk_add_trace_sleeprq(void *ignore,
 				  struct request_queue *q,
 				  struct bio *bio, int rw)
@@ -1316,9 +1315,14 @@ static void blk_add_trace_sleeprq(void *ignore,
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
2.17.0
