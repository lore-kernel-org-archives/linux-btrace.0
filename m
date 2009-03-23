From: Jens Axboe <jens.axboe@oracle.com>
Date: Mon, 23 Mar 2009 18:40:42 +0000
Subject: Re: [Patch] fix
Message-Id: <20090323184042.GX27476@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1237819991.5624.20.camel@kitka.ibm.com>
In-Reply-To: <1237819991.5624.20.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Mon, Mar 23 2009, Martin Peschke wrote:
> Jens,
> 
> Tom fixed my "boken trace magic" issue. Please apply.

Heh well, not sure I'd call that a real fix, but if it makes things,
that is fine. I'll apply it.

> 
> Thanks,
> Martin
> 
> 
> From: Tom Zanussi <tzanussi@gmail.com>
> 
> Blktrace failed to lock reader threads on the cpu used by the corresponding
> writer. This resulted in stale data being consumed when blktrace accidently
> read at a position that was being written to at the same time. This issue
> surfaced as "bad trace magic" warnings emitted by blktrace tools.
> 
> The problem occured on an SMP System z machine. The patch fixes the issue.
> 
> Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>
> 
> ---
>  blktrace.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/blktrace.c
> +++ b/blktrace.c
> @@ -610,7 +610,7 @@ static int lock_on_cpu(int cpu)
>  
>  	CPU_ZERO(&cpu_mask);
>  	CPU_SET(cpu, &cpu_mask);
> -	if (sched_setaffinity(getpid(), sizeof(cpu_mask), &cpu_mask) < 0)
> +	if (sched_setaffinity(0, sizeof(cpu_mask), &cpu_mask) < 0)
>  		return errno;
>  
>  	return 0;
> 
> 

-- 
Jens Axboe

