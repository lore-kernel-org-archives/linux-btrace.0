From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 23 Mar 2020 16:30:09 +0000
Subject: [RFC PATCH 26/39] blktrace: update blk_add_trace_rq_remap()
Message-Id: <20200323163022.30688-27-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 687f8e1025a0..940783885dab 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1601,11 +1601,13 @@ static void blk_add_trace_rq_remap(void *ignore,
 				   sector_t from)
 {
 	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
 	struct blk_io_trace_remap r;
 
 	rcu_read_lock();
 	bt = rcu_dereference(q->blk_trace);
-	if (likely(!bt)) {
+	bte = rcu_dereference(q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
 		rcu_read_unlock();
 		return;
 	}
@@ -1614,9 +1616,18 @@ static void blk_add_trace_rq_remap(void *ignore,
 	r.device_to   = cpu_to_be32(disk_devt(rq->rq_disk));
 	r.sector_from = cpu_to_be64(from);
 
-	__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
-			rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
-			sizeof(r), &r, blk_trace_request_get_cgid(q, rq));
+	if (bt) {
+		__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
+				rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
+				sizeof(r), &r,
+				blk_trace_request_get_cgid(q, rq));
+	} else if (bte) {
+		__blk_add_trace_ext(bte, blk_rq_pos(rq), blk_rq_bytes(rq),
+				    rq_data_dir(rq), 0, BLK_TA_REMAP_EXT, 0,
+				    sizeof(r), &r,
+				    blk_trace_request_get_cgid(q, rq) , 0);
+	
+	}
 	rcu_read_unlock();
 }
 
-- 
2.22.0
