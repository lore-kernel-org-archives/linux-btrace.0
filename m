From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:32 +0000
Subject: [PATCH 25/31] btrace: bring back possibility to toggle statistics at end of trace
Message-Id: <20180427130738.102806-26-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

First, blkparse was internally called in quiet mode by default.
v0.99.1 commit eea01dfc2e0e ("[PATCH] btrace: don't be quiet by default,
and fix -h parameter") changed the default.
v1.0.1 commit bc93336f08a3 ("fix up btrace options & manpage")
removed the no longer functional -S option.
Simply surface -q option of blkparse for use in btrace to suppress stats.
Otherwise it keeps printing stats by default.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 btrace           | 5 +++--
 doc/blktrace.tex | 2 ++
 doc/btrace.8     | 6 +++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/btrace b/btrace
index 44401823aa61..e260b91ff081 100644
--- a/btrace
+++ b/btrace
@@ -8,10 +8,10 @@
 
 TRACEOPTS=""
 PARSEOPTS="-b100000"
-USAGE="Usage: btrace [-s] [-t] [-h] [-v] [-w N] [-n N] [-b N] [-a <trace>...] [-r <dbg mnt>] <dev>..."
+USAGE="Usage: btrace [-s] [-t] [-h] [-v] [-q] [-w N] [-n N] [-b N] [-a <trace>...] [-r <dbg mnt>] <dev>..."
 DIRNAME=`dirname $0`
 
-while getopts "a:w:n:b:r:sthv" c
+while getopts "a:w:n:b:r:sthvq" c
 do
 	case $c in
 	a)	TRACEOPTS=$TRACEOPTS" -a "$OPTARG" ";;
@@ -23,6 +23,7 @@ do
 	t)	PARSEOPTS=$PARSEOPTS" -t";;
 	h)	PARSEOPTS=$PARSEOPTS" -h";;
 	v)	PARSEOPTS=$PARSEOPTS" -v";;
+	q)	PARSEOPTS=$PARSEOPTS" -q";;
 	\?)	echo $USAGE 1>&2
 		exit 2
 		;;
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index b5fc769ab891..aad19e2ff38d 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -222,6 +222,8 @@ default\footnote{blktrace v0.99.1 eea01dfc2e0e (``[PATCH] btrace:
   don't be quiet by default, and fix -h parameter'')} and the
 \emph{-S} option does not exist any more\footnote{blktrace v1.0.1
   bc93336f08a3 (``fix up btrace options \& manpage'')}.
+An inverse quiet option \emph{-q} allows to toggle off statistics\footnote{
+  blktrace newer than 1.2.0}.
 
 \subsection{blktrace -- SCSI commands}
 \label{sec:pc-blktrace}
diff --git a/doc/btrace.8 b/doc/btrace.8
index dc08e3608f1d..833cf9bf3596 100644
--- a/doc/btrace.8
+++ b/doc/btrace.8
@@ -6,7 +6,7 @@ btrace \- perform live tracing for block devices
 
 
 .SH SYNOPSIS
-.B btrace [\-s] [\-t] [\-h] [\-v] [\-w \fIN\fN] [\-n \fIN\fR] [\-b \fIN\fR] [\-r \fI<dbg mnt>\fR] [\-a <\fItrace\fR>...] <\fIdev\fR>...
+.B btrace [\-s] [\-t] [\-h] [\-v] [\-q] [\-w \fIN\fN] [\-n \fIN\fR] [\-b \fIN\fR] [\-r \fI<dbg mnt>\fR] [\-a <\fItrace\fR>...] <\fIdev\fR>...
 .br
 
 
@@ -35,6 +35,10 @@ Hash processes by name, not PID (see \fIblkparse\fR (1)).
 .B \-v
 Be more verbose for marginal errors (see \fIblkparse\fR (1)).
 
+.HP 4
+.B \-q
+Do not print any statistics at end of trace (see \fIblkparse\fR (1)).
+
 .HP 4
 .B \-w \fIN\fR
 Sets run time to the number of seconds specified (see \fIblktrace\fR (8)).
-- 
2.14.2

