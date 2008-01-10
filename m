From: David Dillow <dillowda@ornl.gov>
Date: Thu, 10 Jan 2008 20:25:52 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <1199996752.9159.46.camel@lap75545.ornl.gov>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov>
In-Reply-To: <1199918912.8388.13.camel@lap75545.ornl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de

Ingo, Thomas added as I think this is related to
sched.c:__update_rq_clock()'s checking for forward time warps.

On Wed, 2008-01-09 at 17:48 -0500, David Dillow wrote:
> While trying to gain some insight into a disk issue, I found that
> blktrace/blkparse was giving me bogus traces -- I was seeing requests
> complete before they were even dispatched or queued even! I had thought
> that maybe this was an issue with SMP on the box, but when running with
> 'maxcpus=1', it told me that my 53 second test run only took 3.5
> seconds.
> 
> I started tracking this down, and upon looking at cpu_clock(), and found
> that it uses sched_clock(), which is based on jiffies. At this point I
> had an ahah! moment and remembered that I had NO_HZ enabled.

[I did figure out that the sched_clock() jiffies implementation in
sched.c is a fallback.]

A few pieces of info I forgot in the original message -- this is on an
quad-processor, dual core Opteron box, running 2.6.24-rc7 x86_64. I'm
currently booting it with maxcpus=1, though at this point it is just a
hold-over from my initial bug hunting.

I can provide a full .config/dmesg if needed, but off the top:
CONFIG_NO_HZ=y
CONFIG_HZ00
CONFIG_CPU_FREQ is not set
CONFIG_CPU_IDLE makes no difference

hpet is the current clocksource

When booting with "nohz=off", rq->clock and rq->prev_clock_raw
from /proc/sched_debug track nicely with ktime_get() ("now is at ...
msecs"). rq->clock_overflows is non-zero, but increases relatively
slowly -- 650 for ~355 seconds.

With "nohz=on", rq->prev_clock_raw still tracks nicely with ktime_get(),
but rq->clock is moving very slowly and rq->clock_overflows is
incrementing fairly rapidly -- 53718 for ~357 seconds.

Either way gives a rq->max_delta of 0.999844 -- ms, I presume.

rq->clock_overflows is only incremented in sched.c:__update_rq_clock(),
and only when delta pushes clock more than TICK_NSEC past the current
tick_timestamp. I'm assuming this happens when the CPU's been idle for a
bit, with everything waiting for IO (4 to 5ms in the ticked blktrace),
so there's been no updates of rq->clock from sched_clock().

At the moment, I'm not sure how to track this farther, or how to fix it
properly. Any advice would be appreciated.

Thanks!
-- 
Dave Dillow
National Center for Computational Science
Oak Ridge National Laboratory
(865) 241-6602 office


