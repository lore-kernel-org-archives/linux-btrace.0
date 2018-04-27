From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:08 +0000
Subject: [PATCH 01/31] btt: doc: PDF output with bookmark structure and clickable cross references
Message-Id: <20180427130738.102806-2-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Need to extract labels from section titles as hyperref does not like this.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 btt/doc/Makefile |   2 +-
 btt/doc/btt.tex  | 142 +++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 96 insertions(+), 48 deletions(-)

diff --git a/btt/doc/Makefile b/btt/doc/Makefile
index 2e6fd88432c6..cf4fab61e87c 100644
--- a/btt/doc/Makefile
+++ b/btt/doc/Makefile
@@ -1,4 +1,4 @@
-DOCTMP	= btt.log btt.aux btt.dvi btt.toc btt.tex.bak
+DOCTMP	= btt.log btt.aux btt.dvi btt.toc btt.tex.bak btt.out
 
 all: btt.pdf
 
diff --git a/btt/doc/btt.tex b/btt/doc/btt.tex
index a3d190bb9b74..dbd1fde612d4 100644
--- a/btt/doc/btt.tex
+++ b/btt/doc/btt.tex
@@ -1,5 +1,6 @@
 \documentclass{article}
 \usepackage{epsfig,placeins}
+\usepackage[dvipdfm,pdfborderstyle={/S/U/W 1}]{hyperref}
 
 %
 % Copyright (C) 2007-2009 Alan D. Brunelle <Alan.Brunelle@hp.com>
@@ -27,7 +28,8 @@
 \begin{document}
 \maketitle
 %--------------
-\section{\label{sec:intro}Introduction}
+\section{Introduction}
+\label{sec:intro}
 
 \texttt{btt} is a post-processing tool for the block layer IO tracing
 tool called blktrace. As noted in its Users Guide, blktrace
@@ -63,7 +65,8 @@ easier.
 
 \newpage\tableofcontents
 
-\newpage\section{\label{sec:getting-started}Getting Started}
+\newpage\section{Getting Started}
+\label{sec:getting-started}
 
   The simple pipeline to get going with \texttt{btt} is to perform the
   following steps:
@@ -99,7 +102,8 @@ easier.
 
   \end{enumerate}
 
-\newpage\section{\label{sec:output-overview}Output Overview}
+\newpage\section{Output Overview}
+\label{sec:output-overview}
 
   The major default areas of output provided by \texttt{btt}
   include\label{tl-defs}:
@@ -372,7 +376,8 @@ IO\footnote{It should be noted that incoming requests either go through:
 \end{description}
 
 \newpage
-\subsection*{\label{sec:detailed-data}Detailed Data}
+\subsection*{Detailed Data}
+\label{sec:detailed-data}
 
   In addition to the default sections output, if one supplies the
   \texttt{--all-data} or \texttt{-A} argument (see section~\ref{sec:o-A})
@@ -451,7 +456,8 @@ pdflush       0.000000790 0.000006752 0.247231307  179791
 
 \end{description}
 
-\newpage\section{\label{sec:data-files}Data Files Output}
+\newpage\section{Data Files Output}
+\label{sec:data-files}
 
   Besides the averages output by default, the following 5(+) files are also
   created with data points which may be plotted.
@@ -509,7 +515,8 @@ pdflush       0.000000790 0.000006752 0.247231307  179791
     Section~\ref{sec:o-u} has more details.
   \end{description}
 
-\newpage\section{\label{sec:activity}Activity Data File}
+\newpage\section{Activity Data File}
+\label{sec:activity}
 
   The activity data file contains a series of data values that indicate
   those periods of time when queue and complete traces are being
@@ -585,7 +592,8 @@ pdflush       0.000000790 0.000006752 0.247231307  179791
   low, it represents an extended period of time where no queue requests
   were coming in. Similarly for the red line and C activity.
 
-\newpage\section{\label{sec:hist}Histogram Data Files}
+\newpage\section{Histogram Data Files}
+\label{sec:hist}
 
   The histogram data files provide information concerning incoming and
   outgoing IO sizes (in blocks). For simplicity, the histogram buckets
@@ -600,7 +608,8 @@ pdflush       0.000000790 0.000006752 0.247231307  179791
   The first column (X values) is the various IO sizes, and the second
   column (Y values) represents the number of IOs of that size.
 
-\subsection*{\label{sec:qhist}Q Histogram Data File}
+\subsection*{Q Histogram Data File}
+\label{sec:qhist}
 
   Figure~\ref{fig:qhist} is a sample graph generated from data used during
   some real-world analysis\footnote{Note the logarithmic nature of the
@@ -616,7 +625,8 @@ pdflush       0.000000790 0.000006752 0.247231307  179791
   \caption{\label{fig:qhist}Q Histogram}
   \end{figure}
 
-\subsection*{\label{sec:dhist}D Histogram Data File}
+\subsection*{D Histogram Data File}
+\label{sec:dhist}
 
   Figure~\ref{fig:dhist} is a sample graph generated from data used during
   some real-world analysis\footnote{Note the logarithmic nature of the
@@ -631,7 +641,8 @@ pdflush       0.000000790 0.000006752 0.247231307  179791
   \caption{\label{fig:dhist}D Histogram}
   \end{figure}
 
-\newpage\section{\label{sec:rstat}Running Stats Files}
+\newpage\section{Running Stats Files}
+\label{sec:rstat}
 
 There are two files produced for each of all devices being traced
 (prefixed with \emph{sys\_}) and per-device (prefixed with the device
@@ -668,7 +679,8 @@ figure~\ref{fig:rstats}).
   \caption{\label{fig:rstats}Running Stats}
   \end{figure}
 
-\newpage\section{\label{sec:iostat}iostat Data File}
+\newpage\section{iostat Data File}
+\label{sec:iostat}
   \texttt{btt} attempts to produce the results from running an
   \texttt{iostat -x} command in parallel with the system as it is being
   traced. The fields (columns) generated by the \texttt{--iostat} or
@@ -689,7 +701,8 @@ Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s
   Note that the STAMP field contains the runtime (in seconds) for that
   line of data.
 
-\newpage\section{\label{sec:per-io}Per-IO Data File}
+\newpage\section{Per-IO Data File}
+\label{sec:per-io}
 
   \texttt{btt} can produce a text file containing time line data for each
   IO processed. The time line data contains rudimentary information for
@@ -746,7 +759,8 @@ Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s
     \item start block + number of blocks
   \end{enumerate}
  
-\newpage\section{\label{sec:lat}\label{sec:lat-q2d}\label{sec:lat-q2c}\label{sec:lat-d2c}Latency Data Files}
+\newpage\section{Latency Data Files}
+\label{sec:lat}\label{sec:lat-q2d}\label{sec:lat-q2c}\label{sec:lat-d2c}
 
   The latency data files which can be optionally produced by \texttt{btt}
   provide per-IO latency information, one for queue time (Q2D), one
@@ -757,7 +771,8 @@ Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s
   while the second column (Y values) shows the actual latency for a
   command at that time (either Q2D, D2C or Q2C).
 
-\newpage\section{\label{sec:seek}Seek Data Files}
+\newpage\section{Seek Data Files}
+\label{sec:seek}
 
   \texttt{btt} can also produce two data files containing all IO-to-IO sector
   deltas, providing seek information which can then be plotted. The
@@ -834,7 +849,8 @@ Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s
     between the end of the previous IO and the start of this IO.
   \end{description}
 
-\newpage\subsection{\label{sec:sps-spec}Seeks Per Second}
+\newpage\subsection{Seeks Per Second}
+\label{sec:sps-spec}
 
   When the \texttt{-m} option provides a name, Q2Q and/or D2D seeks
   will trigger \texttt{btt} to output seeks-per-second information. The
@@ -869,7 +885,8 @@ Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s
   \end{figure}
   \FloatBarrier
 
-\newpage\section{\label{sec:cmd-line}Command Line}
+\newpage\section{Command Line}
+\label{sec:cmd-line}
 
 \begin{verbatim}
 Usage: btt 2.09
@@ -904,7 +921,8 @@ Usage: btt 2.09
 [ -Z               | --do-active
 \end{verbatim}
 
-\subsection{\label{sec:o-a}\texttt{--seek-absolute}/\texttt{-a}}
+\subsection{\texttt{--seek-absolute}/\texttt{-a}}
+\label{sec:o-a}
 
   When specified on the command line, this directs btt to calculate
   seek distances based solely upon the ending block address of one IO,
@@ -912,14 +930,16 @@ Usage: btt 2.09
   of the closeness to either the beginning or end of the previous IO. See
   section~\ref{sec:seek} for more details about seek distances.
 
-\subsection{\label{sec:o-A}\texttt{--all-data}/\texttt{-A}}
+\subsection{\texttt{--all-data}/\texttt{-A}}
+\label{sec:o-A}
 
   Normally \texttt{btt} will not print out verbose information
   concerning per-process and per-device data (as outlined in
   section~\ref{sec:detailed-data}). If you desire that level of
   detail you can specify this option.
 
-\subsection{\label{sec:o-B}\texttt{--dump-blocknos}/\texttt{-B}}
+\subsection{\texttt{--dump-blocknos}/\texttt{-B}}
+\label{sec:o-B}
 
   This option will output absolute block numbers to three files prefixed
   by the specified output name:
@@ -938,7 +958,8 @@ Usage: btt 2.09
     the block number, and the third column is the ending block number.
   \end{description}
 
-\subsection{\label{sec:o-d}\texttt{--range-delta}/\texttt{-d}}
+\subsection{\texttt{--range-delta}/\texttt{-d}}
+\label{sec:o-d}
 
   Section~\ref{sec:activity} discussed how \texttt{btt} outputs a file
   containing Q and C activity, the notion of \emph{active} traces simply
@@ -947,7 +968,8 @@ Usage: btt 2.09
   allowing one to change that granularity. The smaller the value, the
   more data points provided.
 
-\subsection{\label{sec:o-D}\texttt{--devices}/\texttt{-D}}
+\subsection{\texttt{--devices}/\texttt{-D}}
+\label{sec:o-D}
 
   Normally, \texttt{btt} will produce data for all devices detected in
   the traces parsed. With this option, one can reduce the analysis to
@@ -956,7 +978,8 @@ Usage: btt 2.09
   each device identifier is separated by a colon (:). A valid specifier
   for devices 8,0 and 8,8 would then be: \texttt{"8,0:8,8"}.
 
-\subsection{\label{sec:o-e}\texttt{--exes}/\texttt{-e}}
+\subsection{\texttt{--exes}/\texttt{-e}}
+\label{sec:o-e}
 
   Likewise, \texttt{btt} will produce data for all processes (executables)
   found in the traces. With this option, one can specify which processes
@@ -964,35 +987,41 @@ Usage: btt 2.09
   a list of executable \emph{names} separated by commas (,). An example
   would be \texttt{"-e mkfs.ext3,mount"}.
 
-\subsection{\label{sec:o-h}\texttt{--help}/\texttt{-h}}
+\subsection{\texttt{--help}/\texttt{-h}}
+\label{sec:o-h}
 
   Prints out the simple help information, as seen at the top of
   section~\ref{sec:cmd-line}.
 
-\subsection{\label{sec:o-i}\texttt{--input-file}/\texttt{-i}}
+\subsection{\texttt{--input-file}/\texttt{-i}}
+\label{sec:o-i}
 
   Specifies the binary input file that \texttt{btt} will interpret traces
   in. See section~\ref{sec:getting-started} for information concerning
   binary trace files.
 
-\subsection{\label{sec:o-I}\texttt{--iostat}/\texttt{-I}}
+\subsection{\texttt{--iostat}/\texttt{-I}}
+\label{sec:o-I}
 
   This option triggers \texttt{btt} to generate iostat-like output to the
   file specified. Refer to section~\ref{sec:iostat} for more information
   on the output produced.
 
-\subsection{\label{sec:o-l}\texttt{--d2c-latencies}/\texttt{-l}}
+\subsection{\texttt{--d2c-latencies}/\texttt{-l}}
+\label{sec:o-l}
 
   This option instructs \texttt{btt} to generate the D2C latency file
   discussed in section~\ref{sec:lat-d2c}.
 
-\subsection{\label{sec:o-L}\texttt{--periodic-latencies}/\texttt{-L}}
+\subsection{\texttt{--periodic-latencies}/\texttt{-L}}
+\label{sec:o-L}
 
   When given a value greater than 0, this option will create two data
   files (q2c \& d2c) per device containing a periodic timestamp \&
   average latency over that period.
 
-\subsection{\label{sec:o-m}\texttt{--seeks-per-second}\texttt{-m}}
+\subsection{\texttt{--seeks-per-second}\texttt{-m}}
+\label{sec:o-m}
 
   Tells \texttt{btt} to output seeks per second information.  Each device
   being measured can have up to 2 files output: One with Q2Q information
@@ -1004,33 +1033,39 @@ Usage: btt 2.09
     section~\ref{sec:seek}.}
   \end{quote}
 
-\subsection{\label{sec:o-M}\texttt{--dev-maps}/\texttt{-M}}
+\subsection{\texttt{--dev-maps}/\texttt{-M}}
+\label{sec:o-M}
 
   Internal option, still under construction.
 
-\subsection{\label{sec:o-o}\texttt{--output-file}/\texttt{-o}}
+\subsection{\texttt{--output-file}/\texttt{-o}}
+\label{sec:o-o}
 
   Normally \texttt{btt} sends the statistical output (covered in
   section~\ref{sec:output-overview}) to standard out, if you specify
   this option this data is redirected to the file specified.
 
-\subsection{\label{sec:o-p}\texttt{--per-io-dump}/\texttt{-p}}
+\subsection{\texttt{--per-io-dump}/\texttt{-p}}
+\label{sec:o-p}
 
   This option tells \texttt{btt} to generate the per IO dump file as
   discussed in section~\ref{sec:per-io}.
 
-\subsection{\label{sec:o-P}\texttt{--per-io-tress}/\texttt{-P}}
+\subsection{\texttt{--per-io-tress}/\texttt{-P}}
+\label{sec:o-P}
 
 The \texttt{-P} option will generate a file that contains a list of all IO
 "sequences" - showing only the Q, D \& C operation times. The D \& C
 time values are separated from the Q time values with a vertical bar.
 
-\subsection{\label{sec:o-q}\texttt{--q2c-latencies}/\texttt{-q}}
+\subsection{\texttt{--q2c-latencies}/\texttt{-q}}
+\label{sec:o-q}
 
   This option instructs \texttt{btt} to generate the Q2C latency file
   discussed in section~\ref{sec:lat-q2c}.
 
-\subsection{\label{sec:o-Q}\texttt{--active-queue-depth}/\texttt{-Q}}
+\subsection{\texttt{--active-queue-depth}/\texttt{-Q}}
+\label{sec:o-Q}
 
   This option tells \texttt{btt} to generate a data file (using the given
   name as a base) which contains: A time stamp in the first column,
@@ -1038,16 +1073,19 @@ time values are separated from the Q time values with a vertical bar.
   driver. (The value is incremented when an \emph{issue} is performend,
   and decremented when a \emph{complete} is performed.
 
-\subsection{\label{sec:o-r}\texttt{--no-remaps}/\texttt{-r}}
+\subsection{\texttt{--no-remaps}/\texttt{-r}}
+\label{sec:o-r}
 
   Ignore remap traces; older kernels did not implement the full remap PDU.
 
-\subsection{\label{sec:o-s}\texttt{--seeks}/\texttt{-s}}
+\subsection{\texttt{--seeks}/\texttt{-s}}
+\label{sec:o-s}
 
   This option instructs \texttt{btt} to generate the seek data file
   discussed in section~\ref{sec:seek}.
 
-\subsection{\label{sec:o-S}\texttt{--iostat-interval}/\texttt{-S}}
+\subsection{\texttt{--iostat-interval}/\texttt{-S}}
+\label{sec:o-S}
 
   The normal \texttt{iostat} command allows one to specify the snapshot
   interval, likewise, \texttt{btt} allows one to specify how many seconds
@@ -1055,8 +1093,9 @@ time values are separated from the Q time values with a vertical bar.
   about the iostat-like capabilities of \texttt{btt} may be found in
   section~\ref{sec:iostat}.
 
-\subsection{\label{sec:o-tT}\texttt{--time-start}/\texttt{-t} and
+\subsection{\texttt{--time-start}/\texttt{-t} and
 \texttt{--time-end}/\texttt{T}}
+\label{sec:o-tT}
 
   \begin{quote}
     \emph{This \texttt{btt} capability is still under construction, results are
@@ -1068,7 +1107,8 @@ time values are separated from the Q time values with a vertical bar.
   trace chosen will be between the start time (or 0.0 if not
   specified) and end time (or the end of the run) specified.
 
-\subsection{\label{sec:o-u}\texttt{--unplug-hist}/\texttt{-u}}
+\subsection{\texttt{--unplug-hist}/\texttt{-u}}
+\label{sec:o-u}
 
   This option instructs \texttt{btt} to generate a data file containing
   histogram information for \emph{unplug} traces on a per device
@@ -1093,11 +1133,13 @@ time values are separated from the Q time values with a vertical bar.
   form, with a \texttt{.dat} extension (as an example, with \texttt{-u
   up\_hist} specified on the command line: \texttt{up\_hist\_008,032.dat}.
 
-\subsection{\label{sec:o-V}\texttt{--version}/\texttt{-V}}
+\subsection{\texttt{--version}/\texttt{-V}}
+\label{sec:o-V}
 
   Prints out the \texttt{btt} version, and exits.
 
-\subsection{\label{sec:o-v}\texttt{--verbose}/\texttt{-v}}
+\subsection{\texttt{--verbose}/\texttt{-v}}
+\label{sec:o-v}
 
   While \texttt{btt} is processing data, it will put out periodic (1-second
   granularity) values describing the progress it is making through the
@@ -1120,7 +1162,8 @@ Sending stats data to bttX.avg
 16.379036+0.000005.379041
 \end{verbatim}
 
-\subsection{\label{sec:o-X}\texttt{--easy-parse-avgs}/\texttt{-X}}
+\subsection{\texttt{--easy-parse-avgs}/\texttt{-X}}
+\label{sec:o-X}
 
   \emph{Some} of the data produced by default can also be shipped
   simultaneously to another file in an easy to parse form. When
@@ -1182,12 +1225,14 @@ UPG 8,16 1.993361748 1.866492147
 ARQ 8,16 12.938165321
   \end{verbatim}
 
-\subsection{\label{sec:o-z}\texttt{--q2d-latencies}/\texttt{-z}}
+\subsection{\texttt{--q2d-latencies}/\texttt{-z}}
+\label{sec:o-z}
 
   This option instructs \texttt{btt} to generate the Q2D latency file
   discussed in section~\ref{sec:lat-q2d}.
 
-\subsection{\label{sec:o-Z}\texttt{--q2d-latencies}/\texttt{-Z}}
+\subsection{\texttt{--q2d-latencies}/\texttt{-Z}}
+\label{sec:o-Z}
 
   This option generates per-device (and total system) data files. Each
   file contain a data line which resembles a timing graph: low meaning
@@ -1216,7 +1261,8 @@ ARQ 8,16 12.938165321
 \caption{\label{fig:live_plot}Sample graph using data from \texttt{-Z}}
 \end{figure}
 
-\newpage\section{\label{sec:bno_plot}bno\_plot.py}
+\newpage\section{bno\_plot.py}
+\label{sec:bno_plot}
 
 Included with the distribution is a simple 3D plotting utility based
 upon the block numbers output when \texttt{-B} is specified (see
@@ -1268,11 +1314,13 @@ prompt.
 \end{figure}
 
 \clearpage
-\newpage\section{\label{sec:appendix}Sample \texttt{btt}
+\newpage\section{Sample \texttt{btt}
 Output}
+\label{sec:appendix}
   Here is a complete output file from a btt run, illustrating a lot of the
   capabilities of btt.
 \input{sample-btt-output.tex}
 
 \end{document}
-\subsection{\label{sec:o-B}\texttt{--dump-blocknos}/\texttt{-B}}
+\subsection{\texttt{--dump-blocknos}/\texttt{-B}}
+\label{sec:o-B}
-- 
2.14.2

