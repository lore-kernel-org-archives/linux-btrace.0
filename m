From: Steven Whitehouse <swhiteho@redhat.com>
Date: Thu, 19 Feb 2009 16:55:39 +0000
Subject: GFS2: Add blktrace support to glocks
Message-Id: <1235062539.9571.771.camel@quoit>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org
Cc: axboe@kernel.dk

Hi,

Since I last posted this pair of patches, I've done some extensive
updating of the kernel patch, so it should now be happy to compile
under all possible Kconfigs (fingers crossed) and also its a fair
bit cleaner too.

I'm adding the linux-btrace list, since I didn't know about that
list when I made the initial posting.

Since there is probably more GFS2 changes than blktrace changes, I
could push this through the GFS2 tree. Let me know if you'd prefer
it to go via the blktrace tree. I'd like to be able to push this
in at the next merge window if possible. This patch is against the
head of the GFS2 -nmw git tree (obviously that makes no difference
to the blktrace side of the patch).

An updated blktrace userland patch follows in the next email, although
the changes from the last version are fairly minor,

Steve.

From 68ebfea9d79d9b5123e17a3345b7ebe39c8575f9 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Thu, 19 Feb 2009 15:38:29 +0000
Subject: [PATCH] GFS2: Add blktrace support to glocks

Glocks are the cache control subsystem for GFS2. It is very useful
to be able to trace the state changes of the glocks using the
same set of sequence numbers as the I/O requests, since this
allows us to see if there are any ordering errors.

The interface uses DLM lock modes so that hopefully it is generic
enough that other cluster filesystems might be able to use the
same interface.

Glocks are identified by two numbers: the type number and the glock
number. The latter is (for most glocks) based upon the disk block number
of the object (inode, resource group, etc) which it protects and for the
other glocks, its a small integer. I think it makes sense to use the
existing sector field for this. The type number is reported as part of
the struct blk_trace_io_glock. I've also added a flags field to that
structure (currently unused) in case of future need.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>

diff --git a/block/blktrace.c b/block/blktrace.c
index b0a2cae..4caa452 100644
--- a/block/blktrace.c
+++ b/block/blktrace.c
@@ -38,8 +38,8 @@ static void blk_unregister_tracepoints(void);
 /*
  * Send out a notify message.
  */
-static void trace_note(struct blk_trace *bt, pid_t pid, int action,
-		       const void *data, size_t len)
+static void trace_note(struct blk_trace *bt, sector_t sector, pid_t pid, 
+		       int action, const void *data, size_t len, int seq)
 {
 	struct blk_io_trace *t;
 
@@ -48,11 +48,17 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 		const int cpu = smp_processor_id();
 
 		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
+		if (seq) {
+			unsigned long *sequence = per_cpu_ptr(bt->sequence, cpu);
+			t->sequence = ++(*sequence);
+		}
 		t->time = ktime_to_ns(ktime_get());
+		t->sector = sector;
 		t->device = bt->dev;
 		t->action = action;
 		t->pid = pid;
 		t->cpu = cpu;
+		t->error = 0;
 		t->pdu_len = len;
 		memcpy((void *) t + sizeof(*t), data, len);
 	}
@@ -65,7 +71,7 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 static void trace_note_tsk(struct blk_trace *bt, struct task_struct *tsk)
 {
 	tsk->btrace_seq = blktrace_seq;
-	trace_note(bt, tsk->pid, BLK_TN_PROCESS, tsk->comm, sizeof(tsk->comm));
+	trace_note(bt, 0, tsk->pid, BLK_TN_PROCESS, tsk->comm, sizeof(tsk->comm), 0);
 }
 
 static void trace_note_time(struct blk_trace *bt)
@@ -79,7 +85,7 @@ static void trace_note_time(struct blk_trace *bt)
 	words[1] = now.tv_nsec;
 
 	local_irq_save(flags);
-	trace_note(bt, 0, BLK_TN_TIMESTAMP, words, sizeof(words));
+	trace_note(bt, 0, 0, BLK_TN_TIMESTAMP, words, sizeof(words), 0);
 	local_irq_restore(flags);
 }
 
@@ -96,7 +102,7 @@ void __trace_note_message(struct blk_trace *bt, const char *fmt, ...)
 	n = vscnprintf(buf, BLK_TN_MAX_MSG, fmt, args);
 	va_end(args);
 
-	trace_note(bt, 0, BLK_TN_MESSAGE, buf, n);
+	trace_note(bt, 0, 0, BLK_TN_MESSAGE, buf, n, 0);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(__trace_note_message);
@@ -797,6 +803,55 @@ static void blk_add_trace_remap(struct request_queue *q, struct bio *bio,
 }
 
 /**
+ * blk_add_trace_glock - Add a trace message about a glock
+ * @bdev: The block device in question
+ * @gltype: The type of the glock
+ * @glnum: The glock number
+ * @cur_state: The current state of the glock (always sent)
+ * @new_state: If the state has changed, this is the new state (maybe 0)
+ * @tgt_state: The target lock state (maybe 0)
+ * @dmt_state: The current requested demote state (maybe 0)
+ *
+ * The states are DLM lock states in order to make this a generic
+ * interface, even though its initial use is restricted to glocks.
+ *
+ */
+
+void blk_add_trace_glock(struct block_device *bdev, u32 gltype, sector_t glnum,
+			 u8 cur_state, u8 new_state, u8 tgt_state, u8 dmt_state)
+{
+	struct task_struct *tsk = current;
+	struct request_queue *rq = bdev_get_queue(bdev);
+	struct blk_trace *bt = rq->blk_trace;
+	struct blk_io_trace_glock g;
+	unsigned long flags;
+	pid_t pid;
+
+	if (likely(!bt))
+		return;
+	if (unlikely(bt->trace_state != Blktrace_running))
+		return;
+
+	pid = tsk->pid;
+	if (unlikely(act_log_check(bt, BLK_TN_GLOCK, glnum, pid)))
+		return;
+
+	g.type = cpu_to_be32(gltype);
+	g.flags = 0;
+	g.cur_state = cur_state;
+	g.new_state = new_state;
+	g.dmt_state = dmt_state;
+	g.tgt_state = tgt_state;
+
+	local_irq_save(flags);
+	if (unlikely(tsk->btrace_seq != blktrace_seq))
+		trace_note_tsk(bt, tsk);
+	trace_note(bt, glnum, pid, BLK_TN_GLOCK, &g, sizeof(g), 1);
+	local_irq_restore(flags);
+};
+EXPORT_SYMBOL_GPL(blk_add_trace_glock);
+
+/**
  * blk_add_driver_data - Add binary message with driver-specific data
  * @q:		queue the io is for
  * @rq:		io request
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 3984e47..3454272 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -27,6 +27,8 @@
 #include <linux/freezer.h>
 #include <linux/workqueue.h>
 #include <linux/jiffies.h>
+#include <trace/gfs2.h>
+#include <linux/blktrace_api.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -40,6 +42,10 @@
 #include "util.h"
 #include "bmap.h"
 
+DEFINE_TRACE(gfs2_glock_state_change);
+DEFINE_TRACE(gfs2_glock_put);
+DEFINE_TRACE(gfs2_demote_rq);
+
 struct gfs2_gl_hash_bucket {
         struct hlist_head hb_list;
 };
@@ -155,7 +161,7 @@ static void glock_free(struct gfs2_glock *gl)
 
 	if (aspace)
 		gfs2_aspace_put(aspace);
-
+	trace_gfs2_glock_put(gl);
 	sdp->sd_lockstruct.ls_ops->lm_put_lock(gfs2_glock_cachep, gl);
 }
 
@@ -422,6 +428,7 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 	int rv;
 
 	spin_lock(&gl->gl_spin);
+	trace_gfs2_glock_state_change(gl, state);
 	state_change(gl, state);
 	gh = find_first_waiter(gl);
 
@@ -836,6 +843,7 @@ static void handle_callback(struct gfs2_glock *gl, unsigned int state,
 			gl->gl_demote_state != state) {
 		gl->gl_demote_state = LM_ST_UNLOCKED;
 	}
+	trace_gfs2_demote_rq(gl);
 }
 
 /**
@@ -1685,10 +1693,92 @@ static int gfs2_dump_lockstate(struct gfs2_sbd *sdp)
 	return error;
 }
 
+static inline u8 glock_trace_state(unsigned int state)
+{
+	switch(state) {
+	case LM_ST_SHARED:
+		return BLK_GLS_PREAD;
+	case LM_ST_DEFERRED:
+		return BLK_GLS_CWRITE;
+	case LM_ST_EXCLUSIVE:
+		return BLK_GLS_EXCLUSIVE;
+	}
+	return BLK_GLS_NULL;
+}
+
+/**
+ * gfs2_trace_state_change - Trace glock state change event
+ * @gl: The glock whose state has changed
+ * @new_state: The new state (gl->gl_state still points to the old state)
+ *
+ * This is rather complicated as it has to deal with many different
+ * possible state changes :(
+ */
+
+static void gfs2_trace_state_change(struct gfs2_glock *gl,
+				    unsigned int new_state)
+{
+	struct gfs2_sbd *sdp = gl->gl_sbd;
+	struct block_device *bdev = sdp->sd_vfs->s_bdev;
+	u8 cur_state = BLK_GLS_NONE, dmt_state = 0;
+
+	/* Deal with special case of first promotion of lock */
+	if (likely(test_bit(GLF_TRACE_INITIAL, &gl->gl_flags)))
+                        cur_state = glock_trace_state(gl->gl_state);
+
+	/* Include demote state iff it is valid */
+	if (test_bit(GLF_DEMOTE, &gl->gl_flags) ||
+	    test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags))
+		dmt_state = glock_trace_state(gl->gl_demote_state);
+	blk_add_trace_glock(bdev, gl->gl_name.ln_type, gl->gl_name.ln_number,
+			    cur_state, glock_trace_state(new_state),
+			    glock_trace_state(gl->gl_target), dmt_state);
+	set_bit(GLF_TRACE_INITIAL, &gl->gl_flags);
+}
+
+/**
+ * gfs2_trace_glock_put - Trace final demotion/disposal of glock
+ * @gl: The glock which will be freed
+ *
+ */
+
+static void gfs2_trace_glock_put(struct gfs2_glock *gl)
+{
+	struct gfs2_sbd *sdp = gl->gl_sbd;
+	struct block_device *bdev = sdp->sd_vfs->s_bdev;
+	u8 cur_state = BLK_GLS_NONE;
+
+	 /* Deal with special case of lock never used */
+	if (likely(test_bit(GLF_TRACE_INITIAL, &gl->gl_flags)))
+		cur_state = glock_trace_state(gl->gl_state);
+
+	blk_add_trace_glock(bdev, gl->gl_name.ln_type, gl->gl_name.ln_number,
+			    cur_state, BLK_GLS_NONE, 0, 0);
+}
+
+/**
+ * gfs2_trace_demote_rq - Trace demote requests received
+ * @gl: The glock which has received the request
+ *
+ * This fires when the request is received. Its a pity that we
+ * cannot log from whence the request came :(
+ */
+
+static void gfs2_trace_demote_rq(struct gfs2_glock *gl)
+{
+	struct gfs2_sbd *sdp = gl->gl_sbd;
+	struct block_device *bdev = sdp->sd_vfs->s_bdev;
+
+	blk_add_trace_glock(bdev, gl->gl_name.ln_type, gl->gl_name.ln_number,
+			    glock_trace_state(gl->gl_state), 0, 0,
+			    glock_trace_state(gl->gl_demote_state));
+}
 
 int __init gfs2_glock_init(void)
 {
 	unsigned i;
+	int rv;
+
 	for(i = 0; i < GFS2_GL_HASH_SIZE; i++) {
 		INIT_HLIST_HEAD(&gl_hash_table[i].hb_list);
 	}
@@ -1703,6 +1793,12 @@ int __init gfs2_glock_init(void)
 		return PTR_ERR(glock_workqueue);
 
 	register_shrinker(&glock_shrinker);
+	rv = register_trace_gfs2_glock_state_change(gfs2_trace_state_change);
+	WARN_ON(rv && rv != -ENOSYS);
+	rv = register_trace_gfs2_glock_put(gfs2_trace_glock_put);
+	WARN_ON(rv && rv != -ENOSYS);
+	rv = register_trace_gfs2_demote_rq(gfs2_trace_demote_rq);
+	WARN_ON(rv && rv != -ENOSYS);
 
 	return 0;
 }
@@ -1711,6 +1807,9 @@ void gfs2_glock_exit(void)
 {
 	unregister_shrinker(&glock_shrinker);
 	destroy_workqueue(glock_workqueue);
+	unregister_trace_gfs2_glock_state_change(gfs2_trace_state_change);
+	unregister_trace_gfs2_glock_put(gfs2_trace_glock_put);
+	unregister_trace_gfs2_demote_rq(gfs2_trace_demote_rq);
 }
 
 static int gfs2_glock_iter_next(struct gfs2_glock_iter *gi)
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 980a086..3192cc3 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -189,6 +189,7 @@ enum {
 	GLF_REPLY_PENDING		= 9,
 	GLF_INITIAL			= 10,
 	GLF_FROZEN			= 11,
+	GLF_TRACE_INITIAL		= 12,
 };
 
 struct gfs2_glock {
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 1dba349..0eb2619 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -62,6 +62,7 @@ enum blktrace_notify {
 	__BLK_TN_PROCESS = 0,		/* establish pid/name mapping */
 	__BLK_TN_TIMESTAMP,		/* include system clock */
 	__BLK_TN_MESSAGE,		/* Character string message */
+	__BLK_TN_GLOCK,			/* Glock data */
 };
 
 
@@ -89,6 +90,7 @@ enum blktrace_notify {
 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))
+#define BLK_TN_GLOCK		(__BLK_TN_GLOCK | BLK_TC_ACT(BLK_TC_NOTIFY))
 
 #define BLK_IO_TRACE_MAGIC	0x65617400
 #define BLK_IO_TRACE_VERSION	0x07
@@ -119,6 +121,29 @@ struct blk_io_trace_remap {
 	__be64 sector;
 };
 
+/* Glock lock states, so we don't need to add any header deps */
+enum {
+	BLK_GLS_NONE = 1, 	/* i.e. invalid */
+	BLK_GLS_NULL,		/* Null lock (preserves LVB content) */
+	BLK_GLS_CREAD,		/* Concurrent read */
+	BLK_GLS_CWRITE,		/* Concurrent write */
+	BLK_GLS_PREAD,		/* Protected read */
+	BLK_GLS_PWRITE,		/* Protected write */
+	BLK_GLS_EXCLUSIVE,	/* Exclusive */
+};
+
+/*
+ * Glock info
+ */
+struct blk_io_trace_glock {
+	__be32 type;	/* Glock type, as per gl_name.ln_type */
+	__be32 flags;	/* Flags, currently unused */
+	u8 cur_state;	/* Current state */
+	u8 new_state;	/* New state */
+	u8 dmt_state;	/* Requested demote state */
+	u8 tgt_state;	/* Target state */
+};
+
 enum {
 	Blktrace_setup = 1,
 	Blktrace_running,
@@ -191,7 +216,9 @@ extern int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 			   char __user *arg);
 extern int blk_trace_startstop(struct request_queue *q, int start);
 extern int blk_trace_remove(struct request_queue *q);
-
+extern void blk_add_trace_glock(struct block_device *bdev, u32 gltype,
+				sector_t glnum, u8 cur_state, u8 new_state,
+				u8 tgt_state, u8 dmt_state);
 #else /* !CONFIG_BLK_DEV_IO_TRACE */
 #define blk_trace_ioctl(bdev, cmd, arg)		(-ENOTTY)
 #define blk_trace_shutdown(q)			do { } while (0)
@@ -201,7 +228,7 @@ extern int blk_trace_remove(struct request_queue *q);
 #define blk_trace_startstop(q, start)		(-ENOTTY)
 #define blk_trace_remove(q)			(-ENOTTY)
 #define blk_add_trace_msg(q, fmt, ...)		do { } while (0)
-
+#define blk_add_trace_glock(bdev, gltype, glnum, c, n, t, d) do { } while (0)
 #endif /* CONFIG_BLK_DEV_IO_TRACE */
 #endif /* __KERNEL__ */
 #endif
diff --git a/include/trace/gfs2.h b/include/trace/gfs2.h
new file mode 100644
index 0000000..2a19ea3
--- /dev/null
+++ b/include/trace/gfs2.h
@@ -0,0 +1,20 @@
+#ifndef _TRACE_GFS2_H
+#define _TRACE_GFS2_H
+
+#include <linux/tracepoint.h>
+
+struct gfs2_glock;
+
+DECLARE_TRACE(gfs2_glock_state_change,
+	TPPROTO(struct gfs2_glock *gl, unsigned int new_state),
+		TPARGS(gl, new_state));
+
+DECLARE_TRACE(gfs2_glock_put,
+	TPPROTO(struct gfs2_glock *gl),
+		TPARGS(gl));
+
+DECLARE_TRACE(gfs2_demote_rq,
+	TPPROTO(struct gfs2_glock *gl),
+		TPARGS(gl));
+
+#endif
-- 
1.6.0.3



