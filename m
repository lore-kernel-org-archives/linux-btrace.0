From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 25 Aug 2020 22:09:49 +0000
Subject: [RFC PATCH 19/39] blktrace: update blk_add_trace_getrq()
Message-Id: <20200825221009.6457-20-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 04c3da8a5443..24b2164d47d4 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1417,16 +1417,36 @@ static void blk_add_trace_getrq(void *ignore,
 				struct request_queue *q,
 				struct bio *bio, int rw)
 {
-	if (bio)
-		blk_add_trace_bio(q, bio, BLK_TA_GETRQ, 0);
-	else {
-		struct blk_trace *bt;
+	u64 ta = 0;
+	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
 
+	rcu_read_lock();
+	bt = rcu_dereference(q->blk_trace);
+	bte = rcu_dereference(q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
+		rcu_read_unlock();
+		return;
+	}
+	if (bt) {
+		ta = BLK_TA_GETRQ;
+	} else if (bte) {
+		ta = BLK_TA_GETRQ_EXT;
+	}
+	rcu_read_unlock();
+
+	if (bio) {
+		blk_add_trace_bio(q, bio, ta, 0);
+	} else {
 		rcu_read_lock();
 		bt = rcu_dereference(q->blk_trace);
-		if (bt)
-			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_GETRQ, 0, 0,
-					NULL, 0);
+		bte = rcu_dereference(q->blk_trace_ext);
+		if (bt) {
+			__blk_add_trace(bt, 0, 0, rw, 0, ta, 0, 0, NULL, 0);
+		} else if (bte) {
+			__blk_add_trace_ext(bte, 0, 0, rw, 0, ta, 0, 0, NULL,
+					0, 0);
+		}
 		rcu_read_unlock();
 	}
 }
-- 
2.22.1
