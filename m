From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:21 +0000
Subject: [PATCH 14/31] blktrace: doc: (un)plug event updates for on-stack plugging
Message-Id: <20180427130738.102806-15-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 doc/blkparse.1   |  8 ++++++--
 doc/blktrace.tex | 19 ++++++++++++++-----
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/doc/blkparse.1 b/doc/blkparse.1
index cedd08e2dc5b..d334d25dac15 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -293,9 +293,13 @@ driver. This may happen automatically if a timeout period has passed (see next
 entry) or if a number of requests have been added to the queue.
 
 .HP 4
-\fBT -- unplug due to timer\fR
+\fBT -- unplug due to timer / schedule\fR
 If nobody requests the i/o that was queued after plugging the queue, Linux will
 automatically unplug it after a defined period has passed.
+Since kernel 2.6.39 and the new on-stack plugging, the equivalent is
+an unplug due to process scheduling
+.\" https://lwn.net/Articles/438256/
+.\" v2.6.39 commit 49cac01e1fa7 ("block: make unplug timer trace event correspond to the schedule() unplug")
 
 .HP 4
 \fBX -- split\fR
@@ -535,7 +539,7 @@ square brackets) is output.
 
 \fBU \-\- unplug\fR
 .br
-\fBT \-\- unplug due to timer\fR
+\fBT \-\- unplug due to timer / schedule\fR
 .RS 4
 The command associated with the event
 (surrounded by square brackets) is output, followed by the number of
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 06de4be1a64b..539362f657d4 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -602,9 +602,13 @@ Short              & Long                       & Description \\ \hline\hline
   if a timeout period has passed (see next entry) or if a number of
   requests have been added to the queue.
 
-  \item[T -- unplug due to timer] If nobody requests the io that was queued
+  \item[T -- unplug due to timer / schedule] If nobody requests the io that was queued
   after plugging the queue, Linux will automatically unplug it after a
-  defined period has passed.
+  defined period has passed. Since kernel 2.6.39 and the new on-stack plugging,
+  the equivalent is an unplug due to process scheduling\footnote{
+    \url{https://lwn.net/Articles/438256/}\newline
+    v2.6.39 commit 49cac01e1fa7 (``block: make unplug timer trace
+    event correspond to the schedule() unplug'') }.
 
   \item[X -- split] On raid or device mapper setups, an incoming io may
   straddle a device or internal zone and needs to be chopped up into
@@ -702,7 +706,7 @@ P & Plug request \\ \hline
 Q & IO handled by request queue code \\ \hline
 R & Requeued \\ \hline
 S & Sleep request \\ \hline
-T & Unplug due to timeout \\ \hline
+T & Unplug due to timeout / schedule \\ \hline
 U & Unplug request \\ \hline
 X & Split \\ \hline
 \end{tabular}
@@ -794,7 +798,7 @@ default output ends each event with a newline character
   square brackets) is output.
 
   \item[U -- unplug]
-  \item[T -- unplug due to timer] The command associated with the event
+  \item[T -- unplug due to timer / schedule] The command associated with the event
   (surrounded by square brackets) is output, followed by the number of
   requests outstanding.
 
@@ -841,13 +845,18 @@ definitions:
   BLK\_TA\_COMPLETE & Command completed by driver. \\ \hline
   BLK\_TA\_PLUG & Device is plugged \\ \hline
   BLK\_TA\_UNPLUG\_IO & Unplug device as IO is made available. \\ \hline
-  BLK\_TA\_UNPLUG\_TIMER & Unplug device after timer expired. \\ \hline
+  BLK\_TA\_UNPLUG\_TIMER & Unplug device after timer expired
+  / process schedule\footnotemark[42]. \\ \hline
   BLK\_TA\_INSERT & Insert request into queue. \\ \hline
   BLK\_TA\_SPLIT & BIO split into 2 or more requests. \\ \hline
   BLK\_TA\_BOUNCE & BIO was bounced \\ \hline
   BLK\_TA\_REMAP & BIO was remapped \\ \hline
 \end{tabular}
 
+\footnotetext[42]{\url{https://lwn.net/Articles/438256/}\newline
+    v2.6.39 commit 49cac01e1fa7 (``block: make unplug timer trace
+    event correspond to the schedule() unplug'') }
+
 %..........................................
 \subsection{blktrace.h Routines}
 Files which include $<linux/blktrace.h>$ are supplied with the following
-- 
2.14.2

