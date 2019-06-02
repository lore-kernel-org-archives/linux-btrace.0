From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:51 +0000
Subject: [RFC PATCH 42/46] null_blk: add module param discard/write-zeroes
Message-Id: <20190602165055.14424-43-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

This patch adds a two new module params discard and write-zeroes
in order to test the REQ_OP_DISACRD and REQ_OP_WRITE_ZEROES
operations.

This is needed to test latest blktrace code changes which enables
us to track more request based operations such as write-zeroes.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 37 +++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index d7ac09c092f2..93fe2c843d03 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -192,6 +192,14 @@ static unsigned int g_zone_nr_conv;
 module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);
 MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones when block device is zoned. Default: 0");
 
+static bool g_discard;
+module_param_named(discard, g_discard, bool, 0444);
+MODULE_PARM_DESC(discard, "Allow REQ_OP_DISCARD processing. Default: false");
+
+static bool g_write_zeroes;
+module_param_named(write_zeroes, g_write_zeroes, bool, 0444);
+MODULE_PARM_DESC(write_zeroes, "Allow REQ_OP_WRITE_ZEROES processing. Default: false");
+
 static struct nullb_device *null_alloc_dev(void);
 static void null_free_dev(struct nullb_device *dev);
 static void null_del_dev(struct nullb *nullb);
@@ -527,6 +535,12 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->zoned = g_zoned;
 	dev->zone_size = g_zone_size;
 	dev->zone_nr_conv = g_zone_nr_conv;
+	dev->discard = g_discard;
+	dev->write_zeroes = g_write_zeroes;
+	pr_info("null_blk: discard  %s\n",
+			dev->discard = true ? "TRUE" : "FALSE");
+	pr_info("null_blk: write_zeroes %s\n",
+			dev->write_zeroes = true ? "TRUE" : "FALSE");
 	return dev;
 }
 
@@ -1059,7 +1073,11 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 
 	sector = blk_rq_pos(rq);
 
-	if (req_op(rq) = REQ_OP_DISCARD) {
+	/* just discard for write zeroes for now */
+	switch (req_op(rq)) {
+	case REQ_OP_DISCARD:
+		/* fall through */
+	case REQ_OP_WRITE_ZEROES:
 		null_handle_discard(nullb, sector, blk_rq_bytes(rq));
 		return 0;
 	}
@@ -1093,7 +1111,11 @@ static int null_handle_bio(struct nullb_cmd *cmd)
 
 	sector = bio->bi_iter.bi_sector;
 
-	if (bio_op(bio) = REQ_OP_DISCARD) {
+	/* just discard for write zeroes for now */
+	switch (bio_op(bio)) {
+	case REQ_OP_DISCARD:
+		/* fall through */
+	case REQ_OP_WRITE_ZEROES:
 		null_handle_discard(nullb, sector,
 			bio_sectors(bio) << SECTOR_SHIFT);
 		return 0;
@@ -1192,7 +1214,6 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 		}
 	}
 	cmd->error = errno_to_blk_status(err);
-
 	if (!cmd->error && dev->zoned) {
 		sector_t sector;
 		unsigned int nr_sectors;
@@ -1402,7 +1423,7 @@ static void null_del_dev(struct nullb *nullb)
 
 static void null_config_discard(struct nullb *nullb)
 {
-	if (nullb->dev->discard = false)
+	if (!nullb->dev->discard)
 		return;
 	nullb->q->limits.discard_granularity = nullb->dev->blocksize;
 	nullb->q->limits.discard_alignment = nullb->dev->blocksize;
@@ -1410,6 +1431,13 @@ static void null_config_discard(struct nullb *nullb)
 	blk_queue_flag_set(QUEUE_FLAG_DISCARD, nullb->q);
 }
 
+static void null_config_write_zeroes(struct nullb *nullb)
+{
+	if (!nullb->dev->write_zeroes)
+		return;
+	blk_queue_max_write_zeroes_sectors(nullb->q, UINT_MAX >> 9);
+}
+
 static int null_open(struct block_device *bdev, fmode_t mode)
 {
 	return 0;
@@ -1702,6 +1730,7 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_physical_block_size(nullb->q, dev->blocksize);
 
 	null_config_discard(nullb);
+	null_config_write_zeroes(nullb);
 
 	sprintf(nullb->disk_name, "nullb%d", nullb->index);
 
-- 
2.19.1
