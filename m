From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 20 Nov 2019 04:25:07 +0000
Subject: [RFC PATCH 37/39] block: update blkdev_ioctl with new trace ioctls
Message-Id: <20191120042509.12835-38-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Add newly intoduce IOCTLs so that userspace tools can call them.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/ioctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 8756efb1419e..20f60f1ede68 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -592,6 +592,10 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	case BLKTRACESTOP:
 	case BLKTRACESETUP:
 	case BLKTRACETEARDOWN:
+	case BLKTRACESETUP_EXT:
+	case BLKTRACESTART_EXT:
+	case BLKTRACESTOP_EXT:
+	case BLKTRACETEARDOWN_EXT:
 		return blk_trace_ioctl(bdev, cmd, argp);
 	case IOC_PR_REGISTER:
 		return blkdev_pr_register(bdev, argp);
-- 
2.22.1
