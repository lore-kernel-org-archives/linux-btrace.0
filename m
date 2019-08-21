From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 21 Aug 2019 06:14:16 +0000
Subject: [PATCH V5 2/9] blk-zoned: update blkdev_nr_zones() with helper
Message-Id: <20190821061423.3408-3-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190821061423.3408-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190821061423.3408-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, xen-devel@lists.xenproject.org, kent.overstreet@gmail.com, yuchao0@huawei.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, konrad.wilk@oracle.com, roger.pau@citrix.com, bvanassche@acm.org, linux-scsi@vger.kernel.org, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This patch updates the blkdev_nr_zones() with newly introduced helper
function to read the nr_sects from block device's hd_parts with the
help if part_nr_sects_read().

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 4bc5f260248a..3f5e9bf03486 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -93,7 +93,7 @@ unsigned int blkdev_nr_zones(struct block_device *bdev)
 	if (!blk_queue_is_zoned(q))
 		return 0;
 
-	return __blkdev_nr_zones(q, bdev->bd_part->nr_sects);
+	return __blkdev_nr_zones(q, bdev_nr_sects(bdev));
 }
 EXPORT_SYMBOL_GPL(blkdev_nr_zones);
 
-- 
2.17.0
