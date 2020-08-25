From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 25 Aug 2020 22:09:52 +0000
Subject: [RFC PATCH 22/39] blktrace: update blk_add_trace_unplug()
Message-Id: <20200825221009.6457-23-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index dd80f25ebdaf..bf8b438d3f8d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1514,9 +1514,11 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 				    unsigned int depth, bool explicit)
 {
 	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
 
 	rcu_read_lock();
 	bt = rcu_dereference(q->blk_trace);
+	bte = rcu_dereference(q->blk_trace_ext);
 	if (bt) {
 		__be64 rpdu = cpu_to_be64(depth);
 		u32 what;
@@ -1527,6 +1529,16 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 			what = BLK_TA_UNPLUG_TIMER;
 
 		__blk_add_trace(bt, 0, 0, 0, 0, what, 0, sizeof(rpdu), &rpdu, 0);
+	} else if (bte) {
+		__be64 rpdu = cpu_to_be64(depth);
+		u64 what;
+
+		if (explicit)
+			what = BLK_TA_UNPLUG_IO_EXT;
+		else
+			what = BLK_TA_UNPLUG_TIMER_EXT;
+		__blk_add_trace_ext(bte, 0, 0, 0, 0, what, 0, sizeof(rpdu),
+				&rpdu, 0, 0);
 	}
 	rcu_read_unlock();
 }
-- 
2.22.1
