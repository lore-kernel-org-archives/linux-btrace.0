From: "Alan D. Brunelle" <Alan.Brunelle@pobox.com>
Date: Mon, 16 Apr 2007 15:39:03 +0000
Subject: [BTT PATCH] Add in unplug IO count histogram option
Message-Id: <46239897.7040207@pobox.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080109080100060509030900"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------080109080100060509030900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------080109080100060509030900
Content-Type: text/plain;
 name="add-hist"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add-hist"

From: Alan D. Brunelle <Alan.Brunelle@hp.com>

Add in unplug IO count histogram

Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>
---

 btt/Makefile      |    2 +
 btt/args.c        |   12 ++++++-
 btt/bt_timeline.c |    2 +
 btt/devs.c        |    2 +
 btt/doc/btt.tex   |   36 +++++++++++++++++++--
 btt/globals.h     |    9 ++++-
 btt/trace_plug.c  |    1 +
 btt/unplug_hist.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 146 insertions(+), 8 deletions(-)

diff --git a/btt/Makefile b/btt/Makefile
index 920c70c..e9a1ef0 100644
--- a/btt/Makefile
+++ b/btt/Makefile
@@ -16,7 +16,7 @@ LIBS	= $(PLIBS) $(ELIBS)
 OBJS	= args.o bt_timeline.o devmap.o devs.o dip_rb.o iostat.o latency.o \
 	  misc.o output.o proc.o seek.o trace.o trace_complete.o trace_im.o \
 	  trace_issue.o trace_queue.o trace_remap.o trace_requeue.o rbtree.o \
-	  mmap.o trace_plug.o bno_dump.o
+	  mmap.o trace_plug.o bno_dump.o unplug_hist.o
 
 all: depend $(PROGS)
 
diff --git a/btt/args.c b/btt/args.c
index 7a4a5fd..9e918c9 100644
--- a/btt/args.c
+++ b/btt/args.c
@@ -29,7 +29,7 @@
 
 #define SETBUFFER_SIZE	(64 * 1024)
 
-#define S_OPTS	"aAB:d:D:e:hi:I:l:M:o:p:q:s:S:t:T:Vv"
+#define S_OPTS	"aAB:d:D:e:hi:I:l:M:o:p:q:s:S:t:T:u:Vv"
 static struct option l_opts[] = {
 	{
 		.name = "seek-absolute",
@@ -140,6 +140,12 @@ static struct option l_opts[] = {
 		.val = 'T'
 	},
 	{
+		.name = "unplug-hist",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'u'
+	},
+	{
 		.name = "version",
 		.has_arg = no_argument,
 		.flag = NULL,
@@ -175,6 +181,7 @@ static char usage_str[] = \
 	"[ -S <interval>    | --iostat-interval=<interval> ]\n" \
 	"[ -t <sec>         | --time-start=<sec> ]\n" \
 	"[ -T <sec>         | --time-end=<sec> ]\n" \
+	"[ -u <output name> | --unplug-hist=<output name> ] \n" \
 	"[ -V               | --version ]\n" \
 	"[ -v               | --verbose ]\n\n";
 
@@ -280,6 +287,9 @@ void handle_args(int argc, char *argv[])
 			sscanf(optarg, "%lf", &t_aend);
 			time_bounded = 1;
 			break;
+		case 'u':
+			unplug_hist_name = strdup(optarg);
+			break;
 		case 'v':
 			verbose = 1;
 			break;
diff --git a/btt/bt_timeline.c b/btt/bt_timeline.c
index 76676a3..f38f6a2 100644
--- a/btt/bt_timeline.c
+++ b/btt/bt_timeline.c
@@ -28,7 +28,7 @@
 char bt_timeline_version[] = "0.99.1";
 
 char *devices, *exes, *input_name, *output_name, *seek_name, *bno_dump_name;
-char *d2c_name, *q2c_name, *per_io_name;
+char *d2c_name, *q2c_name, *per_io_name, *unplug_hist_name;
 FILE *ranges_ofp, *avgs_ofp, *per_io_ofp;
 int verbose, done, time_bounded, output_all_data, seek_absolute;
 double t_astart, t_aend;
diff --git a/btt/devs.c b/btt/devs.c
index 9eece81..397a945 100644
--- a/btt/devs.c
+++ b/btt/devs.c
@@ -134,6 +134,7 @@ void dip_exit(void)
 		region_exit(&dip->regions);
 		seeki_exit(dip->seek_handle);
 		bno_dump_exit(dip->bno_dump_handle);
+		unplug_hist_exit(dip->unplug_hist_handle);
 		free(dip);
 	}
 }
@@ -152,6 +153,7 @@ struct d_info *dip_add(__u32 device, struct io *iop)
 		dip->map = dev_map_find(device);
 		dip->seek_handle = seeki_init(device);
 		dip->bno_dump_handle = bno_dump_init(device);
+		dip->unplug_hist_handle = unplug_hist_init(device);
 		latency_init(dip);
 		list_add_tail(&dip->hash_head, &dev_heads[DEV_HASH(device)]);
 		list_add_tail(&dip->all_head, &all_devs);
diff --git a/btt/doc/btt.tex b/btt/doc/btt.tex
index 26cba36..e8762e8 100644
--- a/btt/doc/btt.tex
+++ b/btt/doc/btt.tex
@@ -22,7 +22,7 @@
 
 \title{\texttt{btt} User Guide}
 \author{Alan D. Brunelle (Alan.Brunelle@hp.com)}
-\date{10 April 2007}
+\date{16 April 2007}
 
 \begin{document}
 \maketitle
@@ -346,6 +346,10 @@ pdflush       0.000000790 0.000006752 0.247231307  179791
     \item[seek details] A data file containing all IO-to-IO
     sector differences can be output, with details found in
     section~\ref{sec:seek}.
+
+    \item[unplug histogram details] A data file per device containing
+    histogram output for the amount of IOs released at unplug time.
+    Section~\ref{sec:o-u} has more details.
   \end{description}
 
 \newpage\section{\label{sec:activity}Activity Data File}
@@ -629,6 +633,7 @@ Usage: \texttt{btt} 0.99.1
 [ -S <interval>    | --iostat-interval=<interval> ]
 [ -t <sec>         | --time-start=<sec> ]
 [ -T <sec>         | --time-end=<sec> ]
+[ -u <output name> | --unplug-hist=<output name> ] 
 [ -V               | --version ]
 [ -v               | --verbose ]
 \end{verbatim}
@@ -737,7 +742,7 @@ Usage: \texttt{btt} 0.99.1
 
 \subsection{\label{sec:o-s}\texttt{--seeks}/\texttt{-s}}
 
-  This option instruct \texttt{btt} to generate the seek data file
+  This option instructs \texttt{btt} to generate the seek data file
   discussed in section~\ref{sec:seek}.
 
 \subsection{\label{sec:o-S}\texttt{--iostat-interval}/\texttt{-S}}
@@ -761,6 +766,31 @@ Usage: \texttt{btt} 0.99.1
   trace chosen will be between the start time (or 0.0 if not
   specified) and end time (or the end of the run) specified. 
 
+\subsection{\label{sec:o-u}\texttt{--unplug-hist}/\texttt{-u}}
+
+  This option instructs \texttt{btt} to generate a data file containing
+  histogram information for \emph{unplug} traces on a per device
+  basis. It shows how many times an unplug was hit with a specified
+  number of IOs released. There are 21 output values into the file, as
+  follows:
+
+  \medskip
+  \begin{tabular}{ll}
+\textbf{X value} & \textbf{Representing Counts} \\\hline
+0 & 0\dots\/4 \\
+1 & 5\dots\/9 \\
+2 & 10\dots\/14 \\
+\dots & \dots\dots\\
+19 & 95\dots\/99 \\
+20 & 100+ \\
+  \end{tabular}
+
+  \medskip
+  The file name(s) generated use the text string passed as an argument for
+  the prefix, followed by the device identifier in \texttt{major,minor}
+  form, with a \texttt{.dat} extension (as an example, with \texttt{-u
+  up\_hist} specified on the command line: \texttt{up\_hist\_008,032.dat}.
+
 \subsection{\label{sec:o-V}\texttt{--version}/\texttt{-V}}
 
   Prints out the \texttt{btt} version, and exits.
@@ -788,7 +818,7 @@ Sending stats data to bttX.avg
 16.379036+0.000005=16.379041
 \end{verbatim}
 
-\newpage\section{\label{sec:appendix}Appendix: Sample \texttt{btt}
+\newpage\section*{\label{sec:appendix}Appendix: Sample \texttt{btt}
 Output}
   
   Here is a complete output file from a btt run, illustrating a lot of the
diff --git a/btt/globals.h b/btt/globals.h
index ad50917..5a6982f 100644
--- a/btt/globals.h
+++ b/btt/globals.h
@@ -158,7 +158,7 @@ struct d_info {
 	void *heads;
 	struct region_info regions;
 	struct devmap *map;
-	void *seek_handle, *bno_dump_handle;
+	void *seek_handle, *bno_dump_handle, *unplug_hist_handle;
 	FILE *d2c_ofp, *q2c_ofp;
 	struct avgs_info avgs;
 	struct stats stats, all_stats;
@@ -196,7 +196,7 @@ struct bilink {
 
 extern char bt_timeline_version[], *devices, *exes, *input_name, *output_name;
 extern char *seek_name, *iostat_name, *d2c_name, *q2c_name, *per_io_name;
-extern char *bno_dump_name;
+extern char *bno_dump_name, *unplug_hist_name;
 extern double range_delta;
 extern FILE *ranges_ofp, *avgs_ofp, *iostat_ofp, *per_io_ofp;
 extern int verbose, done, time_bounded, output_all_data, seek_absolute;
@@ -350,4 +350,9 @@ void trace_remap(struct io *a_iop);
 /* trace_requeue.c */
 void trace_requeue(struct io *r_iop);
 
+/* unplug_hist.c */
+void *unplug_hist_init(__u32 device);
+void unplug_hist_exit(void *arg);
+void unplug_hist_add(struct io *u_iop);
+
 #include "inlines.h"
diff --git a/btt/trace_plug.c b/btt/trace_plug.c
index dd797f6..06d9fc9 100644
--- a/btt/trace_plug.c
+++ b/btt/trace_plug.c
@@ -22,6 +22,7 @@
 
 static inline void trace_unplug(struct io *u_iop, int is_timer)
 {
+	unplug_hist_add(u_iop);
 	dip_unplug(u_iop->t.device, BIT_TIME(u_iop->t.time), is_timer);
 	io_release(u_iop);
 }
diff --git a/btt/unplug_hist.c b/btt/unplug_hist.c
new file mode 100644
index 0000000..03b009b
--- /dev/null
+++ b/btt/unplug_hist.c
@@ -0,0 +1,90 @@
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
+#include "globals.h"
+
+#define BKT_WIDTH	5
+#define MAX_BKT		19
+#define EXCESS_BKT	20
+#define NBKTS		EXCESS_BKT
+
+struct hist_bkt {
+	__u32 dev;
+	int hist[NBKTS * sizeof(int)];
+};
+
+static struct file_info *unplug_hist_files = NULL;
+
+void *unplug_hist_init(__u32 device)
+{
+	struct hist_bkt *hbp;
+
+	if (unplug_hist_name == NULL) return NULL;
+
+	hbp = malloc(sizeof(*hbp));
+	hbp->dev = device;
+	memset(hbp->hist, 0, NBKTS * sizeof(int));
+
+	return hbp;
+}
+
+void unplug_hist_add(struct io *u_iop)
+{
+	struct d_info *dip;
+
+	assert(u_iop->t.pdu_len >= sizeof(__u64));
+
+	dip = __dip_find(u_iop->t.device);
+	if (dip && dip->unplug_hist_handle) {
+		__u64 *val = u_iop->pdu;
+		int n_unplugs = be64_to_cpu(*val);
+		struct hist_bkt * hbp = dip->unplug_hist_handle;
+		int idx = (n_unplugs / BKT_WIDTH) <= MAX_BKT ?: EXCESS_BKT;
+
+		assert((0 <= idx) && (idx <= EXCESS_BKT));
+		hbp->hist[idx]++;
+	}
+}
+
+void unplug_hist_exit(void *arg)
+{
+	if (arg) {
+		FILE *fp;
+		struct hist_bkt *hbp = arg;
+		int mjr = hbp->dev >> MINORBITS;
+		int mnr = hbp->dev & ((1 << MINORBITS) - 1);
+		char *oname = malloc(strlen(unplug_hist_name) + 32);
+
+		sprintf(oname, "%s_%03d,%03d.dat", unplug_hist_name, mjr, mnr);
+		if ((fp = fopen(oname, "w")) != NULL) {
+			int i;
+
+			for (i = 0; i < NBKTS; i++)
+				fprintf(fp, "%d %d\n", i, hbp->hist[i]);
+			fclose(fp);
+
+		}
+		else
+			perror(oname);
+
+		free(oname);
+		free(hbp);
+	}
+}

--------------080109080100060509030900--
