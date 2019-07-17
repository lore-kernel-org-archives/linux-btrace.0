From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 17 Jul 2019 21:24:13 +0000
Subject: [RFC PATCH 16/38] blktrace: update blk_add_trace_bio_complete()
Message-Id: <20190717212435.2990-17-chaitanya.kulkarni@wdc.com>
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
index 23f5312c41d0..649dd69a0a95 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1210,7 +1210,14 @@ static void blk_add_trace_bio_complete(void *ignore,
 				       struct request_queue *q, struct bio *bio,
 				       int error)
 {
-	blk_add_trace_bio(q, bio, BLK_TA_COMPLETE, error);
+	u64 ta = 0;
+
+	if (q->blk_trace) {
+		ta = BLK_TA_COMPLETE;
+	} else if (q->blk_trace_ext) {
+		ta = BLK_TA_COMPLETE_EXT;
+	}
+	blk_add_trace_bio(q, bio, ta, error);
 }
 
 static void blk_add_trace_bio_backmerge(void *ignore,
-- 
2.17.0
