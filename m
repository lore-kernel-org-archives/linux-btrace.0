From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 23 Mar 2020 16:29:53 +0000
Subject: [RFC PATCH 10/39] blktrace: update blk_add_trace_rq_insert()
Message-Id: <20200323163022.30688-11-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 78d43a0bf3f5..cae7ecb5cbe6 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1110,8 +1110,26 @@ static void blk_add_trace_rq(struct request *rq, int error,
 static void blk_add_trace_rq_insert(void *ignore,
 				    struct request_queue *q, struct request *rq)
 {
-	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_INSERT,
-			 blk_trace_request_get_cgid(q, rq));
+	u64 ta = 0;
+	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
+
+	rcu_read_lock();
+	bt = rcu_dereference(rq->q->blk_trace);
+	bte = rcu_dereference(rq->q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte) ) {
+		rcu_read_unlock();
+		return;
+	}
+
+	if (bt) {
+		ta = BLK_TA_INSERT;
+	} else if (bte) {
+		ta = BLK_TA_INSERT_EXT;
+	}
+	rcu_read_unlock();
+	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), ta,
+			blk_trace_request_get_cgid(q, rq));
 }
 
 static void blk_add_trace_rq_issue(void *ignore,
-- 
2.22.0
