From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:11 +0000
Subject: [PATCH 04/31] btrace: fix usage by adding -v (blkparse --verbose)
Message-Id: <20180427130738.102806-5-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Fixes: 19a67de341ca ("[PATCH] btrace: allow -v option for blkparse -v")
Fixes: bc93336f08a3 ("fix up btrace options & manpage")
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 btrace       | 2 +-
 doc/btrace.8 | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/btrace b/btrace
index f1f731b2a18f..44401823aa61 100644
--- a/btrace
+++ b/btrace
@@ -8,7 +8,7 @@
 
 TRACEOPTS=""
 PARSEOPTS="-b100000"
-USAGE="Usage: btrace [-s] [-t] [-h] [-w N] [-n N] [-b N] [-a <trace>...] [-r <dbg mnt>] <dev>..."
+USAGE="Usage: btrace [-s] [-t] [-h] [-v] [-w N] [-n N] [-b N] [-a <trace>...] [-r <dbg mnt>] <dev>..."
 DIRNAME=`dirname $0`
 
 while getopts "a:w:n:b:r:sthv" c
diff --git a/doc/btrace.8 b/doc/btrace.8
index 60462140ccc6..146462ced50c 100644
--- a/doc/btrace.8
+++ b/doc/btrace.8
@@ -6,7 +6,7 @@ btrace \- perform live tracing for block devices
 
 
 .SH SYNOPSIS
-.B btrace [\-s] [\-t] [\-h] [\-w \fIN\fN] [\-n \fIN\fR] [\-b \fIN\fR] [\-r \fI<dbg mnt>\fR] [\-a <\fItrace\fR>...] <\fIdev\fR>...
+.B btrace [\-s] [\-t] [\-h] [\-v] [\-w \fIN\fN] [\-n \fIN\fR] [\-b \fIN\fR] [\-r \fI<dbg mnt>\fR] [\-a <\fItrace\fR>...] <\fIdev\fR>...
 .br
 
 
@@ -31,6 +31,10 @@ Displays time deltas per IO (see \fIblkparse\fR (1)).
 .B \-h
 Hash processes by name, not PID (see \fIblkparse\fR (1)).
 
+.HP 4
+.B \-v
+Be more verbose for marginal errors (see \fIblkparse\fR (1)).
+
 .HP 4
 .B \-w \fIN\fR
 Sets run time to the number of seconds specified (see \fIblktrace\fR (8)).
-- 
2.14.2

