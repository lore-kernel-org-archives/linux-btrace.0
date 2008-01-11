From: Guillaume Chazarain <guichaz@yahoo.fr>
Date: Fri, 11 Jan 2008 22:30:25 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <20080111233025.57d17f6a@inria.fr>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov>
	<1199996752.9159.46.camel@lap75545.ornl.gov>
	<20080110234438.4826f658@inria.fr>
	<20080111114132.084036f2@cheypa.inria.fr>
	<20080111105534.GC1589@elte.hu>
In-Reply-To: <20080111105534.GC1589@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: David Dillow <dillowda@ornl.gov>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, tglx@linutronix.de, Jens Axboe <jens.axboe@oracle.com>, nigel@suspend2.net

Ingo Molnar <mingo@elte.hu> wrote:

> ok. I have applied all but this one

Hmm, I couldn't find them in mingo/linux-2.6-sched-devel.git.

> i think it's much simpler to do what i have below. Could you try it on 
> your box? Or if it is using ACPI idle - in that case the callbacks 
> should already be there and there should be no need for further fixups.
> 
> Subject: x86: idle wakeup event in the HLT loop

I use ACPI, so this patch has no effect.

FYI, I'm currently trying to track down where rq->clock started to
overflow with nohz=off, and it seems to be before 2.6.23, so my patches
are not at fault ;-) Or maybe I am dreaming and it was always
overflowing. Investigating ...

-- 
Guillaume
