From: Hiroaki Mihara <hmihara@redhat.com>
Date: Tue, 24 Sep 2019 22:33:11 +0000
Subject: [PATCH 3/3] doc: tex: add absolute timestamp printing option
Message-Id: <20190924223311.20238-1-hmihara@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The functionality of printing out absolute timestamps has been
implemented in code but not documented in doc/blktrace.tex.

Signed-off-by: Hiroaki Mihara <hmihara@redhat.com>
---
 doc/blktrace.tex | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 4d8278e..3647c75 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -613,6 +613,7 @@ the event's device \\
 \emph{T} & Time stamp (seconds) \\ \hline
 \emph{u} & Elapsed value in microseconds (\emph{-t} command line option) \\ \hline
 \emph{U} & Payload unsigned integer \\ \hline
+\emph{z} & Absolute time stamp \\ \hline
 \end{tabular}
 
 Note that the user can optionally specify field display width, and
-- 
2.21.0
