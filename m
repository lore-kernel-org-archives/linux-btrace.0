From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 11 Jan 2008 09:25:16 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <20080111092513.GO6258@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov> <1199996752.9159.46.camel@lap75545.ornl.gov> <20080110234438.4826f658@inria.fr> <1200020661.5099.3.camel@obelisk.thedillows.org> <20080111090723.GI6258@kernel.dk> <20080111092334.GA8143@elte.hu>
In-Reply-To: <20080111092334.GA8143@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: David Dillow <dillowda@ornl.gov>, Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de

On Fri, Jan 11 2008, Ingo Molnar wrote:
> 
> * Jens Axboe <jens.axboe@oracle.com> wrote:
> 
> > Thanks for reporting this. Guillaume, did you write this patch? We 
> > need to get it into 2.6.24-rc7 asap. Let me know if I should take care 
> > of that, or if it's already queued up elsewhere.
> 
> they are from the scheduler git tree (except the first debug patch), but 
> queued up for v2.6.25 at the moment.

So this means that blktrace will be broken with CONFIG_NO_HZ for 2.6.24?
That's clearly a regression.

-- 
Jens Axboe

