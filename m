From: Bart Van Assche <bvanassche@acm.org>
Date: Wed, 03 Jul 2019 15:03:27 +0000
Subject: Re: [PATCH V3 1/9] block: add a helper function to read nr_setcs
Message-Id: <26917678-fd82-b6c8-761e-220bc7d3b179@acm.org>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190702174236.3332-1-chaitanya.kulkarni@wdc.com>
 <20190702174236.3332-2-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190702174236.3332-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, xen-devel@lists.xenproject.org, kent.overstreet@gmail.com, yuchao0@huawei.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, konrad.wilk@oracle.com, roger.pau@citrix.com, linux-scsi@vger.kernel.org

On 7/2/19 10:42 AM, Chaitanya Kulkarni wrote:
> +/* Helper function to read the bdev->bd_part->nr_sects */
> +static inline sector_t bdev_nr_sects(struct block_device *bdev)
> +{
> +	return part_nr_sects_read(bdev->bd_part);
> +}

Is the comment above bdev_nr_sects() really useful or should it be left out?

Thanks,

Bart.
