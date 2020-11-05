From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Thu, 05 Nov 2020 02:40:15 +0000
Subject: [RFC PATCH 16/39] blktrace: update blk_add_trace_bio_backmerge()
Message-Id: <20201105024038.5831-17-chaitanya.kulkarni@wdc.com>
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
index 9f427aa5e942..84d22df8687e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1342,7 +1342,25 @@ static void blk_add_trace_bio_backmerge(void *ignore,
 					struct request *rq,
 					struct bio *bio)
 {
-	blk_add_trace_bio(q, bio, BLK_TA_BACKMERGE, 0);
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
+		ta = BLK_TA_BACKMERGE;
+	} else if (bte) {
+		ta = BLK_TA_BACKMERGE_EXT;
+	}
+	rcu_read_unlock();
+	blk_add_trace_bio(q, bio, ta, 0);
 }
 
 static void blk_add_trace_bio_frontmerge(void *ignore,
-- 
2.22.1
