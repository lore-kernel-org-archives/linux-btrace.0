From: Carl Henrik Lunde <chlunde@ping.uio.no>
Date: Fri, 30 May 2008 11:04:29 +0000
Subject: [RFC PATCH] block: disable IRQs until data is written to relay
Message-Id: <20080530110429.GA23157@ping.uio.no>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Can you review this patch?  I'm new to locking in the Linux kernel
so I may be misssing something.

I think we must disable IRQs between relay_reserve and initializing
the data; consider the following scenario where task 1 and task 2
runs on the same CPU:

task 1: trace_note_message  task 2: interrupt  userspace (blktrace)
--------------------------  -----------------  --------------------
__trace_note_message                           read(relay)
relay_reserve                                  <blocks ...> 
<interrupted: I/O completion>

                            __blk_add_trace
                            relay_reserve
                            <buffers switched,
                             wake user>
                                               <reads uninitialized
                                                trace_note_message>
                            <done>
<runs again>
memcpy() - too late

-- 
Carl Henrik

--gBBFr7Ir9EOA20Yy
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0001-block-disable-IRQs-until-data-is-written-to-relay-c.patch"

From 30fce97a2d7c02ba265eceed59592dbdc9c34f26 Mon Sep 17 00:00:00 2001
From: Carl Henrik Lunde <chlunde@ping.uio.no>
Date: Fri, 30 May 2008 12:57:47 +0200
Subject: [PATCH] block: disable IRQs until data is written to relay channel

As we may run relay_reserve from interrupt context we must always disable
IRQs.  This is because a call to relay_reserve may expose previously written
data to use space.

Updated new message code and an old but related comment.

Signed-off-by: Carl Henrik Lunde <chlunde@ping.uio.no>
---
 block/blktrace.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/blktrace.c b/block/blktrace.c
index 7ae87cc..8d3a277 100644
--- a/block/blktrace.c
+++ b/block/blktrace.c
@@ -79,16 +79,17 @@ void __trace_note_message(struct blk_trace *bt, const char *fmt, ...)
 {
 	int n;
 	va_list args;
+	unsigned long flags;
 	char *buf;
 
-	preempt_disable();
+	local_irq_save(flags);
 	buf = per_cpu_ptr(bt->msg_data, smp_processor_id());
 	va_start(args, fmt);
 	n = vscnprintf(buf, BLK_TN_MAX_MSG, fmt, args);
 	va_end(args);
 
 	trace_note(bt, 0, BLK_TN_MESSAGE, buf, n);
-	preempt_enable();
+	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(__trace_note_message);
 
@@ -158,10 +159,7 @@ void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	/*
 	 * A word about the locking here - we disable interrupts to reserve
 	 * some space in the relay per-cpu buffer, to prevent an irq
-	 * from coming in and stepping on our toes. Once reserved, it's
-	 * enough to get preemption disabled to prevent read of this data
-	 * before we are through filling it. get_cpu()/put_cpu() does this
-	 * for us
+	 * from coming in and stepping on our toes.
 	 */
 	local_irq_save(flags);
 
-- 
1.5.4.3


--gBBFr7Ir9EOA20Yy--
