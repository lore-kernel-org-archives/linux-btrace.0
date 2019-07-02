From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 02 Jul 2019 17:42:35 +0000
Subject: [COMPILE TEST ONLY PATCH V3 9/9] xen/blkback: use helper in vbd_sz()
Message-Id: <20190702174236.3332-10-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190702174236.3332-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190702174236.3332-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, xen-devel@lists.xenproject.org, kent.overstreet@gmail.com, yuchao0@huawei.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, konrad.wilk@oracle.com, roger.pau@citrix.com, bvanassche@acm.org, linux-scsi@vger.kernel.org, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This patch updates the vbd_sz() macro with newly introduced helper
function to read the nr_sects from block device's hd_parts with the
help of part_nr_sects_read().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/xen-blkback/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 1d3002d773f7..f96cb8d1cb99 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -359,7 +359,7 @@ struct pending_req {
 
 
 #define vbd_sz(_v)	((_v)->bdev->bd_part ? \
-			 (_v)->bdev->bd_part->nr_sects : \
+			  bdev_nr_sects((_v)->bdev) : \
 			  get_capacity((_v)->bdev->bd_disk))
 
 #define xen_blkif_get(_b) (atomic_inc(&(_b)->refcnt))
-- 
2.19.1
