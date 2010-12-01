From: "Alan D. Brunelle" <alan.brunelle@hp.com>
Date: Wed, 01 Dec 2010 17:05:04 +0000
Subject: [PATCH 2/2] Added in -e documentation
Message-Id: <4CF68040.7000004@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090507080907020506020703"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------090507080907020506020703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------090507080907020506020703
Content-Type: text/x-patch;
 name="0002-Added-in-e-documentation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-Added-in-e-documentation.patch"

Updated doc/blktrace.8 and doc/blktrace.tex

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 doc/blktrace.8   |    9 +++++++++
 doc/blktrace.tex |   14 +++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/doc/blktrace.8 b/doc/blktrace.8
index b5e69b7..1264a4b 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -103,6 +103,15 @@ buffer size is 512KiB.
 Adds \fIdev\fR as a device to trace  
 .RE
 
+\-e \fIcommand\fR
+.br
+\-\-execute\-subcommand=\fIcommand\fR
+.RS
+Will execute \fIcommand\fR once the tracers are ready to go, when
+\fIcommand\fR completes, the tracing is stopped. Note: the single
+argument is passed directly to \fIsystem(2)\fR.
+.RE
+
 \-I \fIfile\fR
 .br
 \-\-input\-devs=\fIfile\fR
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 4d8278e..0362a01 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -1,7 +1,7 @@
 \documentclass{article}
 
 %
-% Copyright (C) 2005, 2006 Alan D. Brunelle <Alan.Brunelle@hp.com>
+% Copyright (C) 2005, 2006, 2010 Alan D. Brunelle <Alan.Brunelle@hp.com>
 %
 %  This program is free software; you can redistribute it and/or modify
 %  it under the terms of the GNU General Public License as published by
@@ -21,7 +21,7 @@
 \title{blktrace User Guide}
 \author{blktrace: Jens Axboe (jens.axboe@oracle.com)\\
         User Guide: Alan D. Brunelle (Alan.Brunelle@hp.com)}
-\date{27 May 2008}
+\date{1 December 2010}
 
 \begin{document}
 \maketitle
@@ -368,7 +368,9 @@ of the more arcane command line options:
   \item blktrace may also be run concurrently with blkparse to produce
   \emph{live} output -- to do this specify \emph{-o -} for blktrace.
 
-  \item The default behaviour for blktrace is to run forever until explicitly killed by the user (via a control-C, or \emph{kill} utility invocation). There are two ways to modify this: 
+  \item The default behaviour for blktrace is to run forever until
+  explicitly killed by the user (via a control-C, or \emph{kill} utility
+  invocation). There are three ways to modify this:
 
   \begin{enumerate}
     \item You may utilize the blktrace utility itself to \emph{kill}
@@ -377,6 +379,10 @@ of the more arcane command line options:
     \item You can specify a run-time duration for blktrace via the
     \emph{-w} option -- then blktrace will run for the specified number
     of seconds, and then halt.
+
+		\item You can specify a command to run in parallel with
+		the tracing, and then that command completes the tracing
+		is stopped. (See: -e below)
   \end{enumerate}
 \end{itemize}
 
@@ -387,6 +393,8 @@ Short              & Long                       & Description \\ \hline\hline
 -a \emph{mask}     & --act-mask=\emph{mask}     & Add \emph{mask} to current filter (see below for masks) \\ \hline
 -b \emph{size}     & --buffer-size=\emph{size}  & Specifies buffer size for event extraction (scaled by $2^{10}$) \\ \hline
 -d \emph{dev}      & --dev=\emph{dev}           & Adds \emph{dev} as a device to trace \\ \hline
+-e \emph{command}  & --execute-subcommand= & Executes \emph{cmd} in the background.\\
+                   & \emph{cmd}                            & Stops the trace when the command has completed \\ \hline
 -k                 & --kill                     & Kill on-going trace \\ \hline
 -n \emph{num-sub}  & --num-sub=\emph{num-sub}   & Specifies number of buffers to use \\ \hline
 -o \emph{file}     & --output=\emph{file}       & Prepend \emph{file} to output file name(s) \\
-- 
1.7.1


--------------090507080907020506020703--
