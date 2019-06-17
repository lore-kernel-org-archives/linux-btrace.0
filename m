From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Date: Mon, 17 Jun 2019 16:57:06 +0000
Subject: Re: [PATCH V2 0/7] block: use right accessor to read nr_setcs
Message-Id: <BYAPR04MB5749A60A077E1D976845264A86EB0@BYAPR04MB5749.namprd04.prod.outlook.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190617012832.4311-1-chaitanya.kulkarni@wdc.com>
 <a7458a93-5dd2-ddd1-8466-9da95c4d3aff@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bart Van Assche <bvanassche@acm.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "colyli@suse.de" <colyli@suse.de>, "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>, "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>, "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>

On 06/17/2019 08:45 AM, Bart Van Assche wrote:
> On 6/16/19 6:28 PM, Chaitanya Kulkarni wrote:
>> In the blk-zoned, bcache, f2fs and blktrace implementation
>> block device->hd_part->number of sectors field is accessed directly
>> without any appropriate locking or accessor function. There is
>> an existing accessor function present in the in include/linux/genhd.h
>> which should be used to read the bdev->hd_part->nr_sects.
>
> In the subject, "nr_setcs" should probably be changed into "nr_sects"?
>
Yes, will fix it in next version.
> Bart.
>

