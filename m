From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 17 Dec 2008 08:01:16 +0000
Subject: Re: [PATCH] blktrace: fix to trace a partition, instead of only disk
Message-Id: <20081217080114.GA32491@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <494895E9.9030300@gmail.com>
In-Reply-To: <494895E9.9030300@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Wed, Dec 17 2008, Shawn Du wrote:
> I made some changes to block/blktrace.c to make it able to trace a partition as the -d option specified.
> Doing so by simply using start_lba and end_lba, these two parameters are not passed in from user space,but figured out by do_blk_trace_setup() in kernel. 
> 
> From: Shawn Du <duyuyang@gmail.com>
> Date: Wed, 17 Dec 2008 11:57:46 +0800
> Subject: [PATCH] Trace a partition
> Signed-off-by: Shawn Du <duyuyang@gmail.com>
> ---
>  block/blktrace.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blktrace.c b/block/blktrace.c
> index 85049a7..b8ea04c 100644
> --- a/block/blktrace.c
> +++ b/block/blktrace.c
> @@ -420,10 +420,13 @@ int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	if (!bt->act_mask)
>  		bt->act_mask = (u16) -1;
>  
> -	bt->start_lba = buts->start_lba;
> -	bt->end_lba = buts->end_lba;
> -	if (!bt->end_lba)
> +	if (bdev->bd_part) {
> +		bt->start_lba = bdev->bd_part->start_sect;
> +		bt->end_lba = bt->start_lba + bdev->bd_part->nr_sects;
> +	} else {
> +		bt->start_lba = 0;
>  		bt->end_lba = -1ULL;
> +	}
>  
>  	bt->pid = buts->pid;
>  	bt->trace_state = Blktrace_setup;
> -- 
> 1.5.2.5

Very nice! The only problem with this is that we have actions that are,
by definition, per device. So we probably want to include any sector
that is within the range of the partition, AND a zero sector. So that
means changing act_log_check() to something ala:

-       if (sector < bt->start_lba || sector > bt->end_lba)
+       if (!sector || sector < bt->start_lba || sector > bt->end_lba)
                return 1;

in pseudo patch form.

-- 
Jens Axboe

