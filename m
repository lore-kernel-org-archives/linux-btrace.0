From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 26 Jan 2021 23:33:25 +0000
Subject: [RFC PATCH 03/38] blkdev.h: add new trace ext as a queue member
Message-Id: <20210126233400.31259-4-chaitanya.kulkarni@wdc.com>
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
index f94ee3089e01..0259ff1b1d30 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -533,6 +533,7 @@ struct request_queue {
 	struct mutex		debugfs_mutex;
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace __rcu	*blk_trace;
+	struct blk_trace_ext __rcu	*blk_trace_ext;
 #endif
 	/*
 	 * for flush operations
-- 
2.22.1
