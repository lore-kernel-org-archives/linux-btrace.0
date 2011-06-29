From: Tao Ma <tm@tao.ma>
Date: Wed, 29 Jun 2011 06:20:21 +0000
Subject: Re: Ask a question
Message-Id: <4E0AC425.3030201@tao.ma>
List-Id: <linux-btrace.vger.kernel.org>
References: <201106291407157819892@gmail.com>
In-Reply-To: <201106291407157819892@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 06/29/2011 02:07 PM, majianpeng wrote:
>    Hi all:
>          At present,I wanted to use blktrace.So I readed source and founded the problem.
>          Following is my step:
>          1:mount  -t debugfs debugfs /sys/kernel/debug
>          2:blktrace -d /dev/sdb &
>             $pid
>          3:kill -9 $pid
>          I found some file in /sys/kernel/debug/block.
You shouldn't use -9 to kill it directly. use -2 so that blktrace can
capture the signal and exit as expected.

Having said that, blktrace -k /dev/sdb should help in this case.

Thanks
Tao
>          
> 	     If a btrace is ruing,but I call ioctl(BLKTRACETEARDOWN) 
> 		case BLKTRACETEARDOWN:
>                ret = blk_trace_remove(q);
> 		int blk_trace_remove(struct request_queue *q)
>  297 {               
>  298         struct blk_trace *bt;
>  299 
>  300         bt = xchg(&q->blk_trace, NULL);
>  301         if (!bt)
>  302                 return -EINVAL;
>  303                 
>  304         if (bt->trace_state != Blktrace_running)
>  305                 blk_trace_cleanup(bt);
>  306                 
>  307         return 0;
>  308 }       
>         But the btrace is in blktrace_running, so bt did not cleanup.
>         When and Who cleanup btrace?
