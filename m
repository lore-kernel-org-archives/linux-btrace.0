From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 19 Aug 2019 04:40:41 +0000
Subject: [RFC PATCH 10/38] blktrace: update blk_add_trace_rq_insert()
Message-Id: <20190819044109.3405-11-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3a76fb4ae5e9..4f3241522232 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1104,8 +1104,15 @@ static void blk_add_trace_rq(struct request *rq, int error,
 static void blk_add_trace_rq_insert(void *ignore,
 				    struct request_queue *q, struct request *rq)
 {
-	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_INSERT,
-			 blk_trace_request_get_cgid(q, rq));
+	u64 ta = 0;
+
+	if (rq->q->blk_trace) {
+		ta = BLK_TA_INSERT;
+	} else if (rq->q->blk_trace_ext) {
+		ta = BLK_TA_INSERT_EXT;
+	}
+	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), ta,
+			blk_trace_request_get_cgid(q, rq));
 }
 
 static void blk_add_trace_rq_issue(void *ignore,
-- 
2.17.0
