From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 23 Mar 2020 16:30:07 +0000
Subject: [RFC PATCH 24/39] blktrace: update blk_add_trace_split()
Message-Id: <20200323163022.30688-25-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3131c6ec0e95..6ac1c3744c3d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1509,16 +1509,27 @@ static void blk_add_trace_split(void *ignore,
 				unsigned int pdu)
 {
 	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
+	__be64 rpdu = cpu_to_be64(pdu);
 
 	rcu_read_lock();
 	bt = rcu_dereference(q->blk_trace);
+	bte = rcu_dereference(q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
+		rcu_read_unlock();
+		return;
+	}
 	if (bt) {
-		__be64 rpdu = cpu_to_be64(pdu);
-
 		__blk_add_trace(bt, bio->bi_iter.bi_sector,
 				bio->bi_iter.bi_size, bio_op(bio), bio->bi_opf,
 				BLK_TA_SPLIT, bio->bi_status, sizeof(rpdu),
 				&rpdu, blk_trace_bio_get_cgid(q, bio));
+	} else if (bte) {
+		__blk_add_trace_ext(bte, bio->bi_iter.bi_sector,
+				    bio->bi_iter.bi_size, bio_op(bio),
+				    bio->bi_opf, BLK_TA_SPLIT_EXT,
+				    bio->bi_status, sizeof(rpdu), &rpdu,
+				    blk_trace_bio_get_cgid(q, bio), 0);
 	}
 	rcu_read_unlock();
 }
-- 
2.22.0
