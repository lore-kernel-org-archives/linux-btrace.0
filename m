From: Jens Axboe <jens.axboe@oracle.com>
Date: Mon, 05 Jan 2009 09:18:53 +0000
Subject: Re: Re: Re: [PATCH] blktrace: fix to trace a partition, instead of only disk
Message-Id: <20090105091853.GH32491@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <494895E9.9030300@gmail.com>
In-Reply-To: <494895E9.9030300@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Wed, Dec 31 2008, Shawn Du wrote:
> >Very nice! The only problem with this is that we have actions that are,
> >by definition, per device. So we probably want to include any sector
> >that is within the range of the partition, AND a zero sector. So that
> >means changing act_log_check() to something ala:
> >
> >-       if (sector < bt->start_lba || sector > bt->end_lba)
> >+       if (!sector || sector < bt->start_lba || sector > bt->end_lba)
> >                return 1;
> >
> >in pseudo patch form.
> 
> Thank you sir. And perhaps, we change in __blk_add_trace():
> 
> -	if (unlikely(act_log_check(bt, what, sector, pid)))
> +	if (act_log_check(bt, what, sector, pid))

Sure, lets get rid of it.

-- 
Jens Axboe

