From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Thu, 05 Nov 2020 02:40:11 +0000
Subject: [RFC PATCH 12/39] blktrace: update blk_add_trace_rq_complete()
Message-Id: <20201105024038.5831-13-chaitanya.kulkarni@wdc.com>
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
index d55dec67354d..5472b445f9b0 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1227,7 +1227,25 @@ static void blk_add_trace_rq_requeue(void *ignore,
 static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
 			int error, unsigned int nr_bytes)
 {
-	blk_add_trace_rq(rq, error, nr_bytes, BLK_TA_COMPLETE,
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
+		ta = BLK_TA_COMPLETE;
+	} else if (bte) {
+		ta = BLK_TA_COMPLETE_EXT;
+	}
+	rcu_read_unlock();
+	blk_add_trace_rq(rq, error, nr_bytes, ta,
 			 blk_trace_request_get_cgid(rq->q, rq));
 }
 
-- 
2.22.1
