From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 26 Jan 2021 23:33:33 +0000
Subject: [RFC PATCH 11/38] blktrace: update blk_add_trace_rq_requeue()
Message-Id: <20210126233400.31259-12-chaitanya.kulkarni@wdc.com>
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
index 65097e8b2d5b..f15163838999 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1192,7 +1192,25 @@ static void blk_add_trace_rq_merge(void *ignore, struct request *rq)
 
 static void blk_add_trace_rq_requeue(void *ignore, struct request *rq)
 {
-	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_REQUEUE,
+	u64 ta;
+	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
+
+	rcu_read_lock();
+	bt = rcu_dereference(rq->q->blk_trace);
+	bte = rcu_dereference(rq->q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	if (bt) {
+		ta = BLK_TA_REQUEUE;
+	} else if (bte) {
+		ta = BLK_TA_REQUEUE_EXT;
+	}
+	rcu_read_unlock();
+	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), ta,
 			 blk_trace_request_get_cgid(rq));
 }
 
-- 
2.22.1
