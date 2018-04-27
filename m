From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:20 +0000
Subject: [PATCH 13/31] blktrace: doc: blkparse: sync fixes from man page updates
Message-Id: <20180427130738.102806-14-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 doc/blktrace.tex | 209 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 129 insertions(+), 80 deletions(-)

diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 107aa34eb8c9..06de4be1a64b 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -460,7 +460,13 @@ so that blkparse can decode it.
 
 The \emph{blkparse} utility will attempt to combine streams of events
 for various devices on various CPUs, and produce a formatted output of
-the event information. As with blktrace, some details concerning blkparse
+the event information.
+
+If one or more optional positional arguments \emph{file} are provided,
+they serve as device names of input files. See also -i,-{}-input option
+in section OPTIONS below.
+
+As with blktrace, some details concerning blkparse
 will help in understanding the command line options presented below.
 
 \begin{itemize}
@@ -477,7 +483,7 @@ will help in understanding the command line options presented below.
   % blktrace -d /dev/sda -o - | blkparse -i -
   \end{verbatim}
 
-  \item You can set how many blkparse batches event reads via the
+  \item You can set how many event reads blkparse batches via the
   \emph{-b} option, the default is to handle events in batches of 512.
 
   \item If you have saved event traces in blktrace with different output
@@ -487,57 +493,58 @@ will help in understanding the command line options presented below.
   \item The format of the output data can be controlled via the \emph{-f}
   or \emph{-F} options -- see section~\ref{sec:blkparse-format} for details.
 
-  By default, blkparse sends formatted data to standard output. This may
-  be changed via the \emph{-o} option, or text output can be disabled
-  via the\emph{-O} option. A merged binary stream can be produced using
-  the \emph{-d} option.
-
 \end{itemize}
 
+By default, blkparse sends formatted data to standard output. This may
+be changed via the \emph{-o} option, or text output can be disabled
+via the \emph{-O} option. A merged binary stream used by iowatcher(1)
+can be produced using
+the \emph{-d} option.
+
 \newpage\subsection{Command line arguments}
 \label{sec:blkparse-args}
 \begin{tabular}{|l|l|l|}\hline
 Short              & Long                       & Description \\ \hline\hline
--b \emph{batch}    & --batch={batch}            & Standard input read batching \\ \hline
+-A \emph{hex-mask} & -{}-set-mask=\emph{hex-mask} & Set filter mask to \emph{hex-mask}, see section~\ref{sec:filter-mask} \\ \hline
+-a \emph{mask}     & -{}-act-mask=\emph{mask}     & Add \emph{mask} to current filter, see section~\ref{sec:filter-mask} \\ \hline
+-D \emph{dir}      & -{}-input-directory=\emph{dir} & Prepend \emph{dir} to input file names \\ \hline
+-b \emph{batch}    & -{}-batch=\emph{batch}         & Standard input read batching \\ \hline
 
--i \emph{file}     & --input=\emph{file}        & Specifies base name for input files -- default is \emph{device}.blktrace.\emph{cpu}. \\
+-i \emph{file}     & -{}-input=\emph{file}        & Specifies base name for input files -- default is \emph{device}.blktrace.\emph{cpu}. \\
                    &                            & As noted above, specifying \emph{-i -} runs in \emph{live} mode with blktrace \\
 		   &                            & (reading data from standard in). \\ \hline
 
--F \emph{typ,fmt}  & --format=\emph{typ,fmt}    & Sets output format \\
--f \emph{fmt}      & --format-spec=\emph{fmt}   & (See section~\ref{sec:blkparse-format} for details.) \\ 
-                   &                            & \\
-		   &                            & The -f form specifies a format for all events \\
+-F \emph{typ,fmt}  & -{}-format=\emph{typ,fmt}    & Sets output format \\
+-f \emph{fmt}      & -{}-format-spec=\emph{fmt}   & (See section~\ref{sec:blkparse-format} for details.) \\
                    &                            & \\
 		   &                            & The -F form allows one to specify a format for a specific \\
 		   &                            & event type. The single-character \emph{typ} field is one of the \\
-		   &                            & action specifiers in section~\ref{sec:act-table} \\ \hline
-
-
--m                 & --missing                  & Print missing entries\\ \hline
+		   &                            & action specifiers in section~\ref{sec:act-table} \\
+                   &                            & \\
+		   &                            & The -f form specifies a common format for all events \\ \hline
 
--h                 & --hash-by-name             & Hash processes by name, not by PID\\ \hline
+-h                 & -{}-hash-by-name             & Hash processes by name, not by PID\\ \hline
 
--o \emph{file}     & --output=\emph{file}       & Output file \\ \hline
--O                 & --no-text-output           & Do \emph{not} produce text output, used for binary (-d) only \\ \hline
+-o \emph{file}     & -{}-output=\emph{file}       & Output file \\ \hline
+-O                 & -{}-no-text-output           & Do \emph{not} produce text output, used for binary (-d) only \\ \hline
 
--d \emph{file}     & --dump-binary=\emph{file}  & Binary output file \\ \hline
+-d \emph{file}     & -{}-dump-binary=\emph{file}  & Binary output file used by iowatcher(1) \\ \hline
 
--q                 & --quiet                    & Quite mode \\ \hline
+-q                 & -{}-quiet                    & Quiet mode \\ \hline
 
--s                 & --per-program-stats        & Displays data sorted by program \\ \hline
+-s                 & -{}-per-program-stats        & Displays data sorted by program \\ \hline
 
--t                 & --track-ios                & Display time deltas per IO \\ \hline
+-t                 & -{}-track-ios                & Display time deltas per IO \\ \hline
 
--w \emph{span}     & --stopwatch=\emph{span}    & Display traces for the \emph{span} specified -- where span can be: \\ 
+-w \emph{span}     & -{}-stopwatch=\emph{span}    & Display traces for the \emph{span} specified -- where span can be: \\
                    &                            & \emph{end-time} -- Display traces from time 0 through \emph{end-time} (in ns) \\
 		   &                            & or \\
 		   &                            & \emph{start:end-time} -- Display traces from time \emph{start} \\
 		   &                            & through {end-time} (in ns). \\ \hline
 
--M                 & --no-msgs                  & Do not add messages to binary output file \\\hline
--v                 & --verbose                  & More verbose marginal on marginal errors \\ \hline
--V                 & --version                  & Display version \\ \hline
+-M                 & -{}-no-msgs                  & Do not add messages to binary output file (-d) \\\hline
+-v                 & -{}-verbose                  & More verbose marginal on marginal errors \\ \hline
+-V                 & -{}-version                  & Display version \\ \hline
 
 \end{tabular}
 
@@ -550,6 +557,8 @@ Short              & Long                       & Description \\ \hline\hline
   The output will detail the sector and size of that request, as well
   as the success or failure of it.
 
+  \item[R -- requeued] IO requeued.
+
   \item[D -- issued] A request that previously resided on the block layer
   queue or in the io scheduler has been sent to the driver.
 
@@ -568,7 +577,8 @@ Short              & Long                       & Description \\ \hline\hline
   with an IOMMU.
 
   \item[m -- message] Text message generated via kernel call to
-  \texttt{blk\_add\_trace\_msg}.
+  \texttt{blk\_add\_trace\_msg} from e.g.\ CFQ I/O scheduler or written to
+  /sys/\linebreak[0]kernel/\linebreak[0]debug/\linebreak[0]block/\linebreak[0]\emph{dev}/\linebreak[0]msg.
 
   \item[M -- back merge] A previously inserted request exists that ends
   on the boundary of where this io begins, so the io scheduler can merge
@@ -603,7 +613,8 @@ Short              & Long                       & Description \\ \hline\hline
   normal boundary conditions. dm is notably bad at this and will clone
   lots of io.
 
-  \item[A -- remap] For stacked devices, incoming io is remapped to device
+  \item[A -- remap] For stacked devices (incl.\ partitions),
+  incoming io is remapped to device
   below it in the io stack. The remap action details what exactly is
   being remapped to what.
 
@@ -612,45 +623,64 @@ Short              & Long                       & Description \\ \hline\hline
 \subsection{Output Description and Formatting}
 \label{sec:blkparse-format}
 
-The output from blkparse can be tailored for specific use - in particular,
+The output from blkparse can be tailored for specific use -- in particular,
 to ease parsing of output, and/or limit output fields to those the user
-wants to see. The data for fields which can be output include:
+wants to see.
+It accepts the following subset similar to a C printf format string.
+The data for fields which can be output include:
 
 \smallskip
 \begin{tabular}{|l|l|}\hline
 Field    & Description \\
 Specifier & \\ \hline\hline
-\emph{a} & Action, a (small) string (1 or 2 characters) -- see table below for more details \\ \hline
-\emph{c} & CPU id \\ \hline
-\emph{C} & Command \\ \hline
-\emph{d} & RWBS field, a (small) string (1-3 characters)  -- see section below for more details \\ \hline
+\emph{a} & Action, a (small) string (1 or 2 characters) -- see section~\ref{sec:act-table} \\ \hline
+\emph{c} & CPU id, decimal integer \\ \hline
+\emph{C} & Command, a string with the process name \\ \hline
+\emph{d} & RWBS field, a (small) string (1-3 characters)  -- see section~\ref{sec:rwbs} \\ \hline
 \emph{D} & 7-character string containing the major and minor numbers of
-the event's device \\
-         & (separated by a comma). \\ \hline
-\emph{e} & Error value \\ \hline
-\emph{m} & Minor number of event's device. \\ \hline
-\emph{M} & Major number of event's device. \\ \hline
-\emph{n} & Number of blocks \\ \hline
-\emph{N} & Number of bytes \\ \hline
-\emph{p} & Process ID \\ \hline
-\emph{P} & Display packet data -- series of hexadecimal values\\ \hline
-\emph{s} & Sequence numbers \\ \hline
-\emph{S} & Sector number \\ \hline
-\emph{t} & Time stamp (nanoseconds) \\ \hline
-\emph{T} & Time stamp (seconds) \\ \hline
-\emph{u} & Elapsed value in microseconds (\emph{-t} command line option) \\ \hline
-\emph{U} & Payload unsigned integer \\ \hline
+the \\
+         & event's device (separated by a comma). \\ \hline
+\emph{e} & Error value, decimal integer \\ \hline
+\emph{m} & Minor number of event's device, decimal integer. \\ \hline
+\emph{M} & Major number of event's device, decimal integer. \\ \hline
+\emph{n} & Number of blocks, unsigned decimal integer \\ \hline
+\emph{N} & Number of bytes, unsigned decimal integer \\ \hline
+\emph{p} & Process ID, unsigned decimal integer \\ \hline
+\emph{P} & Display packet data -- series of hexadecimal digits \\ \hline
+\emph{s} & Sequence number per device and per CPU, long decimal integer \\ \hline
+\emph{S} & Sector number, long long unsigned decimal integer \\ \hline
+\emph{t} & Time stamp (nanoseconds), long unsigned decimal integer, \\
+         & default width 9 if no width specified \\ \hline
+\emph{T} & Time stamp (seconds), decimal integer \\ \hline
+\emph{u} & Elapsed value in microseconds (\emph{-t} command line option), \\
+         & unsigned long long decimal integer \\ \hline
+\emph{U} & Payload, unsigned integer \\ \hline
+\emph{z} & Calendar time of time stamp, string with format hh:mm:ss.uuuuuu \\
+         & relative to the user's time zone (localtime(3)) \\ \hline
 \end{tabular}
 
-Note that the user can optionally specify field display width, and
-optionally a left-aligned specifier. These precede field specifiers,
-with a '\%' character, followed by the optional left-alignment specifer
-(-) followed by the width (a decimal number) and then the field.
+Field specifiers start with a '\%' character.
+Note that the user can optionally specify a left-alignment,
+and optionally specify a field display width.
+The optional left-alignment specifier (-) is followed by the width (a
+decimal number).
+Finally, the mandatory field type is given by a character from the list above.
+If a field type character undefined above is used, the output just contains
+the one character, e.g.\ '\%\S' outputs '\S'.
+Alternatively, '\%\%', or '\%' at the end of the format string, produce one '\%'
+in the output.
+
+The format string allows the following escape sequences:
+'\textbackslash{}b', '\textbackslash{}n', '\textbackslash{}r', '\textbackslash{}t'
+for backspace, newline, carriage return, or tabulator respectively.
+
+Don't forget a trailing newline character '\textbackslash{}n' if you expect each event
+on a separate output line.
 
 Thus, to specify the command in a 12-character field that is left aligned:
 
 \begin{verbatim}
--f "%-12C"
+-f "%-12C\n"
 \end{verbatim}
 
 \newpage
@@ -670,6 +700,7 @@ I & IO inserted onto request queue \\ \hline
 M & IO back merged with request on queue \\ \hline
 P & Plug request \\ \hline
 Q & IO handled by request queue code \\ \hline
+R & Requeued \\ \hline
 S & Sleep request \\ \hline
 T & Unplug due to timeout \\ \hline
 U & Unplug request \\ \hline
@@ -677,13 +708,13 @@ X & Split \\ \hline
 \end{tabular}
 
 \subsubsection{RWBS Description}
-\label{sec:act-table}
+\label{sec:rwbs}
 This is a small string containing at least one character ('R' for read,
 'W' for write, or 'D' for block discard operation), and optionally either
 a 'B' (for barrier operations) or 'S' (for synchronous operations).
 
-\subsubsection{Default output}
-\label{sec:default-output}
+\subsubsection{Default output header}
+\label{sec:default-output-header}
 
 The standard \emph{header} (or initial fields displayed) include:
 
@@ -696,8 +727,8 @@ Breaking this down:
 \begin{description}
   \item[\%D] Displays the event's device major/minor as: \%3d,\%-3d.
   \item[\%2c] CPU ID (2-character field).
-  \item[\%8s] Sequence number
-  \item[\%5T.\%9t] 5-charcter field for the seconds portion of the
+  \item[\%8s] Sequence number per device and per CPU
+  \item[\%5T.\%9t] 5-character field for the seconds portion of the
   time stamp and a 9-character field for the nanoseconds in the time stamp.
   \item[\%5p] 5-character field for the process ID.
   \item[\%2a] 2-character field for one of the actions.
@@ -710,38 +741,53 @@ Seeing this in action:
   8,0    3        1     0.000000000   697  G   W 223490 + 8 [kjournald]
 \end{verbatim}
 
-The header is the data in this line up to the 223490 (starting block). 
+The header is the data in this line just before the 223490 (starting block).
 
 The default output for all event types includes this header.
 
-\paragraph{Default output per action}
+\subsubsection{Default output per action}
+\label{sec:default-output-action}
+
+The additional output described in the following is appended to the
+standard header from section~\ref{sec:default-output-header}. The
+default output ends each event with a newline character
+`\textbackslash{}n'.
 
 \begin{description}
-  \item[C -- complete] If a payload is present, this is presented between
-  parenthesis following the header, followed by the error value. 
+  \item[C -- complete]
+  \item[R -- requeue] If a payload is present, this is presented between
+  parentheses following the header.
 
-  If no payload is present, the sector and number of blocks are presented
-  (with an intervening plus (+) character). If the \emph{-t} option
-  was specified, then the elapsed time is presented. In either case,
-  it is followed by the error value for the completion.
+  If no payload is present, the sector is presented. If the number of
+  blocks is non-zero, an intervening plus (+) character and the number
+  of blocks are presented, too. If the action is complete (C) and the
+  \emph{-t} option was specified, then the elapsed time since issue
+  (D) is presented (in parentheses) [see also D2C in btt (1)].
+
+  In either case, it is followed by the error value for the completion
+  (surrounded by square brackets).
 
   \item[D -- issued]
   \item[I -- inserted]
   \item[Q -- queued]
   \item[B -- bounced] If a payload is present, the number of payload bytes
-  is output, followed by the payload in hexadecimal between parenthesis.
+  is output, followed by the payload in hexadecimal between parentheses.
 
   If no payload is present, the sector and number of blocks are presented
-  (with an intervening plus (+) character). If the \emph{-t} option was
-  specified, then the elapsed time is presented (in parenthesis). In
-  either case, it is followed by the command associated with the event
-  (surrounded by square brackets).
+  (with an intervening plus (+) character) unless number of blocks is zero.
+  If the action is inserted (I) or issued (D), and the \emph{-t} option was
+  specified, then the elapsed time since queue (Q) or issue (I) respectively
+  is presented (in parentheses).
+
+  In either case, it is followed by the command associated with the
+  event (surrounded by square brackets).
 
   \item[M -- back merge]
   \item[F -- front merge]
   \item[G -- get request]
   \item[S -- sleep] The starting sector and number of blocks is output
-  (with an intervening plus (+) character), followed by the command
+  (with an intervening plus (+) character) unless number of blocks is zero,
+  followed by the command
   associated with the event (surrounded by square brackets).
 
   \item[P -- plug] The command associated with the event (surrounded by
@@ -753,14 +799,17 @@ The default output for all event types includes this header.
   requests outstanding.
 
   \item[X -- split] The original starting sector followed by the new
-  sector (separated by a slash (/) is output, followed by the command
+  sector (separated by a slash (/)) is output, followed by the command
   associated with the event (surrounded by square brackets).
 
-  \item[A -- remap] Sector and length is output, along with the original
-  device and sector offset.
+  \item[A -- remap] The starting sector and number of blocks is output
+  (with an intervening plus (+) character), followed by a textual left
+  arrow `` $<$- '' as well as original major and minor device number (in
+  parentheses, separated by comma) and original sector offset.
+
+  \item[m -- message] The supplied message.
 
-  \item[m -- message] The supplied message is appended to the end of
-  the standard header.
+  \item[otherwise] ``Unknown action '' followed by the action character.
 
 \end{description}
 
-- 
2.14.2

