From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 11 Jan 2008 09:56:54 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <20080111095654.GR6258@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov> <1199996752.9159.46.camel@lap75545.ornl.gov> <20080110234438.4826f658@inria.fr> <1200020661.5099.3.camel@obelisk.thedillows.org> <20080111090723.GI6258@kernel.dk> <20080111092334.GA8143@elte.hu> <20080111092513.GO6258@kernel.dk> <20080111094205.GE8143@elte.hu>
In-Reply-To: <20080111094205.GE8143@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: David Dillow <dillowda@ornl.gov>, Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de

On Fri, Jan 11 2008, Ingo Molnar wrote:
> 
> * Jens Axboe <jens.axboe@oracle.com> wrote:
> 
> > > they are from the scheduler git tree (except the first debug patch), 
> > > but queued up for v2.6.25 at the moment.
> > 
> > So this means that blktrace will be broken with CONFIG_NO_HZ for 
> > 2.6.24? That's clearly a regression.
> 
> 64-bit CONFIG_NO_HZ is a new feature in v2.6.24. If it happens on 32-bit 
> too and it didnt happen in v2.6.23 32-bit then it's a regression.

If blktrace worked in 2.6.23 and it doesn't in 2.6.24 because of some
option that isn't immediately apparent, then it's a regression. Period.

> all this comes from blktrace's original decision of using sched_clock()
> :-) It's not a global timesource and it's not trivial to turn it into a
> halfways usable global timesource.

Hey, it was a high res time source and the only one easily available :)
I'm fine with using another timesource, I'll take suggestions or patches
any day!

-- 
Jens Axboe

