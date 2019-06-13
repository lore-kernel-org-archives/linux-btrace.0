From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Thu, 13 Jun 2019 14:59:50 +0000
Subject: [PATCH 3/8] blk-zoned: update blkdev_report_zone() with helper
Message-Id: <20190613145955.4813-4-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190613145955.4813-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190613145955.4813-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-scsi@vger.kernel.org, linux-btrace@vger.kernel.org, kent.overstreet@gmail.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This patch updates the blkdev_report_zone(s)() with newly introduced
helper function to read the nr_sects from block device's hd_parts with
the help of part_nr_sects_read() protected by appropriate locking.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-zoned.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 5051db35c3fd..9faf4488339d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -106,7 +106,7 @@ static bool blkdev_report_zone(struct block_device *bdev, struct blk_zone *rep)
 		return false;
 
 	rep->start -= offset;
-	if (rep->start + rep->len > bdev->bd_part->nr_sects)
+	if (rep->start + rep->len > bdev_nr_sects(bdev))
 		return false;
 
 	if (rep->type = BLK_ZONE_TYPE_CONVENTIONAL)
@@ -176,13 +176,13 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 	if (WARN_ON_ONCE(!bdev->bd_disk->fops->report_zones))
 		return -EOPNOTSUPP;
 
-	if (!*nr_zones || sector >= bdev->bd_part->nr_sects) {
+	if (!*nr_zones || sector >= bdev_nr_sects(bdev)) {
 		*nr_zones = 0;
 		return 0;
 	}
 
 	nrz = min(*nr_zones,
-		  __blkdev_nr_zones(q, bdev->bd_part->nr_sects - sector));
+		  __blkdev_nr_zones(q, bdev_nr_sects(bdev) - sector));
 	ret = blk_report_zones(bdev->bd_disk, get_start_sect(bdev) + sector,
 			       zones, &nrz, gfp_mask);
 	if (ret)
-- 
2.19.1
