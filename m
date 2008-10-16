From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Thu, 16 Oct 2008 14:58:10 +0000
Subject: [PATCH btt] Added in -Q / --active-queue-depth option
Message-Id: <48F75682.8010001@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050906020102060203060604"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------050906020102060203060604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jens: Pushed this out successfully...

Alan

--------------050906020102060203060604
Content-Type: text/x-diff;
 name="0001-Added-in-Q-active-queue-depth-option.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Added-in-Q-active-queue-depth-option.patch"

From 4ae2c3c6215de3f9016b5211ac83893cb061b1e1 Mon Sep 17 00:00:00 2001
From: Alan D. Brunelle <alan.brunelle@hp.com>
Date: Thu, 16 Oct 2008 10:53:07 -0400
Subject: [PATCH] Added in -Q / --active-queue-depth option

This will output a data file containing the time stamp and number of
I/Os issued to underlying drivers per device. It will give you an idea
as to how many I/Os are being actively worked per device at any time
during the run.

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 btt/Makefile         |    3 +-
 btt/aqd.c            |   73 ++++++++++++++++++++++++++++++++++++++++++++++++++
 btt/args.c           |   12 +++++++-
 btt/bt_timeline.c    |    2 +-
 btt/devs.c           |    1 +
 btt/doc/btt.tex      |   11 +++++++-
 btt/globals.h        |    9 +++++-
 btt/trace_complete.c |    1 +
 btt/trace_issue.c    |    1 +
 doc/btt.1            |   12 +++++++-
 10 files changed, 118 insertions(+), 7 deletions(-)

diff --git a/btt/Makefile b/btt/Makefile
index a6b078e..8c4d882 100644
--- a/btt/Makefile
+++ b/btt/Makefile
@@ -16,7 +16,8 @@ LIBS	= $(PLIBS) $(ELIBS)
 OBJS	= args.o bt_timeline.o devmap.o devs.o dip_rb.o iostat.o latency.o \
 	  misc.o output.o proc.o seek.o trace.o trace_complete.o trace_im.o \
 	  trace_issue.o trace_queue.o trace_remap.o trace_requeue.o \
-	  ../rbtree.o mmap.o trace_plug.o bno_dump.o unplug_hist.o q2d.o
+	  ../rbtree.o mmap.o trace_plug.o bno_dump.o unplug_hist.o q2d.o \
+	  aqd.o
 
 all: depend $(PROGS)
 
diff --git a/btt/aqd.c b/btt/aqd.c
new file mode 100644
index 0000000..036a0d3
--- /dev/null
+++ b/btt/aqd.c
@@ -0,0 +1,73 @@
+/*
+ * blktrace output analysis: generate a timeline & gather statistics
+ *
+ * Copyright (C) 2006 Alan D. Brunelle <Alan.Brunelle@hp.com>
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "globals.h"
+
+static struct file_info *aqd_files = NULL;
+
+struct aqd_info {
+	FILE *fp;
+	int na;		/* # active */
+};
+
+void *aqd_init(char *str)
+{
+	char *oname;
+	struct aqd_info *ap;
+
+	if (aqd_name == NULL) return NULL;
+
+	ap = malloc(sizeof(*ap));
+	ap->na = 0;
+
+	oname = malloc(strlen(aqd_name) + strlen(str) + 32);
+	sprintf(oname, "%s_%s.dat", aqd_name, str);
+	if ((ap->fp = fopen(oname, "w")) == NULL) {
+		perror(oname);
+		return NULL;
+	}
+	add_file(&aqd_files, ap->fp, oname);
+
+	return ap;
+
+}
+
+void aqd_issue(void *info, double ts)
+{
+	struct aqd_info *ap = info;
+
+	fprintf(ap->fp, "%lf %d\n%lf %d\n", ts, ap->na, ts, ap->na + 1);
+
+	ap->na += 1;
+}
+
+void aqd_complete(void *info, double ts)
+{
+	struct aqd_info *ap = info;
+
+	if (ap->na > 0) {
+		fprintf(ap->fp, "%lf %d\n%lf %d\n", ts, ap->na, ts, ap->na - 1);
+		ap->na -= 1;
+	}
+}
diff --git a/btt/args.c b/btt/args.c
index 9c5c4d5..2cbbf54 100644
--- a/btt/args.c
+++ b/btt/args.c
@@ -29,7 +29,7 @@
 
 #define SETBUFFER_SIZE	(64 * 1024)
 
-#define S_OPTS	"aAB:d:D:e:hi:I:l:m:M:o:p:q:s:S:t:T:u:VvX"
+#define S_OPTS	"aAB:d:D:e:hi:I:l:m:M:o:p:q:Q:s:S:t:T:u:VvX"
 static struct option l_opts[] = {
 	{
 		.name = "seek-absolute",
@@ -122,6 +122,12 @@ static struct option l_opts[] = {
 		.val = 'q'
 	},
 	{
+		.name = "active-queue-depth",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'Q'
+	},
+	{
 		.name = "seeks",
 		.has_arg = required_argument,
 		.flag = NULL,
@@ -190,6 +196,7 @@ static char usage_str[] = \
 	"[ -o <output name> | --output-file=<output name> ]\n" \
 	"[ -p <output name> | --per-io-dump=<output name> ]\n" \
 	"[ -q <output name> | --q2c-latencies=<output name> ]\n" \
+	"[ -Q <output name> | --active-queue-depth=<output name> ]\n" \
 	"[ -s <output name> | --seeks=<output name> ]\n" \
 	"[ -S <interval>    | --iostat-interval=<interval> ]\n" \
 	"[ -t <sec>         | --time-start=<sec> ]\n" \
@@ -287,6 +294,9 @@ void handle_args(int argc, char *argv[])
 		case 'q':
 			q2c_name = strdup(optarg);
 			break;
+		case 'Q':
+			aqd_name = strdup(optarg);
+			break;
 		case 's':
 			seek_name = strdup(optarg);
 			break;
diff --git a/btt/bt_timeline.c b/btt/bt_timeline.c
index 2eed087..c4bbfbf 100644
--- a/btt/bt_timeline.c
+++ b/btt/bt_timeline.c
@@ -29,7 +29,7 @@ char bt_timeline_version[] = "2.05";
 
 char *devices, *exes, *input_name, *output_name, *seek_name, *bno_dump_name;
 char *d2c_name, *q2c_name, *per_io_name, *unplug_hist_name;
-char *sps_name;
+char *sps_name, *aqd_name;
 FILE *ranges_ofp, *avgs_ofp, *xavgs_ofp, *per_io_ofp, *msgs_ofp;
 int verbose, done, time_bounded, output_all_data, seek_absolute;
 int easy_parse_avgs;
diff --git a/btt/devs.c b/btt/devs.c
index 3cf7a6c..2127cde 100644
--- a/btt/devs.c
+++ b/btt/devs.c
@@ -120,6 +120,7 @@ struct d_info *dip_add(__u32 device, struct io *iop)
 		dip->unplug_hist_handle = unplug_hist_init(device);
 		dip->seek_handle = seeki_init(mkhandle(str, device, "_d2d"));
 		dip->q2q_handle = seeki_init(mkhandle(str, device, "_q2q"));
+		dip->aqd_handle = aqd_init(mkhandle(str, device, "_aqd"));
 		latency_init(dip);
 		list_add_tail(&dip->hash_head, &dev_heads[DEV_HASH(device)]);
 		list_add_tail(&dip->all_head, &all_devs);
diff --git a/btt/doc/btt.tex b/btt/doc/btt.tex
index 87e7082..aa7db8c 100644
--- a/btt/doc/btt.tex
+++ b/btt/doc/btt.tex
@@ -798,7 +798,7 @@ Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s
 \newpage\section{\label{sec:cmd-line}Command Line}
 
 \begin{verbatim}
-Usage: btt 2.05
+Usage: btt 2.05 
 [ -a               | --seek-absolute ]
 [ -A               | --all-data ]
 [ -B <output name> | --dump-blocknos=<output name> ]
@@ -814,6 +814,7 @@ Usage: btt 2.05
 [ -o <output name> | --output-file=<output name> ]
 [ -p <output name> | --per-io-dump=<output name> ]
 [ -q <output name> | --q2c-latencies=<output name> ]
+[ -Q <output name> | --active-queue-depth=<output name> ]
 [ -s <output name> | --seeks=<output name> ]
 [ -S <interval>    | --iostat-interval=<interval> ]
 [ -t <sec>         | --time-start=<sec> ]
@@ -938,6 +939,14 @@ Usage: btt 2.05
   This option instructs \texttt{btt} to generate the Q2C latency file
   discussed in section~\ref{sec:lat-q2c}.
 
+\subsection{\label{sec:o-Q}\texttt{--active-queue-depth}/\texttt{-Q}}
+
+  This option tells \texttt{btt} to generate a data file (using the given
+  name as a base) which contains: A time stamp in the first column,
+  and then the number of \emph{active} requests issued to the device
+  driver. (The value is incremented when an \emph{issue} is performend,
+  and decremented when a \emph{complete} is performed.
+
 \subsection{\label{sec:o-s}\texttt{--seeks}/\texttt{-s}}
 
   This option instructs \texttt{btt} to generate the seek data file
diff --git a/btt/globals.h b/btt/globals.h
index fda1bdb..bf1d656 100644
--- a/btt/globals.h
+++ b/btt/globals.h
@@ -146,7 +146,7 @@ struct d_info {
 	struct region_info regions;
 	struct devmap *map;
 	void *q2q_handle, *seek_handle, *bno_dump_handle, *unplug_hist_handle;
-	void *q2d_priv;
+	void *q2d_priv, *aqd_handle;
 	FILE *d2c_ofp, *q2c_ofp;
 	struct avgs_info avgs;
 	struct stats stats, all_stats;
@@ -180,7 +180,7 @@ struct io {
 
 extern char bt_timeline_version[], *devices, *exes, *input_name, *output_name;
 extern char *seek_name, *iostat_name, *d2c_name, *q2c_name, *per_io_name;
-extern char *bno_dump_name, *unplug_hist_name, *sps_name;
+extern char *bno_dump_name, *unplug_hist_name, *sps_name, *aqd_name;
 extern double range_delta;
 extern FILE *ranges_ofp, *avgs_ofp, *xavgs_ofp, *iostat_ofp, *per_io_ofp;
 extern FILE *msgs_ofp;
@@ -202,6 +202,11 @@ extern __u64 q_histo[N_HIST_BKTS], d_histo[N_HIST_BKTS];
 void handle_args(int argc, char *argv[]);
 void clean_args();
 
+/* aqd.c */
+void *aqd_init(char *str);
+void aqd_issue(void *info, double ts);
+void aqd_complete(void *info, double ts);
+
 /* devmap.c */
 int dev_map_read(char *fname);
 struct devmap *dev_map_find(__u32 device);
diff --git a/btt/trace_complete.c b/btt/trace_complete.c
index 41bcb7d..e8773e3 100644
--- a/btt/trace_complete.c
+++ b/btt/trace_complete.c
@@ -59,6 +59,7 @@ static void handle_complete(struct io *c_iop)
 	update_cregion(&c_iop->dip->regions, c_iop->t.time);
 	if (c_iop->pip)
 		update_cregion(&c_iop->pip->regions, c_iop->t.time);
+	aqd_complete(c_iop->dip->aqd_handle, BIT_TIME(c_iop->t.time));
 
 	dip_foreach_list(c_iop, IOP_Q, &head);
 	list_for_each_safe(p, q, &head) {
diff --git a/btt/trace_issue.c b/btt/trace_issue.c
index a18d44d..b7c3e5f 100644
--- a/btt/trace_issue.c
+++ b/btt/trace_issue.c
@@ -34,6 +34,7 @@ static void handle_issue(struct io *d_iop)
 	d_iop->dip->n_ds++;
 	if (!remapper_dev(d_iop->t.device))
 		update_d_histo(d_iop->t.bytes);
+	aqd_issue(d_iop->dip->aqd_handle, BIT_TIME(d_iop->t.time));
 
 	dip_foreach_list(d_iop, IOP_Q, &head);
 	list_for_each_safe(p, q, &head) {
diff --git a/doc/btt.1 b/doc/btt.1
index aded24b..84275a5 100644
--- a/doc/btt.1
+++ b/doc/btt.1
@@ -8,7 +8,7 @@ btt \- analyse block i/o traces produces by blktrace
 .SH SYNOPSIS
 .B btt 
 [ \-a               | \-\-seek\-absolute ]
-.RS 4
+.br
 [ \-A               | \-\-all\-data ]
 .br
 [ \-B <\fIoutput name\fR> | \-\-dump\-blocknos=<\fIoutput name\fR> ]
@@ -35,6 +35,8 @@ btt \- analyse block i/o traces produces by blktrace
 .br
 [ \-q <\fIoutput name\fR> | \-\-q2c\-latencies=<\fIoutput name\fR> ]
 .br
+[ \-Q <\fIoutput name\fR> | \-\-active\-queue\-depth=<\fIoutput name\fR> ]
+.br
 [ \-s <\fIoutput name\fR> | \-\-seeks=<\fIoutput name\fR> ]
 .br
 [ \-S <\fIinterval\fR>    | \-\-iostat\-interval=<\fIinterval\fR> ]
@@ -211,6 +213,14 @@ respectively. The supplied argument provides the basis for the output
 name for each device.
 .RE
 
+.B \-Q <\fIoutput name\fR>
+.br
+.B \-\-active\-queue\-depth=<\fIoutput name\fR>
+.RS 4
+The \-Q option allows one to output data files showing the time stamp
+and the depth of active commands (those issued but not completed).
+.RE
+
 .B \-s <\fIoutput name\fR>
 .br
 .B \-\-seeks=<\fIoutput name\fR>
-- 
1.5.4.3


--------------050906020102060203060604--
