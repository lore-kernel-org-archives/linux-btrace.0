From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:26 +0000
Subject: [RFC PATCH 17/46] blktrace: update blk_add_trace_bio_backmerge()
Message-Id: <20190602165055.14424-18-chaitanya.kulkarni@wdc.com>
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
index 649dd69a0a95..c2233e47e0b4 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1225,7 +1225,14 @@ static void blk_add_trace_bio_backmerge(void *ignore,
 					struct request *rq,
 					struct bio *bio)
 {
-	blk_add_trace_bio(q, bio, BLK_TA_BACKMERGE, 0);
+	u64 ta = 0;
+
+	if (q->blk_trace) {
+		ta = BLK_TA_BACKMERGE;
+	} else if (q->blk_trace_ext) {
+		ta = BLK_TA_BACKMERGE_EXT;
+	}
+	blk_add_trace_bio(q, bio, ta, 0);
 }
 
 static void blk_add_trace_bio_frontmerge(void *ignore,
-- 
2.19.1
