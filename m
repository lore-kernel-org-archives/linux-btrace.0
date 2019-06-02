From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:47 +0000
Subject: [RFC PATCH 38/46] block: set ioprio for zone-reset bio
Message-Id: <20190602165055.14424-39-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-zoned.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ae7e91bd0618..0bd7981e9535 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -249,6 +249,7 @@ int blkdev_reset_zones(struct block_device *bdev,
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
 		bio_set_op_attrs(bio, REQ_OP_ZONE_RESET, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		sector += zone_sectors;
 
-- 
2.19.1
