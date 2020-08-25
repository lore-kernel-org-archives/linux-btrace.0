From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 25 Aug 2020 22:09:47 +0000
Subject: [RFC PATCH 17/39] blktrace: update blk_add_trace_bio_frontmerge()
Message-Id: <20200825221009.6457-18-chaitanya.kulkarni@wdc.com>
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
index bcd3ce0baf09..d24f0a17b750 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1368,7 +1368,25 @@ static void blk_add_trace_bio_frontmerge(void *ignore,
 					 struct request *rq,
 					 struct bio *bio)
 {
-	blk_add_trace_bio(q, bio, BLK_TA_FRONTMERGE, 0);
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
+
+	if (bt) {
+		ta = BLK_TA_FRONTMERGE;
+	} else if (bte) {
+		ta = BLK_TA_FRONTMERGE_EXT;
+	}
+	blk_add_trace_bio(q, bio, ta, 0);
+	rcu_read_unlock();
 }
 
 static void blk_add_trace_bio_queue(void *ignore,
-- 
2.22.1
