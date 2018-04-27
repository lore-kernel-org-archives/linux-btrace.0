From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:22 +0000
Subject: [PATCH 15/31] blktrace: doc: update RWBS including flush, FUA replacing barrier
Message-Id: <20180427130738.102806-16-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Cc: Namhyung Kim <namhyung@gmail.com>
---
 doc/blkparse.1   | 19 +++++++++++++++++--
 doc/blktrace.8   | 11 +++++++++++
 doc/blktrace.tex | 28 +++++++++++++++++++++++++++-
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/doc/blkparse.1 b/doc/blkparse.1
index d334d25dac15..69d05cabe333 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -427,9 +427,24 @@ Thus, to specify the command in a 12-character field that is left aligned:
 .SH "RWBS DESCRIPTION"
 
 This is a small string containing at least one character ('R' for read, 'W'
-for write, or 'D' for block discard operation), and optionally either
+for write, 'D' for block discard operation,
+or 'N' for empty requests otherwise),
+and optionally either
 a 'B' (for barrier operations) or 'S' (for synchronous operations).
-
+Additionally, the string can contain
+\&'A' for readahead, or
+\&'M' for metadata.
+Since blktrace-1.0.3 /
+.\" blktrace commit 344320932064 ("Add FLUSH/FUA support")
+Linux kernel v3.1,
+.\" kernel commit c09c47caedc9 ("blktrace: add FLUSH/FUA support")
+\&'B' (for barrier operations) no longer exists, but
+\&'F' before a write for flush or
+\&'F' after a write for FUA (force unit access).
+As regular expression, the RWBS string has the following format,
+although not necessarily all combinations appear in the Linux block layer:
+
+    F?[RWDN]F?A?B?S?M?
 
 
 .SH "DEFAULT OUTPUT HEADER"
diff --git a/doc/blktrace.8 b/doc/blktrace.8
index 67ea3ddfaedf..708758a9e253 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -241,11 +241,22 @@ line options.
 .br
 \fImeta\fR: metadata
 .br
+\fIflush\fR: flush the volatile write cache
+.br
+\fIfua\fR: Force Unit Access requests
+.br
 \fInotify\fR: trace messages
 .br
 \fIdrv_data\fR: additional driver specific trace
 .RE
 
+\fIbarrier\fR does not exist anymore since blktrace-1.0.3 /
+.\" blktrace commit 344320932064 ("Add FLUSH/FUA support")
+Linux kernel v3.1,
+.\" kernel commit c09c47caedc9 ("blktrace: add FLUSH/FUA support")
+but \fIflush\fR and \fIfua\fR were introduced;
+see also Linux kernel source Documentation/block/writeback_cache_control.txt.
+
 
 .SH REQUEST TYPES
 blktrace distinguishes between two types of block layer requests, file system
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 539362f657d4..4fb9aae16245 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -437,10 +437,19 @@ sync & \emph{synchronous} attribute \\ \hline
 write & \emph{write} requests \\ \hline
 ahead & readahead \\ \hline
 meta & metadata \\ \hline
+flush & flush the volatile write cache \\ \hline
+fua & Force Unit Access requests \\ \hline
 notify & \emph{notify} trace messages \\ \hline
 drv\_data & additional driver specific trace \\ \hline
 \end{tabular}
 
+Barrier does not exist anymore since blktrace-1.0.3\footnote{
+v1.0.3 blktrace commit 344320932064 (``Add FLUSH/FUA support'')}
+/ Linux kernel v3.1\footnote{
+v3.1 kernel commit c09c47caedc9 (``blktrace: add FLUSH/FUA support'')},
+but flush and fua were introduced; see also Linux kernel source
+Documentation/\linebreak[0]block/\linebreak[0]writeback\_cache\_control.txt.
+
 \subsubsection{Request types}
 \label{sec:request-types}
 blktrace disguingishes between two types of block layer requests,
@@ -714,8 +723,25 @@ X & Split \\ \hline
 \subsubsection{RWBS Description}
 \label{sec:rwbs}
 This is a small string containing at least one character ('R' for read,
-'W' for write, or 'D' for block discard operation), and optionally either
+'W' for write, or 'D' for block discard operation,
+or 'N' for empty requests otherwise), and optionally either
 a 'B' (for barrier operations) or 'S' (for synchronous operations).
+Additionally, the string can contain
+'A' for readahead, or
+'M' for metadata.
+Since blktrace-1.0.3\footnote{
+blktrace commit 344320932064 (``Add FLUSH/FUA support'')}
+/ Linux kernel v3.1\footnote{
+kernel commit c09c47caedc9 (``blktrace: add FLUSH/FUA support'')},
+'B' (for barrier operations) no longer exists, but
+'F' before a write for flush or
+'F' after a write for FUA (force unit access).
+As regular expression, the RWBS string has the following format,
+although not necessarily all combinations appear in the Linux block layer:
+
+\begin{verbatim}
+    F?[RWDN]F?A?B?S?M?
+\end{verbatim}
 
 \subsubsection{Default output header}
 \label{sec:default-output-header}
-- 
2.14.2

