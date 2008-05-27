From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 27 May 2008 13:32:06 +0000
Subject: Re: [PATCH 1/2] Added in MESSAGE notes for blktraces
Message-Id: <20080527133206.GU7712@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <483C0216.70008@hp.com>
In-Reply-To: <483C0216.70008@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-btrace@vger.kernel.org

On Tue, May 27 2008, Alan D. Brunelle wrote:
> +#define blk_add_trace_msg(q, fmt, ...)					\
> +	do {								\
> +		struct blk_trace *bt = (q)->blk_trace;			\
> +		if (unlikely(bt))					\
> +			__trace_note_message(bt, fmt, ##__VA_ARGS__);	\
> +	} while (0)
> +#define BLK_TN_MAX_MSG		1024

BTW, I think we need to make this a lot smaller. Something like 128
chars should be enough, I think. 1K is just too much stack size to use
here.

-- 
Jens Axboe

