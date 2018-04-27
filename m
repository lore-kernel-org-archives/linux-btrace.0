From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:24 +0000
Subject: [PATCH 17/31] blktrace: doc: assorted fixes and updates
Message-Id: <20180427130738.102806-18-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

blktrace.git history regarding removed kernel patches

typo: you kernel => your kernel

linux.git history regarding kernel config for blktrace

add debugfs mount alternative: systemd automatism

blktrace.git history regarding statistics option of btrace

typo: parentheses plural

typo: you test cases => your test cases
typo: disguingishes => distinguishes

API:
* header file name changes
* fix duplicate request_queue argument
* BLK_TA_QUEUE only for bio; add BLK_TA_INSERT for rq function
* add BLK_TA_BOUNCE and BLK_TA_COMPLETE to bio function
* message size changes

Roughly explain the internal trace record format and variants
to help the reader understand what functionality can be expected
such as wall clock calendar timestamps.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 doc/blktrace.tex | 169 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 150 insertions(+), 19 deletions(-)

diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 7acf082346d3..6307b9343c44 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -79,11 +79,14 @@ As noted above, the kernel patch along with the blktrace and blkparse utilities
 \subsection{Patching and configuring the Linux kernel}
 \label{sec:patching}
 
-A patch for a \emph{specific Linux kernel} is provided in bt/kernel (where
+A patch for a \emph{specific Linux kernel} used to be\footnote{until
+  blktrace v0.99.2 commit e33da1d51a82 (``[PATCH] Fixup relayfs
+  references and kill kernel patch'')}
+provided in bt/kernel (where
 \emph{bt} is the name of the directory from the above git sequence). The
 detailed actual patching instructions for a Linux kernel is outside the
 scope of this document, but the following may be used as a sample template.
-Note that you may skip this step, if you kernel is at least 2.6.17-rc1.
+Note that you may skip this step, if your kernel is at least 2.6.17-rc1.
 
 As an example, bt/kernel contains blk-trace-2.6.14-rc1-git-G2, download
 linux-2.6.13.tar.bz2 and patch-2.6.14-rc1.bz2
@@ -109,6 +112,15 @@ system -- again, outside the scope of this document -- and then enable
 and navigate through \emph{Device Drivers} and \emph{Block devices}
 and then down to \emph{Support for tracing block io actions} and hit Y.
 
+In more recent kernels\footnote{Linux v2.6.30 2db270a80b8f
+  (``tracing/blktrace: move the tracing file to kernel/trace'')},
+navigate through \emph{Kernel hacking}, hit Y for \emph{Tracers} and
+then enter its submenu, then navigate down to \emph{Support for
+  tracing block IO actions} and hit Y. To be selectable, the following
+dependencies need to be met: \emph{Enable the block layer} as well as
+\emph{File systems}, \emph{Pseudo filesystems}, \emph{sysfs file
+  system support}.
+
 Install the new kernel (and modules\ldots) and reboot. 
 
 \subsection{Mounting the debugfs file system}
@@ -130,6 +142,8 @@ To do this one may do either of the following:
 \begin{verbatim}
 debug /sys/kernel/debug debugfs default 0 0
 \end{verbatim}
+
+\item Have systemd automatically mount debugfs by default.
 \end{enumerate}
 
 \subsection{Build the tools}
@@ -200,9 +214,14 @@ tracing of devices. The above could also be accomplished by issuing:
 % btrace /dev/sda
 \end{verbatim}
 
-By default, \emph{btrace} runs the trace in quiet mode so it will not
-include statistics when you break the run. Add the \emph{-S} option to
+By default, \emph{btrace} did run blkparse in quiet mode so it did not
+include statistics when you break the run. You could add the \emph{-S} option to
 get that dumped as well.
+Meanwhile, \emph{btrace} includes the statistics by
+default\footnote{blktrace v0.99.1 eea01dfc2e0e (``[PATCH] btrace:
+  don't be quiet by default, and fix -h parameter'')} and the
+\emph{-S} option does not exist any more\footnote{blktrace v1.0.1
+  bc93336f08a3 (``fix up btrace options \& manpage'')}.
 
 \subsection{blktrace -- SCSI commands}
 \label{sec:pc-blktrace}
@@ -223,7 +242,7 @@ by applications using the SCSI Generic (\emph{sg}) interface.
 
 Here we see a program issuing an INQUIRY command to the CDROM device.
 The program requested a read of 56 bytes of data, the CDB is included
-in parenthesis after the data length. The completion event shows shows
+in parentheses after the data length. The completion event shows shows
 that the command completed successfully. Tracing SCSI commands can be
 very useful for debugging problems with programs talking directly to the
 device. An example of that would be \emph{cdrecord} burning.
@@ -246,7 +265,7 @@ formatting by blkparse. This would be useful if you want to get
 measurements while running specific loads.
 
 To do this, one would specify the device (or devices) to be watched. Then 
-go run you test cases. Stop the trace, and at your leisure utilize
+go run your test cases. Stop the trace, and at your leisure utilize
 blkparse to see the results.
 
 In this example, devices /dev/sdaa, /dev/sdc and /dev/sdo are used in an 
@@ -462,7 +481,7 @@ Documentation/\linebreak[0]block/\linebreak[0]writeback\_cache\_control.txt.
 
 \subsubsection{Request types}
 \label{sec:request-types}
-blktrace disguingishes between two types of block layer requests,
+blktrace distinguishes between two types of block layer requests,
 file system and scsi commands. The former are dubbed \emph{fs}
 requests, the latter \emph{pc} requests. File system requests are
 normal read/write operations, ie any type of read or write from a
@@ -874,9 +893,9 @@ filesystem. This section provides some details as to the interfaces
 blktrace utilizes in the kernel to effect this. It is good background data
 to help understand some of the outputs and command-line options above.
 
-\subsection{blktrace.h Definitions}
-Files which include $<linux/blktrace.h>$ are supplied with the following
-definitions:
+\subsection{blktrace\_api.h Definitions}
+Files which include $<$linux/blktrace\_api.h$>$ are supplied with the following
+definitions (from include/uapi/linux/blktrace\_api.h):
 
 \subsubsection{Trace Action Specifiers}
 \begin{tabular}{|l|l|}\hline
@@ -904,24 +923,26 @@ definitions:
     event correspond to the schedule() unplug'') }
 
 %..........................................
-\subsection{blktrace.h Routines}
-Files which include $<linux/blktrace.h>$ are supplied with the following
-kernel routine invocable interfaces:
+\subsection{blktrace\_api.h Routines}
+Files which include $<$linux/blktrace\_api.h$>$ used to be supplied with the following
+kernel routine invocable interfaces. Meanwhile tracepoint macros
+``trace\_block\_\dots'' from $<$trace/events/block.h$>$ are used:
 
 \begin{description}
-  \item[blk\_add\_trace\_rq(struct request\_queue *q, struct request\_queue 
+  \item[blk\_add\_trace\_rq(struct request\_queue *q, struct request
   								*rq, u32 what)]
 	Adds a trace event describing the state change of the passed in
 	request\_queue. The \emph{what} parameter describes the change in
 	the request\_queue state, and is one of the request queue action 
-	specifiers -- BLK\_TA\_QUEUE, BLK\_TA\_REQUEUE, BLK\_TA\_ISSUE,
+	specifiers -- BLK\_TA\_INSERT, BLK\_TA\_REQUEUE, BLK\_TA\_ISSUE,
 	or BLK\_TA\_COMPLETE.
 
   \item[blk\_add\_trace\_bio(struct request\_queue *q, struct bio *bio, 
   								u32 what)]
 	Adds a trace event for the BIO passed in. The \emph{what} parameter
 	describes the action being performed on the BIO, and is one of
-	BLK\_TA\_BACKMERGE, BLK\_TA\_FRONTMERGE, or BLK\_TA\_QUEUE.
+	BLK\_TA\_BACKMERGE, BLK\_TA\_FRONTMERGE,
+	BLK\_TA\_BOUNCE, BLK\_TA\_COMPLETE, or BLK\_TA\_QUEUE.
 
   \item[blk\_add\_trace\_generic(struct request\_queue *q, struct bio *bio, 
 							int rw, u32 what)]
@@ -944,9 +965,119 @@ kernel routine invocable interfaces:
 
   \item[blk\_add\_trace\_msg(struct request\_queue *q, char *fmt, ...)]
 	Adds a formatted message to the output stream. The total message
-	size can not exceed BLK\_TN\_MSG\_MSG characters (currently
-	1024). Standard format conversions are supported (as supplied
-	by \texttt{vscnprintf}.
+	size can not exceed BLK\_TN\_MAX\_MSG characters (used to be 1024,
+	meanwhile 128). Standard format conversions are supported (as supplied
+	by \texttt{vscnprintf}).
+
+\end{description}
+
+\subsection{Trace Record Format}
+\label{sec:record}
+
+The following describes trace record format version 7.
+
+\begin{verbatim}
+struct blk_io_trace {
+        __u32 magic;       /* MAGIC | version */
+        __u32 sequence;    /* event number */
+        __u64 time;        /* in nanoseconds */
+        __u64 sector;      /* disk offset */
+        __u32 bytes;       /* transfer length */
+        __u32 action;      /* what happened */
+        __u32 pid;         /* who did it */
+        __u32 device;      /* device number */
+        __u32 cpu;         /* on what cpu did it happen */
+        __u16 error;       /* completion error */
+        __u16 pdu_len;     /* length of data after this trace */
+        /* cgroup id will be stored here if exists */
+};
+\end{verbatim}
+
+The field magic is the ASCII text string ``eat'' followed by one byte
+indicating the blktrace version in binary. It is also used to determine
+endianness on parsing trace records during postprocessing in user space.
+
+The field sequence is per CPU and per device (major, minor).
+
+The field time contains kernel monotonic time in nanoseconds. The
+blkparse tool does not print this directly as ``time stamp'' but only the
+relative time since the oldest trace record (``genesis\_time'').
 
+Any optional payload follows the last structure field immediately:
+\begin{description}
+\item[unplug (io or timer/schedule)] depth as big endian 64 bit value
+\item[split] sector as big endian 64 bit value
+\item[remap] remapping information:
+\begin{verbatim}
+struct blk_io_trace_remap {
+        __be32 device_from;
+        __be32 device_to;
+        __be64 sector_from;
+};
+\end{verbatim}
+\item[drv\_data] bytes provided by a device driver
 \end{description}
+
+\subsection{Special Notification Trace Records}
+\label{sec:records-special}
+
+\subsubsection{Timestamp}
+
+On starting tracing, blktrace writes a notification record with time
+of day. The message payload consists of u32 for seconds and u32 for
+nanoseconds. This allows postprocessing user space to print wallclock
+for each trace record instead of just monotonic nanoseconds as with
+the time field of struct blk\_io\_trace.
+
+\subsubsection{Process Mapping}
+
+On writing any trace record, blktrace conditionally writes a preceding
+additional process record if it has not done so already for this
+process. The payload contains the ``comm'' string of the process. This
+allows to print the process name in addition to the PID for
+postprocessing user space.
+
+A kernel internal epoch counter is used to emit such record only for a
+process it has not done so yet during the current epoch and tracer.
+Starting tracing increases the epoch and the tracer is added to a
+tracking list of active tracers. On trace emit, struct task\_struct of
+the process remembers the current epoch.
+
+\subsubsection{Message}
+
+Text message generated via kernel call to
+\texttt{blk\_add\_trace\_msg} from e.g.\ CFQ I/O scheduler, or written to
+/sys/\linebreak[0]kernel/\linebreak[0]debug/\linebreak[0]block/\linebreak[0]\emph{dev}/\linebreak[0]msg.
+
+\subsection{CGroup Payload}
+
+This requires CONFIG\_BLK\_CGROUP and the blk tracer option
+blk\_cgroup to be enabled\footnote{v4.14 commits ca1136c99b66
+  (``blktrace: export cgroup info in trace'')\newline 35fe6d763229
+  (``block: use standard blktrace API to output cgroup info for debug
+  notes'')}.
+
+If so, message traces and trace actions except for (getrq, sleeprq,
+(un)plug(timer)) contain a cgroup ID. It's the first payload content
+with sizeof(union kernfs\_node\_id) and followed by the actual
+payload. The trace record field pdu\_len is increased accordingly.
+
+The blkparse user space tool currently does not handle traces with
+blk\_cgroup enabled. Such traces have a flag \_\_BLK\_TA\_CGROUP
+(or \_\_BLK\_TN\_CGROUP if it's a notification (Sec.~\ref{sec:records-special}))
+set for their action field to indicate the additional payload part.
+blkparse reports ``Bad fs action'' for such trace records.
+
+With ftrace option blk\_cgroup, the text output of the ftrace tracer ``blk''
+formats the cgroup information between the device and the action column.
+The format is ``\textit{ino},\textit{generation}'' in hexadecimal numbers.
+
+With ftrace option blk\_cgname in addition to blk\_cgroup, the text
+output of the ftrace tracer ``blk'' formats the cgroup information as
+path name string instead of an ID\footnote{ v4.14 commit 69fd5c391763
+  (``blktrace: add an option to allow displaying cgroup path'')}. If
+it cannot get the path name, the output is ``$<\dots>$''.
+
+See also Sec.~\ref{sec:form-text-outp}.
+
 \end{document}
-- 
2.14.2

