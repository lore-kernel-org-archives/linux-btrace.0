From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Date: Fri, 16 May 2008 17:18:49 +0000
Subject: [RFC Patch 1/5] Blktrace - introducing trace_dump() to log output
Message-Id: <op.ua9a5ncx03j166@prasadkr_t60p.in.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080516164644.GA22928@in.ibm.com>
In-Reply-To: <20080516164644.GA22928@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: dwilder@us.ibm.com, axboe@kernel.dk, linux-btrace@vger.kernel.org, akpm@linux-foundation.org, prasad@linux.vnet.ibm.com

This patch replaces the memcpy in the output functions to use trace_dump()
function. This renders several other operations done in blktrace.c such as
setup/tear-down/read operation definitions redundant.

This patch also introduces instances of a few structures required to use
trace_dump() function in struct blk_trace.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
  block/blktrace.c             |   32 +++++++++++++++++++++++++++-----
  include/linux/blktrace_api.h |    3 +++
  2 files changed, 30 insertions(+), 5 deletions(-)

Index: linux-blktrace-many/block/blktrace.c
=================================--- linux-blktrace-many.orig/block/blktrace.c
+++ linux-blktrace-many/block/blktrace.c
@@ -25,6 +25,7 @@
  #include <linux/time.h>
  #include <asm/uaccess.h>

+#define BLKTRACE_ROOT_DIR "block"
  static unsigned int blktrace_seq __read_mostly = 1;

  /*
@@ -35,7 +36,7 @@ static void trace_note(struct blk_trace
  {
  	struct blk_io_trace *t;

-	t = relay_reserve(bt->rchan, sizeof(*t) + len);
+	t = kzalloc(sizeof(*t), GFP_KERNEL);
  	if (t) {
  		const int cpu = smp_processor_id();

@@ -46,7 +47,8 @@ static void trace_note(struct blk_trace
  		t->pid = pid;
  		t->cpu = cpu;
  		t->pdu_len = len;
-		memcpy((void *) t + sizeof(*t), data, len);
+		trace_dump(bt->tpk, t, sizeof(*t));
+		trace_dump(bt->tpk, data, len);
  	}
  }

@@ -151,7 +153,7 @@ void __blk_add_trace(struct blk_trace *b
  	if (unlikely(tsk->btrace_seq != blktrace_seq))
  		trace_note_tsk(bt, tsk);

-	t = relay_reserve(bt->rchan, sizeof(*t) + pdu_len);
+	t = kzalloc(sizeof(*t), GFP_KERNEL);
  	if (t) {
  		cpu = smp_processor_id();
  		sequence = per_cpu_ptr(bt->sequence, cpu);
@@ -168,8 +170,9 @@ void __blk_add_trace(struct blk_trace *b
  		t->error = error;
  		t->pdu_len = pdu_len;

+		trace_dump(bt->tpk, t, sizeof(*t));
  		if (pdu_len)
-			memcpy((void *) t + sizeof(*t), pdu_data, pdu_len);
+			trace_dump(bt->tpk, pdu_data, pdu_len);
  	}

  	local_irq_restore(flags);
@@ -206,7 +209,7 @@ static struct dentry *blk_create_tree(co
  	mutex_lock(&blk_tree_mutex);

  	if (!blk_tree_root) {
-		blk_tree_root = debugfs_create_dir("block", NULL);
+		blk_tree_root = debugfs_create_dir("block_old", NULL);
  		if (!blk_tree_root)
  			goto err;
  		created = 1;
@@ -232,6 +235,11 @@ static void blk_trace_cleanup(struct blk
  	debugfs_remove(bt->dropped_file);
  	blk_remove_tree(bt->dir);
  	free_percpu(bt->sequence);
+	trace_cleanup(bt->tpk->ti);
+
+	kfree(bt->tpk->parent_dir);
+	kfree(bt->tpk->dir);
+	kfree(bt->tpk);
  	kfree(bt);
  }

@@ -342,6 +350,16 @@ int do_blk_trace_setup(struct request_qu
  	if (!bt)
  		goto err;

+	bt->tpk = kzalloc(sizeof(*(bt->tpk)), GFP_KERNEL);
+	if (!bt->tpk)
+		goto err;
+	bt->tpk->parent_dir = kstrdup(BLKTRACE_ROOT_DIR, GFP_KERNEL);
+	if (!bt->tpk->parent_dir)
+		goto parent_dir_err;
+	bt->tpk->dir = kstrdup(name, GFP_KERNEL);
+	if (!bt->tpk->dir)
+		goto dir_err;
+
  	bt->sequence = alloc_percpu(unsigned long);
  	if (!bt->sequence)
  		goto err;
@@ -385,6 +403,10 @@ int do_blk_trace_setup(struct request_qu
  	}

  	return 0;
+dir_err:
+	kfree(bt->tpk->parent_dir);
+parent_dir_err:
+	kfree(bt->tpk);
  err:
  	if (dir)
  		blk_remove_tree(dir);
Index: linux-blktrace-many/include/linux/blktrace_api.h
=================================--- linux-blktrace-many.orig/include/linux/blktrace_api.h
+++ linux-blktrace-many/include/linux/blktrace_api.h
@@ -3,6 +3,7 @@

  #include <linux/blkdev.h>
  #include <linux/relay.h>
+#include <linux/trace.h>

  /*
   * Trace categories
@@ -127,6 +128,8 @@ struct blk_trace {
  	struct dentry *dir;
  	struct dentry *dropped_file;
  	atomic_t dropped;
+	struct trace_info *ti;
+	struct trace_printk_data *tpk;
  };

  /*
