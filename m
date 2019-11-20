From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 20 Nov 2019 04:24:43 +0000
Subject: [RFC PATCH 13/39] blktrace: update blk_add_trace_rq_complete()
Message-Id: <20191120042509.12835-14-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ff4eee1d33d8..19a71a495f86 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1147,7 +1147,14 @@ static void blk_add_trace_rq_requeue(void *ignore,
 static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
 			int error, unsigned int nr_bytes)
 {
-	blk_add_trace_rq(rq, error, nr_bytes, BLK_TA_COMPLETE,
+	u64 ta = 0;
+
+	if (rq->q->blk_trace) {
+		ta = BLK_TA_COMPLETE;
+	} else if (rq->q->blk_trace_ext) {
+		ta = BLK_TA_COMPLETE_EXT;
+	}
+	blk_add_trace_rq(rq, error, nr_bytes, ta,
 			 blk_trace_request_get_cgid(rq->q, rq));
 }
 
-- 
2.22.1
