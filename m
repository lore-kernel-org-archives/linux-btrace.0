From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 23 Mar 2020 16:30:02 +0000
Subject: [RFC PATCH 19/39] blktrace: update blk_add_trace_bio_queue()
Message-Id: <20200323163022.30688-20-chaitanya.kulkarni@wdc.com>
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
index f77aa0c72b6b..e181428b97c1 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1352,7 +1352,25 @@ static void blk_add_trace_bio_frontmerge(void *ignore,
 static void blk_add_trace_bio_queue(void *ignore,
 				    struct request_queue *q, struct bio *bio)
 {
-	blk_add_trace_bio(q, bio, BLK_TA_QUEUE, 0);
+	u64 ta = 0;
+	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
+
+	rcu_read_lock();
+	bt = rcu_dereference(q->blk_trace);
+	bte = rcu_dereference(q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
+		rcu_read_unlock();
+		return;
+	}
+	rcu_read_unlock();
+
+	if (bt) {
+		ta = BLK_TA_QUEUE;
+	} else if (bte) {
+		ta = BLK_TA_QUEUE_EXT;
+	}
+	blk_add_trace_bio(q, bio, ta, 0);
 }
 
 static void blk_add_trace_getrq(void *ignore,
-- 
2.22.0
