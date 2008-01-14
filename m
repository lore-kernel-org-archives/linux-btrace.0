From: Ingo Molnar <mingo@elte.hu>
Date: Mon, 14 Jan 2008 07:59:22 +0000
Subject: Re: [patch] block: fix blktrace timestamps
Message-Id: <20080114075922.GA17686@elte.hu>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080111090723.GI6258@kernel.dk> <20080111092334.GA8143@elte.hu> <20080111092513.GO6258@kernel.dk> <20080111094205.GE8143@elte.hu> <20080111095654.GR6258@kernel.dk> <20080111102953.GA27223@elte.hu> <20080111122802.GT6258@kernel.dk> <20080111132106.GA16496@elte.hu> <20080111171855.GX6258@kernel.dk> <20080114075114.GA13195@elte.hu>
In-Reply-To: <20080114075114.GA13195@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <jens.axboe@oracle.com>
Cc: David Dillow <dillowda@ornl.gov>, Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, Andrew Morton <akpm@linux-foundation.org>


* Ingo Molnar <mingo@elte.hu> wrote:

> because a perfectly working system is:
> 
>  "a user's .config that worked before should work with the new kernel
>   too"
> 
> not:
> 
>  "a user's .config that worked before should work now too, with random
>   new kernel features enabled as well."
> 
> the latter appears to be the rule you are applying, but it's not the 
> regression rule we are using.

Jens, just to bring your definition of regressions to its logical 
conclusion: does this mean that if there is any longstanding bug in the 
block layer that you know about, but i didnt ever utilize that bit of 
the block layer it in my .config, and if i enable it now in the .config 
and i experience that bug, does it suddenly count as a regression? Do 
you realize that your definition for "regressions" turns _almost every_ 
current bug in the kernel into a regression?

	Ingo
