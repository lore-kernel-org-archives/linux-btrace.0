From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 05 Feb 2008 22:34:54 +0000
Subject: [PATCH] Added new IOs per unplug table
Message-Id: <47A8E48E.7020706@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


========== Plug Information ==========

       DEV |    # Plugs # Timer Us  | % Time Q Plugged
---------- | ---------- ----------  | ----------------
 (  8,  0) |       1171(       123) |   0.280946640%
 (  8, 32) |          4(         0) |   0.000325469%
---------- | ---------- ----------  | ----------------
   Overall |    # Plugs # Timer Us  | % Time Q Plugged
   Average |        587(        61) |   0.140636055%

       DEV |    IOs/Unp   IOs/Unp(to)
---------- | ----------   ----------
 (  8,  0) |        9.2          8.8
 (  8, 32) |        2.5          0.0
---------- | ----------   ----------
       DEV |    IOs/Unp   IOs/Unp(to)
   Overall |        9.2          8.8

(Jens: Pushed these changes succesfully.)

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 btt/bt_timeline.c |    2 +-
 btt/devs.c        |   10 +++-
 btt/doc/btt.tex   |  101 ++++++++++++++++++++++++++++++----------------
 btt/globals.h     |    8 ++-
 btt/output.c      |  115 ++++++++++++++++++++++++++++++++++++++---------------
 btt/trace_plug.c  |   10 ++++-
 6 files changed, 170 insertions(+), 76 deletions(-)

diff --git a/btt/bt_timeline.c b/btt/bt_timeline.c
index b1f480a..981b909 100644
--- a/btt/bt_timeline.c
+++ b/btt/bt_timeline.c
@@ -25,7 +25,7 @@
 #include <time.h>
 #include "globals.h"
 
-char bt_timeline_version[] = "2.01";
+char bt_timeline_version[] = "2.02";
 
 char *devices, *exes, *input_name, *output_name, *seek_name, *bno_dump_name;
 char *d2c_name, *q2c_name, *per_io_name, *unplug_hist_name;
diff --git a/btt/devs.c b/btt/devs.c
index 61dd427..38007d1 100644
--- a/btt/devs.c
+++ b/btt/devs.c
@@ -264,7 +264,7 @@ void dip_plug(__u32 dev, double cur_time)
 	dip->last_plug = cur_time;
 }
 
-void dip_unplug(__u32 dev, double cur_time)
+void dip_unplug(__u32 dev, double cur_time, __u64 nios_up)
 {
 	struct d_info *dip = __dip_find(dev);
 
@@ -272,13 +272,17 @@ void dip_unplug(__u32 dev, double cur_time)
 		dip->nplugs++;
 		dip->plugged_time += (cur_time - dip->last_plug);
 		dip->is_plugged = 0;
+		dip->nios_up += nios_up;
 	}
 }
 
-void dip_unplug_tm(__u32 dev)
+void dip_unplug_tm(__u32 dev, __u64 nios_up)
 {
 	struct d_info *dip = __dip_find(dev);
 
-	if (dip && dip->is_plugged)
+	if (dip && dip->is_plugged) {
 		dip->n_timer_unplugs++;
+		dip->nios_upt += nios_up;
+		dip->nplugs_t++;
+	}
 }
diff --git a/btt/doc/btt.tex b/btt/doc/btt.tex
index 0fe44ef..a5bf3ee 100644
--- a/btt/doc/btt.tex
+++ b/btt/doc/btt.tex
@@ -22,7 +22,7 @@
 
 \title{\texttt{btt} User Guide}
 \author{Alan D. Brunelle (Alan.Brunelle@hp.com)}
-\date{13 November 2007}
+\date{5 February 2008}
 
 \begin{document}
 \maketitle
@@ -121,7 +121,7 @@ easier.
 	  \item[Q2G] Time needed to \emph{get} a request (get request
 	  trace).
 
-	  \item[G2I] Time needed to put that request onto the request 
+	  \item[G2I] Time needed to put that request onto the request
 	  queue (insert trace).
         \end{description}
 
@@ -189,7 +189,7 @@ Q2C    0.000207665   0.125405263   1.830917198     2262311
 IO\footnote{It should be noted that incoming requests either go through:
 
 \begin{enumerate}
-  \item Q2G + Q2I 
+  \item Q2G + Q2I
 
   or
 
@@ -276,12 +276,43 @@ IO\footnote{It should be noted that incoming requests either go through:
     \item Explicit unplug request from some subsystem in the kernel.
 
     \item Timed unplugs, due to a request queue exceeding some temporal
-    limit for being plugged. 
+    limit for being plugged.
   \end{enumerate}
 
   The total number of unplugs is equal to the number of plugs less the
   ones due to timer unplugs.
 
+  \item[IOs per Unplug \& Unplugs-due-to-timeout]
+
+  In this subsection one can see the average number of IOs on the request
+  queue at the time of an unplug or unplug due to a timeout. The following
+  sample shows a sample of both unplug sections:
+
+\begin{verbatim}
+========== Plug Information ==========
+
+       DEV |    # Plugs # Timer Us  | % Time Q Plugged
+---------- | ---------- ----------  | ----------------
+ (  8,  0) |       1171(       123) |   0.280946640%
+ (  8, 32) |          4(         0) |   0.000325469%
+---------- | ---------- ----------  | ----------------
+   Overall |    # Plugs # Timer Us  | % Time Q Plugged
+   Average |        587(        61) |   0.140636055%
+
+       DEV |    IOs/Unp   IOs/Unp(to)
+---------- | ----------   ----------
+ (  8,  0) |        9.2          8.8
+ (  8, 32) |        2.5          0.0
+---------- | ----------   ----------
+       DEV |    IOs/Unp   IOs/Unp(to)
+   Overall |        9.2          8.8
+\end{verbatim}
+
+  This table and the preceding one have to be considered together --
+  in the sample output in the immediately preceding table one can see
+  how the larger number of data values for device (8,0) dominates in
+  the overall average.
+
   \item[Active Requests At Q Information]
 
   An important consideration when analyzing block IO schedulers is to
@@ -566,7 +597,7 @@ pdflush       0.000000790 0.000006752 0.247231307  179791
 Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s
              rkB/s     wkB/s avgrq-sz avgqu-sz   await   svctm  %util   Stamp
 ...
-(  8, 16)       0.00     0.00    0.00 1005.30      0.00 152806.36      
+(  8, 16)       0.00     0.00    0.00 1005.30      0.00 152806.36     
               0.00  76403.18   152.00    31.00    0.00    0.00   0.00   71.79
 ...
 (  8, 16)       1.02     5.80    0.34    1.07      4.03     55.62
@@ -599,26 +630,26 @@ Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s
   stream. The issue and completion traces are replicated per IO.
 
 \begin{verbatim}
- 66,0  :     0.763283556 Q       6208+8   
-             0.763300157 I       6208+8   
-             0.763296365 G       6208+8   
-             0.763338848 D       6208+32  
-             0.763705760 C       6208+32  
-
- 66,0  :     0.763314550 Q       6224+8   
-             0.763315341 M       6224+8   
-             0.763338848 D       6208+32  
-             0.763705760 C       6208+32  
-
- 66,0  :     0.763321010 Q       6232+8   
-             0.763321775 M       6232+8   
-             0.763338848 D       6208+32  
-             0.763705760 C       6208+32  
-
- 65,240:     0.763244173 Q       6216+8   
-             0.763244974 M       6216+8   
-             0.763374288 D       6208+32  
-             0.763826610 C       6208+32  
+ 66,0  :     0.763283556 Q       6208+8  
+             0.763300157 I       6208+8  
+             0.763296365 G       6208+8  
+             0.763338848 D       6208+32 
+             0.763705760 C       6208+32 
+
+ 66,0  :     0.763314550 Q       6224+8  
+             0.763315341 M       6224+8  
+             0.763338848 D       6208+32 
+             0.763705760 C       6208+32 
+
+ 66,0  :     0.763321010 Q       6232+8  
+             0.763321775 M       6232+8  
+             0.763338848 D       6208+32 
+             0.763705760 C       6208+32 
+
+ 65,240:     0.763244173 Q       6216+8  
+             0.763244974 M       6216+8  
+             0.763374288 D       6208+32 
+             0.763826610 C       6208+32 
 \end{verbatim}
 
   The columns provide the following information:
@@ -628,11 +659,11 @@ Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s
 
     \item Time of the trace (seconds from the start of the run)
 
-    \item Trace type 
+    \item Trace type
 
     \item start block + number of blocks
   \end{enumerate}
-  
+ 
 \newpage\section{\label{sec:lat}\label{sec:lat-q2c}\label{sec:lat-d2c}Latency Data Files}
 
   The latency data files which can be optionally produced by \texttt{btt}
@@ -657,13 +688,13 @@ Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s
      \item Write data -- just seek deltas for writes
   \end{enumerate}
 
-  The format of the output file names is to have the name generated by 
+  The format of the output file names is to have the name generated by
   the following fields separated by underscores (\texttt{\_}):
-  
+ 
   \begin{itemize}
     \item The prefix provided as the argument to the \texttt{-s} option.
     \item The major and minor numbers of the device separated by a comma.
-    \item The string \texttt{q2q} or \texttt{d2d}, indicating the Q2Q or 
+    \item The string \texttt{q2q} or \texttt{d2d}, indicating the Q2Q or
           D2D seeks, respectively.
     \item One of the following characters:
     	\begin{description}
@@ -723,7 +754,7 @@ Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s
 \newpage\section{\label{sec:cmd-line}Command Line}
 
 \begin{verbatim}
-Usage: btt 2.01 
+Usage: btt 2.01
 [ -a               | --seek-absolute ]
 [ -A               | --all-data ]
 [ -B <output name> | --dump-blocknos=<output name> ]
@@ -742,7 +773,7 @@ Usage: btt 2.01
 [ -S <interval>    | --iostat-interval=<interval> ]
 [ -t <sec>         | --time-start=<sec> ]
 [ -T <sec>         | --time-end=<sec> ]
-[ -u <output name> | --unplug-hist=<output name> ] 
+[ -u <output name> | --unplug-hist=<output name> ]
 [ -V               | --version ]
 [ -v               | --verbose ]
 \end{verbatim}
@@ -759,7 +790,7 @@ Usage: btt 2.01
 
   Normally \texttt{btt} will not print out verbose information
   concerning per-process and per-device data (as outlined in
-  section~\ref{sec:detailed-data}). If you desire that level of 
+  section~\ref{sec:detailed-data}). If you desire that level of
   detail you can specify this option.
 
 \subsection{\label{sec:o-B}\texttt{--dump-blocknos}/\texttt{-B}}
@@ -873,7 +904,7 @@ Usage: btt 2.01
   These options allow one to dictate to \texttt{btt} when to start and stop
   parsing of trace data in terms of seconds since the start of the run. The
   trace chosen will be between the start time (or 0.0 if not
-  specified) and end time (or the end of the run) specified. 
+  specified) and end time (or the end of the run) specified.
 
 \subsection{\label{sec:o-u}\texttt{--unplug-hist}/\texttt{-u}}
 
@@ -929,7 +960,7 @@ Sending stats data to bttX.avg
 
 \newpage\section*{\label{sec:appendix}Appendix: Sample \texttt{btt}
 Output}
-  
+ 
   Here is a complete output file from a btt run, illustrating a lot of the
   capabilities of btt.
 \input{sample-btt-output.tex}
diff --git a/btt/globals.h b/btt/globals.h
index 163986b..f6041de 100644
--- a/btt/globals.h
+++ b/btt/globals.h
@@ -175,7 +175,8 @@ struct d_info {
 	__u32 device;
 
 	int pre_culling;
-	int is_plugged, nplugs, n_timer_unplugs;
+	int is_plugged, nplugs, nplugs_t, n_timer_unplugs;
+	__u64 nios_up, nios_upt;
 	double start_time, last_plug, plugged_time, end_time;
 };
 
@@ -247,8 +248,8 @@ void dip_foreach(struct io *iop, enum iop_type type,
 struct io *dip_find_sec(struct d_info *dip, enum iop_type type, __u64 sec);
 void dip_foreach_out(void (*func)(struct d_info *, void *), void *arg);
 void dip_plug(__u32 dev, double cur_time);
-void dip_unplug(__u32 dev, double cur_time);
-void dip_unplug_tm(__u32 dev);
+void dip_unplug(__u32 dev, double cur_time, __u64 nio_ups);
+void dip_unplug_tm(__u32 dev, __u64 nio_ups);
 void dip_exit(void);
 
 /* dip_rb.c */
@@ -346,6 +347,7 @@ int ready_issue(struct io *d_iop, struct io *c_iop);
 void trace_issue(struct io *d_iop);
 
 /* trace_plug.c */
+__u64 get_nio_up(struct io *u_iop);
 void trace_plug(struct io *p_iop);
 void trace_unplug_io(struct io *u_iop);
 void trace_unplug_timer(struct io *u_iop);
diff --git a/btt/output.c b/btt/output.c
index fd22a9e..e652bbd 100644
--- a/btt/output.c
+++ b/btt/output.c
@@ -84,7 +84,7 @@ static inline char *avg2string(struct avg_info *ap, char *string)
 char *make_dev_hdr(char *pad, size_t len, struct d_info *dip)
 {
 	if (dip->map = NULL)
-		snprintf(pad, len, "(%3d,%3d)", 
+		snprintf(pad, len, "(%3d,%3d)",
 			 MAJOR(dip->device), MINOR(dip->device));
 	else
 		snprintf(pad, len, "%s", dip->map->device);
@@ -181,7 +181,7 @@ void __output_dip_merge_ratio(struct d_info *dip, void *arg)
 		else
 			ratio = q2c_n / d2c_n;
 		blks_avg = (double)dip->avgs.blks.total / d2c_n;
-		fprintf((FILE *)arg, 
+		fprintf((FILE *)arg,
 			"%10s | %8llu %8llu %7.1lf | %8llu %8llu %8llu %8llu\n",
 			make_dev_hdr(scratch, 15, dip),
 			(unsigned long long)dip->n_qs,
@@ -215,11 +215,11 @@ void output_dip_merge_ratio(FILE *ofp)
 	if (n_merges > 1) {
 		fprintf(ofp, "---------- | -------- -------- ------- | -------- -------- -------- --------\n");
 		fprintf(ofp, "%10s | %8s %8s %7s | %8s %8s %8s %8s\n", "DEV", "#Q", "#D", "Ratio", "BLKmin", "BLKavg", "BLKmax", "Total");
-		fprintf((FILE *)ofp, 
+		fprintf((FILE *)ofp,
 			"%10s | %8llu %8llu %7.1lf | %8llu %8llu %8llu %8llu\n",
-			"TOTAL", merge_data.nq, merge_data.nd, 
+			"TOTAL", merge_data.nq, merge_data.nd,
 			(float)merge_data.nq / (float)merge_data.nd,
-			merge_data.blkmin, 
+			merge_data.blkmin,
 			merge_data.total / merge_data.nd,
 			merge_data.blkmax, merge_data.total);
 	}
@@ -282,7 +282,7 @@ void __output_dip_prep_ohead(struct d_info *dip, void *arg)
 	char s1[16], s2[16], s3[16], s4[16], s5[16];
 	struct ohead_data *odp = arg;
 
-	if (dip->avgs.q2g.n > 0 && dip->avgs.g2i.n > 0 && 
+	if (dip->avgs.q2g.n > 0 && dip->avgs.g2i.n > 0 &&
 				   dip->avgs.i2d.n > 0 && dip->avgs.d2c.n > 0) {
 		CALC_AVG(&dip->avgs.q2g);
 		CALC_AVG(&dip->avgs.g2i);
@@ -292,8 +292,8 @@ void __output_dip_prep_ohead(struct d_info *dip, void *arg)
 
 		fprintf(odp->ofp, "%10s | %9s %9s %9s %9s %9s\n",
 			make_dev_hdr(dev_info, 15, dip),
-			q2g_v_q2C(dip, s1, odp), 
-			g2i_v_q2C(dip, s2, odp), 
+			q2g_v_q2C(dip, s1, odp),
+			g2i_v_q2C(dip, s2, odp),
 			q2m_v_q2C(dip, s3, odp),
 			i2d_v_q2C(dip, s4, odp),
 			d2c_v_q2C(dip, s5, odp));
@@ -312,21 +312,21 @@ void output_dip_prep_ohead(FILE *ofp)
 	memset(&od, 0, sizeof(od));
 	od.ofp = ofp;
 
-	fprintf(ofp, "%10s | %9s %9s %9s %9s %9s\n", 
+	fprintf(ofp, "%10s | %9s %9s %9s %9s %9s\n",
 				"DEV", "Q2G", "G2I", "Q2M", "I2D", "D2C");
 	fprintf(ofp, "---------- | --------- --------- --------- --------- ---------\n");
 	dip_foreach_out(__output_dip_prep_ohead, &od);
 
-	if (od.q2g.n = 0 && od.g2i.n = 0 && od.q2m.n = 0 && 
+	if (od.q2g.n = 0 && od.g2i.n = 0 && od.q2m.n = 0 &&
 						od.i2d.n = 0 && od.d2c.n = 0)
 		goto out;
 
-	q2c = od.q2g.total + od.g2i.total + od.q2m.total + 	
+	q2c = od.q2g.total + od.g2i.total + od.q2m.total +
 						od.i2d.total + od.d2c.total;
 	fprintf(ofp, "---------- | --------- --------- --------- --------- ---------\n");
-	fprintf(ofp, "%10s | %8.4lf%% %8.4lf%% %8.4lf%% %8.4lf%% %8.4lf%%\n", "Overall", 
-			OD_AVG(od, q2g, q2c), OD_AVG(od, g2i, q2c), 
-			OD_AVG(od, q2m, q2c), OD_AVG(od, i2d, q2c), 
+	fprintf(ofp, "%10s | %8.4lf%% %8.4lf%% %8.4lf%% %8.4lf%% %8.4lf%%\n", "Overall",
+			OD_AVG(od, q2g, q2c), OD_AVG(od, g2i, q2c),
+			OD_AVG(od, q2m, q2c), OD_AVG(od, i2d, q2c),
 			OD_AVG(od, d2c, q2c));
 
 out:
@@ -371,7 +371,7 @@ void output_seek_mode_info(FILE *ofp, struct o_seek_info *sip)
 	}
 
 	fprintf(ofp, "%10s | %15lld %15.1lf %15lld | %lld(%d)",
-	        "Average", sip->nseeks, sip->mean / sip->nseeks, 
+	        "Average", sip->nseeks, sip->mean / sip->nseeks,
 		sip->median / sip->nseeks, new_list->mode, new_list->nseeks);
 
 	for (p = new_list->next; p != NULL; p = p->next)
@@ -395,7 +395,7 @@ void add_seek_mode_info(struct o_seek_info *sip, struct mode *mp)
 		if (!smip) {
 			struct seek_mode_info *new = malloc(sizeof(*new));
 
-			new->next = sip->head; 
+			new->next = sip->head;
 			sip->head = new;
 			new->mode = *lp;
 			new->nseeks = mp->most_seeks;
@@ -422,7 +422,7 @@ static void do_output_dip_seek_info(struct d_info *dip, FILE *ofp, int is_q2q)
 		nmodes = seeki_mode(handle, &m);
 
 		fprintf(ofp, "%10s | %15lld %15.1lf %15lld | %lld(%d)",
-			make_dev_hdr(dev_info, 15, dip), nseeks, mean, median, 
+			make_dev_hdr(dev_info, 15, dip), nseeks, mean, median,
 			nmodes > 0 ? m.modes[0] : 0, m.most_seeks);
 		for (i = 1; i < nmodes; i++)
 			fprintf(ofp, " %lld", m.modes[i]);
@@ -451,13 +451,13 @@ void output_dip_seek_info(FILE *ofp)
 	n_seeks = 1;
 	memset(&seek_info, 0, sizeof(seek_info));
 
-	fprintf(ofp, "%10s | %15s %15s %15s | %-15s\n", "DEV", "NSEEKS", 
+	fprintf(ofp, "%10s | %15s %15s %15s | %-15s\n", "DEV", "NSEEKS",
 			"MEAN", "MEDIAN", "MODE");
 	fprintf(ofp, "---------- | --------------- --------------- --------------- | ---------------\n");
 	dip_foreach_out(__output_dip_seek_info, ofp);
 	if (n_seeks > 1) {
 		fprintf(ofp, "---------- | --------------- --------------- --------------- | ---------------\n");
-		fprintf(ofp, "%10s | %15s %15s %15s | %-15s\n", 
+		fprintf(ofp, "%10s | %15s %15s %15s | %-15s\n",
 		        "Overall", "NSEEKS", "MEAN", "MEDIAN", "MODE");
 		output_seek_mode_info(ofp, &seek_info);
 		fprintf(ofp, "\n");
@@ -470,13 +470,13 @@ void output_dip_q2q_seek_info(FILE *ofp)
 	n_seeks = 1;
 	memset(&seek_info, 0, sizeof(seek_info));
 
-	fprintf(ofp, "%10s | %15s %15s %15s | %-15s\n", "DEV", "NSEEKS", 
+	fprintf(ofp, "%10s | %15s %15s %15s | %-15s\n", "DEV", "NSEEKS",
 			"MEAN", "MEDIAN", "MODE");
 	fprintf(ofp, "---------- | --------------- --------------- --------------- | ---------------\n");
 	dip_foreach_out(__output_dip_q2q_seek_info, ofp);
 	if (n_seeks > 1) {
 		fprintf(ofp, "---------- | --------------- --------------- --------------- | ---------------\n");
-		fprintf(ofp, "%10s | %15s %15s %15s | %-15s\n", 
+		fprintf(ofp, "%10s | %15s %15s %15s | %-15s\n",
 		        "Overall", "NSEEKS", "MEAN", "MEDIAN", "MODE");
 		output_seek_mode_info(ofp, &seek_info);
 		fprintf(ofp, "\n");
@@ -525,12 +525,12 @@ void __dip_output_plug(struct d_info *dip, void *arg)
 	double delta, pct;
 
 	if (dip->nplugs > 0) {
-		if (dip->is_plugged) dip_unplug(dip->device, dip->end_time);
+		if (dip->is_plugged) dip_unplug(dip->device, dip->end_time, 0);
 		delta = dip->end_time - dip->start_time;
 		pct = 100.0 * ((dip->plugged_time / delta) / delta);
 
-		fprintf(ofp, "%10s | %10d(%10d) | %13.9lf%%\n", 
-			make_dev_hdr(dev_info, 15, dip), 
+		fprintf(ofp, "%10s | %10d(%10d) | %13.9lf%%\n",
+			make_dev_hdr(dev_info, 15, dip),
 			dip->nplugs, dip->n_timer_unplugs, pct);
 
 		n_plugs++;
@@ -543,23 +543,74 @@ void __dip_output_plug(struct d_info *dip, void *arg)
 void __dip_output_plug_all(FILE *ofp, struct plug_info *p)
 {
 	fprintf(ofp, "---------- | ---------- ----------  | ----------------\n");
-	fprintf(ofp, "%10s | %10s %10s  | %s\n", 
+	fprintf(ofp, "%10s | %10s %10s  | %s\n",
 	        "Overall", "# Plugs", "# Timer Us", "% Time Q Plugged");
 	fprintf(ofp, "%10s | %10ld(%10ld) | %13.9lf%%\n", "Average",
-	        p->n_plugs / n_plugs, p->n_timer_unplugs / n_plugs, 
+	        p->n_plugs / n_plugs, p->n_timer_unplugs / n_plugs,
 		p->t_percent / n_plugs);
 
 }
 
+__u64 n_nios_uplugs, n_nios_uplugs_t;
+struct nios_plug_info {
+	__u64 tot_nios_up, tot_nios_up_t;
+} nios_plug_info;
+
+void __dip_output_plug_nios(struct d_info *dip, void *arg)
+{
+	char dev_info[15];
+	FILE *ofp = arg;
+	double a_nios_uplug = 0.0, a_nios_uplug_t = 0.0;
+
+	if (dip->nios_up && dip->nplugs) {
+		a_nios_uplug = (double)dip->nios_up / (double)dip->nplugs;
+		n_nios_uplugs += dip->nplugs;
+		nios_plug_info.tot_nios_up += dip->nios_up;
+	}
+	if (dip->nios_upt && dip->nplugs_t) {
+		a_nios_uplug_t = (double)dip->nios_upt / (double)dip->nplugs_t;
+		n_nios_uplugs_t += dip->nplugs_t;
+		nios_plug_info.tot_nios_up_t += dip->nios_upt;
+	}
+
+	fprintf(ofp, "%10s | %10.1lf   %10.1lf\n",
+		make_dev_hdr(dev_info, 15, dip),
+		a_nios_uplug, a_nios_uplug_t);
+}
+
+void __dip_output_uplug_all(FILE *ofp, struct nios_plug_info *p)
+{
+	double ios_unp = 0.0, ios_unp_to = 0.0;
+
+	if (n_nios_uplugs)
+		ios_unp = (double)p->tot_nios_up / (double)n_nios_uplugs;
+	if (n_nios_uplugs_t)
+		ios_unp_to = (double)p->tot_nios_up_t / (double)n_nios_uplugs_t;
+
+	fprintf(ofp, "---------- | ----------   ----------\n");
+	fprintf(ofp, "%10s | %10s   %10s\n",
+		"Overall", "IOs/Unp", "IOs/Unp(to)");
+	fprintf(ofp, "%10s | %10.1lf   %10.1lf\n",
+		"Average", ios_unp, ios_unp_to);
+}
+
 void output_plug_info(FILE *ofp)
 {
-	fprintf(ofp, "%10s | %10s %10s  | %s\n", 
+	fprintf(ofp, "%10s | %10s %10s  | %s\n",
 	        "DEV", "# Plugs", "# Timer Us", "% Time Q Plugged");
 	fprintf(ofp, "---------- | ---------- ----------  | ----------------\n");
 	dip_foreach_out(__dip_output_plug, ofp);
 	if (n_plugs > 1)
 		__dip_output_plug_all(ofp, &plug_info);
 	fprintf(ofp, "\n");
+
+	fprintf(ofp, "%10s | %10s   %10s\n",
+		"DEV", "IOs/Unp", "IOs/Unp(to)");
+	fprintf(ofp, "---------- | ----------   ----------\n");
+	dip_foreach_out(__dip_output_plug_nios, ofp);
+	if (n_nios_uplugs || n_nios_uplugs_t)
+		__dip_output_uplug_all(ofp, &nios_plug_info);
+	fprintf(ofp, "\n");
 }
 
 int n_actQs;
@@ -574,9 +625,9 @@ void __dip_output_actQ(struct d_info *dip, void *arg)
 		char dev_info[15];
 		double a_actQs = (double)dip->t_act_q / (double)dip->n_qs;
 
-		fprintf((FILE *)arg, "%10s | %13.1lf\n", 
+		fprintf((FILE *)arg, "%10s | %13.1lf\n",
 			make_dev_hdr(dev_info, 15, dip), a_actQs);
-			
+
 		n_actQs++;
 		actQ_info.t_qs += dip->n_qs;
 		actQ_info.t_act_qs += dip->t_act_q;
@@ -587,7 +638,7 @@ void __dip_output_actQ_all(FILE *ofp, struct actQ_info *p)
 {
 	fprintf(ofp, "---------- | -------------\n");
 	fprintf(ofp, "%10s | %13s\n", "Overall", "Avgs Reqs @ Q");
-	fprintf(ofp, "%10s | %13.1lf\n", "Average", 
+	fprintf(ofp, "%10s | %13.1lf\n", "Average",
 		(double)p->t_act_qs / (double)p->t_qs);
 }
 
@@ -618,7 +669,7 @@ void output_histos(void)
 
 	fprintf(ofp, "# BTT histogram data\n");
 	fprintf(ofp, "# Q buckets\n");
-	for (i = 0; i < (N_HIST_BKTS-1); i++) 
+	for (i = 0; i < (N_HIST_BKTS-1); i++)
 		fprintf(ofp, "%4d %lld\n", (i+1), (long long)q_histo[i]);
 	fprintf(ofp, "\n# Q bucket for > %d\n%4d %lld\n", (int)N_HIST_BKTS-1,
 		N_HIST_BKTS-1, (long long)q_histo[N_HIST_BKTS-1]);
@@ -735,7 +786,7 @@ void __output_ranges(FILE *ofp, struct list_head *head_p, float base)
 	}
 }
 
-int output_regions(FILE *ofp, char *header, struct region_info *reg, 
+int output_regions(FILE *ofp, char *header, struct region_info *reg,
 			  float base)
 {
 	if (list_len(&reg->qranges) = 0 && list_len(&reg->cranges) = 0)
diff --git a/btt/trace_plug.c b/btt/trace_plug.c
index 03076d7..155e92a 100644
--- a/btt/trace_plug.c
+++ b/btt/trace_plug.c
@@ -20,16 +20,22 @@
  */
 #include "globals.h"
 
+__u64 get_nio_up(struct io *u_iop)
+{
+	__u64 *val = u_iop->pdu;
+	return be64_to_cpu(*val);
+}
+
 void trace_unplug_io(struct io *u_iop)
 {
 	unplug_hist_add(u_iop);
-	dip_unplug(u_iop->t.device, BIT_TIME(u_iop->t.time));
+	dip_unplug(u_iop->t.device, BIT_TIME(u_iop->t.time), get_nio_up(u_iop));
 	io_release(u_iop);
 }
 
 void trace_unplug_timer(struct io *ut_iop)
 {
-	dip_unplug_tm(ut_iop->t.device);
+	dip_unplug_tm(ut_iop->t.device, get_nio_up(ut_iop));
 	io_release(ut_iop);
 }
 
-- 
1.5.2.5

