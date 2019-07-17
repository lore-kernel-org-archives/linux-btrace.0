From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 17 Jul 2019 21:24:00 +0000
Subject: [RFC PATCH 03/38] blkdev.h: add new trace ext as a queue member
Message-Id: <20190717212435.2990-4-chaitanya.kulkarni@wdc.com>
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
index 1ef375dafb1c..8d21c2295ca9 100644
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
@@ -528,6 +529,8 @@ struct request_queue {
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace	*blk_trace;
 	struct mutex		blk_trace_mutex;
+	struct blk_trace_ext	*blk_trace_ext;
+	struct mutex		blk_trace_ext_mutex;
 #endif
 	/*
 	 * for flush operations
-- 
2.17.0
