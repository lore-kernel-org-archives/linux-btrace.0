From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 08 Jul 2019 18:47:06 +0000
Subject: [PATCH V4 4/9] blk-zoned: update blkdev_reset_zones() with helper
Message-Id: <20190708184711.2984-5-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190708184711.2984-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190708184711.2984-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, xen-devel@lists.xenproject.org, kent.overstreet@gmail.com, yuchao0@huawei.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, konrad.wilk@oracle.com, roger.pau@citrix.com, bvanassche@acm.org, linux-scsi@vger.kernel.org, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This patch updates the blkdev_reset_zones() with newly introduced
helper function to read the nr_sects from block device's hd_parts with
the help of part_nr_sects_read().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-zoned.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 9faf4488339d..e7f2874b5d37 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -229,7 +229,7 @@ int blkdev_reset_zones(struct block_device *bdev,
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
-	if (!nr_sectors || end_sector > bdev->bd_part->nr_sects)
+	if (!nr_sectors || end_sector > bdev_nr_sects(bdev))
 		/* Out of range */
 		return -EINVAL;
 
@@ -239,7 +239,7 @@ int blkdev_reset_zones(struct block_device *bdev,
 		return -EINVAL;
 
 	if ((nr_sectors & (zone_sectors - 1)) &&
-	    end_sector != bdev->bd_part->nr_sects)
+	    end_sector != bdev_nr_sects(bdev))
 		return -EINVAL;
 
 	blk_start_plug(&plug);
-- 
2.17.0
