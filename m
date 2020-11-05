From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Thu, 05 Nov 2020 02:40:35 +0000
Subject: [RFC PATCH 36/39] block: update blkdev_ioctl with new trace ioctls
Message-Id: <20201105024038.5831-37-chaitanya.kulkarni@wdc.com>
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
index 3fbc382eb926..94020ffffcc2 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -553,6 +553,10 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLKTRACESTART:
 	case BLKTRACESTOP:
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
