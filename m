From: Jens Axboe <jens.axboe@oracle.com>
Date: Mon, 26 May 2008 11:29:54 +0000
Subject: Re: [RFC: Kernel Patch] Implement simple message in blktrace stream
Message-Id: <20080526112953.GF7712@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <48372AE6.5080107@hp.com>
In-Reply-To: <48372AE6.5080107@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Fri, May 23 2008, Alan D. Brunelle wrote:

> From 4b2e639af0c6cb8c099003c5a3fda388022e1b49 Mon Sep 17 00:00:00 2001
> From: Alan D. Brunelle <alan.brunelle@hp.com>
> Date: Fri, 23 May 2008 16:27:34 -0400
> Subject: [PATCH] Added in MESSAGE notes for blktraces - sample message for elv switch
> 
> Allows messages to be inserted into blktrace streams. Can be used to
> annotate parts separations in the blktrace stream.
> 
> (Needs cleaning up: separate elevator mods into a separate patch.)
> 
> Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
> ---
>  block/blktrace.c             |    6 ++++++
>  block/elevator.c             |    4 ++++
>  include/linux/blktrace_api.h |   20 ++++++++++++++++++++
>  3 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/block/blktrace.c b/block/blktrace.c
> index b2cbb4e..37dec26 100644
> --- a/block/blktrace.c
> +++ b/block/blktrace.c
> @@ -75,6 +75,12 @@ static void trace_note_time(struct blk_trace *bt)
>  	local_irq_restore(flags);
>  }
>  
> +void __trace_note_message(struct blk_trace *bt, char *msg)
> +{
> +	trace_note(bt, 0, BLK_TN_MESSAGE, msg, strlen(msg));
> +}
> +EXPORT_SYMBOL_GPL(__trace_note_message);
> +
>  static int act_log_check(struct blk_trace *bt, u32 what, sector_t sector,
>  			 pid_t pid)
>  {
> diff --git a/block/elevator.c b/block/elevator.c
> index 980f8ae..d9d4091 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -1051,6 +1051,7 @@ EXPORT_SYMBOL_GPL(elv_unregister);
>   */
>  static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
>  {
> +	char msg[ELV_NAME_MAX +  16];
>  	elevator_t *old_elevator, *e;
>  	void *data;
>  

I don't like this, it completely destroys the "invisibility" of blktrace
when not used. Why not make the blk_add_trace_msg() interface like
sprintf() and friends instead? Then your call for this should just be:

        blk_add_trace_msg(q, "elv switch: %s", e->elevator_type->elevator_name);

instead, and you would not need a 'msg' on the stack for every such
call. Do that and I'll take it in a jiffy :-)

-- 
Jens Axboe

