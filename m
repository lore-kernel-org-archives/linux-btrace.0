From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 11 Jan 2008 09:44:41 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <20080111094441.GF8143@elte.hu>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov> <1199996752.9159.46.camel@lap75545.ornl.gov> <20080110234438.4826f658@inria.fr> <1200020661.5099.3.camel@obelisk.thedillows.org>
In-Reply-To: <1200020661.5099.3.camel@obelisk.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Dillow <dillowda@ornl.gov>
Cc: Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de


* David Dillow <dillowda@ornl.gov> wrote:

> > Just out of curiosity, could you try the appended cumulative patch 
> > and report .clock_warps, .clock_overflows and .clock_underflows as 
> > you did.
> 
> With those patches, CONFIG_NO_HZ works just fine.

could you please try the two patches below, do they fix the problem as 
well? They got a ton of testing in x86.git in the past ~2 months and we 
could perhaps still push them into v2.6.24.

	Ingo

------------------>
Subject: x86: scale cyc_2_nsec according to CPU frequency
From: "Guillaume Chazarain" <guichaz@yahoo.fr>

scale the sched_clock() cyc_2_nsec scaling factor according to
CPU frequency changes.

[ mingo@elte.hu: simplified it and fixed it for SMP. ]

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/tsc_32.c |   43 ++++++++++++++++++++++++++++++-----
 arch/x86/kernel/tsc_64.c |   57 ++++++++++++++++++++++++++++++++++++++---------
 include/asm-x86/timer.h  |   23 ++++++++++++++----
 3 files changed, 102 insertions(+), 21 deletions(-)

Index: linux-x86.q/arch/x86/kernel/tsc_32.c
=================================--- linux-x86.q.orig/arch/x86/kernel/tsc_32.c
+++ linux-x86.q/arch/x86/kernel/tsc_32.c
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
@@ -239,7 +258,9 @@ time_cpufreq_notifier(struct notifier_bl
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
@@ -367,6 +388,8 @@ static inline void check_geode_tsc_relia
 
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
Index: linux-x86.q/arch/x86/kernel/tsc_64.c
=================================--- linux-x86.q.orig/arch/x86/kernel/tsc_64.c
+++ linux-x86.q/arch/x86/kernel/tsc_64.c
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
@@ -100,7 +133,9 @@ static int time_cpufreq_notifier(struct 
 			mark_tsc_unstable("cpufreq changes");
 	}
 
-	set_cyc2ns_scale(tsc_khz_ref);
+	preempt_disable();
+	set_cyc2ns_scale(tsc_khz_ref, smp_processor_id());
+	preempt_enable();
 
 	return 0;
 }
@@ -151,7 +186,7 @@ static unsigned long __init tsc_read_ref
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
Index: linux-x86.q/include/asm-x86/timer.h
=================================--- linux-x86.q.orig/include/asm-x86/timer.h
+++ linux-x86.q/include/asm-x86/timer.h
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

--------------------->
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
