From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 23 Mar 2020 16:29:46 +0000
Subject: [RFC PATCH 03/39] blkdev.h: add new trace ext as a queue member
Message-Id: <20200323163022.30688-4-chaitanya.kulkarni@wdc.com>
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
index f629d40c645c..13ccdfbf7c32 100644
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
@@ -526,6 +527,8 @@ struct request_queue {
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace __rcu	*blk_trace;
 	struct mutex		blk_trace_mutex;
+	struct blk_trace_ext __rcu *blk_trace_ext;
+	struct mutex		blk_trace_ext_mutex;
 #endif
 	/*
 	 * for flush operations
-- 
2.22.0
