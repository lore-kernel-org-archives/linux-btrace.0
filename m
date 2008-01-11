From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 11 Jan 2008 09:34:32 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <20080111093432.GD8143@elte.hu>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov> <1199996752.9159.46.camel@lap75545.ornl.gov>
In-Reply-To: <1199996752.9159.46.camel@lap75545.ornl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Dillow <dillowda@ornl.gov>
Cc: linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, Jens Axboe <jens.axboe@oracle.com>


* David Dillow <dillowda@ornl.gov> wrote:

> Ingo, Thomas added as I think this is related to 
> sched.c:__update_rq_clock()'s checking for forward time warps.

yep, we've got some fixes in this area. Do blktrace timestamps work fine 
in v2.6.23, with NOHZ?

	Ingo
