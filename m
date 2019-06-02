From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:48 +0000
Subject: [RFC PATCH 39/46] block: set ioprio for flush bio
Message-Id: <20190602165055.14424-40-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-flush.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index aedd9320e605..21013fcdf42c 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -69,6 +69,7 @@
 #include <linux/blkdev.h>
 #include <linux/gfp.h>
 #include <linux/blk-mq.h>
+#include <linux/ioprio.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -445,6 +446,7 @@ int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
 	bio = bio_alloc(gfp_mask, 0);
 	bio_set_dev(bio, bdev);
 	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
+	bio_set_prio(bio, get_current_ioprio());
 
 	ret = submit_bio_wait(bio);
 
-- 
2.19.1
