From: David Dillow <dillowda@ornl.gov>
Date: Fri, 11 Jan 2008 15:43:25 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <1200066205.7480.8.camel@lap75545.ornl.gov>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov>
 <1199996752.9159.46.camel@lap75545.ornl.gov> <20080111093432.GD8143@elte.hu>
In-Reply-To: <20080111093432.GD8143@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, Jens Axboe <jens.axboe@oracle.com>


On Fri, 2008-01-11 at 10:34 +0100, Ingo Molnar wrote:
> * David Dillow <dillowda@ornl.gov> wrote:
> 
> > Ingo, Thomas added as I think this is related to 
> > sched.c:__update_rq_clock()'s checking for forward time warps.
> 
> yep, we've got some fixes in this area. Do blktrace timestamps work fine 
> in v2.6.23, with NOHZ?

Do you still want this tested, given that your ktime change works? If
so, it will likely be next week before I can devote some cycles to it --
it'll take installing a new distro on the machines.
-- 
Dave Dillow
National Center for Computational Science
Oak Ridge National Laboratory
(865) 241-6602 office


