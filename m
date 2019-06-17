From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 17 Jun 2019 01:28:30 +0000
Subject: [PATCH V2 5/7] bcache: update cached_dev_init() with helper
Message-Id: <20190617012832.4311-6-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190617012832.4311-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190617012832.4311-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, kent.overstreet@gmail.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

In the bcache when initializing the device we don't actually use any
sort of locking when reading the number of sectors from the part. This
patch updates the cached_dev_init() with newly introduced helper
function to read the nr_sects from block device's hd_parts with the help
of part_nr_sects_read().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/md/bcache/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 1b63ac876169..6a29ba89dae1 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1263,7 +1263,7 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
 			q->limits.raid_partial_stripes_expensive;
 
 	ret = bcache_device_init(&dc->disk, block_size,
-			 dc->bdev->bd_part->nr_sects - dc->sb.data_offset);
+			 bdev_nr_sects(dc->bdev) - dc->sb.data_offset);
 	if (ret)
 		return ret;
 
-- 
2.19.1
