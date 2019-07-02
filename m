From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 02 Jul 2019 17:42:27 +0000
Subject: [PATCH V3 1/9] block: add a helper function to read nr_setcs
Message-Id: <20190702174236.3332-2-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190702174236.3332-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190702174236.3332-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, xen-devel@lists.xenproject.org, kent.overstreet@gmail.com, yuchao0@huawei.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, konrad.wilk@oracle.com, roger.pau@citrix.com, bvanassche@acm.org, linux-scsi@vger.kernel.org, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This patch introduces helper function to read the number of sectors
from struct block_device->bd_part member. For more details Please refer
to the comment in the include/linux/genhd.h for part_nr_sects_read().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/linux/blkdev.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 592669bcc536..be7ee5a0b0dd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1475,6 +1475,12 @@ static inline void put_dev_sector(Sector p)
 	put_page(p.v);
 }
 
+/* Helper function to read the bdev->bd_part->nr_sects */
+static inline sector_t bdev_nr_sects(struct block_device *bdev)
+{
+	return part_nr_sects_read(bdev->bd_part);
+}
+
 int kblockd_schedule_work(struct work_struct *work);
 int kblockd_schedule_work_on(int cpu, struct work_struct *work);
 int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
-- 
2.19.1
