From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:10 +0000
Subject: [PATCH 03/31] btrace: fix usage by adding -h (blkparse --hash-by-name)
Message-Id: <20180427130738.102806-4-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Fixes: d915dee697e3 ("[PATCH] Switch hash option -h, update btrace for all new options")
Fixes: bc93336f08a3 ("fix up btrace options & manpage")
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 btrace       | 2 +-
 doc/btrace.8 | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/btrace b/btrace
index 45c10cffdd4d..f1f731b2a18f 100644
--- a/btrace
+++ b/btrace
@@ -8,7 +8,7 @@
 
 TRACEOPTS=""
 PARSEOPTS="-b100000"
-USAGE="Usage: btrace [-s] [-t] [-w N] [-n N] [-b N] [-a <trace>...] [-r <dbg mnt>] <dev>..."
+USAGE="Usage: btrace [-s] [-t] [-h] [-w N] [-n N] [-b N] [-a <trace>...] [-r <dbg mnt>] <dev>..."
 DIRNAME=`dirname $0`
 
 while getopts "a:w:n:b:r:sthv" c
diff --git a/doc/btrace.8 b/doc/btrace.8
index a1f34c2cfbe1..60462140ccc6 100644
--- a/doc/btrace.8
+++ b/doc/btrace.8
@@ -6,7 +6,7 @@ btrace \- perform live tracing for block devices
 
 
 .SH SYNOPSIS
-.B btrace [\-s] [\-t] [\-w \fIN\fN] [\-n \fIN\fR] [\-b \fIN\fR] [\-r \fI<dbg mnt>\fR] [\-a <\fItrace\fR>...] <\fIdev\fR>...
+.B btrace [\-s] [\-t] [\-h] [\-w \fIN\fN] [\-n \fIN\fR] [\-b \fIN\fR] [\-r \fI<dbg mnt>\fR] [\-a <\fItrace\fR>...] <\fIdev\fR>...
 .br
 
 
@@ -27,6 +27,10 @@ Displays data sorted by program (see \fIblkparse\fR (1)).
 .B \-t 
 Displays time deltas per IO (see \fIblkparse\fR (1)).
 
+.HP 4
+.B \-h
+Hash processes by name, not PID (see \fIblkparse\fR (1)).
+
 .HP 4
 .B \-w \fIN\fR
 Sets run time to the number of seconds specified (see \fIblktrace\fR (8)).
-- 
2.14.2

