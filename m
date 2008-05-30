From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Fri, 30 May 2008 15:30:55 +0000
Subject: Re: Negative queue lengths in btt "iostat" output?
Message-Id: <48401DAF.6000802@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060908060403090904020709"
List-Id: <linux-btrace.vger.kernel.org>
References: <483CA8B7.2090008@cesmail.net>
In-Reply-To: <483CA8B7.2090008@cesmail.net>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------060908060403090904020709
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

M. Edward (Ed) Borasky wrote:
> I'm experimenting with "btt" and I have a case where the "iostat"
> emulation is generating negative queue lengths. They seem to be steadily
> increasing in magnitude. The utilizations don't look right, either -- I
> don't think this device was 100 percent busy for the entire run.
> 
> I've attached a sample -- the input files are huge, but I'll post them
> if you need them.
> 
> 

Hi Ed -

If you get a chance, could you try the attached patch - I have not
committed it, although it looks solid enough. I'm going to keep plugging
on this. [Note the stuff about await & svctm in the patch description.]

Thanks,
Alan

--------------060908060403090904020709
Content-Type: text/x-diff;
 name="0001-Massive-re-write-of-iostat-capability.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Massive-re-write-of-iostat-capability.patch"

From c66b8b2a18b467e5f3205f7187c37f5d7d58fc52 Mon Sep 17 00:00:00 2001
From: Alan D. Brunelle <alan.brunelle@hp.com>
Date: Fri, 30 May 2008 11:25:11 -0400
Subject: [PATCH] Massive re-write of iostat capability

rrqm/s, wrqm/s, r/s, w/s, rkB/s, wkB/s, avgrq-sz, avgqu-sz, and %util
all look good -- match up well w/ iostat. await & svctm do /not/ match
up well w/ iostat, but "look" right when looking at the raw data.

For the record:

await == Average time between GETRQ and COMPLETION for all I/O requests
	 completed in that sample.

svctm == Averate time between ISSUE and COMPLETION for all I/O requests
	 completed in that sample

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 btt/bt_timeline.c    |    6 +-
 btt/devs.c           |    3 +
 btt/globals.h        |   50 +++---
 btt/iostat.c         |  467 ++++++++++++++++++++++++++++----------------------
 btt/trace_complete.c |   16 ++-
 btt/trace_im.c       |    5 +-
 btt/trace_issue.c    |    2 +-
 7 files changed, 310 insertions(+), 239 deletions(-)

diff --git a/btt/bt_timeline.c b/btt/bt_timeline.c
index 2eed087..8c5739e 100644
--- a/btt/bt_timeline.c
+++ b/btt/bt_timeline.c
@@ -60,14 +60,10 @@ int main(int argc, char *argv[])
 	handle_args(argc, argv);
 
 	init_dev_heads();
-	iostat_init();
 	if (process() || output_avgs(avgs_ofp) || output_ranges(ranges_ofp))
 		return 1;
 
-	if (iostat_ofp) {
-		fprintf(iostat_ofp, "\n");
-		iostat_dump_stats(iostat_last_stamp, 1);
-	}
+	iostat_dump_stats();
 
 	if (msgs_ofp != stdout)
 		fclose(msgs_ofp);
diff --git a/btt/devs.c b/btt/devs.c
index 3cf7a6c..4e2ca4c 100644
--- a/btt/devs.c
+++ b/btt/devs.c
@@ -89,6 +89,7 @@ void dip_exit(void)
 		unplug_hist_exit(dip->unplug_hist_handle);
 		if (output_all_data)
 			q2d_release(dip->q2d_priv);
+		iostat_free(dip->stats);
 		free(dip);
 	}
 }
@@ -127,6 +128,8 @@ struct d_info *dip_add(__u32 device, struct io *iop)
 		dip->pre_culling = 1;
 		if (output_all_data)
 			dip->q2d_priv = q2d_init();
+		make_dev_hdr(str, 256, dip, 1);
+		dip->stats = iostat_alloc(str);
 		n_devs++;
 	}
 
diff --git a/btt/globals.h b/btt/globals.h
index c4b7674..fc358b6 100644
--- a/btt/globals.h
+++ b/btt/globals.h
@@ -41,7 +41,7 @@
 #define BIT_START(iop)	((iop)->t.sector)
 #define BIT_END(iop)	((iop)->t.sector + ((iop)->t.bytes >> 9))
 #define IOP_READ(iop)	((iop)->t.action & BLK_TC_ACT(BLK_TC_READ))
-#define IOP_RW(iop)	(IOP_READ(iop) ? 1 : 0)
+#define IOP_RW(iop)	(IOP_READ(iop) ? 0 : 1)
 
 #define TO_SEC(nanosec)	((double)(nanosec) / 1.0e9)
 #define TO_MSEC(nanosec) (1000.0 * TO_SEC(nanosec))
@@ -128,18 +128,6 @@ struct devmap {
 	char device[32], node[32], pci[32], devno[32];
 };
 
-struct stats {
-	__u64 rqm[2], ios[2], sec[2], wait, svctm;
-	double last_qu_change, last_dev_change, tot_qusz, idle_time;
-	int cur_qusz, cur_dev;
-};
-
-struct stats_t {
-	double n;
-	double rqm_s[2], ios_s[2], sec_s[2];
-	double avgrq_sz, avgqu_sz, await, svctm, p_util;
-};
-
 struct d_info {
 	struct list_head all_head, hash_head;
 	void *heads;
@@ -149,7 +137,7 @@ struct d_info {
 	void *q2d_priv;
 	FILE *d2c_ofp, *q2c_ofp;
 	struct avgs_info avgs;
-	struct stats stats, all_stats;
+	void *stats;
 	__u64 last_q, n_qs, n_ds;
 	__u64 n_act_q, t_act_q;	/* # currently active when Q comes in */
 	__u32 device;
@@ -193,7 +181,7 @@ extern struct avgs_info all_avgs;
 extern __u64 last_q;
 extern struct region_info all_regions;
 extern struct list_head all_ios, free_ios;
-extern __u64 iostat_interval, iostat_last_stamp;
+extern __u64 iostat_interval;
 extern time_t genesis, last_vtrace;
 extern double t_astart, t_aend;
 extern __u64 q_histo[N_HIST_BKTS], d_histo[N_HIST_BKTS];
@@ -221,6 +209,10 @@ void dip_plug(__u32 dev, double cur_time);
 void dip_unplug(__u32 dev, double cur_time, __u64 nio_ups);
 void dip_unplug_tm(__u32 dev, __u64 nio_ups);
 void dip_exit(void);
+static inline void *dip_get_stats(struct d_info *dip)
+{
+	return dip->stats;
+}
 
 /* dip_rb.c */
 int rb_insert(struct rb_root *root, struct io *iop);
@@ -230,14 +222,26 @@ void rb_foreach(struct rb_node *n, struct io *iop,
 		      struct list_head *head);
 
 /* iostat.c */
-void iostat_init(void);
-void iostat_getrq(struct io *iop);
-void iostat_merge(struct io *iop);
-void iostat_issue(struct io *iop);
-void iostat_unissue(struct io *iop);
-void iostat_complete(struct io *d_iop, struct io *c_iop);
-void iostat_check_time(__u64 stamp);
-void iostat_dump_stats(__u64 stamp, int all);
+void *iostat_alloc(char *hdr);
+void iostat_free(void *dsp);
+void iostat_insert(void *arg, struct io *i_iop);
+void iostat_issue(void *arg, struct io *d_iop);
+void iostat_merge(void *arg, struct io *iop);
+void iostat_complete(void *arg, struct io *c_iop, __u64 d2c, __u64 g2c,
+			unsigned int nqs);
+void __iostat_check_time(__u64 now);
+void __iostat_dump_stats(void);
+
+static inline void iostat_check_time(__u64 now)
+{
+	if (iostat_ofp)
+		__iostat_check_time(now);
+}
+static inline void iostat_dump_stats(void)
+{
+	if (iostat_ofp)
+		__iostat_dump_stats();
+}
 
 /* latency.c */
 void latency_init(struct d_info *dip);
diff --git a/btt/iostat.c b/btt/iostat.c
index d701e2f..88373be 100644
--- a/btt/iostat.c
+++ b/btt/iostat.c
@@ -1,7 +1,7 @@
 /*
  * blktrace output analysis: generate a timeline & gather statistics
  *
- * Copyright (C) 2006 Alan D. Brunelle <Alan.Brunelle@hp.com>
+ * Copyright (C) 2006-2008 Alan D. Brunelle <Alan.Brunelle@hp.com>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -18,194 +18,244 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  *
  */
-#include <stdio.h>
-#include <unistd.h>
+
+#include <float.h>
 #include "globals.h"
 
-#define INC_STAT(dip, fld) 						\
-	do { 								\
-		(dip)->stats. fld ++;					\
-		(dip)->all_stats. fld ++;				\
-	} while (0)
-
-#define DEC_STAT(dip, fld) 						\
-	do { 								\
-		(dip)->stats. fld --;					\
-		(dip)->all_stats. fld --;				\
-	} while (0)
-
-#define ADD_STAT(dip, fld, val) 					\
-	 do { 								\
-		 __u64 __v = (val);					\
-		(dip)->stats. fld += __v;				\
-		(dip)->all_stats. fld += __v;				\
-	} while (0)
-
-#define SUB_STAT(dip, fld, val) 					\
-	 do { 								\
-		 __u64 __v = (val);					\
-		(dip)->stats. fld -= __v;				\
-		(dip)->all_stats. fld -= __v;				\
-	} while (0)
-
-__u64 last_start, iostat_last_stamp;
+struct __stats {
+	__u64 sectors[2], ios[2], merges[2];	// READ & WRITE
+};
+
+struct disk_stats {
+	struct list_head head;
+	char *hdr;
+	__u64 stamp;
+	__u64 last_q, last_idle, busy_ticks;
+	__u64 rq_ticks, nqs, io_ticks;
+	long long in_flight, qusz;
+	double avgqsz;
+	struct __stats stats[2];	/* 0 == last values */
+
+	double sum_merges[2], sum_ios[2], sum_secs[2];
+	double sum_avgqsz, sum_await, sum_svctm, sum_util;
+};
+
+static __u64 last_seen = (__u64)-1;
+static __u64 last_start = (__u64)-1;
+static int ndumps = 0;
+
 __u64 iostat_interval = 1000000000;
 char *iostat_name = NULL;
 FILE *iostat_ofp = NULL;
 
-void dump_hdr(void)
+#define delta_fld(dsp, fld) ((dsp)->stats[1]. fld - (dsp)->stats[0]. fld)
+
+static void clear_stats(struct __stats *sp)
 {
-	fprintf(iostat_ofp, "Device:       rrqm/s   wrqm/s     r/s     w/s    "
-			    "rsec/s    wsec/s     rkB/s     wkB/s "
-			    "avgrq-sz avgqu-sz   await   svctm  %%util   Stamp\n");
+	memset(sp, 0, sizeof(*sp));
 }
 
-void iostat_init(void)
+void *iostat_alloc(char *hdr)
 {
-	last_start = (__u64)-1;
-	if (iostat_ofp)
-		dump_hdr();
+	struct disk_stats *dsp = malloc(sizeof(*dsp));
+
+	memset(dsp, 0, sizeof(*dsp));
+	dsp->hdr = strdup(hdr);
+
+	return dsp;
 }
 
-void update_tot_qusz(struct d_info *dip, double now)
+void iostat_free(void *arg)
 {
-	dip->stats.tot_qusz += ((now - dip->stats.last_qu_change) *
-						dip->stats.cur_qusz);
-	dip->all_stats.tot_qusz += ((now - dip->all_stats.last_qu_change) *
-						dip->all_stats.cur_qusz);
+	struct disk_stats *dsp = arg;
 
-	dip->stats.last_qu_change = dip->all_stats.last_qu_change = now;
+	free(dsp->hdr);
+	free(dsp);
 }
 
-void update_idle_time(struct d_info *dip, double now, int force)
+void iostat_insert(void *arg, struct io *i_iop)
 {
-	if (dip->stats.cur_dev == 0 || force) {
-		dip->stats.idle_time += (now - dip->stats.last_dev_change);
-		dip->all_stats.idle_time +=
-				       (now - dip->all_stats.last_dev_change);
+	struct disk_stats *dsp = arg;
+
+	if (dsp->qusz > 0) {
+		double dt = TO_SEC(i_iop->t.time - dsp->last_q);
+		dsp->avgqsz += ((double)(dsp->qusz) * dt);
 	}
-	dip->stats.last_dev_change = dip->all_stats.last_dev_change = now;
+
+	dsp->qusz++;
+	dsp->last_q = i_iop->t.time;
 }
 
-void __dump_stats(__u64 stamp, int all, struct d_info *dip, struct stats_t *asp)
+void iostat_issue(void *arg, struct io *d_iop)
 {
-	char hdr[16];
-	struct stats *sp;
-	double dt, nios, avgrq_sz, p_util, nrqm, await, svctm;
-	double now = TO_SEC(stamp);
-
-	if (all) {
-		dt = (double)stamp / 1.0e9;
-		sp = &dip->all_stats;
-	}
-	else {
-		dt = (double)(stamp-last_start) / 1.0e9;
-		sp = &dip->stats;
-	}
+	struct disk_stats *dsp = arg;
+
+	if (dsp->in_flight == 0)
+		dsp->last_idle = d_iop->t.time;
+
+	dsp->in_flight++;
+}
+
+void iostat_merge(void *arg, struct io *iop)
+{
+	struct disk_stats *dsp = arg;
+	dsp->stats[1].merges[IOP_RW(iop)]++;
+}
+
+void iostat_complete(void *arg, struct io *c_iop, __u64 d2c, __u64 g2c,
+			unsigned int nqs)
+{
+	struct disk_stats *dsp = arg;
+	int rw = IOP_RW(c_iop);
+
+	dsp->stats[1].sectors[rw] += (c_iop->t.bytes >> 9);
+	dsp->stats[1].ios[rw]++;
 
-	nios = (double)(sp->ios[0] + sp->ios[1]);
-	nrqm = (double)(sp->rqm[0] + sp->rqm[1]);
-	update_idle_time(dip, now, 1);
-	update_tot_qusz(dip, now);
+	dsp->nqs += nqs;
+	if (g2c != (__u64)-1)
+		dsp->rq_ticks += g2c;
+	if (d2c != (__u64)-1)
+		dsp->io_ticks += d2c;
 
-	if (nios > 0.0) {
-		avgrq_sz = (double)(sp->sec[0] + sp->sec[1]) / nios;
-		svctm = TO_MSEC(sp->svctm) / nios;
+	if (dsp->in_flight == 1)
+		dsp->busy_ticks += (c_iop->t.time - dsp->last_idle);
+	dsp->in_flight--;
+
+	if (dsp->qusz > 0) {
+		double dt = TO_SEC(c_iop->t.time - dsp->last_q);
+		dsp->avgqsz += ((double)(dsp->qusz) * dt);
 	}
-	else
-		avgrq_sz = svctm = 0.0;
 
-	await = ((nios + nrqm) > 0.0) ? TO_MSEC(sp->wait) / (nios+nrqm) : 0.0;
-	p_util = (sp->idle_time <= dt) ? 100.0 * (1.0 - (sp->idle_time / dt)) :
-	                                 0.0;
+	dsp->qusz--;
+	dsp->last_q = c_iop->t.time;
+}
 
-	/*
-	 * For AWAIT: nios should be the same as number of inserts
-	 * and we add in nrqm (number of merges), which should give
-	 * us the total number of IOs sent to the block IO layer.
-	 */
-	fprintf(iostat_ofp, "%-11s ", make_dev_hdr(hdr, 11, dip, 1));
-	fprintf(iostat_ofp, "%8.2lf ", (double)sp->rqm[1] / dt);
-	fprintf(iostat_ofp, "%8.2lf ", (double)sp->rqm[0] / dt);
-	fprintf(iostat_ofp, "%7.2lf ", (double)sp->ios[1] / dt);
-	fprintf(iostat_ofp, "%7.2lf ", (double)sp->ios[0] / dt);
-	fprintf(iostat_ofp, "%9.2lf ", (double)sp->sec[1] / dt);
-	fprintf(iostat_ofp, "%9.2lf ", (double)sp->sec[0] / dt);
-	fprintf(iostat_ofp, "%9.2lf ", (double)(sp->sec[1] / 2) / dt);
-	fprintf(iostat_ofp, "%9.2lf ", (double)(sp->sec[0] / 2) / dt);
-	fprintf(iostat_ofp, "%8.2lf ", avgrq_sz);
-	fprintf(iostat_ofp, "%8.2lf ", (double)sp->tot_qusz / dt);
-	fprintf(iostat_ofp, "%7.2lf ", await);
-	fprintf(iostat_ofp, "%7.2lf ", svctm);
-	fprintf(iostat_ofp, "%6.2lf", p_util);
-	if (all)
-		fprintf(iostat_ofp, "%8s\n", "TOTAL");
-	else {
-		fprintf(iostat_ofp, "%8.2lf\n", TO_SEC(stamp));
-		sp->rqm[0] = sp->rqm[1] = 0;
-		sp->ios[0] = sp->ios[1] = 0;
-		sp->sec[0] = sp->sec[1] = 0;
-		sp->wait = sp->svctm = 0;
+void sum_results(struct disk_stats *dsp, double *merges, double *ios,
+			double *secs, double avgqsz, double await,
+			double svctm, double util)
+{
+	int i;
 
-		sp->tot_qusz = sp->idle_time = 0.0;
+	for (i = 0; i < 2; i++) {
+		dsp->sum_merges[i] += merges[i];
+		dsp->sum_ios[i] += ios[i];
+		dsp->sum_secs[i] += secs[i];
 	}
 
-	if (asp) {
-		int i;
+	dsp->sum_avgqsz += avgqsz;
+	dsp->sum_await += await;
+	dsp->sum_svctm += svctm;
+	dsp->sum_util += util;
+}
 
-		asp->n += 1.0;
-		for (i = 0; i < 2; i++) {
-			asp->rqm_s[i] += ((double)sp->rqm[i] / dt);
-			asp->ios_s[i] += ((double)sp->ios[i] / dt);
-			asp->sec_s[i] += ((double)sp->sec[i] / dt);
-		}
-		asp->avgrq_sz += avgrq_sz;
-		asp->avgqu_sz += (double)sp->tot_qusz / dt;
-		asp->await += await;
-		asp->svctm += svctm;
-		asp->p_util += p_util;
+void dump_hdr(FILE *ofp)
+{
+	fprintf(ofp,
+		"%13s %8s %8s %8s %8s %8s %8s %8s %8s %8s %8s %6s %s\n",
+		"Device", "rrqm/s", "wrqm/s", "r/s", "w/s",
+		"rkB/s", "wkB/s", "avgrq-sz", "avgqu-sz", "await",
+		"svctm", "%util", "Stamp");
+}
+
+void dump(struct disk_stats *dsp, struct disk_stats *adsp, __u64 now,
+		double dt, char *tail)
+{
+	FILE *ofp = iostat_ofp;
+	double await, arqsz, busy_ticks, util, svctm;
+	double merges[2] = {
+		(double)delta_fld(dsp, merges[0]),
+		(double)delta_fld(dsp, merges[1])
+	};
+	double secs[2] = {
+		(double)delta_fld(dsp, sectors[0]),
+		(double)delta_fld(dsp, sectors[1])
+	};
+	double ios[2] = {
+		(double)delta_fld(dsp, ios[0]),
+		(double)delta_fld(dsp, ios[1])
+	};
+	double nios = ios[0] + ios[1];
+	double avgqsz = dsp->avgqsz / dt;
+
+	busy_ticks = TO_SEC(dsp->busy_ticks);
+	util = 100.0 * (busy_ticks / dt);
+
+	if (ios[0] || ios[1]) {
+		arqsz = (secs[0] + secs[1]) / nios;
+		await = 1000.0 * (TO_SEC(dsp->rq_ticks) / dsp->nqs);
+		svctm = 1000.0 * (TO_SEC(dsp->io_ticks) / nios);
 	}
+	else
+		await = arqsz = svctm = 0.0;
+
+	fprintf(ofp, "%13s ", dsp->hdr);
+	fprintf(ofp, "%8.2f %8.2f ", merges[0] / dt, merges[1] / dt);
+	fprintf(ofp, "%8.2f %8.2f ", ios[0] / dt, ios[1] / dt);
+	fprintf(ofp, "%8.1f %8.1f ", secs[0] / (2 * dt), secs[1] / (2 * dt));
+	fprintf(ofp, "%8.2f ", arqsz);
+	fprintf(ofp, "%8.2f ", avgqsz);
+	fprintf(ofp, "%8.2f ", await);
+	fprintf(ofp, "%8.2f ", svctm);
+	fprintf(ofp, "%6.2f ", util);
+	fprintf(ofp, "%6s\n", tail);
+
+	/*
+	 * Accumulate results
+	 */
+	sum_results(dsp, merges, ios, secs, avgqsz, await, svctm, util);
+	sum_results(adsp, merges, ios, secs, avgqsz, await, svctm, util);
+
+	/*
+	 * Clear out counters, save current stats as previous.
+	 */
+	dsp->busy_ticks = 0;
+	dsp->last_idle = now;
+	dsp->rq_ticks = dsp->io_ticks = 0;
+	dsp->nqs = 0;
+	dsp->last_q = now;
+	dsp->avgqsz = 0.0;
+
+	memcpy(&dsp->stats[0], &dsp->stats[1], sizeof(dsp->stats[1]));
 }
 
-void __dump_stats_t(__u64 stamp, struct stats_t *asp, int all)
+void dump_a(struct disk_stats *dsp, double dt, int ndevs, int ndumps,
+							char *pre, char *pst)
 {
-	if (asp->n < 2.0) return;	// What's the point?
-
-	fprintf(iostat_ofp, "%-11s ", "TOTAL");
-	fprintf(iostat_ofp, "%8.2lf ", asp->rqm_s[0]);
-	fprintf(iostat_ofp, "%8.2lf ", asp->rqm_s[1]);
-	fprintf(iostat_ofp, "%7.2lf ", asp->ios_s[0]);
-	fprintf(iostat_ofp, "%7.2lf ", asp->ios_s[1]);
-	fprintf(iostat_ofp, "%9.2lf ", asp->sec_s[0]);
-	fprintf(iostat_ofp, "%9.2lf ", asp->sec_s[1]);
-	fprintf(iostat_ofp, "%9.2lf ", asp->sec_s[0] / 2.0);
-	fprintf(iostat_ofp, "%9.2lf ", asp->sec_s[1] / 2.0);
-	fprintf(iostat_ofp, "%8.2lf ", asp->avgrq_sz / asp->n);
-	fprintf(iostat_ofp, "%8.2lf ", asp->avgqu_sz / asp->n);
-	fprintf(iostat_ofp, "%7.2lf ", asp->await / asp->n);
-	fprintf(iostat_ofp, "%7.2lf ", asp->svctm / asp->n);
-	fprintf(iostat_ofp, "%6.2lf", asp->p_util / asp->n);
-	if (all)
-		fprintf(iostat_ofp, "%8s\n", "TOTAL");
-	else 
-		fprintf(iostat_ofp, "%8.2lf\n", TO_SEC(stamp));
+	FILE *ofp = iostat_ofp;
+	double rd_merges = dsp->sum_merges[0];
+	double wr_merges = dsp->sum_merges[1];
+	double rd_ios = dsp->sum_ios[0];
+	double wr_ios = dsp->sum_ios[1];
+	double nios = rd_ios + wr_ios;
+	double rd_sec = dsp->sum_secs[0];
+	double wr_sec = dsp->sum_secs[1];
+	double arqsz = (rd_ios || wr_ios) ? (rd_sec + wr_sec) / nios : 0.0;
+
+	fprintf(ofp, "%13s ", pre);
+	fprintf(ofp, "%8.2f %8.2f ", rd_merges / dt, wr_merges / dt);
+	fprintf(ofp, "%8.2f %8.2f ", rd_ios / dt, wr_ios / dt);
+	fprintf(ofp, "%8.1f %8.1f ", rd_sec / (2 * dt), wr_sec / (2 * dt));
+	fprintf(ofp, "%8.2f ", arqsz);
+	fprintf(ofp, "%8.2f ", dsp->sum_avgqsz / (double)(ndevs * ndumps));
+	fprintf(ofp, "%8.2f ", dsp->sum_await  / (double)(ndevs * ndumps));
+	fprintf(ofp, "%8.2f ", dsp->sum_svctm  / (double)(ndevs * ndumps));
+	fprintf(ofp, "%6.2f ", dsp->sum_util   / (double)(ndevs * ndumps));
+	fprintf(ofp, "%6s\n", pst);
 }
 
-void iostat_dump_stats(__u64 stamp, int all)
+void collect_dsps(struct list_head *head)
 {
 	struct d_info *dip;
-	struct stats_t as;
-
-	memset(&as, 0, sizeof(struct stats_t));
-	if (all)
-		dump_hdr();
+	struct disk_stats *dsp;
 
 	if (devices == NULL) {
 		struct list_head *p;
 
 		__list_for_each(p, &all_devs) {
 			dip = list_entry(p, struct d_info, all_head);
-			__dump_stats(stamp, all, dip, &as);
+			dsp = dip_get_stats(dip);
+
+			list_add_tail(&dsp->head, head);
 		}
 	}
 	else {
@@ -215,82 +265,91 @@ void iostat_dump_stats(__u64 stamp, int all)
 
 		while (p && ((i = sscanf(p, "%u,%u", &mjr, &mnr)) == 2)) {
 			dip = __dip_find((__u32)((mjr << MINORBITS) | mnr));
-			__dump_stats(stamp, all, dip, &as);
+			dsp = dip_get_stats(dip);
+
+			list_add_tail(&dsp->head, head);
 
 			p = strchr(p, ';');
 			if (p) p++;
 		}
 	}
-
-	__dump_stats_t(stamp, &as, all);
-
-	if (!all && iostat_ofp)
-		fprintf(iostat_ofp, "\n");
 }
 
-void iostat_check_time(__u64 stamp)
+void dump_stats(__u64 now, int clear0)
 {
-	if (iostat_ofp) {
-		if (last_start == (__u64)-1)
-			last_start = stamp;
-		else if ((stamp - last_start) >= iostat_interval) {
-			iostat_dump_stats(stamp, 0);
-			last_start = stamp;
-		}
-
-		iostat_last_stamp = stamp;
+	double dt = TO_SEC(now - last_start);
+	int ndevs = 0;
+	char buf[128];
+	struct disk_stats adsp, *dsp;
+	struct list_head *p, *q;
+	LIST_HEAD(dsps);
+
+	memset(&adsp, 0, sizeof(adsp));
+	adsp.hdr = "TOTAL";
+
+	sprintf(buf, "%6.1lf", TO_SEC(now));
+	collect_dsps(&dsps);
+
+	list_for_each_safe(p, q, &dsps) {
+		dsp = list_entry(p, struct disk_stats, head);
+		list_del(&dsp->head);
+
+		if (dsp->in_flight)
+			dsp->busy_ticks += (now - dsp->last_idle);
+		if (clear0)
+			clear_stats(&dsp->stats[0]);
+		dump(dsp, &adsp, now, dt, buf);
+		ndevs++;
 	}
-}
-
-void iostat_getrq(struct io *iop)
-{
-	update_tot_qusz(iop->dip, TO_SEC(iop->t.time));
-	INC_STAT(iop->dip, cur_qusz);
-}
-
-void iostat_merge(struct io *iop)
-{
-	INC_STAT(iop->dip, rqm[IOP_RW(iop)]);
-}
-
-void iostat_issue(struct io *iop)
-{
-	int rw = IOP_RW(iop);
-	struct d_info *dip = iop->dip;
-	double now = TO_SEC(iop->t.time);
 
-	INC_STAT(dip, ios[rw]);
-	ADD_STAT(dip, sec[rw], iop->t.bytes >> 9);
+	if (ndevs > 1) {
+		dump_a(&adsp, dt, ndevs, 1, "ITER", "AVG");
+		fprintf(iostat_ofp, "\n");
+	}
 
-	update_idle_time(dip, now, 0);
-	INC_STAT(dip, cur_dev);
+	ndumps++;
 }
 
-void iostat_unissue(struct io *iop)
+void __iostat_check_time(__u64 now)
 {
-	int rw = IOP_RW(iop);
-	struct d_info *dip = iop->dip;
+	if (!iostat_ofp)
+		return;
+	if (last_start == (__u64)-1) {
+		dump_hdr(iostat_ofp);
+		last_start = now;
+	}
+	else if ((now - last_start) >= iostat_interval) {
+		dump_stats(now, 0);
+		last_start = now;
+	}
 
-	DEC_STAT(dip, ios[rw]);
-	SUB_STAT(dip, sec[rw], iop->t.bytes >> 9);
-	DEC_STAT(dip, cur_dev);
+	last_seen = now;
 }
 
-void iostat_complete(struct io *q_iop, struct io *c_iop)
+void __iostat_dump_stats(void)
 {
-	double now = TO_SEC(c_iop->t.time);
-	struct d_info *dip = q_iop->dip;
-
-	if (q_iop->i_time != (__u64)-1)
-		ADD_STAT(c_iop->dip, wait, tdelta(q_iop->i_time,c_iop->t.time));
-	else if (q_iop->m_time != (__u64)-1)
-		ADD_STAT(c_iop->dip, wait, tdelta(q_iop->m_time,c_iop->t.time));
-
-	update_tot_qusz(dip, now);
-	DEC_STAT(dip, cur_qusz);
-
-	update_idle_time(dip, now, 0);
-	DEC_STAT(dip, cur_dev);
+	int ndevs = 0;
+	LIST_HEAD(dsps);
+	struct list_head *p, *q;
+	struct disk_stats adsp, *dsp;
+
+	dump_stats(last_seen, 0);
+	fprintf(iostat_ofp, "\n");
+
+	memset(&adsp, 0, sizeof(adsp));
+	adsp.hdr = "TOTAL";
+
+	collect_dsps(&dsps);
+	list_for_each_safe(p, q, &dsps) {
+		dsp = list_entry(p, struct disk_stats, head);
+		list_del(&dsp->head);
+		ndevs++;
+
+		sum_results(&adsp, dsp->sum_merges, dsp->sum_ios,
+				dsp->sum_secs, dsp->sum_avgqsz,
+				dsp->sum_await, dsp->sum_svctm, dsp->sum_util);
+	}
 
-	ADD_STAT(dip, svctm, tdelta(q_iop->t.time, c_iop->t.time));
+	dump_hdr(iostat_ofp);
+	dump_a(&adsp, TO_SEC(last_seen), ndevs, ndumps, "TOTAL", "AVG");
 }
diff --git a/btt/trace_complete.c b/btt/trace_complete.c
index 41bcb7d..2afda15 100644
--- a/btt/trace_complete.c
+++ b/btt/trace_complete.c
@@ -51,8 +51,11 @@ static void display_io_track(FILE *ofp, struct io *iop)
 
 static void handle_complete(struct io *c_iop)
 {
+	unsigned int nqs = 0;
 	LIST_HEAD(head);
 	struct list_head *p, *q;
+	__u64 g2c = (__u64)-1;
+	__u64 d2c = (__u64)-1;
 
 	update_blks(c_iop);
 	update_cregion(&all_regions, c_iop->t.time);
@@ -71,11 +74,10 @@ static void handle_complete(struct io *c_iop)
 		latency_q2c(q_iop->dip, q_iop->t.time, q2c);
 
 		if (q_iop->d_time != (__u64)-1) {
-			__u64 d2c = tdelta(q_iop->d_time, c_iop->t.time);
-
+			if (d2c == (__u64)-1)
+				d2c = tdelta(q_iop->d_time, c_iop->t.time);
 			update_d2c(q_iop, d2c);
 			latency_d2c(q_iop->dip, c_iop->t.time, d2c);
-			iostat_complete(q_iop, c_iop);
 		}
 
 		if (per_io_ofp) {
@@ -85,9 +87,17 @@ static void handle_complete(struct io *c_iop)
 			display_io_track(per_io_ofp, q_iop);
 		}
 
+		if (q_iop->g_time != (__u64)-1) {
+			if (g2c == (__u64)-1)
+				g2c = tdelta(q_iop->g_time, c_iop->t.time);
+			nqs++;
+		}
+
 		list_del(&q_iop->f_head);
 		io_release(q_iop);
 	}
+
+	iostat_complete(dip_get_stats(c_iop->dip), c_iop, d2c, g2c, nqs);
 }
 
 void trace_complete(struct io *c_iop)
diff --git a/btt/trace_im.c b/btt/trace_im.c
index 49c876c..0cb6690 100644
--- a/btt/trace_im.c
+++ b/btt/trace_im.c
@@ -24,8 +24,6 @@ static void handle_g(struct io *g_iop)
 {
 	struct io *q_iop;
 
-	iostat_getrq(g_iop);
-
 	q_iop = dip_find_sec(g_iop->dip, IOP_Q, g_iop->t.sector);
 	if (q_iop) {
 		q_iop->g_time = g_iop->t.time;
@@ -52,13 +50,14 @@ static void handle_i(struct io *i_iop)
 		if (q_iop->g_time != (__u64)-1)
 			update_g2i(q_iop, tdelta(q_iop->g_time, i_iop->t.time));
 	}
+	iostat_insert(dip_get_stats(i_iop->dip), i_iop);
 }
 
 static void handle_m(struct io *m_iop)
 {
 	struct io *q_iop;
 
-	iostat_merge(m_iop);
+	iostat_merge(dip_get_stats(m_iop->dip), m_iop);
 
 	q_iop = dip_find_sec(m_iop->dip, IOP_Q, m_iop->t.sector);
 	if (q_iop) {
diff --git a/btt/trace_issue.c b/btt/trace_issue.c
index a18d44d..1a4a203 100644
--- a/btt/trace_issue.c
+++ b/btt/trace_issue.c
@@ -30,8 +30,8 @@ static void handle_issue(struct io *d_iop)
 
 	seeki_add(d_iop->dip->seek_handle, d_iop);
 	bno_dump_add(d_iop->dip->bno_dump_handle, d_iop);
-	iostat_issue(d_iop);
 	d_iop->dip->n_ds++;
+	iostat_issue(dip_get_stats(d_iop->dip), d_iop);
 	if (!remapper_dev(d_iop->t.device))
 		update_d_histo(d_iop->t.bytes);
 
-- 
1.5.4.3


--------------060908060403090904020709--
