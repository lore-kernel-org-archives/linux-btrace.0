From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 20 Nov 2019 04:24:56 +0000
Subject: [RFC PATCH 26/39] blktrace: update blk_add_trace_rq_remap()
Message-Id: <20191120042509.12835-27-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d9418335ec26..1659bab715ae 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1431,18 +1431,23 @@ static void blk_add_trace_rq_remap(void *ignore,
 				   sector_t from)
 {
 	struct blk_trace *bt = q->blk_trace;
+	struct blk_trace_ext *bte = q->blk_trace_ext;
 	struct blk_io_trace_remap r;
 
-	if (likely(!bt))
-		return;
-
 	r.device_from = cpu_to_be32(dev);
 	r.device_to   = cpu_to_be32(disk_devt(rq->rq_disk));
 	r.sector_from = cpu_to_be64(from);
 
-	__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
-			rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
-			sizeof(r), &r, blk_trace_request_get_cgid(q, rq));
+	if (q->blk_trace) {
+		__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
+				rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
+				sizeof(r), &r, blk_trace_request_get_cgid(q, rq));
+	} else if (q->blk_trace_ext) {
+		__blk_add_trace_ext(bte, blk_rq_pos(rq), blk_rq_bytes(rq),
+				    rq_data_dir(rq), 0, BLK_TA_REMAP_EXT, 0,
+				    sizeof(r), &r, blk_trace_request_get_cgid(q, rq),
+				    req_get_ioprio(rq));
+	}
 }
 
 /**
-- 
2.22.1
