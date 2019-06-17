From: Bart Van Assche <bvanassche@acm.org>
Date: Mon, 17 Jun 2019 15:45:14 +0000
Subject: Re: [PATCH V2 0/7] block: use right accessor to read nr_setcs
Message-Id: <a7458a93-5dd2-ddd1-8466-9da95c4d3aff@acm.org>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190617012832.4311-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190617012832.4311-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, kent.overstreet@gmail.com, jaegeuk@kernel.org, damien.lemoal@wdc.com

On 6/16/19 6:28 PM, Chaitanya Kulkarni wrote:
> In the blk-zoned, bcache, f2fs and blktrace implementation
> block device->hd_part->number of sectors field is accessed directly
> without any appropriate locking or accessor function. There is
> an existing accessor function present in the in include/linux/genhd.h
> which should be used to read the bdev->hd_part->nr_sects.

In the subject, "nr_setcs" should probably be changed into "nr_sects"?

Bart.
