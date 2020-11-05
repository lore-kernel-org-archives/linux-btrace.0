From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Thu, 05 Nov 2020 02:40:19 +0000
Subject: [RFC PATCH 20/39] blktrace: update blk_add_trace_sleeprq()
Message-Id: <20201105024038.5831-21-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 916d7e95dca8..31d8f36a0ad8 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1456,16 +1456,36 @@ static void blk_add_trace_sleeprq(void *ignore,
 				  struct request_queue *q,
 				  struct bio *bio, int rw)
 {
-	if (bio)
-		blk_add_trace_bio(q, bio, BLK_TA_SLEEPRQ, 0);
-	else {
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
+	if (bt) {
+		ta = BLK_TA_SLEEPRQ;
+	} else if (bte) {
+		ta = BLK_TA_SLEEPRQ_EXT;
+	}
+	rcu_read_unlock();
+	if (bio) {
+		blk_add_trace_bio(q, bio, ta, 0);
+	} else {
 		struct blk_trace *bt;
 
 		rcu_read_lock();
 		bt = rcu_dereference(q->blk_trace);
+		bte = rcu_dereference(q->blk_trace_ext);
 		if (bt)
-			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_SLEEPRQ,
-					0, 0, NULL, 0);
+			__blk_add_trace(bt, 0, 0, rw, 0, ta, 0, 0, NULL, 0);
+		else if (bte)
+			__blk_add_trace_ext(bte, 0, 0, rw, 0, ta, 0, 0, NULL,
+					0, 0);
 		rcu_read_unlock();
 	}
 }
-- 
2.22.1
