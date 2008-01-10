From: Guillaume Chazarain <guichaz@yahoo.fr>
Date: Thu, 10 Jan 2008 22:44:38 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <20080110234438.4826f658@inria.fr>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov>
	<1199996752.9159.46.camel@lap75545.ornl.gov>
In-Reply-To: <1199996752.9159.46.camel@lap75545.ornl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Dillow <dillowda@ornl.gov>
Cc: linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de

David Dillow <dillowda@ornl.gov> wrote:

> At the moment, I'm not sure how to track this farther, or how to fix it
> properly. Any advice would be appreciated.

Just out of curiosity, could you try the appended cumulative patch and
report .clock_warps, .clock_overflows and .clock_underflows as you did.

Thanks.

commit 20fa02359d971bdb820d238184fabd42d8018e4f
Author: Guillaume Chazarain <guichaz@yahoo.fr>
Date:   Thu Jan 10 23:36:43 2008 +0100

    sched: monitor clock underflows in /proc/sched_debug
    
    We monitor clock overflows, let's also monitor clock underflows.
    
    Signed-off-by: Guillaume Chazarain <guichaz@yahoo.fr>

diff --git a/kernel/sched.c b/kernel/sched.c
index 37cf07a..cab9756 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -317,7 +317,7 @@ struct rq {
 	u64 clock, prev_clock_raw;
 	s64 clock_max_delta;
 
-	unsigned int clock_warps, clock_overflows;
+	unsigned int clock_warps, clock_overflows, clock_underflows;
 	u64 idle_clock;
 	unsigned int clock_deep_idle_events;
 	u64 tick_timestamp;
@@ -3485,8 +3485,10 @@ void scheduler_tick(void)
 	/*
 	 * Let rq->clock advance by at least TICK_NSEC:
 	 */
-	if (unlikely(rq->clock < next_tick))
+	if (unlikely(rq->clock < next_tick)) {
 		rq->clock = next_tick;
+		rq->clock_underflows++;
+	}
 	rq->tick_timestamp = rq->clock;
 	update_cpu_load(rq);
 	if (curr != rq->idle) /* FIXME: needed? */
diff --git a/kernel/sched_debug.c b/kernel/sched_debug.c
index 80fbbfc..9e5de09 100644
--- a/kernel/sched_debug.c
+++ b/kernel/sched_debug.c
@@ -179,6 +179,7 @@ static void print_cpu(struct seq_file *m, int cpu)
 	PN(prev_clock_raw);
 	P(clock_warps);
 	P(clock_overflows);
+	P(clock_underflows);
 	P(clock_deep_idle_events);
 	PN(clock_max_delta);
 	P(cpu_load[0]);

commit c146421cae64bb626714dc951fa39b55d2f819c1
Author: Guillaume Chazarain <guichaz@yahoo.fr>
Date:   Wed Jan 2 14:10:17 2008 +0100

    commit 60c6397ce4e8c9fd7feaeaef4167ace71c3949c8
    
        x86: scale cyc_2_nsec according to CPU frequency
    
        scale the sched_clock() cyc_2_nsec scaling factor according to
        CPU frequency changes.
    
        [ mingo@elte.hu: simplified it and fixed it for SMP. ]
    
        Signed-off-by: Ingo Molnar <mingo@elte.hu>
        Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/arch/x86/kernel/tsc_32.c b/arch/x86/kernel/tsc_32.c
index 9ebc0da..00bb4c1 100644
--- a/arch/x86/kernel/tsc_32.c
+++ b/arch/x86/kernel/tsc_32.c
@@ -5,6 +5,7 @@
 #include <linux/jiffies.h>
 #include <linux/init.h>
 #include <linux/dmi.h>
+#include <linux/percpu.h>
 
 #include <asm/delay.h>
 #include <asm/tsc.h>
@@ -80,13 +81,31 @@ EXPORT_SYMBOL_GPL(check_tsc_unstable);
  *
  *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
  */
-unsigned long cyc2ns_scale __read_mostly;
 
-#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
+DEFINE_PER_CPU(unsigned long, cyc2ns);
 
-static inline void set_cyc2ns_scale(unsigned long cpu_khz)
+static void set_cyc2ns_scale(unsigned long cpu_khz, int cpu)
 {
-	cyc2ns_scale = (1000000 << CYC2NS_SCALE_FACTOR)/cpu_khz;
+	unsigned long flags, prev_scale, *scale;
+	unsigned long long tsc_now, ns_now;
+
+	local_irq_save(flags);
+	sched_clock_idle_sleep_event();
+
+	scale = &per_cpu(cyc2ns, cpu);
+
+	rdtscll(tsc_now);
+	ns_now = __cycles_2_ns(tsc_now);
+
+	prev_scale = *scale;
+	if (cpu_khz)
+		*scale = (NSEC_PER_MSEC << CYC2NS_SCALE_FACTOR)/cpu_khz;
+
+	/*
+	 * Start smoothly with the new frequency:
+	 */
+	sched_clock_idle_wakeup_event(0);
+	local_irq_restore(flags);
 }
 
 /*
@@ -239,7 +258,9 @@ time_cpufreq_notifier(struct notifier_block *nb, unsigned long val, void *data)
 						ref_freq, freq->new);
 			if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
 				tsc_khz = cpu_khz;
-				set_cyc2ns_scale(cpu_khz);
+				preempt_disable();
+				set_cyc2ns_scale(cpu_khz, smp_processor_id());
+				preempt_enable();
 				/*
 				 * TSC based sched_clock turns
 				 * to junk w/ cpufreq
@@ -367,6 +388,8 @@ static inline void check_geode_tsc_reliable(void) { }
 
 void __init tsc_init(void)
 {
+	int cpu;
+
 	if (!cpu_has_tsc || tsc_disable)
 		goto out_no_tsc;
 
@@ -380,7 +403,15 @@ void __init tsc_init(void)
 				(unsigned long)cpu_khz / 1000,
 				(unsigned long)cpu_khz % 1000);
 
-	set_cyc2ns_scale(cpu_khz);
+	/*
+	 * Secondary CPUs do not run through tsc_init(), so set up
+	 * all the scale factors for all CPUs, assuming the same
+	 * speed as the bootup CPU. (cpufreq notifiers will fix this
+	 * up if their speed diverges)
+	 */
+	for_each_possible_cpu(cpu)
+		set_cyc2ns_scale(cpu_khz, cpu);
+
 	use_tsc_delay();
 
 	/* Check and install the TSC clocksource */
diff --git a/arch/x86/kernel/tsc_64.c b/arch/x86/kernel/tsc_64.c
index 9c70af4..32edd2c 100644
--- a/arch/x86/kernel/tsc_64.c
+++ b/arch/x86/kernel/tsc_64.c
@@ -10,6 +10,7 @@
 
 #include <asm/hpet.h>
 #include <asm/timex.h>
+#include <asm/timer.h>
 
 static int notsc __initdata = 0;
 
@@ -18,16 +19,48 @@ EXPORT_SYMBOL(cpu_khz);
 unsigned int tsc_khz;
 EXPORT_SYMBOL(tsc_khz);
 
-static unsigned int cyc2ns_scale __read_mostly;
+/* Accelerators for sched_clock()
+ * convert from cycles(64bits) => nanoseconds (64bits)
+ *  basic equation:
+ *		ns = cycles / (freq / ns_per_sec)
+ *		ns = cycles * (ns_per_sec / freq)
+ *		ns = cycles * (10^9 / (cpu_khz * 10^3))
+ *		ns = cycles * (10^6 / cpu_khz)
+ *
+ *	Then we use scaling math (suggested by george@mvista.com) to get:
+ *		ns = cycles * (10^6 * SC / cpu_khz) / SC
+ *		ns = cycles * cyc2ns_scale / SC
+ *
+ *	And since SC is a constant power of two, we can convert the div
+ *  into a shift.
+ *
+ *  We can use khz divisor instead of mhz to keep a better precision, since
+ *  cyc2ns_scale is limited to 10^6 * 2^10, which fits in 32 bits.
+ *  (mathieu.desnoyers@polymtl.ca)
+ *
+ *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
+ */
+DEFINE_PER_CPU(unsigned long, cyc2ns);
 
-static inline void set_cyc2ns_scale(unsigned long khz)
+static void set_cyc2ns_scale(unsigned long cpu_khz, int cpu)
 {
-	cyc2ns_scale = (NSEC_PER_MSEC << NS_SCALE) / khz;
-}
+	unsigned long flags, prev_scale, *scale;
+	unsigned long long tsc_now, ns_now;
 
-static unsigned long long cycles_2_ns(unsigned long long cyc)
-{
-	return (cyc * cyc2ns_scale) >> NS_SCALE;
+	local_irq_save(flags);
+	sched_clock_idle_sleep_event();
+
+	scale = &per_cpu(cyc2ns, cpu);
+
+	rdtscll(tsc_now);
+	ns_now = __cycles_2_ns(tsc_now);
+
+	prev_scale = *scale;
+	if (cpu_khz)
+		*scale = (NSEC_PER_MSEC << CYC2NS_SCALE_FACTOR)/cpu_khz;
+
+	sched_clock_idle_wakeup_event(0);
+	local_irq_restore(flags);
 }
 
 unsigned long long sched_clock(void)
@@ -100,7 +133,9 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 			mark_tsc_unstable("cpufreq changes");
 	}
 
-	set_cyc2ns_scale(tsc_khz_ref);
+	preempt_disable();
+	set_cyc2ns_scale(tsc_khz_ref, smp_processor_id());
+	preempt_enable();
 
 	return 0;
 }
@@ -151,7 +186,7 @@ static unsigned long __init tsc_read_refs(unsigned long *pm,
 void __init tsc_calibrate(void)
 {
 	unsigned long flags, tsc1, tsc2, tr1, tr2, pm1, pm2, hpet1, hpet2;
-	int hpet = is_hpet_enabled();
+	int hpet = is_hpet_enabled(), cpu;
 
 	local_irq_save(flags);
 
@@ -206,7 +241,9 @@ void __init tsc_calibrate(void)
 	}
 
 	tsc_khz = tsc2 / tsc1;
-	set_cyc2ns_scale(tsc_khz);
+
+	for_each_possible_cpu(cpu)
+		set_cyc2ns_scale(tsc_khz, cpu);
 }
 
 /*
diff --git a/include/asm-x86/timer.h b/include/asm-x86/timer.h
index 0db7e99..4f6fcb0 100644
--- a/include/asm-x86/timer.h
+++ b/include/asm-x86/timer.h
@@ -2,6 +2,7 @@
 #define _ASMi386_TIMER_H
 #include <linux/init.h>
 #include <linux/pm.h>
+#include <linux/percpu.h>
 
 #define TICK_SIZE (tick_nsec / 1000)
 
@@ -16,7 +17,7 @@ extern int recalibrate_cpu_khz(void);
 #define calculate_cpu_khz() native_calculate_cpu_khz()
 #endif
 
-/* Accellerators for sched_clock()
+/* Accelerators for sched_clock()
  * convert from cycles(64bits) => nanoseconds (64bits)
  *  basic equation:
  *		ns = cycles / (freq / ns_per_sec)
@@ -31,20 +32,32 @@ extern int recalibrate_cpu_khz(void);
  *	And since SC is a constant power of two, we can convert the div
  *  into a shift.
  *
- *  We can use khz divisor instead of mhz to keep a better percision, since
+ *  We can use khz divisor instead of mhz to keep a better precision, since
  *  cyc2ns_scale is limited to 10^6 * 2^10, which fits in 32 bits.
  *  (mathieu.desnoyers@polymtl.ca)
  *
  *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
  */
-extern unsigned long cyc2ns_scale __read_mostly;
+
+DECLARE_PER_CPU(unsigned long, cyc2ns);
 
 #define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
 
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
+static inline unsigned long long __cycles_2_ns(unsigned long long cyc)
 {
-	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
+	return cyc * per_cpu(cyc2ns, smp_processor_id()) >> CYC2NS_SCALE_FACTOR;
 }
 
+static inline unsigned long long cycles_2_ns(unsigned long long cyc)
+{
+	unsigned long long ns;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ns = __cycles_2_ns(cyc);
+	local_irq_restore(flags);
+
+	return ns;
+}
 
 #endif

commit 235fdf2d607e7139d3a7392506996a476229d12e
Author: Guillaume Chazarain <guichaz@yahoo.fr>
Date:   Thu Jan 10 23:36:44 2008 +0100

    sched: fix rq->clock warps on frequency changes
    
    Fix 2bacec8c318ca0418c0ee9ac662ee44207765dd4
    (sched: touch softlockup watchdog after idling) that reintroduced warps
    on frequency changes. touch_softlockup_watchdog() calls __update_rq_clock
    that checks rq->clock for warps, so call it after adjusting rq->clock.
    
    Signed-off-by: Guillaume Chazarain <guichaz@yahoo.fr>

diff --git a/kernel/sched.c b/kernel/sched.c
index cab9756..eee610d 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -668,7 +668,6 @@ void sched_clock_idle_wakeup_event(u64 delta_ns)
 	struct rq *rq = cpu_rq(smp_processor_id());
 	u64 now = sched_clock();
 
-	touch_softlockup_watchdog();
 	rq->idle_clock += delta_ns;
 	/*
 	 * Override the previous timestamp and ignore all
@@ -680,6 +679,7 @@ void sched_clock_idle_wakeup_event(u64 delta_ns)
 	rq->prev_clock_raw = now;
 	rq->clock += delta_ns;
 	spin_unlock(&rq->lock);
+	touch_softlockup_watchdog();
 }
 EXPORT_SYMBOL_GPL(sched_clock_idle_wakeup_event);
 

commit 241a8c3fb4d6fd452518a8e4e8eeabe9696c82aa
Author: Guillaume Chazarain <guichaz@yahoo.fr>
Date:   Thu Jan 10 23:36:45 2008 +0100

    sched: Fix rq->clock overflows detection with CONFIG_NO_HZ
    
    When using CONFIG_NO_HZ, rq->tick_timestamp is not updated every TICK_NSEC.
    We check that the number of skipped ticks matches the clock jump seen in
    __update_rq_clock().
    
    
    Signed-off-by: Guillaume Chazarain <guichaz@yahoo.fr>

diff --git a/kernel/sched.c b/kernel/sched.c
index eee610d..6f1271d 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -288,6 +288,7 @@ struct rq {
 	unsigned long cpu_load[CPU_LOAD_IDX_MAX];
 	unsigned char idle_at_tick;
 #ifdef CONFIG_NO_HZ
+	unsigned long last_tick_seen;
 	unsigned char in_nohz_recently;
 #endif
 	/* capture load from *all* tasks on this cpu: */
@@ -379,6 +380,32 @@ static inline int cpu_of(struct rq *rq)
 #endif
 }
 
+#ifdef CONFIG_NO_HZ
+static inline bool nohz_on(int cpu)
+{
+	return tick_get_tick_sched(cpu)->nohz_mode != NOHZ_MODE_INACTIVE;
+}
+
+static inline u64 max_skipped_ticks(struct rq *rq)
+{
+	return nohz_on(cpu_of(rq)) ? jiffies - rq->last_tick_seen + 2 : 1;
+}
+
+static inline void update_last_tick_seen(struct rq *rq)
+{
+	rq->last_tick_seen = jiffies;
+}
+#else
+static inline u64 max_skipped_ticks(struct rq *rq)
+{
+	return 1;
+}
+
+static inline void update_last_tick_seen(struct rq *rq)
+{
+}
+#endif
+
 /*
  * Update the per-runqueue clock, as finegrained as the platform can give
  * us, but without assuming monotonicity, etc.:
@@ -403,9 +430,12 @@ static void __update_rq_clock(struct rq *rq)
 		/*
 		 * Catch too large forward jumps too:
 		 */
-		if (unlikely(clock + delta > rq->tick_timestamp + TICK_NSEC)) {
-			if (clock < rq->tick_timestamp + TICK_NSEC)
-				clock = rq->tick_timestamp + TICK_NSEC;
+		u64 max_jump = max_skipped_ticks(rq) * TICK_NSEC;
+		u64 max_time = rq->tick_timestamp + max_jump;
+
+		if (unlikely(clock + delta > max_time)) {
+			if (clock < max_time)
+				clock = max_time;
 			else
 				clock++;
 			rq->clock_overflows++;
@@ -3490,6 +3520,7 @@ void scheduler_tick(void)
 		rq->clock_underflows++;
 	}
 	rq->tick_timestamp = rq->clock;
+	update_last_tick_seen(rq);
 	update_cpu_load(rq);
 	if (curr != rq->idle) /* FIXME: needed? */
 		curr->sched_class->task_tick(rq, curr);
@@ -6762,6 +6793,7 @@ void __init sched_init(void)
 		lockdep_set_class(&rq->lock, &rq->rq_lock_key);
 		rq->nr_running = 0;
 		rq->clock = 1;
+		update_last_tick_seen(rq);
 		init_cfs_rq(&rq->cfs, rq);
 #ifdef CONFIG_FAIR_GROUP_SCHED
 		INIT_LIST_HEAD(&rq->leaf_cfs_rq_list);

commit 437f7a5480a0916e5b0877e04ca87f998ef3f3e2
Author: Guillaume Chazarain <guichaz@yahoo.fr>
Date:   Thu Jan 10 23:36:45 2008 +0100

    sched: make sure jiffies is up to date before calling __update_rq_clock()
    
    Now that __update_rq_clock() uses jiffies to detect clock overflows, make sure
    jiffies are up to date before touch_softlockup_watchdog().
    
    Removed a touch_softlockup_watchdog() call becoming redundant with the added
    tick_nohz_update_jiffies().
    
    Signed-off-by: Guillaume Chazarain <guichaz@yahoo.fr>

diff --git a/kernel/sched.c b/kernel/sched.c
index 6f1271d..f6b3160 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -63,6 +63,7 @@
 #include <linux/reciprocal_div.h>
 #include <linux/unistd.h>
 #include <linux/pagemap.h>
+#include <linux/tick.h>
 
 #include <asm/tlb.h>
 #include <asm/irq_regs.h>
@@ -709,7 +710,7 @@ void sched_clock_idle_wakeup_event(u64 delta_ns)
 	rq->prev_clock_raw = now;
 	rq->clock += delta_ns;
 	spin_unlock(&rq->lock);
-	touch_softlockup_watchdog();
+	tick_nohz_update_jiffies();
 }
 EXPORT_SYMBOL_GPL(sched_clock_idle_wakeup_event);
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cb89fa8..2190593 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -133,14 +133,13 @@ void tick_nohz_update_jiffies(void)
 	if (!ts->tick_stopped)
 		return;
 
-	touch_softlockup_watchdog();
-
 	cpu_clear(cpu, nohz_cpu_mask);
 	now = ktime_get();
 
 	local_irq_save(flags);
 	tick_do_update_jiffies64(now);
 	local_irq_restore(flags);
+	touch_softlockup_watchdog();
 }
 
 /**

commit 63a885d40031190e17860c899446376b0fceefa8
Author: Guillaume Chazarain <guichaz@yahoo.fr>
Date:   Thu Jan 10 23:36:45 2008 +0100

    scheduler_tick() is not called every jiffies

diff --git a/kernel/sched.c b/kernel/sched.c
index f6b3160..9f73005 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -387,6 +387,11 @@ static inline bool nohz_on(int cpu)
 	return tick_get_tick_sched(cpu)->nohz_mode != NOHZ_MODE_INACTIVE;
 }
 
+static inline u64 min_skipped_ticks(struct rq *rq)
+{
+	return nohz_on(cpu_of(rq)) ? jiffies - rq->last_tick_seen : 1;
+}
+
 static inline u64 max_skipped_ticks(struct rq *rq)
 {
 	return nohz_on(cpu_of(rq)) ? jiffies - rq->last_tick_seen + 2 : 1;
@@ -397,6 +402,11 @@ static inline void update_last_tick_seen(struct rq *rq)
 	rq->last_tick_seen = jiffies;
 }
 #else
+static inline u64 min_skipped_ticks(struct rq *rq)
+{
+	return 1;
+}
+
 static inline u64 max_skipped_ticks(struct rq *rq)
 {
 	return 1;
@@ -3498,25 +3508,23 @@ void account_steal_time(struct task_struct *p, cputime_t steal)
 }
 
 /*
- * This function gets called by the timer code, with HZ frequency.
+ * This function gets called by the timer code with HZ frequency or less when
+ * using CONFIG_NO_HZ.
  * We call it with interrupts disabled.
- *
- * It also gets called by the fork code, when changing the parent's
- * timeslices.
  */
 void scheduler_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
 	struct task_struct *curr = rq->curr;
-	u64 next_tick = rq->tick_timestamp + TICK_NSEC;
+	u64 next_tick = rq->tick_timestamp + min_skipped_ticks(rq) * TICK_NSEC;
 
 	spin_lock(&rq->lock);
 	__update_rq_clock(rq);
 	/*
-	 * Let rq->clock advance by at least TICK_NSEC:
+	 * Let rq->clock advance by at least the number of elapsed ticks:
 	 */
-	if (unlikely(rq->clock < next_tick)) {
+	if (unlikely(rq->clock < next_tick - nohz_on(cpu) * TICK_NSEC)) {
 		rq->clock = next_tick;
 		rq->clock_underflows++;
 	}


-- 
Guillaume
