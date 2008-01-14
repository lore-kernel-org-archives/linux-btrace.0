From: Jens Axboe <jens.axboe@oracle.com>
Date: Mon, 14 Jan 2008 08:10:01 +0000
Subject: Re: [patch] block: fix blktrace timestamps
Message-Id: <20080114081001.GN6258@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080111092334.GA8143@elte.hu> <20080111092513.GO6258@kernel.dk> <20080111094205.GE8143@elte.hu> <20080111095654.GR6258@kernel.dk> <20080111102953.GA27223@elte.hu> <20080111122802.GT6258@kernel.dk> <20080111132106.GA16496@elte.hu> <20080111171855.GX6258@kernel.dk> <20080114075114.GA13195@elte.hu> <20080114075922.GA17686@elte.hu>
In-Reply-To: <20080114075922.GA17686@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: David Dillow <dillowda@ornl.gov>, Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, Andrew Morton <akpm@linux-foundation.org>

On Mon, Jan 14 2008, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > because a perfectly working system is:
> > 
> >  "a user's .config that worked before should work with the new kernel
> >   too"
> > 
> > not:
> > 
> >  "a user's .config that worked before should work now too, with random
> >   new kernel features enabled as well."
> > 
> > the latter appears to be the rule you are applying, but it's not the 
> > regression rule we are using.
> 
> Jens, just to bring your definition of regressions to its logical 
> conclusion: does this mean that if there is any longstanding bug in the 
> block layer that you know about, but i didnt ever utilize that bit of 
> the block layer it in my .config, and if i enable it now in the .config 
> and i experience that bug, does it suddenly count as a regression? Do 
> you realize that your definition for "regressions" turns _almost every_ 
> current bug in the kernel into a regression?

Ingo, why do you keep harping this issue? I thought I suggested we agree
to disagree on this and let it rest.

And I would say that, yes, that is a regression, if that config option
is a core option that people are likely to enable. The CONFIG_NO_HZ is a
new option, people will select it. Your example pertain more to the 'use
mmio for IO operations' type options for drivers. If you enable that and
your driver suddenly stops working, you have a clear idea of WHY it
stops working and how to fix it. Not so with this blktrace scenario, I
bet that would take people quite a while to figure out how it broke.

Can we drop this subject now, please? The issue is resolved (and
merged), debating definitions of regressions is not very productive :-)

-- 
Jens Axboe

