From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:19 +0000
Subject: [PATCH 12/31] blktrace: doc: blktrace: sync fixes from man page updates
Message-Id: <20180427130738.102806-13-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 doc/blktrace.tex | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 32b4e14fe318..107aa34eb8c9 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -353,7 +353,8 @@ of the more arcane command line options:
 \begin{itemize}
   \item blktrace receives data from the kernel in buffers passed up
   through the debug file system (relay). Each device being traced has
-  a file created in the mounted directory for the debugfs, which defaults
+  a directory with files created under the \emph{block/} directory
+  in the mounted directory for the debugfs, which defaults
   to \emph{/sys/kernel/debug} -- this can be overridden with the \emph{-r}
   command line argument.
   
@@ -381,12 +382,9 @@ of the more arcane command line options:
   \item blktrace may also be run concurrently with blkparse to produce
   \emph{live} output -- to do this specify \emph{-o -} for blktrace.
 
-  \item The default behaviour for blktrace is to run forever until explicitly killed by the user (via a control-C, or \emph{kill} utility invocation). There are two ways to modify this: 
+  \item The default behaviour for blktrace is to run forever until explicitly killed by the user (via a control-C, or \emph{kill} utility invocation). There is one way to modify this:
 
   \begin{enumerate}
-    \item You may utilize the blktrace utility itself to \emph{kill}
-    a running trace -- via the \emph{-k} option.
-
     \item You can specify a run-time duration for blktrace via the
     \emph{-w} option -- then blktrace will run for the specified number
     of seconds, and then halt.
@@ -397,20 +395,25 @@ of the more arcane command line options:
 \label{sec:blktrace-args}
 \begin{tabular}{|l|l|l|}\hline
 Short              & Long                       & Description \\ \hline\hline
--A \emph{hex-mask} & --set-mask=\emph{hex-mask} & Set filter mask to \emph{hex-mask} \\ \hline
--a \emph{mask}     & --act-mask=\emph{mask}     & Add \emph{mask} to current filter (see below for masks) \\ \hline
--b \emph{size}     & --buffer-size=\emph{size}  & Specifies buffer size for event extraction (scaled by $2^{10}$) \\ \hline
--d \emph{dev}      & --dev=\emph{dev}           & Adds \emph{dev} as a device to trace \\ \hline
--k                 & --kill                     & Kill on-going trace \\ \hline
--n \emph{num-sub}  & --num-sub=\emph{num-sub}   & Specifies number of buffers to use \\ \hline
--o \emph{file}     & --output=\emph{file}       & Prepend \emph{file} to output file name(s) \\
+-A \emph{hex-mask} & -{}-set-mask=\emph{hex-mask} & Set filter mask to \emph{hex-mask} \\ \hline
+-a \emph{mask}     & -{}-act-mask=\emph{mask}     & Add \emph{mask} to current filter (see below for masks) \\ \hline
+-b \emph{size}     & -{}-buffer-size=\emph{size}  & Specifies buffer size for event extraction (scaled by $2^{10}$) \\ \hline
+-d \emph{dev}      & -{}-dev=\emph{dev}           & Adds \emph{dev} as a device to trace \\ \hline
+-n \emph{num-sub}  & -{}-num-sub-buffers=\emph{num-sub}   & Specifies number of buffers to use \\ \hline
+-l                 & -{}-listen                   & Run in network listen mode (blktrace server) \\ \hline
+-h \emph{host}     & -{}-host=\emph{host}         & Run in network client mode, connecting to given \emph{host} \\ \hline
+-p \emph{port}     & -{}-port=\emph{port}         & Network \emph{port} to use (default 8462) \\ \hline
+-s                 & -{}-no-sendfile              & Make network client NOT use sendfile() to transfer data \\ \hline
+-o \emph{file}     & -{}-output=\emph{file}       & Prepend \emph{file} to output file name(s) \\
                    &                            & \textbf{This only works when using a single device} \\
                    &                            & \textbf{or when piping the output via \texttt{-o -}} \\
                    &                            & \textbf{with multiple devices.} \\ \hline
--r \emph{rel-path} & --relay=\emph{rel-path}    & Specifies debugfs mount point \\ \hline
--V                 & --version                  & Outputs version \\ \hline
--w \emph{seconds}  & --stopwatch=\emph{seconds} & Sets run time to the number of seconds specified \\ \hline
--I \emph{devs file}& --input-devs=\emph{devs file}& Adds devices found in \emph{devs file} to list of devices to trace. \\
+-D \emph{dir}      & -{}-output-dir=\emph{dir}    & Prepend \emph{dir} to output file name(s) \\ \hline
+-r \emph{rel-path} & -{}-relay=\emph{rel-path}    & Specifies debugfs mount point \\ \hline
+-v                 & -{}-version                  & Outputs version \\ \hline
+-V                 & -{}-version                  & Outputs version \\ \hline
+-w \emph{seconds}  & -{}-stopwatch=\emph{seconds} & Sets run time to the number of seconds specified \\ \hline
+-I \emph{devs file}& -{}-input-devs=\emph{devs file}& Adds devices found in \emph{devs file} to list of devices to trace. \\
                    &                              & (One device per line.) \\ \hline
 \end{tabular}
 
@@ -423,15 +426,19 @@ line options.\smallskip
 \begin{tabular}{|l|l|}\hline
 barrier & \emph{barrier} attribute \\ \hline
 complete & \emph{completed} by driver \\ \hline
-fs & \emph{FS} requests \\ \hline
+discard & \emph{discard} / trim request \\ \hline
+fs & \emph{FS} (file system) requests \\ \hline
 issue & \emph{issued} to driver \\ \hline
 pc & \emph{packet command} events \\ \hline
 queue & \emph{queue} operations \\ \hline
-read & \emph{read} traces \\ \hline
+read & \emph{read} requests \\ \hline
 requeue & \emph{requeue} operations \\ \hline
 sync & \emph{synchronous} attribute \\ \hline
-write & \emph{write} traces \\ \hline
+write & \emph{write} requests \\ \hline
+ahead & readahead \\ \hline
+meta & metadata \\ \hline
 notify & \emph{notify} trace messages \\ \hline
+drv\_data & additional driver specific trace \\ \hline
 \end{tabular}
 
 \subsubsection{Request types}
@@ -442,7 +449,7 @@ requests, the latter \emph{pc} requests. File system requests are
 normal read/write operations, ie any type of read or write from a
 specific disk location at a given size. These requests typically
 originate from a user process, but they may also be initiated by
-the vm flushing dirty data to disk or the file system syncing
+the vm (virtual memory) flushing dirty data to disk or the file system syncing
 a super or journal block to disk. \emph{pc} requests are SCSI
 commands. blktrace sends the command data block as a payload
 so that blkparse can decode it.
-- 
2.14.2

