From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 20 Nov 2019 04:24:33 +0000
Subject: [RFC PATCH 03/39] blkdev.h: add new trace ext as a queue member
Message-Id: <20191120042509.12835-4-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Update a struct queue with block trace extension.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/linux/blkdev.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 397bb9bc230b..3b2945c50a83 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -34,6 +34,7 @@ struct scsi_ioctl_command;
 struct request_queue;
 struct elevator_queue;
 struct blk_trace;
+struct blk_trace_ext;
 struct request;
 struct sg_io_hdr;
 struct bsg_job;
@@ -532,6 +533,8 @@ struct request_queue {
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace	*blk_trace;
 	struct mutex		blk_trace_mutex;
+	struct blk_trace_ext	*blk_trace_ext;
+	struct mutex		blk_trace_ext_mutex;
 #endif
 	/*
 	 * for flush operations
-- 
2.22.1
