From: Guillaume Chazarain <guichaz@yahoo.fr>
Date: Sat, 12 Jan 2008 00:03:53 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <20080112010353.0eeb18bf@inria.fr>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov>
	<1199996752.9159.46.camel@lap75545.ornl.gov>
	<20080110234438.4826f658@inria.fr>
	<20080111114132.084036f2@cheypa.inria.fr>
	<20080111105534.GC1589@elte.hu>
	<20080111233025.57d17f6a@inria.fr>
In-Reply-To: <20080111233025.57d17f6a@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: David Dillow <dillowda@ornl.gov>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, tglx@linutronix.de, Jens Axboe <jens.axboe@oracle.com>, nigel@suspend2.net

Guillaume Chazarain <guichaz@yahoo.fr> wrote:

> FYI, I'm currently trying to track down where rq->clock started to
> overflow with nohz=off, and it seems to be before 2.6.23, so my patches
> are not at fault ;-) Or maybe I am dreaming and it was always
> overflowing. Investigating ...

And the winner is:

commit 529c77261bccd9d37f110f58b0753d95beaa9fa2
Author: Ingo Molnar <mingo@elte.hu>
Date:   Fri Aug 10 23:05:11 2007 +0200

    sched: improve rq-clock overflow logic
    
    improve the rq-clock overflow logic: limit the absolute rq->clock
    delta since the last scheduler tick, instead of limiting the delta
    itself.
    
    tested by Arjan van de Ven - whole laptop was misbehaving due to
    an incorrectly calibrated cpu_khz confusing sched_clock().
    
    Signed-off-by: Ingo Molnar <mingo@elte.hu>
    Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

diff --git a/kernel/sched.c b/kernel/sched.c
index b0afd8d..6247e4a 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -263,6 +263,7 @@ struct rq {
 
 	unsigned int clock_warps, clock_overflows;
 	unsigned int clock_unstable_events;
+	u64 tick_timestamp;
 
 	atomic_t nr_iowait;
 
@@ -341,8 +342,11 @@ static void __update_rq_clock(struct rq *rq)
 		/*
 		 * Catch too large forward jumps too:
 		 */
-		if (unlikely(delta > 2*TICK_NSEC)) {
-			clock++;
+		if (unlikely(clock + delta > rq->tick_timestamp + TICK_NSEC)) {
+			if (clock < rq->tick_timestamp + TICK_NSEC)
+				clock = rq->tick_timestamp + TICK_NSEC;
+			else
+				clock++;
 			rq->clock_overflows++;
 		} else {
 			if (unlikely(delta > rq->clock_max_delta))
@@ -3308,9 +3312,16 @@ void scheduler_tick(void)
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
 	struct task_struct *curr = rq->curr;
+	u64 next_tick = rq->tick_timestamp + TICK_NSEC;
 
 	spin_lock(&rq->lock);
 	__update_rq_clock(rq);
+	/*
+	 * Let rq->clock advance by at least TICK_NSEC:
+	 */
+	if (unlikely(rq->clock < next_tick))
+		rq->clock = next_tick;
+	rq->tick_timestamp = rq->clock;
 	update_cpu_load(rq);
 	if (curr != rq->idle) /* FIXME: needed? */
 		curr->sched_class->task_tick(rq, curr);


Seems like I originally was not the only one seeing 2 jiffies jumps ;-)
I'll adapt my patches.

-- 
Guillaume
