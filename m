From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 25 Aug 2020 22:09:51 +0000
Subject: [RFC PATCH 21/39] blktrace: update blk_add_trace_plug()
Message-Id: <20200825221009.6457-22-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3cd11e1c46d5..dd80f25ebdaf 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1493,11 +1493,20 @@ static void blk_add_trace_sleeprq(void *ignore,
 static void blk_add_trace_plug(void *ignore, struct request_queue *q)
 {
 	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
 
 	rcu_read_lock();
 	bt = rcu_dereference(q->blk_trace);
+	bte = rcu_dereference(q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
+		rcu_read_unlock();
+		return;
+	}
 	if (bt)
 		__blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, 0);
+	else if (bte)
+		__blk_add_trace_ext(bte, 0, 0, 0, 0, BLK_TA_PLUG_EXT, 0, 0,
+				    NULL, 0, 0);
 	rcu_read_unlock();
 }
 
-- 
2.22.1
