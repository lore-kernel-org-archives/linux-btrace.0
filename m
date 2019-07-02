From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 02 Jul 2019 17:42:28 +0000
Subject: [PATCH V3 2/9] blk-zoned: update blkdev_nr_zones() with helper
Message-Id: <20190702174236.3332-3-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190702174236.3332-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190702174236.3332-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, xen-devel@lists.xenproject.org, kent.overstreet@gmail.com, yuchao0@huawei.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, konrad.wilk@oracle.com, roger.pau@citrix.com, bvanassche@acm.org, linux-scsi@vger.kernel.org, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This patch updates the blkdev_nr_zones() with newly introduced helper
function to read the nr_sects from block device's hd_parts with the
help if part_nr_sects_read().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ae7e91bd0618..5051db35c3fd 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -90,7 +90,7 @@ unsigned int blkdev_nr_zones(struct block_device *bdev)
 	if (!blk_queue_is_zoned(q))
 		return 0;
 
-	return __blkdev_nr_zones(q, bdev->bd_part->nr_sects);
+	return __blkdev_nr_zones(q, bdev_nr_sects(bdev));
 }
 EXPORT_SYMBOL_GPL(blkdev_nr_zones);
 
-- 
2.19.1
