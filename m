From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:49 +0000
Subject: [RFC PATCH 40/46] block: set ioprio for write-zeroes, discard etc
Message-Id: <20190602165055.14424-41-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-lib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 5f2c429d4378..efc9a1bf5262 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -7,6 +7,7 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/scatterlist.h>
+#include <linux/ioprio.h>
 
 #include "blk.h"
 
@@ -64,6 +65,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
 		bio_set_op_attrs(bio, op, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		bio->bi_iter.bi_size = req_sects << 9;
 		sector += req_sects;
@@ -162,6 +164,7 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		bio->bi_io_vec->bv_offset = 0;
 		bio->bi_io_vec->bv_len = bdev_logical_block_size(bdev);
 		bio_set_op_attrs(bio, REQ_OP_WRITE_SAME, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		if (nr_sects > max_write_same_sectors) {
 			bio->bi_iter.bi_size = max_write_same_sectors << 9;
@@ -234,6 +237,8 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
 		bio->bi_opf = REQ_OP_WRITE_ZEROES;
+		bio_set_prio(bio, get_current_ioprio());
+
 		if (flags & BLKDEV_ZERO_NOUNMAP)
 			bio->bi_opf |= REQ_NOUNMAP;
 
@@ -286,6 +291,7 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		while (nr_sects != 0) {
 			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
-- 
2.19.1
