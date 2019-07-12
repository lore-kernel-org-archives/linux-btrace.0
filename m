From: "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Fri, 12 Jul 2019 01:59:24 +0000
Subject: Re: [PATCH V4 1/9] block: add a helper function to read nr_setcs
Message-Id: <yq18st457yb.fsf@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190708184711.2984-1-chaitanya.kulkarni@wdc.com>
        <20190708184711.2984-2-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190708184711.2984-2-chaitanya.kulkarni@wdc.com> (Chaitanya
        Kulkarni's message of "Mon, 8 Jul 2019 11:47:03 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-block@vger.kernel.org, colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, xen-devel@lists.xenproject.org, kent.overstreet@gmail.com, yuchao0@huawei.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, konrad.wilk@oracle.com, roger.pau@citrix.com, bvanassche@acm.org, linux-scsi@vger.kernel.org


Hi Chaitanya,

> +static inline sector_t bdev_nr_sects(struct block_device *bdev)
> +{
> +	return part_nr_sects_read(bdev->bd_part);
> +}

Can bdev end up being NULL in any of the call sites?

Otherwise no objections.

-- 
Martin K. Petersen	Oracle Linux Engineering
