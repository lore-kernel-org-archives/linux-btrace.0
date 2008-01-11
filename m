From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 11 Jan 2008 09:42:05 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <20080111094205.GE8143@elte.hu>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov> <1199996752.9159.46.camel@lap75545.ornl.gov> <20080110234438.4826f658@inria.fr> <1200020661.5099.3.camel@obelisk.thedillows.org> <20080111090723.GI6258@kernel.dk> <20080111092334.GA8143@elte.hu> <20080111092513.GO6258@kernel.dk>
In-Reply-To: <20080111092513.GO6258@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <jens.axboe@oracle.com>
Cc: David Dillow <dillowda@ornl.gov>, Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de


* Jens Axboe <jens.axboe@oracle.com> wrote:

> > they are from the scheduler git tree (except the first debug patch), 
> > but queued up for v2.6.25 at the moment.
> 
> So this means that blktrace will be broken with CONFIG_NO_HZ for 
> 2.6.24? That's clearly a regression.

64-bit CONFIG_NO_HZ is a new feature in v2.6.24. If it happens on 32-bit 
too and it didnt happen in v2.6.23 32-bit then it's a regression.

all this comes from blktrace's original decision of using sched_clock()
:-) It's not a global timesource and it's not trivial to turn it into a
halfways usable global timesource.

	Ingo
