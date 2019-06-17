From: Bart Van Assche <bvanassche@acm.org>
Date: Mon, 17 Jun 2019 15:53:19 +0000
Subject: Re: [PATCH V2 0/7] block: use right accessor to read nr_setcs
Message-Id: <a5a43553-69f1-fb99-fbfe-d0cb676a6cfa@acm.org>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190617012832.4311-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190617012832.4311-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, kent.overstreet@gmail.com, jaegeuk@kernel.org, damien.lemoal@wdc.com

On 6/16/19 6:28 PM, Chaitanya Kulkarni wrote:
> Changes from V1:-
> 
> 1. Drop the target_pscsi patch. (Bart)
> 2. Remove rcu locking which is not needed. (Bart)
> 
> Chaitanya Kulkarni (7):
>    block: add a helper function to read nr_setcs
>    blk-zoned: update blkdev_nr_zones() with helper
>    blk-zoned: update blkdev_report_zone() with helper
>    blk-zoned: update blkdev_reset_zones() with helper
>    bcache: update cached_dev_init() with helper
>    f2fs: use helper in init_blkz_info()
>    blktrace: use helper in blk_trace_setup_lba()
> 
>   block/blk-zoned.c         | 12 ++++++------
>   drivers/md/bcache/super.c |  2 +-
>   fs/f2fs/super.c           |  2 +-
>   include/linux/blkdev.h    | 10 ++++++++++
>   kernel/trace/blktrace.c   |  2 +-
>   5 files changed, 19 insertions(+), 9 deletions(-)

My feedback about the pscsi_get_blocks() was misleading: what I meant is 
that it is not necessary to introduce RCU locking in that function. I 
think that using bdev_nr_sects() or part_nr_sects_read() to read 
nr_sects in that function is useful.

Is there any reason that the following Xen macro has not been converted?

#define vbd_sz(_v)	((_v)->bdev->bd_part ? \
			 (_v)->bdev->bd_part->nr_sects : \
			  get_capacity((_v)->bdev->bd_disk))

Thanks,

Bart.
