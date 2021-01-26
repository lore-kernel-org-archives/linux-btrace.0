From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 26 Jan 2021 23:33:39 +0000
Subject: [RFC PATCH 17/38] blktrace: update blk_add_trace_bio_frontmerge()
Message-Id: <20210126233400.31259-18-chaitanya.kulkarni@wdc.com>
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
index 1eff4afa4019..8dd41a7592b2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1352,7 +1352,25 @@ static void blk_add_trace_bio_backmerge(void *ignore, struct bio *bio)
 
 static void blk_add_trace_bio_frontmerge(void *ignore, struct bio *bio)
 {
-	blk_add_trace_bio(bio->bi_disk->queue, bio, BLK_TA_FRONTMERGE, 0);
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
+		ta = BLK_TA_FRONTMERGE;
+	} else if (bte) {
+		ta = BLK_TA_FRONTMERGE_EXT;
+	}
+	rcu_read_unlock();
+	blk_add_trace_bio(bio->bi_disk->queue, bio, ta, 0);
 }
 
 static void blk_add_trace_bio_queue(void *ignore, struct bio *bio)
-- 
2.22.1
