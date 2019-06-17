From: Bart Van Assche <bvanassche@acm.org>
Date: Mon, 17 Jun 2019 15:47:52 +0000
Subject: Re: [PATCH V2 1/7] block: add a helper function to read nr_setcs
Message-Id: <67bcc55e-a674-7a71-7ce3-3a6745977740@acm.org>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190617012832.4311-1-chaitanya.kulkarni@wdc.com>
 <20190617012832.4311-2-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190617012832.4311-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, kent.overstreet@gmail.com, jaegeuk@kernel.org, damien.lemoal@wdc.com

On 6/16/19 6:28 PM, Chaitanya Kulkarni wrote:
> This patch introduces helper function to read the number of sectors
> from struct block_device->bd_part member. For more details Please refer
> to the comment in the include/linux/genhd.h for part_nr_sects_read().
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>   include/linux/blkdev.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 592669bcc536..2ef1de20fd22 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1475,6 +1475,16 @@ static inline void put_dev_sector(Sector p)
>   	put_page(p.v);
>   }
>   
> +/* Helper function to read the bdev->bd_part->nr_sects */
> +static inline sector_t bdev_nr_sects(struct block_device *bdev)
> +{
> +	sector_t nr_sects;
> +
> +	nr_sects = part_nr_sects_read(bdev->bd_part);
> +
> +	return nr_sects;
> +}

Although this looks fine to me, is there any reason why the body of that 
function has not been written as follows?

static inline sector_t bdev_nr_sects(struct block_device *bdev)
{
	return part_nr_sects_read(bdev->bd_part);
}

Thanks,

Bart.
