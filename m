From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 27 May 2008 12:44:06 +0000
Subject: [PATCH 1/2] Added in MESSAGE notes for blktraces
Message-Id: <483C0216.70008@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-btrace@vger.kernel.org


Allows messages to be inserted into blktrace streams.

Associated blkparse patches will be posted to linux-btrace & may also be
found at:

http://free.linux.hp.com/~adb/blktrace/0001-Added-in-handling-of-MESSAGE-notes.patch
http://free.linux.hp.com/~adb/blktrace/0002-Added-in-new-message-updates-to-the-documentation.patch

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 block/blktrace.c             |   14 ++++++++++++++
 include/linux/blktrace_api.h |   25 +++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/block/blktrace.c b/block/blktrace.c
index b2cbb4e..20e11f3 100644
--- a/block/blktrace.c
+++ b/block/blktrace.c
@@ -75,6 +75,20 @@ static void trace_note_time(struct blk_trace *bt)
 	local_irq_restore(flags);
 }

+void __trace_note_message(struct blk_trace *bt, const char *fmt, ...)
+{
+	int n;
+	va_list args;
+	static char bt_msg_buf[BLK_TN_MAX_MSG];
+
+	va_start(args, fmt);
+	n = vscnprintf(bt_msg_buf, BLK_TN_MAX_MSG, fmt, args);
+	va_end(args);
+
+	trace_note(bt, 0, BLK_TN_MESSAGE, bt_msg_buf, n);
+}
+EXPORT_SYMBOL_GPL(__trace_note_message);
+
 static int act_log_check(struct blk_trace *bt, u32 what, sector_t sector,
 			 pid_t pid)
 {
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index cfc3147..b7cd8f1 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -55,6 +55,7 @@ enum blktrace_act {
 enum blktrace_notify {
 	__BLK_TN_PROCESS = 0,		/* establish pid/name mapping */
 	__BLK_TN_TIMESTAMP,		/* include system clock */
+	__BLK_TN_MESSAGE,		/* Character string message */
 };


@@ -79,6 +80,7 @@ enum blktrace_notify {

 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
+#define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))

 #define BLK_IO_TRACE_MAGIC	0x65617400
 #define BLK_IO_TRACE_VERSION	0x07
@@ -149,7 +151,28 @@ extern void blk_trace_shutdown(struct request_queue *);
 extern void __blk_add_trace(struct blk_trace *, sector_t, int, int,
u32, int, int, void *);
 extern int do_blk_trace_setup(struct request_queue *q,
 	char *name, dev_t dev, struct blk_user_trace_setup *buts);
+extern void __trace_note_message(struct blk_trace *, const char *fmt, ...);

+/**
+ * blk_add_trace_msg - Add a (simple) message to the blktrace stream
+ * @q:		queue the io is for
+ * @fmt:	format to print message in
+ * args...	Variable argument list for format
+ *
+ * Description:
+ *     Records a (simple) message onto the blktrace stream.
+ *
+ *     NOTE: BLK_TN_MAX_MSG characters are output at most.
+ *     NOTE: Can not use 'static inline' due to presence of var args...
+ *
+ **/
+#define blk_add_trace_msg(q, fmt, ...)					\
+	do {								\
+		struct blk_trace *bt = (q)->blk_trace;			\
+		if (unlikely(bt))					\
+			__trace_note_message(bt, fmt, ##__VA_ARGS__);	\
+	} while (0)
+#define BLK_TN_MAX_MSG		1024

 /**
  * blk_add_trace_rq - Add a trace for a request oriented action
@@ -299,6 +322,8 @@ extern int blk_trace_remove(struct request_queue *q);
 #define blk_trace_setup(q, name, dev, arg)	(-ENOTTY)
 #define blk_trace_startstop(q, start)		(-ENOTTY)
 #define blk_trace_remove(q)			(-ENOTTY)
+#define blk_add_trace_msg(q, fmt, ...)		do { } while (0)
+
 #endif /* CONFIG_BLK_DEV_IO_TRACE */
 #endif /* __KERNEL__ */
 #endif
-- 
1.5.4.3

