From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:17 +0000
Subject: [PATCH 10/31] blktrace: doc: PDF output with bookmark structure and clickable cross references
Message-Id: <20180427130738.102806-11-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Need to extract labels from section titles as hyperref does not like this.

$ sed 's/{\(\\label{[^}]*}\)\([^}]*}\)/{\2\n\1/' -i blktrace.tex

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 doc/Makefile     |  2 +-
 doc/blktrace.tex | 64 +++++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/doc/Makefile b/doc/Makefile
index 0be44256e9e9..11ad4107ed46 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -1,4 +1,4 @@
-DOCTMP	= blktrace.log blktrace.aux blktrace.dvi
+DOCTMP	= blktrace.log blktrace.aux blktrace.dvi blktrace.out
 
 all: blktrace.pdf
 
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 4d8278e8eec4..c46e3e072be6 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -1,4 +1,5 @@
 \documentclass{article}
+\usepackage[dvipdfm,pdfborderstyle={/S/U/W 1}]{hyperref}
 
 %
 % Copyright (C) 2005, 2006 Alan D. Brunelle <Alan.Brunelle@hp.com>
@@ -26,7 +27,8 @@
 \begin{document}
 \maketitle
 %---------------------
-\section{\label{sec:intro}Introduction}
+\section{Introduction}
+\label{sec:intro}
 
 blktrace is a block layer IO tracing mechanism which provides detailed
 information about request queue operations up to user space. There are
@@ -54,13 +56,15 @@ as part of the following git repository:
 git://git.kernel.org/pub/scm/linux/kernel/git/axboe/blktrace.git bt
 
 %--------------------------
-\newpage\section{\label{sec:quick-start}Quick Start Guide}
+\newpage\section{Quick Start Guide}
+\label{sec:quick-start}
 
 The following sections outline some quick steps towards utilizing
 blktrace. Some of the specific instructions below may need to be tailored
 to your environment.
 
-\subsection{\label{sec:get-blktrace}Retrieving blktrace}
+\subsection{Retrieving blktrace}
+\label{sec:get-blktrace}
 
 As noted above, the kernel patch along with the blktrace and blkparse utilities are stored in a git repository. One simple way to get going would be:
 
@@ -70,7 +74,8 @@ As noted above, the kernel patch along with the blktrace and blkparse utilities
 % git checkout
 \end{verbatim}
 
-\subsection{\label{sec:patching}Patching and configuring the Linux kernel}
+\subsection{Patching and configuring the Linux kernel}
+\label{sec:patching}
 
 A patch for a \emph{specific Linux kernel} is provided in bt/kernel (where
 \emph{bt} is the name of the directory from the above git sequence). The
@@ -104,7 +109,8 @@ and then down to \emph{Support for tracing block io actions} and hit Y.
 
 Install the new kernel (and modules\ldots) and reboot. 
 
-\subsection{\label{sec:mount}Mounting the debugfs file system}
+\subsection{Mounting the debugfs file system}
+\label{sec:mount}
 
 blktrace utilizes files under the debug file system, and thus must have
 the mount point set up -- mounted on the directory /sys/kernel/debug.
@@ -124,7 +130,8 @@ debug /sys/kernel/debug debugfs default 0 0
 \end{verbatim}
 \end{enumerate}
 
-\subsection{\label{sec:build}Build the tools}
+\subsection{Build the tools}
+\label{sec:build}
 
 To build and install the tools, execute the following sequence (as root):
 
@@ -133,7 +140,8 @@ To build and install the tools, execute the following sequence (as root):
 % make && make install
 \end{verbatim}
 
-\subsection{\label{sec:live-blktrace}blktrace -- live}
+\subsection{blktrace -- live}
+\label{sec:live-blktrace}
 
 Now to simply watch what is going on for a specific disk (to stop the
 trace, hit control-C):
@@ -194,7 +202,8 @@ By default, \emph{btrace} runs the trace in quiet mode so it will not
 include statistics when you break the run. Add the \emph{-S} option to
 get that dumped as well.
 
-\subsection{\label{sec:pc-blktrace}blktrace -- SCSI commands}
+\subsection{blktrace -- SCSI commands}
+\label{sec:pc-blktrace}
 
 The previous section showed typical file system io actions, but blktrace
 can also show SCSI commands going in and out of the queue as submitted
@@ -217,7 +226,8 @@ that the command completed successfully. Tracing SCSI commands can be
 very useful for debugging problems with programs talking directly to the
 device. An example of that would be \emph{cdrecord} burning.
 
-\subsection{\label{sec:blktrace-post}blktrace -- post-processing}
+\subsection{blktrace -- post-processing}
+\label{sec:blktrace-post}
 
 Another way to run blktrace is to have blktrace save data away for later
 formatting by blkparse. This would be useful if you want to get 
@@ -330,7 +340,8 @@ Total (65,160):
 \end{verbatim}
 
 %----------------------------
-\newpage\section{\label{sec:blktrace-ug}blktrace User Guide}
+\newpage\section{blktrace User Guide}
+\label{sec:blktrace-ug}
 
 The \emph{blktrace} utility extracts event traces from the kernel (via
 the relaying through the debug file system). Some background details
@@ -380,7 +391,8 @@ of the more arcane command line options:
   \end{enumerate}
 \end{itemize}
 
-\subsection{\label{sec:blktrace-args}Command line arguments}
+\subsection{Command line arguments}
+\label{sec:blktrace-args}
 \begin{tabular}{|l|l|l|}\hline
 Short              & Long                       & Description \\ \hline\hline
 -A \emph{hex-mask} & --set-mask=\emph{hex-mask} & Set filter mask to \emph{hex-mask} \\ \hline
@@ -400,7 +412,8 @@ Short              & Long                       & Description \\ \hline\hline
                    &                              & (One device per line.) \\ \hline
 \end{tabular}
 
-\subsubsection{\label{sec:filter-mask}Filter Masks}
+\subsubsection{Filter Masks}
+\label{sec:filter-mask}
 The following masks may be passed with the \emph{-a} command line
 option, multiple filters may be combined via multiple \emph{-a} command
 line options.\smallskip
@@ -419,7 +432,8 @@ write & \emph{write} traces \\ \hline
 notify & \emph{notify} trace messages \\ \hline
 \end{tabular}
 
-\subsubsection{\label{sec:request-types}Request types}
+\subsubsection{Request types}
+\label{sec:request-types}
 blktrace disguingishes between two types of block layer requests,
 file system and scsi commands. The former are dubbed \emph{fs}
 requests, the latter \emph{pc} requests. File system requests are
@@ -432,7 +446,8 @@ commands. blktrace sends the command data block as a payload
 so that blkparse can decode it.
 
 %----------------------------
-\newpage\section{\label{sec:blkparse-ug}blkparse User Guide}
+\newpage\section{blkparse User Guide}
+\label{sec:blkparse-ug}
 
 The \emph{blkparse} utility will attempt to combine streams of events
 for various devices on various CPUs, and produce a formatted output of
@@ -470,7 +485,8 @@ will help in understanding the command line options presented below.
 
 \end{itemize}
 
-\newpage\subsection{\label{sec:blkparse-args}Command line arguments}
+\newpage\subsection{Command line arguments}
+\label{sec:blkparse-args}
 \begin{tabular}{|l|l|l|}\hline
 Short              & Long                       & Description \\ \hline\hline
 -b \emph{batch}    & --batch={batch}            & Standard input read batching \\ \hline
@@ -517,7 +533,8 @@ Short              & Long                       & Description \\ \hline\hline
 \end{tabular}
 
 \newpage
-\subsection{\label{sec:blkparse-actions}Trace actions}
+\subsection{Trace actions}
+\label{sec:blkparse-actions}
 
 \begin{description}
   \item[C -- complete] A previously issued request has been completed.
@@ -583,7 +600,8 @@ Short              & Long                       & Description \\ \hline\hline
 
 \end{description}
 
-\subsection{\label{sec:blkparse-format}Output Description and Formatting}
+\subsection{Output Description and Formatting}
+\label{sec:blkparse-format}
 
 The output from blkparse can be tailored for specific use - in particular,
 to ease parsing of output, and/or limit output fields to those the user
@@ -627,7 +645,8 @@ Thus, to specify the command in a 12-character field that is left aligned:
 \end{verbatim}
 
 \newpage
-\subsubsection{\label{sec:act-table}Action Table}
+\subsubsection{Action Table}
+\label{sec:act-table}
 The following table shows the various actions which may be output.
 
 \begin{tabular}{|l|l|}\hline
@@ -648,12 +667,14 @@ U & Unplug request \\ \hline
 X & Split \\ \hline
 \end{tabular}
 
-\subsubsection{\label{sec:act-table}RWBS Description}
+\subsubsection{RWBS Description}
+\label{sec:act-table}
 This is a small string containing at least one character ('R' for read,
 'W' for write, or 'D' for block discard operation), and optionally either
 a 'B' (for barrier operations) or 'S' (for synchronous operations).
 
-\subsubsection{\label{sec:default-output}Default output}
+\subsubsection{Default output}
+\label{sec:default-output}
 
 The standard \emph{header} (or initial fields displayed) include:
 
@@ -736,7 +757,8 @@ The default output for all event types includes this header.
 
 %------------------------------
 \newpage
-\newpage\section*{\label{sec:blktrace-kg}Appendix: blktrace Kernel Guide}
+\newpage\section*{Appendix: blktrace Kernel Guide}
+\label{sec:blktrace-kg}
 
 The blktrace facility provides an efficient event transfer mechanism which
 supplies block IO layer state transition data via the relay
-- 
2.14.2

