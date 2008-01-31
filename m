From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Thu, 31 Jan 2008 22:14:32 +0000
Subject: [PATCH] UNPLUG does the timing stuff, UNPLUG TIMEOUT only does timeout
Message-Id: <47A24848.6090306@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Each UNPLUG TIMEOUT should be followed by an UNPLUG, so we were getting
double information on time outs. This makes sure unplugs due to time outs
are only accounted for once.

[Jens: I pushed the tree out...]

---
 btt/devs.c       |   18 ++++++++++++------
 btt/globals.h    |    3 ++-
 btt/output.c     |    2 +-
 btt/trace_plug.c |   14 +++++---------
 4 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/btt/devs.c b/btt/devs.c
index 6a0fcfc..61dd427 100644
--- a/btt/devs.c
+++ b/btt/devs.c
@@ -264,15 +264,21 @@ void dip_plug(__u32 dev, double cur_time)
 	dip->last_plug = cur_time;
 }
 
-void dip_unplug(__u32 dev, double cur_time, int is_timer)
+void dip_unplug(__u32 dev, double cur_time)
 {
 	struct d_info *dip = __dip_find(dev);
 
-	if (!dip || !dip->is_plugged) return;
+	if (dip && dip->is_plugged) {
+		dip->nplugs++;
+		dip->plugged_time += (cur_time - dip->last_plug);
+		dip->is_plugged = 0;
+	}
+}
 
-	dip->nplugs++;
-	if (is_timer) dip->n_timer_unplugs++;
+void dip_unplug_tm(__u32 dev)
+{
+	struct d_info *dip = __dip_find(dev);
 
-	dip->plugged_time += (cur_time - dip->last_plug);
-	dip->is_plugged = 0;
+	if (dip && dip->is_plugged)
+		dip->n_timer_unplugs++;
 }
diff --git a/btt/globals.h b/btt/globals.h
index 4176fb4..163986b 100644
--- a/btt/globals.h
+++ b/btt/globals.h
@@ -247,7 +247,8 @@ void dip_foreach(struct io *iop, enum iop_type type,
 struct io *dip_find_sec(struct d_info *dip, enum iop_type type, __u64 sec);
 void dip_foreach_out(void (*func)(struct d_info *, void *), void *arg);
 void dip_plug(__u32 dev, double cur_time);
-void dip_unplug(__u32 dev, double cur_time, int is_timer);
+void dip_unplug(__u32 dev, double cur_time);
+void dip_unplug_tm(__u32 dev);
 void dip_exit(void);
 
 /* dip_rb.c */
diff --git a/btt/output.c b/btt/output.c
index 33a9a73..fd22a9e 100644
--- a/btt/output.c
+++ b/btt/output.c
@@ -525,7 +525,7 @@ void __dip_output_plug(struct d_info *dip, void *arg)
 	double delta, pct;
 
 	if (dip->nplugs > 0) {
-		if (dip->is_plugged) dip_unplug(dip->device, dip->end_time, 0);
+		if (dip->is_plugged) dip_unplug(dip->device, dip->end_time);
 		delta = dip->end_time - dip->start_time;
 		pct = 100.0 * ((dip->plugged_time / delta) / delta);
 
diff --git a/btt/trace_plug.c b/btt/trace_plug.c
index 06d9fc9..03076d7 100644
--- a/btt/trace_plug.c
+++ b/btt/trace_plug.c
@@ -20,21 +20,17 @@
  */
 #include "globals.h"
 
-static inline void trace_unplug(struct io *u_iop, int is_timer)
+void trace_unplug_io(struct io *u_iop)
 {
 	unplug_hist_add(u_iop);
-	dip_unplug(u_iop->t.device, BIT_TIME(u_iop->t.time), is_timer);
+	dip_unplug(u_iop->t.device, BIT_TIME(u_iop->t.time));
 	io_release(u_iop);
 }
 
-void trace_unplug_io(struct io *u_iop)
-{
-	trace_unplug(u_iop, 0);
-}
-
-void trace_unplug_timer(struct io *u_iop)
+void trace_unplug_timer(struct io *ut_iop)
 {
-	trace_unplug(u_iop, 1);
+	dip_unplug_tm(ut_iop->t.device);
+	io_release(ut_iop);
 }
 
 void trace_plug(struct io *p_iop)
-- 
1.5.2.5

