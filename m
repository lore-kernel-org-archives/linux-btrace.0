From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 28 May 2008 12:13:29 +0000
Subject: Re: [PATCH] Changed blk trace msgs to directly use relay buffer
Message-Id: <20080528121329.GU25504@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <483C1C5A.5000001@hp.com>
In-Reply-To: <483C1C5A.5000001@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-btrace@vger.kernel.org

On Tue, May 27 2008, Alan D. Brunelle wrote:

> From 43c8ea2b78f31d7ccd349384a9a2084e787aafc1 Mon Sep 17 00:00:00 2001
> From: Alan D. Brunelle <alan.brunelle@hp.com>
> Date: Tue, 27 May 2008 10:32:36 -0400
> Subject: [PATCH] Changed blk trace msgs to directly use relay buffer
> 
> Allows for SMP-usage without corruption, and removes an extra copy at
> the expense of copying extra bytes. Reduced message size from 1024 to 128.

Or, alternatively, something like the below. Then we don't
unconditionally reserve and copy 128 bytes for each message, at the
cost 128 bytes per-cpu per trace.

diff --git a/block/blktrace.c b/block/blktrace.c
index 20e11f3..7ae87cc 100644
--- a/block/blktrace.c
+++ b/block/blktrace.c
@@ -79,13 +79,16 @@ void __trace_note_message(struct blk_trace *bt, const char *fmt, ...)
 {
 	int n;
 	va_list args;
-	static char bt_msg_buf[BLK_TN_MAX_MSG];
+	char *buf;
 
+	preempt_disable();
+	buf = per_cpu_ptr(bt->msg_data, smp_processor_id());
 	va_start(args, fmt);
-	n = vscnprintf(bt_msg_buf, BLK_TN_MAX_MSG, fmt, args);
+	n = vscnprintf(buf, BLK_TN_MAX_MSG, fmt, args);
 	va_end(args);
 
-	trace_note(bt, 0, BLK_TN_MESSAGE, bt_msg_buf, n);
+	trace_note(bt, 0, BLK_TN_MESSAGE, buf, n);
+	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(__trace_note_message);
 
@@ -246,6 +249,7 @@ static void blk_trace_cleanup(struct blk_trace *bt)
 	debugfs_remove(bt->dropped_file);
 	blk_remove_tree(bt->dir);
 	free_percpu(bt->sequence);
+	free_percpu(bt->msg_data);
 	kfree(bt);
 }
 
@@ -360,6 +364,10 @@ int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!bt->sequence)
 		goto err;
 
+	bt->msg_data = __alloc_percpu(BLK_TN_MAX_MSG);
+	if (!bt->msg_data)
+		goto err;
+
 	ret = -ENOENT;
 	dir = blk_create_tree(buts->name);
 	if (!dir)
@@ -406,6 +414,7 @@ err:
 		if (bt->dropped_file)
 			debugfs_remove(bt->dropped_file);
 		free_percpu(bt->sequence);
+		free_percpu(bt->msg_data);
 		if (bt->rchan)
 			relay_close(bt->rchan);
 		kfree(bt);
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index b7cd8f1..e3ef903 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -121,6 +121,7 @@ struct blk_trace {
 	int trace_state;
 	struct rchan *rchan;
 	unsigned long *sequence;
+	unsigned char *msg_data;
 	u16 act_mask;
 	u64 start_lba;
 	u64 end_lba;
@@ -172,7 +173,7 @@ extern void __trace_note_message(struct blk_trace *, const char *fmt, ...);
 		if (unlikely(bt))					\
 			__trace_note_message(bt, fmt, ##__VA_ARGS__);	\
 	} while (0)
-#define BLK_TN_MAX_MSG		1024
+#define BLK_TN_MAX_MSG		128
 
 /**
  * blk_add_trace_rq - Add a trace for a request oriented action

-- 
Jens Axboe

