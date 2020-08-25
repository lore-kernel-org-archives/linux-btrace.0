From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 25 Aug 2020 22:09:55 +0000
Subject: [RFC PATCH 25/39] blktrace: update blk_add_trace_rq_remap()
Message-Id: <20200825221009.6457-26-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 17fa5269155f..0c2d119abd9a 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1616,8 +1616,8 @@ static void blk_add_trace_bio_remap(void *ignore,
 	} else if (bte) {
 		__blk_add_trace_ext(bte, bio->bi_iter.bi_sector,
 				    bio->bi_iter.bi_size, bio_op(bio),
-				    bio->bi_opf, BLK_TA_REMAP_EXT, bio->bi_status,
-				    sizeof(r), &r,
+				    bio->bi_opf, BLK_TA_REMAP_EXT,
+				    bio->bi_status, sizeof(r), &r,
 				    blk_trace_bio_get_cgid(q, bio), 0);
 	}
 	rcu_read_unlock();
@@ -1642,11 +1642,13 @@ static void blk_add_trace_rq_remap(void *ignore,
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
@@ -1655,9 +1657,18 @@ static void blk_add_trace_rq_remap(void *ignore,
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
+				    blk_trace_request_get_cgid(q, rq), 0);
+
+	}
 	rcu_read_unlock();
 }
 
-- 
2.22.1
