From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 11 Jan 2008 09:51:24 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <20080111095121.GG8143@elte.hu>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov> <1199996752.9159.46.camel@lap75545.ornl.gov> <20080110234438.4826f658@inria.fr> <1200020661.5099.3.camel@obelisk.thedillows.org> <20080111094441.GF8143@elte.hu>
In-Reply-To: <20080111094441.GF8143@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Dillow <dillowda@ornl.gov>
Cc: Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de


* Ingo Molnar <mingo@elte.hu> wrote:

> > With those patches, CONFIG_NO_HZ works just fine.
> 
> could you please try the two patches below, do they fix the problem as 
> well? They got a ton of testing in x86.git in the past ~2 months and 
> we could perhaps still push them into v2.6.24.

plus, if needed, perhaps this patch below from Guillaume ontop of it.

	Ingo

---------------->
Subject: sched: fix rq->clock warps on frequency changes
From: Guillaume Chazarain <guichaz@yahoo.fr>

sched: fix rq->clock warps on frequency changes

Fix 2bacec8c318ca0418c0ee9ac662ee44207765dd4
(sched: touch softlockup watchdog after idling) that reintroduced warps
on frequency changes. touch_softlockup_watchdog() calls __update_rq_clock
that checks rq->clock for warps, so call it after adjusting rq->clock.

Signed-off-by: Guillaume Chazarain <guichaz@yahoo.fr>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-x86.q/kernel/sched.c
=================================--- linux-x86.q.orig/kernel/sched.c
+++ linux-x86.q/kernel/sched.c
@@ -668,7 +668,6 @@ void sched_clock_idle_wakeup_event(u64 d
 	struct rq *rq = cpu_rq(smp_processor_id());
 	u64 now = sched_clock();
 
-	touch_softlockup_watchdog();
 	rq->idle_clock += delta_ns;
 	/*
 	 * Override the previous timestamp and ignore all
@@ -680,6 +679,7 @@ void sched_clock_idle_wakeup_event(u64 d
 	rq->prev_clock_raw = now;
 	rq->clock += delta_ns;
 	spin_unlock(&rq->lock);
+	touch_softlockup_watchdog();
 }
 EXPORT_SYMBOL_GPL(sched_clock_idle_wakeup_event);
 
