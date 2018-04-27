From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:23 +0000
Subject: [PATCH 16/31] blktrace: doc: no more SCSI CDB in payload
Message-Id: <20180427130738.102806-17-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 doc/blktrace.8   |  6 ++++++
 doc/blktrace.tex | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/doc/blktrace.8 b/doc/blktrace.8
index 708758a9e253..1afd44cb0e73 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -269,6 +269,12 @@ flushing dirty data to disk or the file system syncing a
 super or journal block to disk. \fBpc\fR requests are SCSI commands. blktrace
 sends the command data block as a payload so that blkparse can decode it.
 
+Since Linux kernel v4.11, SCSI commands no longer appear as payload in
+\fBpc\fR requests. You can use SCSI tracepoints instead
+(/sys/kernel/debug/tracing/events/scsi/).
+Correlation between blktrace and SCSI tracing:
+A blktrace issue event (D) causes a scsi_dispatch_cmd_start tracepoint;
+A scsi_dispatch_cmd_done tracepoint causes a blktrace complete event (C).
 
 .SH EXAMPLES
 To trace the i/o on the device \fI/dev/sda\fR and parse the output to human
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 4fb9aae16245..7acf082346d3 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -228,6 +228,16 @@ that the command completed successfully. Tracing SCSI commands can be
 very useful for debugging problems with programs talking directly to the
 device. An example of that would be \emph{cdrecord} burning.
 
+Since Linux kernel v4.11\footnote{
+v4.11 commit 48b77ad60844 (``block: cleanup tracing'')\newline
+v4.11 commit 82ed4db499b8 (``block: split scsi\_request out of struct request'')},
+SCSI commands no longer appear as part of an io action.
+You can use SCSI tracepoints instead
+(/sys/\linebreak[0]kernel/\linebreak[0]debug/\linebreak[0]tracing/\linebreak[0]events/\linebreak[0]scsi/).
+Correlation between blktrace and SCSI tracing:
+A blktrace issue event (D) causes a scsi\_dispatch\_cmd\_start event;
+a scsi\_dispatch\_cmd\_done tracepoint causes a blktrace complete event (C).
+
 \subsection{blktrace -- post-processing}
 \label{sec:blktrace-post}
 
@@ -463,6 +473,16 @@ a super or journal block to disk. \emph{pc} requests are SCSI
 commands. blktrace sends the command data block as a payload
 so that blkparse can decode it.
 
+Since Linux kernel v4.11\footnote{
+v4.11 commit 48b77ad60844 (``block: cleanup tracing'')\newline
+v4.11 commit 82ed4db499b8 (``block: split scsi\_request out of struct request'')},
+SCSI commands no longer appear as payload in
+\emph{pc} requests. You can use SCSI tracepoints instead
+(/sys/\linebreak[0]kernel/\linebreak[0]debug/\linebreak[0]tracing/\linebreak[0]events/\linebreak[0]scsi/).
+Correlation between blktrace and SCSI tracing:
+A blktrace issue event (D) causes a scsi\_dispatch\_cmd\_start tracepoint;
+a scsi\_dispatch\_cmd\_done tracepoint causes a blktrace complete event (C).
+
 %----------------------------
 \newpage\section{blkparse User Guide}
 \label{sec:blkparse-ug}
-- 
2.14.2

