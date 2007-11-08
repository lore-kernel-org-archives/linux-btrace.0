From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Thu, 08 Nov 2007 14:15:15 +0000
Subject: [PATCH] Add UNPLUG traces to all appropriate places
Message-Id: <473319F3.30706@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: dm-devel@redhat.com, btrace <linux-btrace@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>

Added blk_unplug interface, allowing all invocations of unplugs to result
in a generated blktrace UNPLUG. Previously, we saw a PLUG on each of the
underlying devices, and an UNPLUG on the volume. This patch ensures that
we see the UNPLUG calls for each of the underlying devices.

Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>
---
 block/ll_rw_blk.c      |   24 +++++++++++++++---------
 drivers/md/bitmap.c    |    3 +--
 drivers/md/dm-table.c  |    3 +--
 drivers/md/linear.c    |    3 +--
 drivers/md/md.c        |    4 ++--
 drivers/md/multipath.c |    3 +--
 drivers/md/raid0.c     |    3 +--
 drivers/md/raid1.c     |    3 +--
 drivers/md/raid10.c    |    3 +--
 drivers/md/raid5.c     |    3 +--
 include/linux/blkdev.h |    1 +
 11 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 75c98d5..37f8e9c 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -1634,15 +1634,7 @@ static void blk_backing_dev_unplug(struct 
backing_dev_info *bdi,
 {
     struct request_queue *q = bdi->unplug_io_data;
 
-    /*
-     * devices don't necessarily have an ->unplug_fn defined
-     */
-    if (q->unplug_fn) {
-        blk_add_trace_pdu_int(q, BLK_TA_UNPLUG_IO, NULL,
-                    q->rq.count[READ] + q->rq.count[WRITE]);
-
-        q->unplug_fn(q);
-    }
+    blk_unplug(q);
 }
 
 static void blk_unplug_work(struct work_struct *work)
@@ -1666,6 +1658,20 @@ static void blk_unplug_timeout(unsigned long data)
     kblockd_schedule_work(&q->unplug_work);
 }
 
+void blk_unplug(struct request_queue *q)
+{
+    /*
+     * devices don't necessarily have an ->unplug_fn defined
+     */
+    if (q->unplug_fn) {
+        blk_add_trace_pdu_int(q, BLK_TA_UNPLUG_IO, NULL,
+                    q->rq.count[READ] + q->rq.count[WRITE]);
+
+        q->unplug_fn(q);
+    }
+}
+EXPORT_SYMBOL(blk_unplug);
+
 /**
  * blk_start_queue - restart a previously stopped queue
  * @q:    The &struct request_queue in question
diff --git a/drivers/md/bitmap.c b/drivers/md/bitmap.c
index 7c426d0..1b1ef31 100644
--- a/drivers/md/bitmap.c
+++ b/drivers/md/bitmap.c
@@ -1207,8 +1207,7 @@ int bitmap_startwrite(struct bitmap *bitmap, 
sector_t offset, unsigned long sect
             prepare_to_wait(&bitmap->overflow_wait, &__wait,
                     TASK_UNINTERRUPTIBLE);
             spin_unlock_irq(&bitmap->lock);
-            bitmap->mddev->queue
-                ->unplug_fn(bitmap->mddev->queue);
+            blk_unplug(bitmap->mddev->queue);
             schedule();
             finish_wait(&bitmap->overflow_wait, &__wait);
             continue;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 5a7eb65..e298d8d 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1000,8 +1000,7 @@ void dm_table_unplug_all(struct dm_table *t)
         struct dm_dev *dd = list_entry(d, struct dm_dev, list);
         struct request_queue *q = bdev_get_queue(dd->bdev);
 
-        if (q->unplug_fn)
-            q->unplug_fn(q);
+        blk_unplug(q);
     }
 }
 
diff --git a/drivers/md/linear.c b/drivers/md/linear.c
index 56a11f6..3dac1cf 100644
--- a/drivers/md/linear.c
+++ b/drivers/md/linear.c
@@ -87,8 +87,7 @@ static void linear_unplug(struct request_queue *q)
 
     for (i=0; i < mddev->raid_disks; i++) {
         struct request_queue *r_queue = 
bdev_get_queue(conf->disks[i].rdev->bdev);
-        if (r_queue->unplug_fn)
-            r_queue->unplug_fn(r_queue);
+        blk_unplug(r_queue);
     }
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 808cd95..cef9ebd 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5445,7 +5445,7 @@ void md_do_sync(mddev_t *mddev)
          * about not overloading the IO subsystem. (things like an
          * e2fsck being done on the RAID array should execute fast)
          */
-        mddev->queue->unplug_fn(mddev->queue);
+        blk_unplug(mddev->queue);
         cond_resched();
 
         currspeed = ((unsigned long)(io_sectors-mddev->resync_mark_cnt))/2
@@ -5464,7 +5464,7 @@ void md_do_sync(mddev_t *mddev)
      * this also signals 'finished resyncing' to md_stop
      */
  out:
-    mddev->queue->unplug_fn(mddev->queue);
+    blk_unplug(mddev->queue);
 
     wait_event(mddev->recovery_wait, 
!atomic_read(&mddev->recovery_active));
 
diff --git a/drivers/md/multipath.c b/drivers/md/multipath.c
index b35731c..eb631eb 100644
--- a/drivers/md/multipath.c
+++ b/drivers/md/multipath.c
@@ -125,8 +125,7 @@ static void unplug_slaves(mddev_t *mddev)
             atomic_inc(&rdev->nr_pending);
             rcu_read_unlock();
 
-            if (r_queue->unplug_fn)
-                r_queue->unplug_fn(r_queue);
+            blk_unplug(r_queue);
 
             rdev_dec_pending(rdev, mddev);
             rcu_read_lock();
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index c111105..f8e5917 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -35,8 +35,7 @@ static void raid0_unplug(struct request_queue *q)
     for (i=0; i<mddev->raid_disks; i++) {
         struct request_queue *r_queue = bdev_get_queue(devlist[i]->bdev);
 
-        if (r_queue->unplug_fn)
-            r_queue->unplug_fn(r_queue);
+        blk_unplug(r_queue);
     }
 }
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 85478d6..4a69c41 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -549,8 +549,7 @@ static void unplug_slaves(mddev_t *mddev)
             atomic_inc(&rdev->nr_pending);
             rcu_read_unlock();
 
-            if (r_queue->unplug_fn)
-                r_queue->unplug_fn(r_queue);
+            blk_unplug(r_queue);
 
             rdev_dec_pending(rdev, mddev);
             rcu_read_lock();
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index fc6607a..5cdcc93 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -593,8 +593,7 @@ static void unplug_slaves(mddev_t *mddev)
             atomic_inc(&rdev->nr_pending);
             rcu_read_unlock();
 
-            if (r_queue->unplug_fn)
-                r_queue->unplug_fn(r_queue);
+            blk_unplug(r_queue);
 
             rdev_dec_pending(rdev, mddev);
             rcu_read_lock();
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 82af346..1cfc984 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3186,8 +3186,7 @@ static void unplug_slaves(mddev_t *mddev)
             atomic_inc(&rdev->nr_pending);
             rcu_read_unlock();
 
-            if (r_queue->unplug_fn)
-                r_queue->unplug_fn(r_queue);
+            blk_unplug(r_queue);
 
             rdev_dec_pending(rdev, mddev);
             rcu_read_lock();
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8396db2..d18ee67 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -697,6 +697,7 @@ extern int blk_execute_rq(struct request_queue *, 
struct gendisk *,
 extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
                   struct request *, int, rq_end_io_fn *);
 extern int blk_verify_command(unsigned char *, int);
+extern void blk_unplug(struct request_queue *q);
 
 static inline struct request_queue *bdev_get_queue(struct block_device 
*bdev)
 {
-- 
1.5.2.5

