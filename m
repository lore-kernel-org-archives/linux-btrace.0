From: Bart Van Assche <bvanassche@acm.org>
Date: Wed, 21 Aug 2019 15:20:24 +0000
Subject: Re: [PATCH V5 0/9] block: use right accessor to read nr_sects
Message-Id: <1aaf1d56-c1a2-957c-28b6-048f9965f412@acm.org>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190821061423.3408-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190821061423.3408-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, xen-devel@lists.xenproject.org, kent.overstreet@gmail.com, yuchao0@huawei.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, konrad.wilk@oracle.com, roger.pau@citrix.com, linux-scsi@vger.kernel.org

On 8/20/19 11:14 PM, Chaitanya Kulkarni wrote:
> In the blk-zoned, bcache, f2fs, target-pscsi, xen and blktrace
> implementation block device->hd_part->number of sectors field is
> accessed directly without any appropriate locking or accessor function.
> There is an existing accessor function present in the in
> include/linux/genhd.h which should be used to read the
> bdev->hd_part->nr_sects.

For the entire series:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
