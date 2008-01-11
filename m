From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 11 Jan 2008 09:32:11 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <20080111093211.GC8143@elte.hu>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov> <1199996752.9159.46.camel@lap75545.ornl.gov> <20080110234438.4826f658@inria.fr> <1200020661.5099.3.camel@obelisk.thedillows.org> <20080111090723.GI6258@kernel.dk> <478736C6.3080802@suspend2.net>
In-Reply-To: <478736C6.3080802@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nigel@nigel.suspend2.net
Cc: Jens Axboe <jens.axboe@oracle.com>, David Dillow <dillowda@ornl.gov>, Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de


* nigel@suspend2.net <nigel@suspend2.net> wrote:

> >>> Just out of curiosity, could you try the appended cumulative patch 
> >>> and report .clock_warps, .clock_overflows and .clock_underflows as 
> >>> you did.
> >> With those patches, CONFIG_NO_HZ works just fine.
> 
> Could these patches also help with hibernation issues? I'm trying 
> x86_64+NO_HZ, and seeing activity delayed during the atomic copy and 
> afterwards until I manually generate interrupts (by pressing keys).

i dont think that should be related to cpu_clock() use. Does the patch 
below make any difference? (or could you try x86.git to get the whole 
stack of x86 changes that we have at the moment.) Here's the coordinates 
for x86.git:

--------------{ x86.git instructions }---------->

# Add Linus's tree as a remote
git remote --add linus
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

# Add Ingo's tree as a remote
git remote --add x86
git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86.git

# With that setup, just run the following to get any changes you
# don't have.  It will also notice any new branches Ingo/Linus
# add to their repo.  Look in .git/config afterwards, the format
# to add new remotes is easy to figure out.
git remote update

	Ingo

----------->
Subject: x86: kick CPUS that might be sleeping in cpus_idle_wait
From: Steven Rostedt <rostedt@goodmis.org>

Sometimes cpu_idle_wait gets stuck because it might miss CPUS that are
already in idle, have no tasks waiting to run and have no interrupts going
to them.  This is common on bootup when switching cpu idle governors.

This patch gives those CPUS that don't check in an IPI kick.

Background:
-----------
I notice this while developing the mcount patches, that every once in a
while the system would hang. Looking deeper, the hang was always at boot
up when registering init_menu of the cpu_idle menu governor. Talking
with Thomas Gliexner, we discovered that one of the CPUS had no timer
events scheduled for it and it was in idle (running with NO_HZ). So the
CPU would not set the cpu_idle_state bit.

Hitting sysrq-t a few times would eventually route the interrupt to the
stuck CPU and the system would continue.

Note, I would have used the PDA isidle but that is set after the
cpu_idle_state bit is cleared, and would leave a window open where we
may miss being kicked.

hmm, looking closer at this, we still have a small race window between
clearing the cpu_idle_state and disabling interrupts (hence the RFC).

    CPU0:                          CPU 1:
  ---------                       ---------
 cpu_idle_wait():                 cpu_idle():
      |                           __cpu_cpu_var(is_idle) = 1;
      |                           if (__get_cpu_var(cpu_idle_state)) /* = 0 */
 per_cpu(cpu_idle_state, 1) = 1;         |
 if (per_cpu(is_idle, 1)) /* = 1 */     |
 smp_call_function(1)                    |
      |                             receives ipi and runs do_nothing.
 wait on map = empty               idle();
   /* waits forever */

So really we need interrupts off for most of this then. One might think
that we could simply clear the cpu_idle_state from do_nothing, but I'm
assuming that cpu_idle governors can be removed, and this might cause a
race that a governor might be used after the module was removed.

Venki said:

  I think your RFC patch is the right solution here.  As I see it, there is
  no race with your RFC patch.  As long as you call a dummy smp_call_function
  on all CPUs, we should be OK.  We can get rid of cpu_idle_state and the
  current wait forever logic altogether with dummy smp_call_function.  And so
  there wont be any wait forever scenario.

  The whole point of cpu_idle_wait() is to make all CPUs come out of idle
  loop atleast once.  The caller will use cpu_idle_wait something like this.

  // Want to change idle handler

  - Switch global idle handler to always present default_idle

  - call cpu_idle_wait so that all cpus come out of idle for an instant
    and stop using old idle pointer and start using default idle

  - Change the idle handler to a new handler

  - optional cpu_idle_wait if you want all cpus to start using the new
    handler immediately.

Maybe the below 1s patch is safe bet for .24.  But for .25, I would say we
just replace all complicated logic by simple dummy smp_call_function and
remove cpu_idle_state altogether.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andi Kleen <ak@suse.de>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86/kernel/process_32.c |   11 +++++++++++
 arch/x86/kernel/process_64.c |   11 +++++++++++
 2 files changed, 22 insertions(+)

Index: linux-x86.q/arch/x86/kernel/process_32.c
=================================--- linux-x86.q.orig/arch/x86/kernel/process_32.c
+++ linux-x86.q/arch/x86/kernel/process_32.c
@@ -214,6 +214,10 @@ void cpu_idle(void)
 	}
 }
 
+static void do_nothing(void *unused)
+{
+}
+
 void cpu_idle_wait(void)
 {
 	unsigned int cpu, this_cpu = get_cpu();
@@ -238,6 +242,13 @@ void cpu_idle_wait(void)
 				cpu_clear(cpu, map);
 		}
 		cpus_and(map, map, cpu_online_map);
+		/*
+		 * We waited 1 sec, if a CPU still did not call idle
+		 * it may be because it is in idle and not waking up
+		 * because it has nothing to do.
+		 * Give all the remaining CPUS a kick.
+		 */
+		smp_call_function_mask(map, do_nothing, 0, 0);
 	} while (!cpus_empty(map));
 
 	set_cpus_allowed(current, tmp);
Index: linux-x86.q/arch/x86/kernel/process_64.c
=================================--- linux-x86.q.orig/arch/x86/kernel/process_64.c
+++ linux-x86.q/arch/x86/kernel/process_64.c
@@ -204,6 +204,10 @@ void cpu_idle(void)
 	}
 }
 
+static void do_nothing(void *unused)
+{
+}
+
 void cpu_idle_wait(void)
 {
 	unsigned int cpu, this_cpu = get_cpu();
@@ -228,6 +232,13 @@ void cpu_idle_wait(void)
 				cpu_clear(cpu, map);
 		}
 		cpus_and(map, map, cpu_online_map);
+		/*
+		 * We waited 1 sec, if a CPU still did not call idle
+		 * it may be because it is in idle and not waking up
+		 * because it has nothing to do.
+		 * Give all the remaining CPUS a kick.
+		 */
+		smp_call_function_mask(map, do_nothing, 0, 0);
 	} while (!cpus_empty(map));
 
 	set_cpus_allowed(current, tmp);
