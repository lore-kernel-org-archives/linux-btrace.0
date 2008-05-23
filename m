From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Fri, 23 May 2008 20:36:54 +0000
Subject: [RFC: Kernel Patch] Implement simple message in blktrace stream
Message-Id: <48372AE6.5080107@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010401020901030905050904"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------010401020901030905050904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------010401020901030905050904
Content-Type: text/x-diff;
 name="0001-Added-in-MESSAGE-notes-for-blktraces-sample-messag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Added-in-MESSAGE-notes-for-blktraces-sample-messag.patc";
 filename*1="h"

From 4b2e639af0c6cb8c099003c5a3fda388022e1b49 Mon Sep 17 00:00:00 2001
From: Alan D. Brunelle <alan.brunelle@hp.com>
Date: Fri, 23 May 2008 16:27:34 -0400
Subject: [PATCH] Added in MESSAGE notes for blktraces - sample message for elv switch

Allows messages to be inserted into blktrace streams. Can be used to
annotate parts separations in the blktrace stream.

(Needs cleaning up: separate elevator mods into a separate patch.)

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 block/blktrace.c             |    6 ++++++
 block/elevator.c             |    4 ++++
 include/linux/blktrace_api.h |   20 ++++++++++++++++++++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/block/blktrace.c b/block/blktrace.c
index b2cbb4e..37dec26 100644
--- a/block/blktrace.c
+++ b/block/blktrace.c
@@ -75,6 +75,12 @@ static void trace_note_time(struct blk_trace *bt)
 	local_irq_restore(flags);
 }
 
+void __trace_note_message(struct blk_trace *bt, char *msg)
+{
+	trace_note(bt, 0, BLK_TN_MESSAGE, msg, strlen(msg));
+}
+EXPORT_SYMBOL_GPL(__trace_note_message);
+
 static int act_log_check(struct blk_trace *bt, u32 what, sector_t sector,
 			 pid_t pid)
 {
diff --git a/block/elevator.c b/block/elevator.c
index 980f8ae..d9d4091 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -1051,6 +1051,7 @@ EXPORT_SYMBOL_GPL(elv_unregister);
  */
 static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 {
+	char msg[ELV_NAME_MAX +  16];
 	elevator_t *old_elevator, *e;
 	void *data;
 
@@ -1110,6 +1111,9 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	queue_flag_clear(QUEUE_FLAG_ELVSWITCH, q);
 	spin_unlock_irq(q->queue_lock);
 
+	sprintf(msg, "elv switch: %s", e->elevator_type->elevator_name);
+	blk_add_trace_msg(q, msg);
+
 	return 1;
 
 fail_register:
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index cfc3147..4409c6a 100644
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
@@ -144,6 +146,7 @@ struct blk_user_trace_setup {
 
 #ifdef __KERNEL__
 #if defined(CONFIG_BLK_DEV_IO_TRACE)
+extern void __trace_note_message(struct blk_trace *, char *);
 extern int blk_trace_ioctl(struct block_device *, unsigned, char __user *);
 extern void blk_trace_shutdown(struct request_queue *);
 extern void __blk_add_trace(struct blk_trace *, sector_t, int, int, u32, int, int, void *);
@@ -152,6 +155,22 @@ extern int do_blk_trace_setup(struct request_queue *q,
 
 
 /**
+ * blk_add_trace_msg - Add a (simple) message to the blktrace stream
+ * @q:		queue the io is for
+ * @msg:	characters to send
+ *
+ * Description:
+ *     Records a (simple) message onto the blktrace stream.
+ *
+ **/
+static inline void blk_add_trace_msg(struct request_queue *q, char *msg)
+{
+	struct blk_trace *bt = q->blk_trace;
+	if (unlikely(bt))
+		__trace_note_message(bt, msg);
+}
+
+/**
  * blk_add_trace_rq - Add a trace for a request oriented action
  * @q:		queue the io is for
  * @rq:		the source request
@@ -288,6 +307,7 @@ extern int blk_trace_startstop(struct request_queue *q, int start);
 extern int blk_trace_remove(struct request_queue *q);
 
 #else /* !CONFIG_BLK_DEV_IO_TRACE */
+#define blk_add_trace_msg(q, msg)		do { } while (0)
 #define blk_trace_ioctl(bdev, cmd, arg)		(-ENOTTY)
 #define blk_trace_shutdown(q)			do { } while (0)
 #define blk_add_trace_rq(q, rq, what)		do { } while (0)
-- 
1.5.4.3


--------------010401020901030905050904--
