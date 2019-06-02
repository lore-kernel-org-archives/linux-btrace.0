From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:15 +0000
Subject: [RFC PATCH 06/46] blktrace: add trace note APIs
Message-Id: <20190602165055.14424-7-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 114 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 0741dd11531f..e6b0a914cb85 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -112,6 +112,53 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 	}
 }
 
+static void trace_note_ext(struct blk_trace_ext *bt, pid_t pid, u64 action,
+			   const void *data, size_t len,
+			   union kernfs_node_id *cgid, u32 ioprio)
+{
+	struct blk_io_trace_ext *t;
+	struct ring_buffer_event *event = NULL;
+	struct ring_buffer *buffer = NULL;
+	int pc = 0;
+	int cpu = smp_processor_id();
+	bool blk_tracer = blk_tracer_enabled;
+	ssize_t cgid_len = cgid ? sizeof(*cgid) : 0;
+
+	if (blk_tracer) {
+		buffer = blk_tr->trace_buffer.buffer;
+		pc = preempt_count();
+		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
+						  sizeof(*t) + len + cgid_len,
+						  0, pc);
+		if (!event)
+			return;
+		t = ring_buffer_event_data(event);
+		goto record_it;
+	}
+
+	if (!bt->rchan)
+		return;
+
+	t = relay_reserve(bt->rchan, sizeof(*t) + len + cgid_len);
+	if (t) {
+		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION_EXT;
+		t->time = ktime_to_ns(ktime_get());
+record_it:
+		t->device = bt->dev;
+		t->action = action | (cgid ? __BLK_TN_CGROUP : 0);
+		t->ioprio = ioprio;
+		t->pid = pid;
+		t->cpu = cpu;
+		t->pdu_len = len + cgid_len;
+		if (cgid)
+			memcpy((void *)t + sizeof(*t), cgid, cgid_len);
+		memcpy((void *) t + sizeof(*t) + cgid_len, data, len);
+
+		if (blk_tracer)
+			trace_buffer_unlock_commit(blk_tr, buffer, event, 0, pc);
+	}
+}
+
 /*
  * Send out a notify for this process, if we haven't done so since a trace
  * started
@@ -130,6 +177,20 @@ static void trace_note_tsk(struct task_struct *tsk)
 	spin_unlock_irqrestore(&running_trace_lock, flags);
 }
 
+static void trace_note_tsk_ext(struct task_struct *tsk, u32 ioprio)
+{
+	unsigned long flags;
+	struct blk_trace_ext *bt;
+
+	tsk->btrace_seq = blktrace_seq;
+	spin_lock_irqsave(&running_trace_ext_lock, flags);
+	list_for_each_entry(bt, &running_trace_ext_list, running_ext_list) {
+		trace_note_ext(bt, tsk->pid, BLK_TN_PROCESS_EXT, tsk->comm,
+			   sizeof(tsk->comm), NULL, ioprio);
+	}
+	spin_unlock_irqrestore(&running_trace_ext_lock, flags);
+}
+
 static void trace_note_time(struct blk_trace *bt)
 {
 	struct timespec64 now;
@@ -146,6 +207,22 @@ static void trace_note_time(struct blk_trace *bt)
 	local_irq_restore(flags);
 }
 
+static void trace_note_time_ext(struct blk_trace_ext *bt)
+{
+	struct timespec64 now;
+	unsigned long flags;
+	u32 words[2];
+
+	/* need to check user space to see if this breaks in y2038 or y2106 */
+	ktime_get_real_ts64(&now);
+	words[0] = (u32)now.tv_sec;
+	words[1] = now.tv_nsec;
+
+	local_irq_save(flags);
+	trace_note_ext(bt, 0, BLK_TN_TIMESTAMP, words, sizeof(words), NULL, 0);
+	local_irq_restore(flags);
+}
+
 void __trace_note_message(struct blk_trace *bt, struct blkcg *blkcg,
 	const char *fmt, ...)
 {
@@ -183,6 +260,43 @@ void __trace_note_message(struct blk_trace *bt, struct blkcg *blkcg,
 }
 EXPORT_SYMBOL_GPL(__trace_note_message);
 
+void __trace_note_message_ext(struct blk_trace_ext *bt, struct blkcg *blkcg,
+	const char *fmt, ...)
+{
+	int n;
+	va_list args;
+	unsigned long flags;
+	char *buf;
+
+	if (unlikely(bt->trace_state != Blktrace_running &&
+		     !blk_tracer_enabled))
+		return;
+
+	/*
+	 * If the BLK_TC_NOTIFY action mask isn't set, don't send any note
+	 * message to the trace.
+	 */
+	if (!(bt->act_mask & BLK_TC_NOTIFY))
+		return;
+
+	local_irq_save(flags);
+	buf = this_cpu_ptr(bt->msg_data);
+	va_start(args, fmt);
+	n = vscnprintf(buf, BLK_TN_MAX_MSG, fmt, args);
+	va_end(args);
+
+	if (!(blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP))
+		blkcg = NULL;
+#ifdef CONFIG_BLK_CGROUP
+	trace_note_ext(bt, 0, BLK_TN_MESSAGE_EXT, buf, n,
+		blkcg ? cgroup_get_kernfs_id(blkcg->css.cgroup) : NULL, 0);
+#else
+	trace_note_ext(bt, 0, BLK_TN_MESSAGE_EXT, buf, n, NULL, 0);
+#endif
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(__trace_note_message_ext);
+
 static int act_log_check(struct blk_trace *bt, u32 what, sector_t sector,
 			 pid_t pid)
 {
-- 
2.19.1
