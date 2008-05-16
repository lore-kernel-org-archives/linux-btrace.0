From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Date: Fri, 16 May 2008 17:18:54 +0000
Subject: [RFC Patch 2/5] Blktrace - Remove the 'dropped' file from blktrace.c
Message-Id: <op.ua9a5sq103j166@prasadkr_t60p.in.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080516164644.GA22928@in.ibm.com>
In-Reply-To: <20080516164644.GA22928@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: dwilder@us.ibm.com, axboe@kernel.dk, linux-btrace@vger.kernel.org, akpm@linux-foundation.org, prasad@linux.vnet.ibm.com

Remove the 'dropped' file and the setup/removal/access operations  
surrounding
it. The use of trace_dump() has rendered this file redundant, as 'trace'
infrastructure makes this file available already.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
  block/blktrace.c             |   33 ---------------------------------
  include/linux/blktrace_api.h |    2 --
  2 files changed, 35 deletions(-)

Index: linux-blktrace-many/block/blktrace.c
=================================--- linux-blktrace-many.orig/block/blktrace.c
+++ linux-blktrace-many/block/blktrace.c
@@ -232,7 +232,6 @@ err:
  static void blk_trace_cleanup(struct blk_trace *bt)
  {
  	relay_close(bt->rchan);
-	debugfs_remove(bt->dropped_file);
  	blk_remove_tree(bt->dir);
  	free_percpu(bt->sequence);
  	trace_cleanup(bt->tpk->ti);
@@ -259,30 +258,6 @@ int blk_trace_remove(struct request_queu
  }
  EXPORT_SYMBOL_GPL(blk_trace_remove);

-static int blk_dropped_open(struct inode *inode, struct file *filp)
-{
-	filp->private_data = inode->i_private;
-
-	return 0;
-}
-
-static ssize_t blk_dropped_read(struct file *filp, char __user *buffer,
-				size_t count, loff_t *ppos)
-{
-	struct blk_trace *bt = filp->private_data;
-	char buf[16];
-
-	snprintf(buf, sizeof(buf), "%u\n", atomic_read(&bt->dropped));
-
-	return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
-}
-
-static const struct file_operations blk_dropped_fops = {
-	.owner =	THIS_MODULE,
-	.open =		blk_dropped_open,
-	.read =		blk_dropped_read,
-};
-
  /*
   * Keep track of how many times we encountered a full subbuffer, to aid
   * the user space app in telling how many lost events there were.
@@ -296,7 +271,6 @@ static int blk_subbuf_start_callback(str
  		return 1;

  	bt = buf->chan->private_data;
-	atomic_inc(&bt->dropped);
  	return 0;
  }

@@ -371,13 +345,8 @@ int do_blk_trace_setup(struct request_qu

  	bt->dir = dir;
  	bt->dev = dev;
-	atomic_set(&bt->dropped, 0);

  	ret = -EIO;
-	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,  
&blk_dropped_fops);
-	if (!bt->dropped_file)
-		goto err;
-
  	bt->rchan = relay_open("trace", dir, buts->buf_size,
  				buts->buf_nr, &blk_relay_callbacks, bt);
  	if (!bt->rchan)
@@ -411,8 +380,6 @@ err:
  	if (dir)
  		blk_remove_tree(dir);
  	if (bt) {
-		if (bt->dropped_file)
-			debugfs_remove(bt->dropped_file);
  		free_percpu(bt->sequence);
  		if (bt->rchan)
  			relay_close(bt->rchan);
Index: linux-blktrace-many/include/linux/blktrace_api.h
=================================--- linux-blktrace-many.orig/include/linux/blktrace_api.h
+++ linux-blktrace-many/include/linux/blktrace_api.h
@@ -126,8 +126,6 @@ struct blk_trace {
  	u32 pid;
  	u32 dev;
  	struct dentry *dir;
-	struct dentry *dropped_file;
-	atomic_t dropped;
  	struct trace_info *ti;
  	struct trace_printk_data *tpk;
  };
