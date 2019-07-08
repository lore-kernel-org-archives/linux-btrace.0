From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 08 Jul 2019 18:47:07 +0000
Subject: [PATCH V4 5/9] bcache: update cached_dev_init() with helper
Message-Id: <20190708184711.2984-6-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190708184711.2984-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190708184711.2984-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, xen-devel@lists.xenproject.org, kent.overstreet@gmail.com, yuchao0@huawei.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, konrad.wilk@oracle.com, roger.pau@citrix.com, bvanassche@acm.org, linux-scsi@vger.kernel.org, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

In the bcache when initializing the cached device we don't actually
use any sort of locking when reading the number of sectors from the
part. This patch updates the cached_dev_init() with newly introduced
helper function to read the nr_sects from block device's hd_parts with
the help of part_nr_sects_read().

Acked-by: Coly Li <colyli@suse.de>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/md/bcache/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 26e374fbf57c..024c52d11b0f 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1302,7 +1302,7 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
 			q->limits.raid_partial_stripes_expensive;
 
 	ret = bcache_device_init(&dc->disk, block_size,
-			 dc->bdev->bd_part->nr_sects - dc->sb.data_offset);
+			 bdev_nr_sects(dc->bdev) - dc->sb.data_offset);
 	if (ret)
 		return ret;
 
-- 
2.17.0
