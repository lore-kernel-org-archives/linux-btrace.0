From: Jens Axboe <jens.axboe@oracle.com>
Date: Mon, 14 Jan 2008 08:42:32 +0000
Subject: Re: [patch] block: fix blktrace timestamps
Message-Id: <20080114084231.GQ6258@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080111092334.GA8143@elte.hu> <20080111092513.GO6258@kernel.dk> <20080111094205.GE8143@elte.hu> <20080111095654.GR6258@kernel.dk> <20080111102953.GA27223@elte.hu> <20080111122802.GT6258@kernel.dk> <20080111132106.GA16496@elte.hu> <20080111171855.GX6258@kernel.dk> <20080114075114.GA13195@elte.hu> <20080114083901.GA17897@infradead.org>
In-Reply-To: <20080114083901.GA17897@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, David Dillow <dillowda@ornl.gov>, Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, Andrew Morton <akpm@linux-foundation.org>

On Mon, Jan 14 2008, Christoph Hellwig wrote:
> 
> Folks, this is getting a little silly.

It is

> Even if CONFIG_NO_HZ is new this is a an important regression, and
> yes we should avoid regressions wherever we can, and for such a quite
> important feature we should fix it.  On the other hand blktrace is using
> the wrong interface, and it has been told multiple times on lkml that
> sched_clock() should never ever be used outside the scheduler.  So the
> burden to fix this regression lies on the shoulders of the blktrace
> maintainer.

That is true. So far alternatives have all been slower though, so not
very tempting to transition to.

> No need for silly name calling here.

I don't know what thread you are reading, but neiter Ingo nor I have
resorted to silly name calling. The thread has long since diverted from
the original topic, though.

-- 
Jens Axboe

