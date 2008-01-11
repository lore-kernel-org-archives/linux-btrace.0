From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 11 Jan 2008 12:42:37 +0000
Subject: Re: [patch] block: fix blktrace timestamps
Message-Id: <20080111124236.GV6258@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199996752.9159.46.camel@lap75545.ornl.gov> <20080110234438.4826f658@inria.fr> <1200020661.5099.3.camel@obelisk.thedillows.org> <20080111090723.GI6258@kernel.dk> <20080111092334.GA8143@elte.hu> <20080111092513.GO6258@kernel.dk> <20080111094205.GE8143@elte.hu> <20080111095654.GR6258@kernel.dk> <20080111102953.GA27223@elte.hu> <20080111122802.GT6258@kernel.dk>
In-Reply-To: <20080111122802.GT6258@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: David Dillow <dillowda@ornl.gov>, Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de

On Fri, Jan 11 2008, Jens Axboe wrote:
> > ktime_get() should have been used instead, which is a proper GTOD 
> > clocksource. The patch below implements this.
> 
> Will give it a whirl, it looks promising indeed and gets rid of the ugly
> cpu sync stuff. What is the cost of ktime_get() compared to
> sched_clock()?

Works for me - will apply it right now, we can always evaluate any
potential performance impact later. It's more important to have a
functional blktrace in 2.6.24.

Thanks Ingo!

-- 
Jens Axboe

