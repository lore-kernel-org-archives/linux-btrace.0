From: Ingo Molnar <mingo@elte.hu>
Date: Mon, 14 Jan 2008 07:51:14 +0000
Subject: Re: [patch] block: fix blktrace timestamps
Message-Id: <20080114075114.GA13195@elte.hu>
List-Id: <linux-btrace.vger.kernel.org>
References: <1200020661.5099.3.camel@obelisk.thedillows.org> <20080111090723.GI6258@kernel.dk> <20080111092334.GA8143@elte.hu> <20080111092513.GO6258@kernel.dk> <20080111094205.GE8143@elte.hu> <20080111095654.GR6258@kernel.dk> <20080111102953.GA27223@elte.hu> <20080111122802.GT6258@kernel.dk> <20080111132106.GA16496@elte.hu> <20080111171855.GX6258@kernel.dk>
In-Reply-To: <20080111171855.GX6258@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <jens.axboe@oracle.com>
Cc: David Dillow <dillowda@ornl.gov>, Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, Andrew Morton <akpm@linux-foundation.org>


* Jens Axboe <jens.axboe@oracle.com> wrote:

> > - Fact: feature CONFIG_CPU_IDLE=y did not exist in 64-bit x86 in v2.6.23.
> >   It has known bugs but they are not flagged 'regressions' (because the 
> >   feature did not exist before and the option is default-disabled) hence 
> >   the feature can stay. Some fixes to it are too dangerous or too 
> >   unproven and are delayed to v2.6.25.
> 
> > 
> > and now apply the same rule to CONFIG_NO_HZ:
> > 
> > - Fact: feature CONFIG_NO_HZ=y did not exist in 64-bit x86 in v2.6.23.
> >   It has known bugs but they are not flagged 'regressions' (because the 
> >   feature did not exist before and the option is default-disabled) hence 
> >   the feature can stay. Some fixes to it are too dangerous or too 
> >   unproven and are delayed to v2.6.25.
> 
> Forget about this unrelated feature, it has nothing to do with this 
> situation. [...]

why "forget" about a perfectly valid example right from v2.6.24 that 
demonstrates our definition for regressions and demonstrates the rules 
we are applying? Because it does not fit your argument? :)

> [...] What if some (eg) sata driver broke because someone enabled 
> CONFIG_NO_HZ. Would you say that's not a regression because it worked 
> before that option was there? [...]

as long as it's the same situation as have here (i.e. that NO_HZ 
appeared on an architecture where it wasnt offered before): yes, 
exactly, it's _NOT_ a regression in that sata driver [the sata driver 
might not even have been touched], and it's _NOT_ a regression in 
CONFIG_NO_HZ either because a regression can only be something that 
"something breaks that worked before". In that case it's a _bug_ in the 
newly introduced NO_HZ code.

> [...] That's crap, no user would buy that argument. As far as the user 
> is concerned, it IS a regression.

the user enabled a newly introduced kernel feature and that new feature 
might be not perfect. It might break a whole lot of unrelated code. We 
consider them bugs (of course), and work on fixing them, but still we 
dont consider such bugs a regression and dont revert a new feature if 
it's not fixed. It's a special-case. We apply that special case to all 
sorts of new kernel features, such as the new iwl3945 driver in 2.6.24, 
which has a number of unfixed bugs. We applied that to new kernel 
features as well, such as containers/control-groups in 2.6.23, etc. This 
is nothing new, we did this numerous times ever since the new-style 
development model was introduced around 2.6.12. _You_ might not know 
about it but that does not change the situation.

because a perfectly working system is:

 "a user's .config that worked before should work with the new kernel 
  too"

not:

 "a user's .config that worked before should work now too, with random
  new kernel features enabled as well."

the latter appears to be the rule you are applying, but it's not the 
regression rule we are using.

> Since we obviously disagree on this, lets agree to not debate it any 
> further. It doesn't matter anyway, since the issue is resolved.

this is not a matter of opinion or "disagreement", this is a matter of 
fact. You were the one telling me: "go fix that regression", so this 
issue might come up anytime in the future. Better clear it once and for 
all, we all have got better things to do than to rehash the same issue 
again and again.

	Ingo
