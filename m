From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 11 Jun 2008 13:06:46 +0000
Subject: Re: [RFC PATCH] block: disable IRQs until data is written to relay channel
Message-Id: <20080611130642.GA20851@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080530110429.GA23157@ping.uio.no>
In-Reply-To: <20080530110429.GA23157@ping.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Wed, Jun 11 2008, Carl Henrik Lunde wrote:
> On Fri, May 30, 2008 at 13:44, Jens Axboe <jens.axboe@oracle.com> wrote:
> > On Fri, May 30 2008, Carl Henrik Lunde wrote:
> >> Hi,
> >>
> >> Can you review this patch?  I'm new to locking in the Linux kernel
> >> so I may be misssing something.
> >>
> >> I think we must disable IRQs between relay_reserve and initializing
> >> the data; consider the following scenario where task 1 and task 2
> >> runs on the same CPU:
> >>
> >> task 1: trace_note_message  task 2: interrupt  userspace (blktrace)
> >> --------------------------  -----------------  --------------------
> >> __trace_note_message                           read(relay)
> >> relay_reserve                                  <blocks ...>
> >> <interrupted: I/O completion>
> >>
> >>                             __blk_add_trace
> >>                             relay_reserve
> >>                             <buffers switched,
> >>                              wake user>
> >>                                                <reads uninitialized
> >>                                                 trace_note_message>
> >>                             <done>
> >> <runs again>
> >> memcpy() - too late
> >>
> >> --
> >> Carl Henrik
> >
> >> From 30fce97a2d7c02ba265eceed59592dbdc9c34f26 Mon Sep 17 00:00:00 2001
> >> From: Carl Henrik Lunde <chlunde@ping.uio.no>
> >> Date: Fri, 30 May 2008 12:57:47 +0200
> >> Subject: [PATCH] block: disable IRQs until data is written to relay channel
> >>
> >> As we may run relay_reserve from interrupt context we must always disable
> >> IRQs.  This is because a call to relay_reserve may expose previously written
> >> data to use space.
> >>
> >> Updated new message code and an old but related comment.
> >>
> >> Signed-off-by: Carl Henrik Lunde <chlunde@ping.uio.no>
> >> ---
> >>  block/blktrace.c |   10 ++++------
> >>  1 files changed, 4 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/block/blktrace.c b/block/blktrace.c
> >> index 7ae87cc..8d3a277 100644
> >> --- a/block/blktrace.c
> >> +++ b/block/blktrace.c
> >> @@ -79,16 +79,17 @@ void __trace_note_message(struct blk_trace *bt, const char *fmt, ...)
> >>  {
> >>       int n;
> >>       va_list args;
> >> +     unsigned long flags;
> >>       char *buf;
> >>
> >> -     preempt_disable();
> >> +     local_irq_save(flags);
> >>       buf = per_cpu_ptr(bt->msg_data, smp_processor_id());
> >>       va_start(args, fmt);
> >>       n = vscnprintf(buf, BLK_TN_MAX_MSG, fmt, args);
> >>       va_end(args);
> >>
> >>       trace_note(bt, 0, BLK_TN_MESSAGE, buf, n);
> >> -     preempt_enable();
> >> +     local_irq_restore(flags);
> >
> > Good spotting, applied! Thanks.
> 
> Hmm, applied where?

Still local, I'll get it pushed out for 2.6.26 final for sure.

-- 
Jens Axboe

