From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 25 Aug 2020 22:09:33 +0000
Subject: [RFC PATCH 03/39] blkdev.h: add new trace ext as a queue member
Message-Id: <20200825221009.6457-4-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Update a struct queue with block trace extension.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/linux/blkdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bb5636cc17b9..cd3ba7781843 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -529,6 +529,7 @@ struct request_queue {
 	struct mutex		debugfs_mutex;
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace __rcu	*blk_trace;
+	struct blk_trace_ext __rcu	*blk_trace_ext;
 #endif
 	/*
 	 * for flush operations
-- 
2.22.1
