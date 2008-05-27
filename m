From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 27 May 2008 12:47:55 +0000
Subject: [PATCH] Added in new message updates to the documentation.
Message-Id: <483C02FB.4040409@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 doc/blktrace.tex |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 7e08543..82c35e8 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -21,7 +21,7 @@
 \title{blktrace User Guide}
 \author{blktrace: Jens Axboe (jens.axboe@oracle.com)\\
         User Guide: Alan D. Brunelle (Alan.Brunelle@hp.com)}
-\date{18 February 2007}
+\date{27 May 2008}

 \begin{document}
 \maketitle
@@ -536,6 +536,9 @@ Short              & Long                       &
Description \\ \hline\hline
   using better hardware - either a better io controller, or a platform
   with an IOMMU.

+  \item[m -- message] Text message generated via kernel call to
+  \texttt{blk\_add\_trace\_msg}.
+
   \item[M -- back merge] A previously inserted request exists that ends
   on the boundary of where this io begins, so the io scheduler can merge
   them together.
@@ -721,6 +724,9 @@ The default output for all event types includes this
header.
   \item[A -- remap] Sector and length is output, along with the original
   device and sector offset.

+  \item[m -- message] The supplied message is appended to the end of
+  the standard header.
+
 \end{description}

 %------------------------------
@@ -796,6 +802,11 @@ kernel routine invocable interfaces:
 	Adds a trace with a remap event. \emph{dev} and \emph{sector} denote
 	the original device this \emph{bio} was mapped from.

+  \item[blk\_add\_trace\_msg(struct request\_queue *q, char *fmt, ...)]
+	Adds a formatted message to the output stream. The total message
+	size can not exceed BLK\_TN\_MSG\_MSG characters (currently
+	1024). Standard format conversions are supported (as supplied
+	by \texttt{vscnprintf}.

 \end{description}
 \end{document}
-- 
1.5.4.3

