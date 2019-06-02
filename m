From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:50 +0000
Subject: [RFC PATCH 41/46] null_blk: add write-zeroes flag to nullb_device
Message-Id: <20190602165055.14424-42-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

This patch adds a new write-zeroes flag just like discard under
struct null_blk to enable REQ_OP_WRITE_ZEROES operation on the null_blk.

This is needed for testing the blktrace extension with different
priorities on write-zeroes operation.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 34b22d6523ba..ecd1e45f6eb9 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -63,6 +63,7 @@ struct nullb_device {
 	bool power; /* power on/off the device */
 	bool memory_backed; /* if data is stored in memory */
 	bool discard; /* if support discard */
+	bool write_zeroes; /* if support write_zeroes */
 	bool zoned; /* if device is zoned */
 };
 
-- 
2.19.1
