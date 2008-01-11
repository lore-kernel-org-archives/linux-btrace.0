From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 11 Jan 2008 10:55:34 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <20080111105534.GC1589@elte.hu>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov> <1199996752.9159.46.camel@lap75545.ornl.gov> <20080110234438.4826f658@inria.fr> <20080111114132.084036f2@cheypa.inria.fr>
In-Reply-To: <20080111114132.084036f2@cheypa.inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guillaume Chazarain <guichaz@yahoo.fr>
Cc: mingo@redhat.com, David Dillow <dillowda@ornl.gov>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, tglx@linutronix.de, Jens Axboe <jens.axboe@oracle.com>, nigel@suspend2.net


* Guillaume Chazarain <guichaz@yahoo.fr> wrote:

> David Dillow <dillowda@ornl.gov> wrote:
> 
> > Patched kernel, nohz=off:
> >   .clock_underflows              : 213887
> 
> A little bit of warning about these patches, they are WIP, that's why 
> I did not send them earlier. It regress nohz=off.

ok. I have applied all but this one:

> A bit of context: these patches aim at making sure cpu_clock() on my
> laptop (cpufreq enabled) never overflows/underflows/warps with
> CONFIG_NOHZ enabled. With these patches, I have a few hundreds
> overflows and underflows during early bootup, and then nothing :-)

cool :-)

> >     sched: Fix rq->clock overflows detection with CONFIG_NO_HZ
> 
> I think this one is the most important for David, but unfortunately it
> has some problems.
> 
> > +static inline u64 max_skipped_ticks(struct rq *rq)
> > +{
> > +	return nohz_on(cpu_of(rq)) ? jiffies - rq->last_tick_seen + 2 : 1;
> > +}
> 
> Here, I initially wrote rq->last_tick_seen + 1 but experiments showed
> that +2 was needed as I really saw deltas of 2 milliseconds.
> 
> These patches have two objectives:
>  - taking into account that jiffies are not always incremented by 1
> thanks to nohz
>  - as the tick is stopped and restarted it may not tick at the exact
> expected moment, so allow a window of 1 jiffie. If the tick occurs
> during the right jiffy, we know the TSC is more precise than the tick
> so don't correct the clock.

i think it's much simpler to do what i have below. Could you try it on 
your box? Or if it is using ACPI idle - in that case the callbacks 
should already be there and there should be no need for further fixups.

> And the problem is that I seem to need a window of 2 jiffies, so I need
> some help.
> 
> >     sched: make sure jiffies is up to date before calling __update_rq_clock()
> 
> This is one is needed too but I'm less confident in its validity.
> 
> >     scheduler_tick() is not called every jiffies
> 
> This one is a bit ugly and seems to break nohz=off.

ok, i took this one out.

	Ingo

-------------------->
Subject: x86: idle wakeup event in the HLT loop
From: Ingo Molnar <mingo@elte.hu>

do a proper idle-wakeup event on HLT as well - some CPUs stop the TSC
in HLT too, not just when going through the ACPI methods.

(the ACPI idle code already does this.)

[ update the 64-bit side too, as noticed by Jiri Slaby. ]

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86/kernel/process_32.c |   15 ++++++++++++---
 arch/x86/kernel/process_64.c |   13 ++++++++++---
 2 files changed, 22 insertions(+), 6 deletions(-)

Index: linux-x86.q/arch/x86/kernel/process_32.c
=================================--- linux-x86.q.orig/arch/x86/kernel/process_32.c
+++ linux-x86.q/arch/x86/kernel/process_32.c
@@ -113,10 +113,19 @@ void default_idle(void)
 		smp_mb();
 
 		local_irq_disable();
-		if (!need_resched())
+		if (!need_resched()) {
+			ktime_t t0, t1;
+			u64 t0n, t1n;
+
+			t0 = ktime_get();
+			t0n = ktime_to_ns(t0);
 			safe_halt();	/* enables interrupts racelessly */
-		else
-			local_irq_enable();
+			local_irq_disable();
+			t1 = ktime_get();
+			t1n = ktime_to_ns(t1);
+			sched_clock_idle_wakeup_event(t1n - t0n);
+		}
+		local_irq_enable();
 		current_thread_info()->status |= TS_POLLING;
 	} else {
 		/* loop is done by the caller */
Index: linux-x86.q/arch/x86/kernel/process_64.c
=================================--- linux-x86.q.orig/arch/x86/kernel/process_64.c
+++ linux-x86.q/arch/x86/kernel/process_64.c
@@ -116,9 +116,16 @@ static void default_idle(void)
 	smp_mb();
 	local_irq_disable();
 	if (!need_resched()) {
-		/* Enables interrupts one instruction before HLT.
-		   x86 special cases this so there is no race. */
-		safe_halt();
+		ktime_t t0, t1;
+		u64 t0n, t1n;
+
+		t0 = ktime_get();
+		t0n = ktime_to_ns(t0);
+		safe_halt();	/* enables interrupts racelessly */
+		local_irq_disable();
+		t1 = ktime_get();
+		t1n = ktime_to_ns(t1);
+		sched_clock_idle_wakeup_event(t1n - t0n);
 	} else
 		local_irq_enable();
 	current_thread_info()->status |= TS_POLLING;
