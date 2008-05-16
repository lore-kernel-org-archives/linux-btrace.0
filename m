From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Date: Fri, 16 May 2008 17:19:13 +0000
Subject: [RFC Patch 4/5] Blktrace - Remove the rchan instance from blktrace.c
Message-Id: <op.ua9a6b2h03j166@prasadkr_t60p.in.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080516164644.GA22928@in.ibm.com>
In-Reply-To: <20080516164644.GA22928@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: dwilder@us.ibm.com, axboe@kernel.dk, linux-btrace@vger.kernel.org, akpm@linux-foundation.org, prasad@linux.vnet.ibm.com

This patch removes the rchan instance from blk_trace structure and its
associated operations, since trace_dump() uses 'trace' infrastructure
which internally uses relay buffers.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
  block/blktrace.c             |   48  
-------------------------------------------
  include/linux/blktrace_api.h |    1
  2 files changed, 49 deletions(-)

Index: linux-blktrace-many/block/blktrace.c
=================================--- linux-blktrace-many.orig/block/blktrace.c
+++ linux-blktrace-many/block/blktrace.c
@@ -182,7 +182,6 @@ EXPORT_SYMBOL_GPL(__blk_add_trace);

  static void blk_trace_cleanup(struct blk_trace *bt)
  {
-	relay_close(bt->rchan);
  	free_percpu(bt->sequence);
  	trace_cleanup(bt->tpk->ti);

@@ -209,51 +208,12 @@ int blk_trace_remove(struct request_queu
  EXPORT_SYMBOL_GPL(blk_trace_remove);

  /*
- * Keep track of how many times we encountered a full subbuffer, to aid
- * the user space app in telling how many lost events there were.
- */
-static int blk_subbuf_start_callback(struct rchan_buf *buf, void *subbuf,
-				     void *prev_subbuf, size_t prev_padding)
-{
-	struct blk_trace *bt;
-
-	if (!relay_buf_full(buf))
-		return 1;
-
-	bt = buf->chan->private_data;
-	return 0;
-}
-
-static int blk_remove_buf_file_callback(struct dentry *dentry)
-{
-	debugfs_remove(dentry);
-	return 0;
-}
-
-static struct dentry *blk_create_buf_file_callback(const char *filename,
-						   struct dentry *parent,
-						   int mode,
-						   struct rchan_buf *buf,
-						   int *is_global)
-{
-	return debugfs_create_file(filename, mode, parent, buf,
-					&relay_file_operations);
-}
-
-static struct rchan_callbacks blk_relay_callbacks = {
-	.subbuf_start		= blk_subbuf_start_callback,
-	.create_buf_file	= blk_create_buf_file_callback,
-	.remove_buf_file	= blk_remove_buf_file_callback,
-};
-
-/*
   * Setup everything required to start tracing
   */
  int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
  			struct blk_user_trace_setup *buts)
  {
  	struct blk_trace *old_bt, *bt = NULL;
-	struct dentry *dir = NULL;
  	int ret, i;

  	if (!buts->buf_size || !buts->buf_nr)
@@ -292,11 +252,6 @@ int do_blk_trace_setup(struct request_qu
  	bt->dev = dev;

  	ret = -EIO;
-	bt->rchan = relay_open("trace", dir, buts->buf_size,
-				buts->buf_nr, &blk_relay_callbacks, bt);
-	if (!bt->rchan)
-		goto err;
-
  	bt->act_mask = buts->act_mask;
  	if (!bt->act_mask)
  		bt->act_mask = (u16) -1;
@@ -324,8 +279,6 @@ parent_dir_err:
  err:
  	if (bt) {
  		free_percpu(bt->sequence);
-		if (bt->rchan)
-			relay_close(bt->rchan);
  		kfree(bt);
  	}
  	return ret;
@@ -378,7 +331,6 @@ int blk_trace_startstop(struct request_q
  	} else {
  		if (bt->trace_state = Blktrace_running) {
  			bt->trace_state = Blktrace_stopped;
-			relay_flush(bt->rchan);
  			ret = 0;
  		}
  	}
Index: linux-blktrace-many/include/linux/blktrace_api.h
=================================--- linux-blktrace-many.orig/include/linux/blktrace_api.h
+++ linux-blktrace-many/include/linux/blktrace_api.h
@@ -118,7 +118,6 @@ enum {

  struct blk_trace {
  	int trace_state;
-	struct rchan *rchan;
  	unsigned long *sequence;
  	u16 act_mask;
  	u64 start_lba;
