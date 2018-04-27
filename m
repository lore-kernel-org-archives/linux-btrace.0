From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:18 +0000
Subject: [PATCH 11/31] blktrace: doc: add table of contents to show document structure
Message-Id: <20180427130738.102806-12-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Also let appendix appear in ToC.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 doc/blktrace.tex | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index c46e3e072be6..32b4e14fe318 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -55,6 +55,8 @@ as part of the following git repository:
 
 git://git.kernel.org/pub/scm/linux/kernel/git/axboe/blktrace.git bt
 
+\newpage\tableofcontents
+
 %--------------------------
 \newpage\section{Quick Start Guide}
 \label{sec:quick-start}
@@ -757,7 +759,7 @@ The default output for all event types includes this header.
 
 %------------------------------
 \newpage
-\newpage\section*{Appendix: blktrace Kernel Guide}
+\newpage\section{Appendix: blktrace Kernel Guide}
 \label{sec:blktrace-kg}
 
 The blktrace facility provides an efficient event transfer mechanism which
-- 
2.14.2

