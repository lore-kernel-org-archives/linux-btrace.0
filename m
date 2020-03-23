From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 23 Mar 2020 16:30:03 +0000
Subject: [RFC PATCH 20/39] blktrace: update blk_add_trace_getrq()
Message-Id: <20200323163022.30688-21-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index e181428b97c1..9fd0e5758d3d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1377,16 +1377,36 @@ static void blk_add_trace_getrq(void *ignore,
 				struct request_queue *q,
 				struct bio *bio, int rw)
 {
-	if (bio)
-		blk_add_trace_bio(q, bio, BLK_TA_GETRQ, 0);
-	else {
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
+	if (bio) {
+		if (bt) {
+			blk_add_trace_bio(q, bio, BLK_TA_GETRQ, 0);
+		} else if (bte) {
+			blk_add_trace_bio(q, bio, BLK_TA_GETRQ_EXT, 0);
+		}
+	} else {
 		struct blk_trace *bt;
 
 		rcu_read_lock();
 		bt = rcu_dereference(q->blk_trace);
+		bte = rcu_dereference(q->blk_trace_ext);
 		if (bt)
 			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_GETRQ, 0, 0,
 					NULL, 0);
+		else if (bte)
+			__blk_add_trace_ext(bte, 0, 0, rw, 0, BLK_TA_GETRQ_EXT,
+					    0, 0, NULL, 0, 0);
 		rcu_read_unlock();
 	}
 }
-- 
2.22.0
