From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Thu, 05 Nov 2020 02:40:22 +0000
Subject: [RFC PATCH 23/39] blktrace: update blk_add_trace_split()
Message-Id: <20201105024038.5831-24-chaitanya.kulkarni@wdc.com>
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
index ffae6abfa606..8e3fec896f88 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1548,18 +1548,29 @@ static void blk_add_trace_split(void *ignore,
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
 				BLK_TA_SPLIT,
 				blk_status_to_errno(bio->bi_status),
 				sizeof(rpdu), &rpdu,
 				blk_trace_bio_get_cgid(q, bio));
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
2.22.1
