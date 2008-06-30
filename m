From: Jeff Moyer <jmoyer@redhat.com>
Date: Mon, 30 Jun 2008 17:29:43 +0000
Subject: [patch] spelling and grammar fixes for btreplay.tex
Message-Id: <x4963rqrfug.fsf@segfault.boston.devel.redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Sorry for such a lame patch, but I figured if I was reading it I may as
well fix it.

Cheers,

Jeff

diff --git a/btreplay/doc/btreplay.tex b/btreplay/doc/btreplay.tex
index b4027ff..8b0ecf7 100644
--- a/btreplay/doc/btreplay.tex
+++ b/btreplay/doc/btreplay.tex
@@ -80,7 +80,7 @@ The basic operating work-flow to replay IOs would be something like:
 
   \item You extract the pertinent IO information from the traces saved by
   \texttt{blktrace} using the \texttt{btrecord} utility. This will parse
-  each trace file created by \texttt{blktrace}, and crafty IO descriptions
+  each trace file created by \texttt{blktrace}, and craft IO descriptions
   to be used in the next phase of the workload processing.
 
   \item Once \texttt{btrecord} has successfully created a series of data
@@ -157,15 +157,15 @@ Each input data file (one per device per CPU) results in a new record
 data file (again, one per device per CPU) which contains information
 about \emph{bunches} of IOs to be replayed. \texttt{btreplay} operates on
 these record data files by spawning a new pair of threads per file. One
-thread managed the submitting of AIOs per bunch in the record data file,
+thread manages the submitting of AIOs per bunch in the record data file,
 while the other thread manages reclaiming AIOs completed\footnote{We
 have found that having the same thread do both results in a further
-reduction in replay timing accuracty.}.
+reduction in replay timing accuracy.}.
 
 Each submitting thread simply reads the input file of \emph{bunches}
 recorded by \texttt{btrecord}, and attempts to faithfully reproduce the
 ordering and timing of IOs seen during the sample workload. The reclaiming
-thread simply wait for AIO completions, freeing up resources for the
+thread simply waits for AIO completions, freeing up resources for the
 submitting thread to utilize to submit new AIOs.
 
 The number of CPUs being used on the replay system can be different from
@@ -206,7 +206,7 @@ included as well.
   \begin{quote}
     \emph{The user has \emph{some} control over this (via the
     \texttt{--max-pkts} option). One \emph{could} simply specify
-    \texttt{-max-pkts=1} and then each IO would be treated individualy. Of
+    \texttt{-max-pkts=1} and then each IO would be treated individually. Of
     course, this would probably then run into the problem of excessive
     inter-IO times.}
   \end{quote}
@@ -306,7 +306,7 @@ amount of time (in nanoseconds) to include in any one bunch of IOs that
 are to be processed. The smaller the value, the smaller the number of
 IOs processed at one time -- perhaps yielding in more realistic replay.
 However, after a certain point the amount of overhead per bunch may result
-in additonal real replay time, thus yielding less accurate replay times.
+in additional real replay time, thus yielding less accurate replay times.
 
 The default value is 10,000,000 nanoseconds (10 milliseconds).
 
@@ -360,7 +360,7 @@ sdab:3: 474773 pkts (tot), 117849 pkts (replay), 69572 bunches, 1.7 pkts/bunch
 \begin{figure}[h!]
 \begin{description}
   \item[Field 1] The first field contains the device name and CPU
-  identrifer. Thus: \texttt{sdab:0:} means the device \texttt{sdab} and
+  identifier. Thus: \texttt{sdab:0:} means the device \texttt{sdab} and
   traces on CPU 0. 
 
   \item[Field 2] The second field contains the total number of packets
@@ -463,8 +463,8 @@ to run through the input files. The default value is 1.
 \subsubsection{\label{sec:p-o-M}\texttt{-M} or \texttt{map-devs}\\
 Specify Device Mappings}
 
-This option requires a single paramter which specifies the name of a
-file contain device mappings. The file must be very simply managed, with
+This option requires a single parameter which specifies the name of a
+file containing device mappings. The file must be very simply managed, with
 just two pieces of data per line:
 
 \begin{enumerate}
@@ -497,7 +497,7 @@ Pre-bunch Stalls}
 When specified on the command line, all pre-bunch stall indicators will be
 ignored. IOs will be replayed without inter-bunch delays.
 
-\subsubsection{\label{sec:o-x}\texttt{-x} or \texttt{--acc-factor}\\Accelaration
+\subsubsection{\label{sec:o-x}\texttt{-x} or \texttt{--acc-factor}\\Acceleration
 Factor}
 
   While the \texttt{--no-stalls} option allows the traces to be replayed
