From: "Alan D. Brunelle" <alan.brunelle@hp.com>
Date: Tue, 10 Apr 2007 18:15:21 +0000
Subject: [BTT PATCH] Misc fixes to seek output
Message-Id: <461BD439.1030409@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020608030402060404010407"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------020608030402060404010407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------020608030402060404010407
Content-Type: text/plain;
 name="seek-minor-fixes"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="seek-minor-fixes"

From: Alan D. Brunelle <Alan.Brunelle@hp.com>

Converted seek output for absolute to be end-to-start, and added rw on out

Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>
---

 btt/doc/btt.tex |   14 +++++++-------
 btt/seek.c      |    9 +++++----
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/btt/doc/btt.tex b/btt/doc/btt.tex
index ced747d..26cba36 100644
--- a/btt/doc/btt.tex
+++ b/btt/doc/btt.tex
@@ -602,9 +602,9 @@ Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s
     \emph{end} of the previous IO and the beginning of the next, or the
     end of this IO and the start of the next.
 
-    \item[\texttt{-a}] If the \texttt{-a} or \texttt{seek-absolute}
+    \item[\texttt{-a}] If the \texttt{-a} or \texttt{--seek-absolute}
     option is specified, then the seek distance is simply the difference
-    between the start of the previous IO and the start of this IO.
+    between the end of the previous IO and the start of this IO.
   \end{description}
 
 \newpage\section{\label{sec:cmd-line}Command Line}
@@ -635,11 +635,11 @@ Usage: \texttt{btt} 0.99.1
 
 \subsection{\label{sec:o-a}\texttt{--seek-absolute}/\texttt{-a}}
 
-  When specified on the command line, this directs btt to calculate seek
-  distances based solely upon the starting block addresses of succeeding
-  IOs. By default \texttt{btt} uses the concept of the closeness to either
-  the beginning or end of the previous IO. See section~\ref{sec:seek}
-  for more details about seek distances.
+  When specified on the command line, this directs btt to calculate
+  seek distances based solely upon the ending block address of one IO,
+  and the start of the next.  By default \texttt{btt} uses the concept
+  of the closeness to either the beginning or end of the previous IO. See
+  section~\ref{sec:seek} for more details about seek distances.
 
 \subsection{\label{sec:o-A}\texttt{--all-data}/\texttt{-A}}
 
diff --git a/btt/seek.c b/btt/seek.c
index b8a3d42..8738698 100644
--- a/btt/seek.c
+++ b/btt/seek.c
@@ -106,7 +106,7 @@ long long seek_dist(struct seeki *sip, struct io *iop)
 	long long start = BIT_START(iop), end = BIT_END(iop);
 
 	if (seek_absolute)
-		dist = start - sip->last_start;
+		dist = start - sip->last_end;
 	else {
 		/* Some overlap means no seek */
 		if (((sip->last_start <= start) && (start <= sip->last_end)) ||
@@ -153,14 +153,15 @@ void seeki_exit(void *param)
 void seeki_add(void *handle, struct io *iop)
 {
 	struct seeki *sip = handle;
+	char rw = IOP_READ(iop) ? 'r' : 'w';
 	long long dist = seek_dist(sip, iop);
-	FILE *fp = IOP_READ(iop) ? sip->rfp : sip->wfp;
 	double tstamp = BIT_TIME(iop->t.time);
+	FILE *fp = IOP_READ(iop) ? sip->rfp : sip->wfp;
 
 	if (fp)
-		fprintf(fp, "%15.9lf %13lld\n", tstamp, dist);
+		fprintf(fp, "%15.9lf %13lld %c\n", tstamp, dist, rw);
 	if (sip->cfp)
-		fprintf(sip->cfp, "%15.9lf %13lld\n", tstamp, dist);
+		fprintf(sip->cfp, "%15.9lf %13lld %c\n", tstamp, dist, rw);
 
 	dist = llabs(dist);
 	sip->tot_seeks++;

--------------020608030402060404010407--
