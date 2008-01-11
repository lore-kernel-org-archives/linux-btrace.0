From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 11 Jan 2008 10:29:53 +0000
Subject: [patch] block: fix blktrace timestamps
Message-Id: <20080111102953.GA27223@elte.hu>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov> <1199996752.9159.46.camel@lap75545.ornl.gov> <20080110234438.4826f658@inria.fr> <1200020661.5099.3.camel@obelisk.thedillows.org> <20080111090723.GI6258@kernel.dk> <20080111092334.GA8143@elte.hu> <20080111092513.GO6258@kernel.dk> <20080111094205.GE8143@elte.hu> <20080111095654.GR6258@kernel.dk>
In-Reply-To: <20080111095654.GR6258@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <jens.axboe@oracle.com>
Cc: David Dillow <dillowda@ornl.gov>, Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de


(David, could you try the patch further below - does it fix bkltrace 
timestamps too?)

* Jens Axboe <jens.axboe@oracle.com> wrote:

> On Fri, Jan 11 2008, Ingo Molnar wrote:
> > 
> > * Jens Axboe <jens.axboe@oracle.com> wrote:
> > 
> > > > they are from the scheduler git tree (except the first debug patch), 
> > > > but queued up for v2.6.25 at the moment.
> > > 
> > > So this means that blktrace will be broken with CONFIG_NO_HZ for 
> > > 2.6.24? That's clearly a regression.
> > 
> > 64-bit CONFIG_NO_HZ is a new feature in v2.6.24. If it happens on 
> > 32-bit too and it didnt happen in v2.6.23 32-bit then it's a 
> > regression.
> 
> If blktrace worked in 2.6.23 and it doesn't in 2.6.24 because of some 
> option that isn't immediately apparent, then it's a regression. 
> Period.

not completely correct. CONFIG_NO_HZ is a default-disabled option that 
became newly available on 64-bit x86. So if NO_HZ does not completely 
work on 64-bit, and if 32-bit works fine - which we dont know yet (my 
guess would be that it's similarly broken on the same box) then it's not 
a regression.

But even if it's not "technically" a regression, it's something we want 
to fix in .24 if we can, so i'm all with you Jens :)

and you can see that by looking at the patch. It does not unbreak 
something that 2.6.24 broke. It makes something work better that used to 
be so broken for such a long time. (sched_clock() based blktrace)

anyway, the most dangerous one of these patches has become well-tested 
meanwhile in x86.git. So maybe we can get this fix into v2.6.24. Maybe 
not. We'll see.

> > all this comes from blktrace's original decision of using sched_clock()
> > :-) It's not a global timesource and it's not trivial to turn it into a
> > halfways usable global timesource.
> 
> Hey, it was a high res time source and the only one easily available 
> :) I'm fine with using another timesource, I'll take suggestions or 
> patches any day!

Correction: it was not a high res time source, it was "the scheduler's 
per-cpu, non-exported, non-coherent, warps-and-jumps-like-hell high-res 
timesource that was intentionally called the _sched_ clock" ;-)

ktime_get() should have been used instead, which is a proper GTOD 
clocksource. The patch below implements this.

	Ingo

------------->
Subject: block: fix blktrace timestamps
From: Ingo Molnar <mingo@elte.hu>

David Dillow reported broken blktrace timestamps. The reason
is cpu_clock() which is not a global time source.

Fix bkltrace timestamps by using ktime_get() like the networking
code does for packet timestamps. This also removes a whole lot
of complexity from bkltrace.c and shrinks the code by 500 bytes:

   text    data     bss     dec     hex filename
   2888     124      44    3056     bf0 blktrace.o.before
   2390     116      44    2550     9f6 blktrace.o.after

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 block/blktrace.c |   69 +------------------------------------------------------
 1 file changed, 2 insertions(+), 67 deletions(-)

Index: linux-x86.q/block/blktrace.c
=================================--- linux-x86.q.orig/block/blktrace.c
+++ linux-x86.q/block/blktrace.c
@@ -25,7 +25,6 @@
 #include <linux/time.h>
 #include <asm/uaccess.h>
 
-static DEFINE_PER_CPU(unsigned long long, blk_trace_cpu_offset) = { 0, };
 static unsigned int blktrace_seq __read_mostly = 1;
 
 /*
@@ -41,7 +40,7 @@ static void trace_note(struct blk_trace 
 		const int cpu = smp_processor_id();
 
 		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
-		t->time = cpu_clock(cpu) - per_cpu(blk_trace_cpu_offset, cpu);
+		t->time = ktime_to_ns(ktime_get());
 		t->device = bt->dev;
 		t->action = action;
 		t->pid = pid;
@@ -159,7 +158,7 @@ void __blk_add_trace(struct blk_trace *b
 
 		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
 		t->sequence = ++(*sequence);
-		t->time = cpu_clock(cpu) - per_cpu(blk_trace_cpu_offset, cpu);
+		t->time = ktime_to_ns(ktime_get());
 		t->sector = sector;
 		t->bytes = bytes;
 		t->action = what;
@@ -506,73 +505,9 @@ void blk_trace_shutdown(struct request_q
 	}
 }
 
-/*
- * Average offset over two calls to cpu_clock() with a gettimeofday()
- * in the middle
- */
-static void blk_check_time(unsigned long long *t, int this_cpu)
-{
-	unsigned long long a, b;
-	struct timeval tv;
-
-	a = cpu_clock(this_cpu);
-	do_gettimeofday(&tv);
-	b = cpu_clock(this_cpu);
-
-	*t = tv.tv_sec * 1000000000 + tv.tv_usec * 1000;
-	*t -= (a + b) / 2;
-}
-
-/*
- * calibrate our inter-CPU timings
- */
-static void blk_trace_check_cpu_time(void *data)
-{
-	unsigned long long *t;
-	int this_cpu = get_cpu();
-
-	t = &per_cpu(blk_trace_cpu_offset, this_cpu);
-
-	/*
-	 * Just call it twice, hopefully the second call will be cache hot
-	 * and a little more precise
-	 */
-	blk_check_time(t, this_cpu);
-	blk_check_time(t, this_cpu);
-
-	put_cpu();
-}
-
-static void blk_trace_set_ht_offsets(void)
-{
-#if defined(CONFIG_SCHED_SMT)
-	int cpu, i;
-
-	/*
-	 * now make sure HT siblings have the same time offset
-	 */
-	preempt_disable();
-	for_each_online_cpu(cpu) {
-		unsigned long long *cpu_off, *sibling_off;
-
-		for_each_cpu_mask(i, per_cpu(cpu_sibling_map, cpu)) {
-			if (i = cpu)
-				continue;
-
-			cpu_off = &per_cpu(blk_trace_cpu_offset, cpu);
-			sibling_off = &per_cpu(blk_trace_cpu_offset, i);
-			*sibling_off = *cpu_off;
-		}
-	}
-	preempt_enable();
-#endif
-}
-
 static __init int blk_trace_init(void)
 {
 	mutex_init(&blk_tree_mutex);
-	on_each_cpu(blk_trace_check_cpu_time, NULL, 1, 1);
-	blk_trace_set_ht_offsets();
 
 	return 0;
 }
