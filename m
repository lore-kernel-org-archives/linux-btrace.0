From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 11 Jan 2008 09:29:28 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <20080111092925.GB8143@elte.hu>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov> <1199996752.9159.46.camel@lap75545.ornl.gov> <20080110234438.4826f658@inria.fr> <1200020661.5099.3.camel@obelisk.thedillows.org> <20080111090723.GI6258@kernel.dk> <20080111092334.GA8143@elte.hu>
In-Reply-To: <20080111092334.GA8143@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <jens.axboe@oracle.com>
Cc: David Dillow <dillowda@ornl.gov>, Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de


* Ingo Molnar <mingo@elte.hu> wrote:

> > Thanks for reporting this. Guillaume, did you write this patch? We 
> > need to get it into 2.6.24-rc7 asap. Let me know if I should take 
> > care of that, or if it's already queued up elsewhere.
> 
> they are from the scheduler git tree (except the first debug patch), 
> but queued up for v2.6.25 at the moment.

some of them are not - Guillaume has not sent them. I'll sort it out.

	Ingo
