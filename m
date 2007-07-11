From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 11 Jul 2007 12:48:43 +0000
Subject: Re: blktrace crashing with 2.6.22-rc3
Message-Id: <20070711124843.GV4587@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <466E7226.7060609@lichota.net>
In-Reply-To: <466E7226.7060609@lichota.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, Jun 12 2007, Jens Axboe wrote:
> On Tue, Jun 12 2007, Krzysztof Lichota wrote:
> > Jens Axboe napisa??(a):
> > >> Should I investigate it further or is it a known issue?
> > >
> > > I think it's a known issue. Don't run blktrace -k unless the trace is
> > > really stuck - does it work correctly if you just ctrl-c out of
> > > blktrace?
> > 
> > Yes, it works. I just got the impression that blktrace -k is the
> > preferred way of terminating the trace.
> 
> oh no, -k is for KILL, extremely unpolite :-)
> 
> > Thanks for help :)
> 
> It sounds like you have found a way to reliably cause that bug, so I'll
> see if I can reproduce and get it fixed.

This should fix it, no more stuck traces.

diff --git a/block/blktrace.c b/block/blktrace.c
index 3f0e7c3..0ad5a77 100644
--- a/block/blktrace.c
+++ b/block/blktrace.c
@@ -180,53 +180,11 @@ EXPORT_SYMBOL_GPL(__blk_add_trace);
 
 static struct dentry *blk_tree_root;
 static struct mutex blk_tree_mutex;
-static unsigned int root_users;
-
-static inline void blk_remove_root(void)
-{
-	if (blk_tree_root) {
-		debugfs_remove(blk_tree_root);
-		blk_tree_root = NULL;
-	}
-}
-
-static void blk_remove_tree(struct dentry *dir)
-{
-	mutex_lock(&blk_tree_mutex);
-	debugfs_remove(dir);
-	if (--root_users = 0)
-		blk_remove_root();
-	mutex_unlock(&blk_tree_mutex);
-}
-
-static struct dentry *blk_create_tree(const char *blk_name)
-{
-	struct dentry *dir = NULL;
-
-	mutex_lock(&blk_tree_mutex);
-
-	if (!blk_tree_root) {
-		blk_tree_root = debugfs_create_dir("block", NULL);
-		if (!blk_tree_root)
-			goto err;
-	}
-
-	dir = debugfs_create_dir(blk_name, blk_tree_root);
-	if (dir)
-		root_users++;
-	else
-		blk_remove_root();
-
-err:
-	mutex_unlock(&blk_tree_mutex);
-	return dir;
-}
 
 static void blk_trace_cleanup(struct blk_trace *bt)
 {
-	relay_close(bt->rchan);
 	debugfs_remove(bt->dropped_file);
-	blk_remove_tree(bt->dir);
+	relay_close(bt->rchan);
 	free_percpu(bt->sequence);
 	kfree(bt);
 }
@@ -289,7 +247,18 @@ static int blk_subbuf_start_callback(struct rchan_buf *buf, void *subbuf,
 
 static int blk_remove_buf_file_callback(struct dentry *dentry)
 {
+	struct dentry *parent = dentry->d_parent;
+
 	debugfs_remove(dentry);
+
+	/*
+	 * this will fail for all but the last file, but that is ok. what we
+	 * care about is the top level buts.name directory going away, when
+	 * the last trace file is gone. Then we don't have to rmdir() that
+	 * manually on trace stop, so it nicely solves the issue with
+	 * force killing of running traces.
+	 */
+	debugfs_remove(parent);
 	return 0;
 }
 
@@ -350,7 +319,7 @@ static int blk_trace_setup(request_queue_t *q, struct block_device *bdev,
 		goto err;
 
 	ret = -ENOENT;
-	dir = blk_create_tree(buts.name);
+	dir = debugfs_create_dir(buts.name, blk_tree_root);
 	if (!dir)
 		goto err;
 
@@ -388,8 +357,6 @@ static int blk_trace_setup(request_queue_t *q, struct block_device *bdev,
 
 	return 0;
 err:
-	if (dir)
-		blk_remove_tree(dir);
 	if (bt) {
 		if (bt->dropped_file)
 			debugfs_remove(bt->dropped_file);
@@ -555,8 +522,11 @@ static __init int blk_trace_init(void)
 	on_each_cpu(blk_trace_check_cpu_time, NULL, 1, 1);
 	blk_trace_set_ht_offsets();
 
+	blk_tree_root = debugfs_create_dir("block", NULL);
+	if (!blk_tree_root)
+		return -ENOMEM;
+
 	return 0;
 }
 
 module_init(blk_trace_init);
-
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index ec8896b..8f3c999 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -345,11 +345,6 @@ void debugfs_remove(struct dentry *dentry)
 			switch (dentry->d_inode->i_mode & S_IFMT) {
 			case S_IFDIR:
 				ret = simple_rmdir(parent->d_inode, dentry);
-				if (ret)
-					printk(KERN_ERR
-						"DebugFS rmdir on %s failed : "
-						"directory not empty.\n",
-						dentry->d_name.name);
 				break;
 			case S_IFLNK:
 				kfree(dentry->d_inode->i_private);

-- 
Jens Axboe

