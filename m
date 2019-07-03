From: Minwoo Im <minwoo.im.dev@gmail.com>
Date: Wed, 03 Jul 2019 00:20:37 +0000
Subject: Re: [PATCH V3 2/9] blk-zoned: update blkdev_nr_zones() with helper
Message-Id: <20190703002037.GC15705@minwoo-desktop>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190702174236.3332-1-chaitanya.kulkarni@wdc.com>
 <20190702174236.3332-3-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190702174236.3332-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-block@vger.kernel.org, colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, xen-devel@lists.xenproject.org, kent.overstreet@gmail.com, yuchao0@huawei.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, konrad.wilk@oracle.com, roger.pau@citrix.com, bvanassche@acm.org, linux-scsi@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>

On 19-07-02 10:42:28, Chaitanya Kulkarni wrote:
> This patch updates the blkdev_nr_zones() with newly introduced helper
> function to read the nr_sects from block device's hd_parts with the
> help if part_nr_sects_read().

It looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
