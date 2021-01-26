From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 26 Jan 2021 23:33:37 +0000
Subject: [RFC PATCH 15/38] blktrace: update blk_add_trace_bio_complete()
Message-Id: <20210126233400.31259-16-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8231665b02a2..b09ed08d0782 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1305,7 +1305,25 @@ static void blk_add_trace_bio_bounce(void *ignore, struct bio *bio)
 static void blk_add_trace_bio_complete(void *ignore,
 				       struct request_queue *q, struct bio *bio)
 {
-	blk_add_trace_bio(q, bio, BLK_TA_COMPLETE,
+	u64 ta = 0;
+	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
+
+	rcu_read_lock();
+	bt = rcu_dereference(bio->bi_disk->queue->blk_trace);
+	bte = rcu_dereference(bio->bi_disk->queue->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	if (bt) {
+		ta = BLK_TA_COMPLETE;
+	} else if (bte) {
+		ta = BLK_TA_COMPLETE_EXT;
+	}
+	rcu_read_unlock();
+	blk_add_trace_bio(bio->bi_disk->queue, bio, ta,
 			  blk_status_to_errno(bio->bi_status));
 }
 
-- 
2.22.1
