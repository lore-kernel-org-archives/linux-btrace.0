From: Eric Sandeen <sandeen@redhat.com>
Date: Mon, 04 May 2009 20:40:53 +0000
Subject: [PATCH] fix up btrace options & manpage
Message-Id: <49FF52D5.70607@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The btrace script & man page didn't quite match for options,
and the btrace script was missing a few options in the getopts
specification (b&n).  Also, there seems to be no such thing as
a "summarize" option anywhere, so remove it.

Reported-by: /Milos Malik <mmalik@redhat.com <mailto:mmalik@redhat.com>>/
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

(this goes after the general manpage cleanup I sent, sorry,
should have been a series in retrospect)


diff --git a/btrace b/btrace
index f902707..45c10cf 100644
--- a/btrace
+++ b/btrace
@@ -8,11 +8,10 @@
 
 TRACEOPTS=""
 PARSEOPTS="-b100000"
-SUMMARIZE=""
-USAGE="Usage: btrace [-s] [-t] [-S] [-w N] [-a <trace>...] [-r <dbg mnt]<dev>..."
+USAGE="Usage: btrace [-s] [-t] [-w N] [-n N] [-b N] [-a <trace>...] [-r <dbg mnt>] <dev>..."
 DIRNAME=`dirname $0`
 
-while getopts "a:r:stSw:hv" c
+while getopts "a:w:n:b:r:sthv" c
 do
 	case $c in
 	a)	TRACEOPTS=$TRACEOPTS" -a "$OPTARG" ";;
@@ -24,13 +23,11 @@ do
 	t)	PARSEOPTS=$PARSEOPTS" -t";;
 	h)	PARSEOPTS=$PARSEOPTS" -h";;
 	v)	PARSEOPTS=$PARSEOPTS" -v";;
-	S)	SUMMARIZE="";;
 	\?)	echo $USAGE 1>&2
 		exit 2
 		;;
 	esac
 done
-PARSEOPTS="${PARSEOPTS} ${SUMMARIZE}"
 
 shift `expr $OPTIND - 1`
 if [ $# -eq 0 ]; then
diff --git a/doc/btrace.8 b/doc/btrace.8
index 1e6c06d..a1f34c2 100644
--- a/doc/btrace.8
+++ b/doc/btrace.8
@@ -6,7 +6,7 @@ btrace \- perform live tracing for block devices
 
 
 .SH SYNOPSIS
-.B btrace [\-s] [\-t] [\-w \fIN\fN] [\-n \fIN\fR] [\-b \fIN\fR]  [\-a <\fItrace\fR>...] <\fIdev\fR>...
+.B btrace [\-s] [\-t] [\-w \fIN\fN] [\-n \fIN\fR] [\-b \fIN\fR] [\-r \fI<dbg mnt>\fR] [\-a <\fItrace\fR>...] <\fIdev\fR>...
 .br
 
 
@@ -41,6 +41,10 @@ Specifies buffer size for event extraction (scaled by 1024) (see
 \fIblktrace\fR (8)).
 
 .HP 4
+.B \-r \fI<dbg mnt>\fR
+Specifies the debugfs mountpoint.
+
+.HP 4
 .B \-a <\fItrace\fR>...
 Adds mask to current filter (see \fIblktrace\fR (8)).
 

