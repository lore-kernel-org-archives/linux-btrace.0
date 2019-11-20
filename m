From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 20 Nov 2019 04:25:06 +0000
Subject: [RFC PATCH 36/39] blktrace: implement setup-start-stop ioclts
Message-Id: <20191120042509.12835-37-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Implement newly introduced IOCTLs for setup/start/stop/teardown.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 297 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 297 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 4d909871b058..3f204bd9a311 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -594,6 +594,17 @@ static void blk_trace_free(struct blk_trace *bt)
 	kfree(bt);
 }
 
+static void blk_trace_free_ext(struct blk_trace_ext *bt)
+{
+	debugfs_remove(bt->msg_file);
+	debugfs_remove(bt->dropped_file);
+	relay_close(bt->rchan);
+	debugfs_remove(bt->dir);
+	free_percpu(bt->sequence);
+	free_percpu(bt->msg_data);
+	kfree(bt);
+}
+
 static void get_probe_ref(void)
 {
 	mutex_lock(&blk_probe_mutex);
@@ -616,6 +627,12 @@ static void blk_trace_cleanup(struct blk_trace *bt)
 	put_probe_ref();
 }
 
+static void blk_trace_cleanup_ext(struct blk_trace_ext *bt)
+{
+	blk_trace_free_ext(bt);
+	put_probe_ref();
+}
+
 static int __blk_trace_remove(struct request_queue *q)
 {
 	struct blk_trace *bt;
@@ -630,6 +647,20 @@ static int __blk_trace_remove(struct request_queue *q)
 	return 0;
 }
 
+static int __blk_trace_remove_ext(struct request_queue *q)
+{
+	struct blk_trace_ext *bt;
+
+	bt = xchg(&q->blk_trace_ext, NULL);
+	if (!bt)
+		return -EINVAL;
+
+	if (bt->trace_state != Blktrace_running)
+		blk_trace_cleanup_ext(bt);
+
+	return 0;
+}
+
 int blk_trace_remove(struct request_queue *q)
 {
 	int ret;
@@ -653,6 +684,17 @@ static ssize_t blk_dropped_read(struct file *filp, char __user *buffer,
 	return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
 }
 
+static ssize_t blk_dropped_read_ext(struct file *filp, char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	struct blk_trace_ext *bt = filp->private_data;
+	char buf[16];
+
+	snprintf(buf, sizeof(buf), "%u\n", atomic_read(&bt->dropped));
+
+	return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
+}
+
 static const struct file_operations blk_dropped_fops = {
 	.owner =	THIS_MODULE,
 	.open =		simple_open,
@@ -660,6 +702,13 @@ static const struct file_operations blk_dropped_fops = {
 	.llseek =	default_llseek,
 };
 
+static const struct file_operations blk_dropped_fops_ext = {
+	.owner =	THIS_MODULE,
+	.open =		simple_open,
+	.read =		blk_dropped_read_ext,
+	.llseek =	default_llseek,
+};
+
 static ssize_t blk_msg_write(struct file *filp, const char __user *buffer,
 				size_t count, loff_t *ppos)
 {
@@ -680,6 +729,26 @@ static ssize_t blk_msg_write(struct file *filp, const char __user *buffer,
 	return count;
 }
 
+static ssize_t blk_msg_write_ext(struct file *filp, const char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	char *msg;
+	struct blk_trace_ext *bt;
+
+	if (count >= BLK_TN_MAX_MSG)
+		return -EINVAL;
+
+	msg = memdup_user_nul(buffer, count);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	bt = filp->private_data;
+	__trace_note_message_ext(bt, NULL, "%s", msg);
+	kfree(msg);
+
+	return count;
+}
+
 static const struct file_operations blk_msg_fops = {
 	.owner =	THIS_MODULE,
 	.open =		simple_open,
@@ -687,6 +756,13 @@ static const struct file_operations blk_msg_fops = {
 	.llseek =	noop_llseek,
 };
 
+static const struct file_operations blk_msg_fops_ext = {
+	.owner =	THIS_MODULE,
+	.open =		simple_open,
+	.write =	blk_msg_write_ext,
+	.llseek =	noop_llseek,
+};
+
 /*
  * Keep track of how many times we encountered a full subbuffer, to aid
  * the user space app in telling how many lost events there were.
@@ -721,12 +797,31 @@ static struct dentry *blk_create_buf_file_callback(const char *filename,
 					&relay_file_operations);
 }
 
+static int blk_subbuf_start_callback_ext(struct rchan_buf *buf, void *subbuf,
+				     void *prev_subbuf, size_t prev_padding)
+{
+	struct blk_trace_ext *bt;
+
+	if (!relay_buf_full(buf))
+		return 1;
+
+	bt = buf->chan->private_data;
+	atomic_inc(&bt->dropped);
+	return 0;
+}
+
 static struct rchan_callbacks blk_relay_callbacks = {
 	.subbuf_start		= blk_subbuf_start_callback,
 	.create_buf_file	= blk_create_buf_file_callback,
 	.remove_buf_file	= blk_remove_buf_file_callback,
 };
 
+static struct rchan_callbacks blk_relay_callbacks_ext = {
+	.subbuf_start		= blk_subbuf_start_callback_ext,
+	.create_buf_file	= blk_create_buf_file_callback,
+	.remove_buf_file	= blk_remove_buf_file_callback,
+};
+
 static void blk_trace_setup_lba(struct blk_trace *bt,
 				struct block_device *bdev)
 {
@@ -744,6 +839,24 @@ static void blk_trace_setup_lba(struct blk_trace *bt,
 	}
 }
 
+static void blk_trace_setup_lba_ext(struct blk_trace_ext *bt,
+				struct block_device *bdev)
+{
+	struct hd_struct *part = NULL;
+
+	if (bdev)
+		part = bdev->bd_part;
+
+	if (part) {
+		bt->start_lba = part->start_sect;
+		bt->end_lba = part->start_sect + part->nr_sects;
+	} else {
+		bt->start_lba = 0;
+		bt->end_lba = -1ULL;
+	}
+}
+
+
 /*
  * Setup everything required to start tracing
  */
@@ -834,6 +947,105 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	return ret;
 }
 
+static int do_blk_trace_setup_ext(struct request_queue *q, char *name, dev_t dev,
+			      struct block_device *bdev,
+			      struct blk_user_trace_setup_ext *buts)
+{
+	struct blk_trace_ext *bt = NULL;
+	struct dentry *dir = NULL;
+	int ret;
+
+	if (q->blk_trace) {
+		pr_err("queue is already associated with legecy trace\n");
+		return -EINVAL;
+	}
+	if (!buts->buf_size || !buts->buf_nr)
+		return -EINVAL;
+
+	if (!blk_debugfs_root)
+		return -ENOENT;
+
+	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
+	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
+
+	/*
+	 * some device names have larger paths - convert the slashes
+	 * to underscores for this to work as expected
+	 */
+	strreplace(buts->name, '/', '_');
+
+	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
+	if (!bt)
+		return -ENOMEM;
+
+	ret = -ENOMEM;
+	bt->sequence = alloc_percpu(unsigned long);
+	if (!bt->sequence)
+		goto err;
+
+	bt->msg_data = __alloc_percpu(BLK_TN_MAX_MSG, __alignof__(char));
+	if (!bt->msg_data)
+		goto err;
+
+	ret = -ENOENT;
+
+	dir = debugfs_lookup(buts->name, blk_debugfs_root);
+	if (!dir)
+		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
+	if (!dir)
+		goto err;
+
+	bt->dev = dev;
+	atomic_set(&bt->dropped, 0);
+	INIT_LIST_HEAD(&bt->running_ext_list);
+
+	ret = -EIO;
+	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
+					       &blk_dropped_fops_ext);
+	if (!bt->dropped_file)
+		goto err;
+
+	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops_ext);
+	if (!bt->msg_file)
+		goto err;
+
+	bt->rchan = relay_open("trace", dir, buts->buf_size,
+				buts->buf_nr, &blk_relay_callbacks_ext, bt);
+	if (!bt->rchan)
+		goto err;
+
+	bt->act_mask = buts->act_mask;
+	if (!bt->act_mask)
+		bt->act_mask = (u64) -1ULL;
+
+	bt->prio_mask = buts->prio_mask;
+
+	blk_trace_setup_lba_ext(bt, bdev);
+
+	/* overwrite with user settings */
+	if (buts->start_lba)
+		bt->start_lba = buts->start_lba;
+	if (buts->end_lba)
+		bt->end_lba = buts->end_lba;
+
+	bt->pid = buts->pid;
+	bt->trace_state = Blktrace_setup;
+
+	ret = -EBUSY;
+	if (cmpxchg(&q->blk_trace_ext, NULL, bt))
+		goto err;
+
+	get_probe_ref();
+
+	ret = 0;
+err:
+	if (dir && !bt->dir)
+		dput(dir);
+	if (ret)
+		blk_trace_free_ext(bt);
+	return ret;
+}
+
 static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 			     struct block_device *bdev, char __user *arg)
 {
@@ -855,6 +1067,28 @@ static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	return 0;
 }
 
+static int __blk_trace_setup_ext(struct request_queue *q, char *name, dev_t dev,
+			     struct block_device *bdev, char __user *arg)
+{
+	struct blk_user_trace_setup_ext buts;
+	int ret;
+
+	ret = copy_from_user(&buts, arg, sizeof(buts));
+	if (ret)
+		return -EFAULT;
+
+	ret = do_blk_trace_setup_ext(q, name, dev, bdev, &buts);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(arg, &buts, sizeof(buts))) {
+		__blk_trace_remove_ext(q);
+		return -EFAULT;
+	}
+	return 0;
+}
+
+
 int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		    struct block_device *bdev,
 		    char __user *arg)
@@ -943,6 +1177,47 @@ static int __blk_trace_startstop(struct request_queue *q, int start)
 	return ret;
 }
 
+static int __blk_trace_startstop_ext(struct request_queue *q, int start)
+{
+	int ret;
+	struct blk_trace_ext *bt = q->blk_trace_ext;
+
+	if (bt = NULL)
+		return -EINVAL;
+
+	/*
+	 * For starting a trace, we can transition from a setup or stopped
+	 * trace. For stopping a trace, the state must be running
+	 */
+	ret = -EINVAL;
+	if (start) {
+		if (bt->trace_state = Blktrace_setup ||
+		    bt->trace_state = Blktrace_stopped) {
+			blktrace_seq++;
+			smp_mb();
+			bt->trace_state = Blktrace_running;
+			spin_lock_irq(&running_trace_ext_lock);
+			list_add(&bt->running_ext_list,
+					&running_trace_ext_list);
+			spin_unlock_irq(&running_trace_ext_lock);
+
+			trace_note_time_ext(bt);
+			ret = 0;
+		}
+	} else {
+		if (bt->trace_state = Blktrace_running) {
+			bt->trace_state = Blktrace_stopped;
+			spin_lock_irq(&running_trace_ext_lock);
+			list_del_init(&bt->running_ext_list);
+			spin_unlock_irq(&running_trace_ext_lock);
+			relay_flush(bt->rchan);
+			ret = 0;
+		}
+	}
+
+	return ret;
+}
+
 int blk_trace_startstop(struct request_queue *q, int start)
 {
 	int ret;
@@ -985,6 +1260,10 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 		bdevname(bdev, b);
 		ret = __blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
 		break;
+	case BLKTRACESETUP_EXT:
+		bdevname(bdev, b);
+		ret = __blk_trace_setup_ext(q, b, bdev->bd_dev, bdev, arg);
+		break;
 #if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
 	case BLKTRACESETUP32:
 		bdevname(bdev, b);
@@ -997,9 +1276,18 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	case BLKTRACESTOP:
 		ret = __blk_trace_startstop(q, start);
 		break;
+	case BLKTRACESTART_EXT:
+		start = 1;
+		/* fall through */
+	case BLKTRACESTOP_EXT:
+		ret = __blk_trace_startstop_ext(q, start);
+		break;
 	case BLKTRACETEARDOWN:
 		ret = __blk_trace_remove(q);
 		break;
+	case BLKTRACETEARDOWN_EXT:
+		ret = __blk_trace_remove_ext(q);
+		break;
 	default:
 		ret = -ENOTTY;
 		break;
@@ -1024,6 +1312,15 @@ void blk_trace_shutdown(struct request_queue *q)
 	}
 
 	mutex_unlock(&q->blk_trace_mutex);
+
+	mutex_lock(&q->blk_trace_ext_mutex);
+
+	if (q->blk_trace_ext) {
+		__blk_trace_startstop_ext(q, 0);
+		__blk_trace_remove_ext(q);
+	}
+
+	mutex_unlock(&q->blk_trace_ext_mutex);
 }
 
 #ifdef CONFIG_BLK_CGROUP
-- 
2.22.1
