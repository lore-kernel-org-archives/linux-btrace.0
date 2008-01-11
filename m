From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 11 Jan 2008 17:18:55 +0000
Subject: Re: [patch] block: fix blktrace timestamps
Message-Id: <20080111171855.GX6258@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080110234438.4826f658@inria.fr> <1200020661.5099.3.camel@obelisk.thedillows.org> <20080111090723.GI6258@kernel.dk> <20080111092334.GA8143@elte.hu> <20080111092513.GO6258@kernel.dk> <20080111094205.GE8143@elte.hu> <20080111095654.GR6258@kernel.dk> <20080111102953.GA27223@elte.hu> <20080111122802.GT6258@kernel.dk> <20080111132106.GA16496@elte.hu>
In-Reply-To: <20080111132106.GA16496@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: David Dillow <dillowda@ornl.gov>, Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de

On Fri, Jan 11 2008, Ingo Molnar wrote:
> 
> * Jens Axboe <jens.axboe@oracle.com> wrote:
> 
> > > > If blktrace worked in 2.6.23 and it doesn't in 2.6.24 because of 
> > > > some option that isn't immediately apparent, then it's a 
> > > > regression. Period.
> > > 
> > > not completely correct. CONFIG_NO_HZ is a default-disabled option 
> > > that became newly available on 64-bit x86. So if NO_HZ does not 
> > > completely work on 64-bit, and if 32-bit works fine - which we dont 
> > > know yet (my guess would be that it's similarly broken on the same 
> > > box) then it's not a regression.
> > 
> > Ingo, it doesn't matter if the option is disabled by default or not! 
> > The fact is that functionality foo works in 2.6.23 and doesn't in 
> > 2.6.24 because of something unrelated. And that IS a regression, no 
> > matter what kind of word play you are doing here :-)
> 
> argh, Jens. Really. I believe you stopped using your brain because 
> CONFIG_BKL_IO_TRACE=y is affected by this bug and apparently you've got 
> a weak spot for it ;)

I don't think so.

> Think about it another way then, in the context of another, real kernel 
> feature we introduced in v2.6.24, namely CONFIG_CPU_IDLE=y:
> 
> - Fact: feature CONFIG_CPU_IDLE=y did not exist in 64-bit x86 in v2.6.23.
>   It has known bugs but they are not flagged 'regressions' (because the 
>   feature did not exist before and the option is default-disabled) hence 
>   the feature can stay. Some fixes to it are too dangerous or too 
>   unproven and are delayed to v2.6.25.

> 
> and now apply the same rule to CONFIG_NO_HZ:
> 
> - Fact: feature CONFIG_NO_HZ=y did not exist in 64-bit x86 in v2.6.23.
>   It has known bugs but they are not flagged 'regressions' (because the 
>   feature did not exist before and the option is default-disabled) hence 
>   the feature can stay. Some fixes to it are too dangerous or too 
>   unproven and are delayed to v2.6.25.

Forget about this unrelated feature, it has nothing to do with this
situation. What if some (eg) sata driver broke because someone enabled
CONFIG_NO_HZ. Would you say that's not a regression because it worked
before that option was there? That's crap, no user would buy that
argument. As far as the user is concerned, it IS a regression.

Since we obviously disagree on this, lets agree to not debate it any
further. It doesn't matter anyway, since the issue is resolved.

> > [...] What is the cost of ktime_get() compared to sched_clock()?
> 
> compared to the costs of IO transfers it should be OK. It can be really 
> fast but in the worst-case it can be as slow as 3-6 usecs (when we use 
> the acpi_pm clocksource). If there's complaints then probably the 
> networking folks will yell first :)

How does that compare to sched_clock()? 3-6 usec would render blktrace
unusable for certain types of testing, unfortunately. This isn't just
queried per IO, it's done for every action for that IO. So you'd
typically have up to eg 10 traces for a single IO piece, perhaps even
more.

For 2.6.24 the solution is fine, I'll revisit the impact when I can.

-- 
Jens Axboe

