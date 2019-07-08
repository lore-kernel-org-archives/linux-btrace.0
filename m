From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 08 Jul 2019 18:47:02 +0000
Subject: [PATCH V4 0/9] block: use right accessor to read nr_sects
Message-Id: <20190708184711.2984-1-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, xen-devel@lists.xenproject.org, kent.overstreet@gmail.com, yuchao0@huawei.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, konrad.wilk@oracle.com, roger.pau@citrix.com, bvanassche@acm.org, linux-scsi@vger.kernel.org, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Hi,

In the blk-zoned, bcache, f2fs, target-pscsi, xen and blktrace
implementation block device->hd_part->number of sectors field is
accessed directly without any appropriate locking or accessor function. 
There is an existing accessor function present in the in 
include/linux/genhd.h which should be used to read the
bdev->hd_part->nr_sects.

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
bdev->hd_part->nr_sects.

This series is based on :-

1. Repo :-
   git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git.
2. Branch :- for-next.

Please consider this for 5.3.

Changes from V3:-

1. Get rid of the comment in the 1st patch for helper. (Bart)

Chaitanya Kulkarni (9):
  block: add a helper function to read nr_setcs
  blk-zoned: update blkdev_nr_zones() with helper
  blk-zoned: update blkdev_report_zone() with helper
  blk-zoned: update blkdev_reset_zones() with helper
  bcache: update cached_dev_init() with helper
  f2fs: use helper in init_blkz_info()
  blktrace: use helper in blk_trace_setup_lba()
  target/pscsi: use helper in pscsi_get_blocks()
  xen/blkback: use helper in vbd_sz()

 block/blk-zoned.c                  | 12 ++++++------
 drivers/block/xen-blkback/common.h |  2 +-
 drivers/md/bcache/super.c          |  2 +-
 drivers/target/target_core_pscsi.c |  2 +-
 fs/f2fs/super.c                    |  2 +-
 include/linux/blkdev.h             |  5 +++++
 kernel/trace/blktrace.c            |  2 +-
 7 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.17.0
