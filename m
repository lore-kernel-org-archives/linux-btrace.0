From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Thu, 13 Jun 2019 14:59:47 +0000
Subject: [PATCH 0/8] block: use right accessor to read nr_sects
Message-Id: <20190613145955.4813-1-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-scsi@vger.kernel.org, linux-btrace@vger.kernel.org, kent.overstreet@gmail.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Hi,

In the current block layer implementation including drivers and fs
there are some places in the code where block device->hd_part->number
of sectors is accessed directly without any locking. There is an
existing accessor function present in the include/linux/genhd.h
which should be used to read the bdev->hd_part->nr_sects
with the help of appropriate locking.

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
part_nr_sects_read() with expected rcu locking and removes the direct
accesses to the bdev->hd_part->nr_sects.

This is based on :-
1. Repo :- git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git.
2. Branch :- for-next.

Regards,
Chaitanya

Chaitanya Kulkarni (8):
  block: add a helper function to read nr_setcs
  blk-zoned: update blkdev_nr_zones() with helper
  blk-zoned: update blkdev_report_zone() with helper
  blk-zoned: update blkdev_reset_zones() with helper
  bcache: update cached_dev_init() with helper
  target/pscsi: use helper in pscsi_get_blocks()
  f2fs: use helper in init_blkz_info()
  blktrace: use helper in blk_trace_setup_lba()

 block/blk-zoned.c                  | 12 ++++++------
 drivers/md/bcache/super.c          |  2 +-
 drivers/target/target_core_pscsi.c |  2 +-
 fs/f2fs/super.c                    |  2 +-
 include/linux/blkdev.h             | 12 ++++++++++++
 kernel/trace/blktrace.c            |  2 +-
 6 files changed, 22 insertions(+), 10 deletions(-)

-- 
2.19.1
