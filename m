From: Ingo Molnar <mingo@elte.hu>
Date: Tue, 14 Apr 2009 07:59:47 +0000
Subject: Re: PATCH 1/3] blktrace: support per-partition tracing
Message-Id: <20090414075947.GA27003@elte.hu>
List-Id: <linux-btrace.vger.kernel.org>
References: <49E42620.4050701@cn.fujitsu.com>
In-Reply-To: <49E42620.4050701@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Shawn Du <duyuyang@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-btrace@vger.kernel.org


* Li Zefan <lizf@cn.fujitsu.com> wrote:

> --- a/include/linux/blktrace_api.h
> +++ b/include/linux/blktrace_api.h
> @@ -165,8 +165,9 @@ struct blk_trace {
>  
>  extern int blk_trace_ioctl(struct block_device *, unsigned, char __user *);
>  extern void blk_trace_shutdown(struct request_queue *);
> -extern int do_blk_trace_setup(struct request_queue *q,
> -	char *name, dev_t dev, struct blk_user_trace_setup *buts);
> +extern int do_blk_trace_setup(struct request_queue *q, char *name,
> +			      dev_t dev, struct block_device *bdev,
> +			      struct blk_user_trace_setup *buts);
>  extern void __trace_note_message(struct blk_trace *, const char *fmt, ...);
>  
>  /**
> @@ -193,6 +194,7 @@ extern void __trace_note_message(struct blk_trace *, const char *fmt, ...);
>  extern void blk_add_driver_data(struct request_queue *q, struct request *rq,
>  				void *data, size_t len);
>  extern int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
> +			   struct block_device *bdev,
>  			   char __user *arg);
>  extern int blk_trace_startstop(struct request_queue *q, int start);
>  extern int blk_trace_remove(struct request_queue *q);

Small detail: you forgot about the !CONFIG_BLK_DEV_IO_TRACE case 
here, the wrapper macros there need to be updated.

(no need to resend - i fixed this up in the 1/3 and 3/3 patches)

	Ingo
