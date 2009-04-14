From: Li Zefan <lizf@cn.fujitsu.com>
Date: Tue, 14 Apr 2009 06:00:05 +0000
Subject: [PATCH 3/3] blktrace: add trace/ to /sys/block/sda
Message-Id: <49E42665.6020506@cn.fujitsu.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <49E42620.4050701@cn.fujitsu.com>
In-Reply-To: <49E42620.4050701@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>, Jens Axboe <jens.axboe@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Shawn Du <duyuyang@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-btrace@vger.kernel.org

Impact: allow ftrace-plugin blktrace to trace device-mapper devices

To trace a single partition:
  # echo 1 > /sys/block/sda/sda1/enable
To trace the whole sda instead:
  # echo 1 > /sys/block/sda/enable

Thus we also fix an issue reported by Ted, that ftrace-plugin blktrace
can't be used to trace device-mapper devices.

Now:

  # echo 1 > /sys/block/dm-0/trace/enable
  echo: write error: No such device or address
  # mount -t ext4 /dev/dm-0 /mnt
  # echo 1 > /sys/block/dm-0/trace/enable
  # echo blk > /debug/tracing/current_tracer

Reported-by: Theodore Tso <tytso@mit.edu>
Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>
---
 block/blk-sysfs.c            |    7 ++++++-
 include/linux/blktrace_api.h |    6 ++++++
 kernel/trace/blktrace.c      |    5 +++++
 3 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 73f36be..8653d71 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -387,16 +387,21 @@ struct kobj_type blk_queue_ktype = {
 int blk_register_queue(struct gendisk *disk)
 {
 	int ret;
+	struct device *dev = disk_to_dev(disk);
 
 	struct request_queue *q = disk->queue;
 
 	if (WARN_ON(!q))
 		return -ENXIO;
 
+	ret = blk_trace_init_sysfs(dev);
+	if (ret)
+		return ret;
+
 	if (!q->request_fn)
 		return 0;
 
-	ret = kobject_add(&q->kobj, kobject_get(&disk_to_dev(disk)->kobj),
+	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj),
 			  "%s", "queue");
 	if (ret < 0)
 		return ret;
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 6b2c87e..b5d1ca4 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -198,6 +198,7 @@ extern int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 			   char __user *arg);
 extern int blk_trace_startstop(struct request_queue *q, int start);
 extern int blk_trace_remove(struct request_queue *q);
+extern int blk_trace_init_sysfs(struct device *dev);
 
 extern struct attribute_group blk_trace_attr_group;
 
@@ -211,6 +212,11 @@ extern struct attribute_group blk_trace_attr_group;
 #define blk_trace_remove(q)			(-ENOTTY)
 #define blk_add_trace_msg(q, fmt, ...)		do { } while (0)
 
+static inline int blk_trace_init_sysfs(struct device *dev)
+{
+	return 0;
+}
+
 #endif /* CONFIG_BLK_DEV_IO_TRACE */
 #endif /* __KERNEL__ */
 #endif
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d109898..8e7c5da 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1644,3 +1644,8 @@ out:
 	return ret ? ret : count;
 }
 
+int blk_trace_init_sysfs(struct device *dev)
+{
+	return sysfs_create_group(&dev->kobj, &blk_trace_attr_group);
+}
+
-- 
1.5.4.rc3

