From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 11 Jan 2008 10:50:59 +0000
Subject: Re: [patch] block: fix blktrace timestamps
Message-Id: <20080111105059.GB1589@elte.hu>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199996752.9159.46.camel@lap75545.ornl.gov> <20080110234438.4826f658@inria.fr> <1200020661.5099.3.camel@obelisk.thedillows.org> <20080111090723.GI6258@kernel.dk> <20080111092334.GA8143@elte.hu> <20080111092513.GO6258@kernel.dk> <20080111094205.GE8143@elte.hu> <20080111095654.GR6258@kernel.dk> <20080111102953.GA27223@elte.hu> <20080111114713.0a2df9ee@cheypa.inria.fr>
In-Reply-To: <20080111114713.0a2df9ee@cheypa.inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guillaume Chazarain <guichaz@yahoo.fr>
Cc: Jens Axboe <jens.axboe@oracle.com>, David Dillow <dillowda@ornl.gov>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de


* Guillaume Chazarain <guichaz@yahoo.fr> wrote:

> > Correction: it was not a high res time source, it was "the 
> > scheduler's per-cpu, non-exported, non-coherent, 
> > warps-and-jumps-like-hell high-res timesource that was intentionally 
> > called the _sched_ clock" ;-)
> 
> I think the warts of cpu_clock() are fixable, except maybe 
> unsynchronization on SMP which is harder.

yes - but in terms of v2.6.24, the bkltrace patch i sent is a lot less 
risky.

	Ingo
