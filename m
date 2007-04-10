From: "Alan D. Brunelle" <alan.brunelle@hp.com>
Date: Tue, 10 Apr 2007 17:05:09 +0000
Subject: [BTT PATCH] Add in option to change seek distance calculations
Message-Id: <461BC3C5.5060307@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090307060903020709050203"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------090307060903020709050203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

See the updated doc for details.

--------------090307060903020709050203
Content-Type: text/plain;
 name="seek-absolute"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="seek-absolute"

From: Alan D. Brunelle <Alan.Brunelle@hp.com>

Add in option to have seeks be start-to-start, rather than closest

Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>
---

 btt/args.c        |   11 ++++++++++-
 btt/bt_timeline.c |    2 +-
 btt/doc/btt.tex   |   28 ++++++++++++++++++++++++++--
 btt/globals.h     |    2 +-
 btt/seek.c        |   19 ++++++++++++-------
 5 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/btt/args.c b/btt/args.c
index 9aa24ae..bc60faf 100644
--- a/btt/args.c
+++ b/btt/args.c
@@ -29,9 +29,15 @@
 
 #define SETBUFFER_SIZE	(64 * 1024)
 
-#define S_OPTS	"AB:d:D:e:hi:I:l:M:o:p:q:s:S:t:T:Vv"
+#define S_OPTS	"aAB:d:D:e:hi:I:l:M:o:p:q:s:S:t:T:Vv"
 static struct option l_opts[] = {
 	{
+		.name = "seek-absolute",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'a'
+	},
+	{
 		.name = "all-data",
 		.has_arg = no_argument,
 		.flag = NULL,
@@ -213,6 +219,9 @@ void handle_args(int argc, char *argv[])
 
 	while ((c = getopt_long(argc, argv, S_OPTS, l_opts, NULL)) != -1) {
 		switch (c) {
+		case 'a':
+			seek_absolute = 1;
+			break;
 		case 'A':
 			output_all_data = 1;
 			break;
diff --git a/btt/bt_timeline.c b/btt/bt_timeline.c
index d998e99..76676a3 100644
--- a/btt/bt_timeline.c
+++ b/btt/bt_timeline.c
@@ -30,7 +30,7 @@ char bt_timeline_version[] = "0.99.1";
 char *devices, *exes, *input_name, *output_name, *seek_name, *bno_dump_name;
 char *d2c_name, *q2c_name, *per_io_name;
 FILE *ranges_ofp, *avgs_ofp, *per_io_ofp;
-int verbose, done, time_bounded, output_all_data;
+int verbose, done, time_bounded, output_all_data, seek_absolute;
 double t_astart, t_aend;
 unsigned long n_traces;
 struct avgs_info all_avgs;
diff --git a/btt/doc/btt.tex b/btt/doc/btt.tex
index 07b2127..ced747d 100644
--- a/btt/doc/btt.tex
+++ b/btt/doc/btt.tex
@@ -1,5 +1,5 @@
 \documentclass{article}
-\usepackage{epsfig}
+\usepackage{epsfig,placeins}
 
 %
 % Copyright (C) 2007 Alan D. Brunelle <Alan.Brunelle@hp.com>
@@ -22,7 +22,7 @@
 
 \title{\texttt{btt} User Guide}
 \author{Alan D. Brunelle (Alan.Brunelle@hp.com)}
-\date{1 March 2007}
+\date{10 April 2007}
 
 \begin{document}
 \maketitle
@@ -591,11 +591,27 @@ Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s
   \epsfig{file=seek.eps,width=4.5in}
   \caption{\label{fig:seek}Seek Chart}
   \end{figure}
+  \FloatBarrier
+
+  The seek difference is calculated in one of two ways:
+
+  \begin{description}
+    \item[default] By default, the seek distance is calculated as the
+    \emph{closest} distance between the previous IO and this IO. The
+    concept of \emph{closeness} means that it could either be the
+    \emph{end} of the previous IO and the beginning of the next, or the
+    end of this IO and the start of the next.
+
+    \item[\texttt{-a}] If the \texttt{-a} or \texttt{seek-absolute}
+    option is specified, then the seek distance is simply the difference
+    between the start of the previous IO and the start of this IO.
+  \end{description}
 
 \newpage\section{\label{sec:cmd-line}Command Line}
 
 \begin{verbatim}
 Usage: \texttt{btt} 0.99.1 
+[ -a               | --seek-absolute ]
 [ -A               | --all-data ]
 [ -B <output name> | --dump-blocknos=<output name> ]
 [ -d <seconds>     | --range-delta=<seconds> ]
@@ -617,6 +633,14 @@ Usage: \texttt{btt} 0.99.1
 [ -v               | --verbose ]
 \end{verbatim}
 
+\subsection{\label{sec:o-a}\texttt{--seek-absolute}/\texttt{-a}}
+
+  When specified on the command line, this directs btt to calculate seek
+  distances based solely upon the starting block addresses of succeeding
+  IOs. By default \texttt{btt} uses the concept of the closeness to either
+  the beginning or end of the previous IO. See section~\ref{sec:seek}
+  for more details about seek distances.
+
 \subsection{\label{sec:o-A}\texttt{--all-data}/\texttt{-A}}
 
   Normally \texttt{btt} will not print out verbose information
diff --git a/btt/globals.h b/btt/globals.h
index 912bb7c..ad50917 100644
--- a/btt/globals.h
+++ b/btt/globals.h
@@ -199,7 +199,7 @@ extern char *seek_name, *iostat_name, *d2c_name, *q2c_name, *per_io_name;
 extern char *bno_dump_name;
 extern double range_delta;
 extern FILE *ranges_ofp, *avgs_ofp, *iostat_ofp, *per_io_ofp;
-extern int verbose, done, time_bounded, output_all_data;
+extern int verbose, done, time_bounded, output_all_data, seek_absolute;
 extern unsigned int n_devs;
 extern unsigned long n_traces;
 extern struct list_head all_devs, all_procs, retries, rmhd;
diff --git a/btt/seek.c b/btt/seek.c
index fb62714..b8a3d42 100644
--- a/btt/seek.c
+++ b/btt/seek.c
@@ -105,14 +105,19 @@ long long seek_dist(struct seeki *sip, struct io *iop)
 	long long dist;
 	long long start = BIT_START(iop), end = BIT_END(iop);
 
-	/* Some overlap means no seek */
-	if (((sip->last_start <= start) && (start <= sip->last_end)) ||
-	    ((sip->last_start <= end) && (end <= sip->last_end)))
-		dist = 0;
-	else if (start > sip->last_end)
-		dist = start - sip->last_end;
-	else
+	if (seek_absolute)
 		dist = start - sip->last_start;
+	else {
+		/* Some overlap means no seek */
+		if (((sip->last_start <= start) && (start <= sip->last_end)) ||
+		    ((sip->last_start <= end) && (end <= sip->last_end)))
+			dist = 0;
+		else if (start > sip->last_end)
+			dist = start - sip->last_end;
+		else
+			dist = start - sip->last_start;
+
+	}
 
 	sip->last_start = start;
 	sip->last_end = end;

--------------090307060903020709050203--
