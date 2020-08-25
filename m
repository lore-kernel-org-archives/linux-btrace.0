From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 25 Aug 2020 22:09:37 +0000
Subject: [RFC PATCH 07/39] blktrace: add core trace API
Message-Id: <20200825221009.6457-8-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 130 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index a2270818e29c..05cf30bd000f 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -462,6 +462,136 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	local_irq_restore(flags);
 }
 
+/*
+ * Data direction bit lookup
+ */
+static const u64 ddir_act_ext[2] = { BLK_TC_ACT_EXT(BLK_TC_READ),
+				 BLK_TC_ACT_EXT(BLK_TC_WRITE) };
+
+/* The ilog2() calls fall out because they're constant */
+#define MASK_TC_BIT_EXT(rw, __name) ((rw & REQ_ ## __name) << \
+	  (ilog2(BLK_TC_ ## __name) + BLK_TC_SHIFT_EXT - __REQ_ ## __name))
+
+/*
+ * The worker for the various blk_add_trace*() types. Fills out a
+ * blk_io_trace structure and places it in a per-cpu subbuffer.
+ */
+static void __blk_add_trace_ext(struct blk_trace_ext *bt, sector_t sector, int bytes,
+		     int op, int op_flags, u64 what, int error, int pdu_len,
+		     void *pdu_data, u64 cgid, u32 ioprio)
+{
+	struct task_struct *tsk = current;
+	struct ring_buffer_event *event = NULL;
+	struct trace_buffer *buffer = NULL;
+	struct blk_io_trace_ext *t;
+	unsigned long flags = 0;
+	unsigned long *sequence;
+	pid_t pid;
+	int cpu, pc = 0;
+	bool blk_tracer = blk_tracer_enabled;
+	ssize_t cgid_len = cgid ? sizeof(cgid) : 0;
+
+	if (unlikely(bt->trace_state != Blktrace_running && !blk_tracer))
+		return;
+
+	what |= ddir_act_ext[op_is_write(op) ? WRITE : READ];
+	what |= MASK_TC_BIT_EXT(op_flags, SYNC);
+	what |= MASK_TC_BIT_EXT(op_flags, RAHEAD);
+	what |= MASK_TC_BIT_EXT(op_flags, META);
+	what |= MASK_TC_BIT_EXT(op_flags, PREFLUSH);
+	what |= MASK_TC_BIT_EXT(op_flags, FUA);
+	if (op = REQ_OP_ZONE_APPEND)
+		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_APPEND);
+	if (op = REQ_OP_DISCARD || op = REQ_OP_SECURE_ERASE)
+		what |= BLK_TC_ACT_EXT(BLK_TC_DISCARD);
+	if (op = REQ_OP_FLUSH)
+		what |= BLK_TC_ACT_EXT(BLK_TC_FLUSH);
+	if (unlikely(op = REQ_OP_WRITE_ZEROES))
+		what |= BLK_TC_ACT_EXT(BLK_TC_WRITE_ZEROES);
+	if (unlikely(op = REQ_OP_ZONE_RESET))
+		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_RESET);
+	if (unlikely(op = REQ_OP_ZONE_RESET_ALL))
+		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_RESET_ALL);
+	if (unlikely(op = REQ_OP_ZONE_OPEN))
+		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_OPEN);
+	if (unlikely(op = REQ_OP_ZONE_CLOSE))
+		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_CLOSE);
+	if (unlikely(op = REQ_OP_ZONE_FINISH))
+		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_FINISH);
+
+	if (cgid)
+		what |= __BLK_TA_CGROUP;
+
+	pid = tsk->pid;
+	if (act_log_check_ext(bt, what, sector, pid))
+		return;
+	if (bt->prio_mask && !prio_log_check(bt, ioprio))
+		return;
+
+	cpu = raw_smp_processor_id();
+
+	if (blk_tracer) {
+		tracing_record_cmdline(current);
+
+		buffer = blk_tr->array_buffer.buffer;
+		pc = preempt_count();
+		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
+						  sizeof(*t) + pdu_len + cgid_len,
+						  0, pc);
+		if (!event)
+			return;
+		t = ring_buffer_event_data(event);
+		goto record_it;
+	}
+
+	if (unlikely(tsk->btrace_seq != blktrace_seq))
+		trace_note_tsk_ext(tsk, ioprio);
+
+	/*
+	 * A word about the locking here - we disable interrupts to reserve
+	 * some space in the relay per-cpu buffer, to prevent an irq
+	 * from coming in and stepping on our toes.
+	 */
+	local_irq_save(flags);
+	t = relay_reserve(bt->rchan, sizeof(*t) + pdu_len + cgid_len);
+	if (t) {
+		sequence = per_cpu_ptr(bt->sequence, cpu);
+
+		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION_EXT;
+		t->sequence = ++(*sequence);
+		t->time = ktime_to_ns(ktime_get());
+record_it:
+		/*
+		 * These two are not needed in ftrace as they are in the
+		 * generic trace_entry, filled by tracing_generic_entry_update,
+		 * but for the trace_event->bin() synthesizer benefit we do it
+		 * here too.
+		 */
+		t->cpu = cpu;
+		t->pid = pid;
+
+		t->sector = sector;
+		t->bytes = bytes;
+		t->action = what;
+		t->ioprio = ioprio;
+		t->device = bt->dev;
+		t->error = error;
+		t->pdu_len = pdu_len + cgid_len;
+
+		if (cgid_len)
+			memcpy((void *)t + sizeof(*t), &cgid, cgid_len);
+		if (pdu_len)
+			memcpy((void *)t + sizeof(*t) + cgid_len, pdu_data, pdu_len);
+
+		if (blk_tracer) {
+			trace_buffer_unlock_commit(blk_tr, buffer, event, 0, pc);
+			return;
+		}
+	}
+
+	local_irq_restore(flags);
+}
+
 static void blk_trace_free(struct blk_trace *bt)
 {
 	debugfs_remove(bt->msg_file);
-- 
2.22.1
