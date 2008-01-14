From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 14 Jan 2008 08:39:01 +0000
Subject: Re: [patch] block: fix blktrace timestamps
Message-Id: <20080114083901.GA17897@infradead.org>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080111090723.GI6258@kernel.dk> <20080111092334.GA8143@elte.hu> <20080111092513.GO6258@kernel.dk> <20080111094205.GE8143@elte.hu> <20080111095654.GR6258@kernel.dk> <20080111102953.GA27223@elte.hu> <20080111122802.GT6258@kernel.dk> <20080111132106.GA16496@elte.hu> <20080111171855.GX6258@kernel.dk> <20080114075114.GA13195@elte.hu>
In-Reply-To: <20080114075114.GA13195@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: Jens Axboe <jens.axboe@oracle.com>, David Dillow <dillowda@ornl.gov>, Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, Andrew Morton <akpm@linux-foundation.org>


Folks, this is getting a little silly.

Even if CONFIG_NO_HZ is new this is a an important regression, and
yes we should avoid regressions wherever we can, and for such a quite
important feature we should fix it.  On the other hand blktrace is using
the wrong interface, and it has been told multiple times on lkml that
sched_clock() should never ever be used outside the scheduler.  So the
burden to fix this regression lies on the shoulders of the blktrace
maintainer.

No need for silly name calling here.

