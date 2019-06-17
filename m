From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 17 Jun 2019 01:28:25 +0000
Subject: [PATCH V2 0/7] block: use right accessor to read nr_setcs
Message-Id: <20190617012832.4311-1-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, kent.overstreet@gmail.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Hi,

In the blk-zoned, bcache, f2fs and blktrace implementation
block device->hd_part->number of sectors field is accessed directly
without any appropriate locking or accessor function. There is
an existing accessor function present in the in include/linux/genhd.h
which should be used to read the bdev->hd_part->nr_sects.

From ${KERN_DIR}/include/linux/genhd.h:-
<snip>
714 /*
715  * Any access of part->nr_sects which is not protected by partition
716  * bd_mutex or gendisk bdev bd_mutex, should be done using this
717  * accessor function.
718  *
719  * Code written along the lines of i_size_read() and i_size_write().
720  * CONFIG_PREEMPT case optimizes the case of UP kernel with preemption
721  * on.
722  */
723 static inline sector_t part_nr_sects_read(struct hd_struct *part)
724 {
<snip>

This patch series introduces a helper function on the top of the
part_nr_sects_read() and removes the all direct accesses to the
bdev->hd_part->nr_sects for blk-zoned.c.

This series is based on :-

1. Repo :-
   git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git.
2. Branch :- for-next.

Regards,
Chaitanya

Changes from V1:-

1. Drop the target_pscsi patch. (Bart)
2. Remove rcu locking which is not needed. (Bart)

Chaitanya Kulkarni (7):
  block: add a helper function to read nr_setcs
  blk-zoned: update blkdev_nr_zones() with helper
  blk-zoned: update blkdev_report_zone() with helper
  blk-zoned: update blkdev_reset_zones() with helper
  bcache: update cached_dev_init() with helper
  f2fs: use helper in init_blkz_info()
  blktrace: use helper in blk_trace_setup_lba()

 block/blk-zoned.c         | 12 ++++++------
 drivers/md/bcache/super.c |  2 +-
 fs/f2fs/super.c           |  2 +-
 include/linux/blkdev.h    | 10 ++++++++++
 kernel/trace/blktrace.c   |  2 +-
 5 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.19.1
