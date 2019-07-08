From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 08 Jul 2019 18:47:08 +0000
Subject: [PATCH V4 6/9] f2fs: use helper in init_blkz_info()
Message-Id: <20190708184711.2984-7-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190708184711.2984-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190708184711.2984-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, xen-devel@lists.xenproject.org, kent.overstreet@gmail.com, yuchao0@huawei.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, konrad.wilk@oracle.com, roger.pau@citrix.com, bvanassche@acm.org, linux-scsi@vger.kernel.org, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This patch updates the init_blkz_info() with newly introduced helper
function to read the nr_sects from block device's hd_parts with the
help of part_nr_sects_read().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6b959bbb336a..24e2848afcf5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2798,7 +2798,7 @@ static int init_percpu_info(struct f2fs_sb_info *sbi)
 static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 {
 	struct block_device *bdev = FDEV(devi).bdev;
-	sector_t nr_sectors = bdev->bd_part->nr_sects;
+	sector_t nr_sectors = bdev_nr_sects(bdev);
 	sector_t sector = 0;
 	struct blk_zone *zones;
 	unsigned int i, nr_zones;
-- 
2.17.0
