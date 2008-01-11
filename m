From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 11 Jan 2008 12:28:02 +0000
Subject: Re: [patch] block: fix blktrace timestamps
Message-Id: <20080111122802.GT6258@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov> <1199996752.9159.46.camel@lap75545.ornl.gov> <20080110234438.4826f658@inria.fr> <1200020661.5099.3.camel@obelisk.thedillows.org> <20080111090723.GI6258@kernel.dk> <20080111092334.GA8143@elte.hu> <20080111092513.GO6258@kernel.dk> <20080111094205.GE8143@elte.hu> <20080111095654.GR6258@kernel.dk> <20080111102953.GA27223@elte.hu>
In-Reply-To: <20080111102953.GA27223@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: David Dillow <dillowda@ornl.gov>, Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de

On Fri, Jan 11 2008, Ingo Molnar wrote:
> 
> (David, could you try the patch further below - does it fix bkltrace 
> timestamps too?)
> 
> * Jens Axboe <jens.axboe@oracle.com> wrote:
> 
> > On Fri, Jan 11 2008, Ingo Molnar wrote:
> > > 
> > > * Jens Axboe <jens.axboe@oracle.com> wrote:
> > > 
> > > > > they are from the scheduler git tree (except the first debug patch), 
> > > > > but queued up for v2.6.25 at the moment.
> > > > 
> > > > So this means that blktrace will be broken with CONFIG_NO_HZ for 
> > > > 2.6.24? That's clearly a regression.
> > > 
> > > 64-bit CONFIG_NO_HZ is a new feature in v2.6.24. If it happens on 
> > > 32-bit too and it didnt happen in v2.6.23 32-bit then it's a 
> > > regression.
> > 
> > If blktrace worked in 2.6.23 and it doesn't in 2.6.24 because of some 
> > option that isn't immediately apparent, then it's a regression. 
> > Period.
> 
> not completely correct. CONFIG_NO_HZ is a default-disabled option that 
> became newly available on 64-bit x86. So if NO_HZ does not completely 
> work on 64-bit, and if 32-bit works fine - which we dont know yet (my 
> guess would be that it's similarly broken on the same box) then it's not 
> a regression.

Ingo, it doesn't matter if the option is disabled by default or not!
The fact is that functionality foo works in 2.6.23 and doesn't in 2.6.24
because of something unrelated. And that IS a regression, no matter what
kind of word play you are doing here :-)

> But even if it's not "technically" a regression, it's something we want 
> to fix in .24 if we can, so i'm all with you Jens :)

That's good :)

> ktime_get() should have been used instead, which is a proper GTOD 
> clocksource. The patch below implements this.

Will give it a whirl, it looks promising indeed and gets rid of the ugly
cpu sync stuff. What is the cost of ktime_get() compared to
sched_clock()?

-- 
Jens Axboe

