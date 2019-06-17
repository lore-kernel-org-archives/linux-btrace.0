From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Date: Mon, 17 Jun 2019 16:58:18 +0000
Subject: Re: [PATCH V2 0/7] block: use right accessor to read nr_setcs
Message-Id: <BYAPR04MB5749B6308E645ECEBD5F63E486EB0@BYAPR04MB5749.namprd04.prod.outlook.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190617012832.4311-1-chaitanya.kulkarni@wdc.com>
 <a5a43553-69f1-fb99-fbfe-d0cb676a6cfa@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bart Van Assche <bvanassche@acm.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "colyli@suse.de" <colyli@suse.de>, "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>, "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>, "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>

On 06/17/2019 08:53 AM, Bart Van Assche wrote:
> On 6/16/19 6:28 PM, Chaitanya Kulkarni wrote:
>> Changes from V1:-
>>
>> 1. Drop the target_pscsi patch. (Bart)
>> 2. Remove rcu locking which is not needed. (Bart)
>>
>> Chaitanya Kulkarni (7):
>>     block: add a helper function to read nr_setcs
>>     blk-zoned: update blkdev_nr_zones() with helper
>>     blk-zoned: update blkdev_report_zone() with helper
>>     blk-zoned: update blkdev_reset_zones() with helper
>>     bcache: update cached_dev_init() with helper
>>     f2fs: use helper in init_blkz_info()
>>     blktrace: use helper in blk_trace_setup_lba()
>>
>>    block/blk-zoned.c         | 12 ++++++------
>>    drivers/md/bcache/super.c |  2 +-
>>    fs/f2fs/super.c           |  2 +-
>>    include/linux/blkdev.h    | 10 ++++++++++
>>    kernel/trace/blktrace.c   |  2 +-
>>    5 files changed, 19 insertions(+), 9 deletions(-)
>
> My feedback about the pscsi_get_blocks() was misleading: what I meant is
> that it is not necessary to introduce RCU locking in that function. I
> think that using bdev_nr_sects() or part_nr_sects_read() to read
> nr_sects in that function is useful.
>
My bad. I'll add pscsi patch.
> Is there any reason that the following Xen macro has not been converted?
>
> #define vbd_sz(_v)	((_v)->bdev->bd_part ? \
> 			 (_v)->bdev->bd_part->nr_sects : \
> 			  get_capacity((_v)->bdev->bd_disk))
>
I'll convert this too and appropriate mailing list.

Thanks Bart again for detailed feedback.
> Thanks,
>
> Bart.
>

