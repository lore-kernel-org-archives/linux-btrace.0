From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Thu, 13 Jun 2019 14:59:53 +0000
Subject: [COMPILE TESTED PATCH 6/8] target/pscsi: use helper in pscsi_get_blocks()
Message-Id: <20190613145955.4813-7-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190613145955.4813-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190613145955.4813-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-scsi@vger.kernel.org, linux-btrace@vger.kernel.org, kent.overstreet@gmail.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This patch updates the pscsi_get_blocks() with newly introduced helper
function to read the nr_sects from block device's hd_parts with the
help if part_nr_sects_read() protected by appropriate locking.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/target/target_core_pscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index c9d92b3e777d..da481edab2de 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -1030,7 +1030,7 @@ static sector_t pscsi_get_blocks(struct se_device *dev)
 	struct pscsi_dev_virt *pdv = PSCSI_DEV(dev);
 
 	if (pdv->pdv_bd && pdv->pdv_bd->bd_part)
-		return pdv->pdv_bd->bd_part->nr_sects;
+		return bdev_nr_sects(pdv->pdv_bd);
 
 	return 0;
 }
-- 
2.19.1
