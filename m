From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Thu, 16 Oct 2008 16:07:59 +0000
Subject: [PATCH btt] Added in -L option - output periodic latency information
Message-Id: <48F766DF.4080108@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000501020903000002000508"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------000501020903000002000508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jens:

Pushed successfully...

Alan

--------------000501020903000002000508
Content-Type: text/x-diff;
 name="0001-Added-in-L-option-output-periodic-latency-informa.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Added-in-L-option-output-periodic-latency-informa.patch"

From 2baef5087c57d39ee2fc488cd52348f61f32b1fc Mon Sep 17 00:00:00 2001
From: Alan D. Brunelle <alan.brunelle@hp.com>
Date: Thu, 16 Oct 2008 12:03:45 -0400
Subject: [PATCH] Added in -L option - output periodic latency information

---
 btt/Makefile      |    2 +-
 btt/aqd.c         |   10 +++++
 btt/args.c        |   12 ++++++-
 btt/bt_timeline.c |    2 +
 btt/devs.c        |    7 ++++
 btt/doc/btt.tex   |    7 ++++
 btt/globals.h     |   12 +++++-
 btt/latency.c     |    2 +
 btt/plat.c        |  102 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/btt.1         |   11 ++++++
 10 files changed, 163 insertions(+), 4 deletions(-)
 create mode 100644 btt/plat.c

diff --git a/btt/Makefile b/btt/Makefile
index 8c4d882..1f6dacc 100644
--- a/btt/Makefile
+++ b/btt/Makefile
@@ -17,7 +17,7 @@ OBJS	= args.o bt_timeline.o devmap.o devs.o dip_rb.o iostat.o latency.o \
 	  misc.o output.o proc.o seek.o trace.o trace_complete.o trace_im.o \
 	  trace_issue.o trace_queue.o trace_remap.o trace_requeue.o \
 	  ../rbtree.o mmap.o trace_plug.o bno_dump.o unplug_hist.o q2d.o \
-	  aqd.o
+	  aqd.o plat.o
 
 all: depend $(PROGS)
 
diff --git a/btt/aqd.c b/btt/aqd.c
index 036a0d3..775fca6 100644
--- a/btt/aqd.c
+++ b/btt/aqd.c
@@ -53,6 +53,16 @@ void *aqd_init(char *str)
 
 }
 
+void aqd_exit(void *info)
+{
+	free(info);
+}
+
+void aqd_clean(void)
+{
+	clean_files(&aqd_files);
+}
+
 void aqd_issue(void *info, double ts)
 {
 	struct aqd_info *ap = info;
diff --git a/btt/args.c b/btt/args.c
index 2cbbf54..db4186e 100644
--- a/btt/args.c
+++ b/btt/args.c
@@ -29,7 +29,7 @@
 
 #define SETBUFFER_SIZE	(64 * 1024)
 
-#define S_OPTS	"aAB:d:D:e:hi:I:l:m:M:o:p:q:Q:s:S:t:T:u:VvX"
+#define S_OPTS	"aAB:d:D:e:hi:I:l:L:m:M:o:p:q:Q:s:S:t:T:u:VvX"
 static struct option l_opts[] = {
 	{
 		.name = "seek-absolute",
@@ -92,6 +92,12 @@ static struct option l_opts[] = {
 		.val = 'l'
 	},
 	{
+		.name = "periodic-latencies",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'L'
+	},
+	{
 		.name = "seeks-per-second",
 		.has_arg = required_argument,
 		.flag = NULL,
@@ -191,6 +197,7 @@ static char usage_str[] = \
 	"[ -i <input name>  | --input-file=<input name> ]\n" \
 	"[ -I <output name> | --iostat=<output name> ]\n" \
 	"[ -l <output name> | --d2c-latencies=<output name> ]\n" \
+	"[ -L <freq>        | --periodic-latencies=<freq> ]\n" \
 	"[ -m <output name> | --seeks-per-second=<output name> ]\n" \
 	"[ -M <dev map>     | --dev-maps=<dev map>\n" \
 	"[ -o <output name> | --output-file=<output name> ]\n" \
@@ -275,6 +282,9 @@ void handle_args(int argc, char *argv[])
 		case 'l':
 			d2c_name = strdup(optarg);
 			break;
+		case 'L':
+			plat_freq = atof(optarg);
+			break;
 		case 'I':
 			iostat_name = strdup(optarg);
 			break;
diff --git a/btt/bt_timeline.c b/btt/bt_timeline.c
index c4bbfbf..75e41ca 100644
--- a/btt/bt_timeline.c
+++ b/btt/bt_timeline.c
@@ -45,6 +45,7 @@ LIST_HEAD(free_ios);
 LIST_HEAD(free_bilinks);
 __u64 q_histo[N_HIST_BKTS], d_histo[N_HIST_BKTS];
 
+double plat_freq = 0.0;
 double range_delta = 0.1;
 __u64 last_q = (__u64)-1;
 
@@ -82,6 +83,7 @@ int main(int argc, char *argv[])
 	dip_exit();
 	seek_clean();
 	pip_exit();
+	aqd_clean();
 	io_free_all();
 	region_exit(&all_regions);
 
diff --git a/btt/devs.c b/btt/devs.c
index 2127cde..b7943d3 100644
--- a/btt/devs.c
+++ b/btt/devs.c
@@ -85,6 +85,9 @@ void dip_exit(void)
 		region_exit(&dip->regions);
 		seeki_exit(dip->seek_handle);
 		seeki_exit(dip->q2q_handle);
+		aqd_exit(dip->aqd_handle);
+		plat_exit(dip->q2c_plat_handle);
+		plat_exit(dip->d2c_plat_handle);
 		bno_dump_exit(dip->bno_dump_handle);
 		unplug_hist_exit(dip->unplug_hist_handle);
 		if (output_all_data)
@@ -121,6 +124,10 @@ struct d_info *dip_add(__u32 device, struct io *iop)
 		dip->seek_handle = seeki_init(mkhandle(str, device, "_d2d"));
 		dip->q2q_handle = seeki_init(mkhandle(str, device, "_q2q"));
 		dip->aqd_handle = aqd_init(mkhandle(str, device, "_aqd"));
+		dip->q2c_plat_handle =
+				plat_init(mkhandle(str, device, "_q2c_plat"));
+		dip->d2c_plat_handle =
+				plat_init(mkhandle(str, device, "_d2c_plat"));
 		latency_init(dip);
 		list_add_tail(&dip->hash_head, &dev_heads[DEV_HASH(device)]);
 		list_add_tail(&dip->all_head, &all_devs);
diff --git a/btt/doc/btt.tex b/btt/doc/btt.tex
index aa7db8c..eb4d29a 100644
--- a/btt/doc/btt.tex
+++ b/btt/doc/btt.tex
@@ -809,6 +809,7 @@ Usage: btt 2.05
 [ -i <input name>  | --input-file=<input name> ]
 [ -I <output name> | --iostat=<output name> ]
 [ -l <output name> | --d2c-latencies=<output name> ]
+[ -L <freq>        | --periodic-latencies=<freq> ]
 [ -m <output name> | --seeks-per-second=<output name> ]
 [ -M <dev map>     | --dev-maps=<dev map>
 [ -o <output name> | --output-file=<output name> ]
@@ -907,6 +908,12 @@ Usage: btt 2.05
   This option instructs \texttt{btt} to generate the D2C latency file
   discussed in section~\ref{sec:lat-d2c}.
 
+\subsection{\label{sec:o-L}\texttt{--periodic-latencies}/\texttt{-L}}
+
+  When given a value greater than 0, this option will create two data
+  files (q2c \& d2c) per device containing a periodic timestamp \&
+  average latency over that period.
+
 \subsection{\label{sec:o-m}\texttt{--seeks-per-second}\texttt{-m}}
 
   Tells \texttt{btt} to output seeks per second information.  Each device
diff --git a/btt/globals.h b/btt/globals.h
index bf1d656..8b804ee 100644
--- a/btt/globals.h
+++ b/btt/globals.h
@@ -146,7 +146,7 @@ struct d_info {
 	struct region_info regions;
 	struct devmap *map;
 	void *q2q_handle, *seek_handle, *bno_dump_handle, *unplug_hist_handle;
-	void *q2d_priv, *aqd_handle;
+	void *q2d_priv, *aqd_handle, *q2c_plat_handle, *d2c_plat_handle;
 	FILE *d2c_ofp, *q2c_ofp;
 	struct avgs_info avgs;
 	struct stats stats, all_stats;
@@ -181,7 +181,7 @@ struct io {
 extern char bt_timeline_version[], *devices, *exes, *input_name, *output_name;
 extern char *seek_name, *iostat_name, *d2c_name, *q2c_name, *per_io_name;
 extern char *bno_dump_name, *unplug_hist_name, *sps_name, *aqd_name;
-extern double range_delta;
+extern double range_delta, plat_freq;
 extern FILE *ranges_ofp, *avgs_ofp, *xavgs_ofp, *iostat_ofp, *per_io_ofp;
 extern FILE *msgs_ofp;
 extern int verbose, done, time_bounded, output_all_data, seek_absolute;
@@ -204,6 +204,8 @@ void clean_args();
 
 /* aqd.c */
 void *aqd_init(char *str);
+void aqd_exit(void *info);
+void aqd_clean(void);
 void aqd_issue(void *info, double ts);
 void aqd_complete(void *info, double ts);
 
@@ -282,6 +284,12 @@ void bno_dump_exit(void *param);
 void bno_dump_add(void *handle, struct io *iop);
 void bno_dump_clean(void);
 
+/* plat.c */
+void *plat_init(char *str);
+void plat_exit(void *info);
+void plat_clean(void);
+void plat_x2c(void *info, __u64 ts, __u64 latency);
+
 /* q2d.c */
 void q2d_histo_add(void *priv, __u64 q2d);
 void *q2d_init(void);
diff --git a/btt/latency.c b/btt/latency.c
index 916f566..4fb02d5 100644
--- a/btt/latency.c
+++ b/btt/latency.c
@@ -62,10 +62,12 @@ void latency_clean(void)
 
 void latency_d2c(struct d_info *dip, __u64 tstamp, __u64 latency)
 {
+	plat_x2c(dip->d2c_plat_handle, tstamp, latency);
 	latency_out(dip->d2c_ofp, tstamp, latency);
 }
 
 void latency_q2c(struct d_info *dip, __u64 tstamp, __u64 latency)
 {
+	plat_x2c(dip->q2c_plat_handle, tstamp, latency);
 	latency_out(dip->q2c_ofp, tstamp, latency);
 }
diff --git a/btt/plat.c b/btt/plat.c
new file mode 100644
index 0000000..9b7a2a1
--- /dev/null
+++ b/btt/plat.c
@@ -0,0 +1,102 @@
+/*
+ * blktrace output analysis: generate a timeline & gather statistics
+ *
+ * (C) Copyright 2008 Hewlett-Packard Development Company, L.P.
+ * 	Alan D. Brunelle <alan.brunelle@hp.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+#include "globals.h"
+
+struct plat_info {
+	long nl;
+	FILE *fp;
+	double first_ts, last_ts, tl;
+};
+
+static struct file_info *plat_files = NULL;
+
+void *plat_init(char *str)
+{
+	char *oname;
+	struct plat_info *pp;
+
+	if (plat_freq <= 0.0) return NULL;
+
+	pp = malloc(sizeof(*pp));
+	pp->nl = 0;
+	pp->first_ts = pp->last_ts = pp->tl = -1.0;
+
+	oname = malloc(strlen(str) + 32);
+	sprintf(oname, "%s.dat", str);
+	if ((pp->fp = fopen(oname, "w")) == NULL) {
+		perror(oname);
+		return NULL;
+	}
+	add_file(&plat_files, pp->fp, oname);
+
+	return pp;
+}
+
+void plat_exit(void *info)
+{
+	struct plat_info *pp = info;
+
+	if (pp == NULL) return;
+
+	if (pp->first_ts != -1.0) {
+		double delta = pp->last_ts - pp->first_ts;
+
+		fprintf(pp->fp, "%lf %lf\n",
+			pp->first_ts + (delta / 2), pp->tl / pp->nl);
+	}
+	free(info);
+}
+
+void plat_clean(void)
+{
+	clean_files(&plat_files);
+}
+
+void plat_x2c(void *info, __u64 ts, __u64 latency)
+{
+	double now = TO_SEC(ts);
+	double lat = TO_SEC(latency);
+	struct plat_info *pp = info;
+
+	if (pp == NULL) return;
+
+	if (pp->first_ts == -1.0) {
+		pp->first_ts = pp->last_ts = now;
+		pp->nl = 1;
+		pp->tl = lat;
+	}
+	else if ((now - pp->first_ts) >= plat_freq) {
+		double delta = pp->last_ts - pp->first_ts;
+
+		fprintf(pp->fp, "%lf %lf\n",
+			pp->first_ts + (delta / 2), pp->tl / pp->nl);
+
+		pp->first_ts = pp->last_ts = now;
+		pp->nl = 1;
+		pp->tl = lat;
+	}
+	else {
+		pp->last_ts = now;
+		pp->nl += 1;
+		pp->tl += lat;
+	}
+}
diff --git a/doc/btt.1 b/doc/btt.1
index 84275a5..55bc62a 100644
--- a/doc/btt.1
+++ b/doc/btt.1
@@ -27,6 +27,8 @@ btt \- analyse block i/o traces produces by blktrace
 .br
 [ \-l <\fIoutput name\fR> | \-\-d2c\-latencies=<\fIoutput name\fR> ]
 .br
+[ \-L <\fIfreq\fR>        | \-\-periodic\-latencies=<\fIfreq\fR> ]
+.br
 [ \-M <\fIdev map\fR>     | \-\-dev\-maps=<\fIdev map\fR>
 .br
 [ \-o <\fIoutput name\fR> | \-\-output\-file=<\fIoutput name\fR> ]
@@ -181,6 +183,15 @@ respectively. The supplied argument provides the basis for the output
 name for each device.
 .RE
 
+.B \-L <\fIfreq\fR>
+.br
+.B \-\-periodic\-latencies=<\fIfreq\fR>
+.RS 4
+The \-L option allows one to output periodic latency information for both
+Q2C and D2C latencies. The frequency specified will regulate how often
+an average latency is output -- a floating point value expressing seconds.
+.RE
+
 .B \-M <\fIdev map\fR>
 .br
 .B \-\-dev\-maps=<\fIdev map\fR>
-- 
1.5.4.3


--------------000501020903000002000508--
