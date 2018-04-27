From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:34 +0000
Subject: [PATCH 27/31] blkparse: elapsed time: change unit of custom format, no exit on none
Message-Id: <20180427130738.102806-28-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

This brings the unit in line with the default output format,
so it becomes possible to imitate the default with custom output format.

Since only particular trace subtypes provide elapsed time,
remove the early exit if no elapsed time is available.
Otherwise the custom format field %u is hardly usable.

$ blkparse -t sdw1
 65,97   3        4    13.942706121 75872  I   R 2048 + 1 (    5985) [dd]
 65,97   3        5    13.942709906 75872  D   R 2048 + 1 (    3785) [dd]
 65,97   2        2    13.943098186     0  C   R 2048 + 1 (  388280) [0]

$ blkparse -t sdw1 \
  -F C,"%D %2c %8s %5T.%9t %5p %2a %3d %S + %n (%8u) (%P) [%e]\n" \
  -F D,"%D %2c %8s %5T.%9t %5p %2a %3d %S + %n (%8u) %N (%P) [%C]\n" \
  -F I,"%D %2c %8s %5T.%9t %5p %2a %3d %S + %n (%8u) %N (%P) [%C]\n"
 65,97   3        4    13.942706121 75872  I   R 2048 + 1 (    5985) 512 () [dd]
 65,97   3        5    13.942709906 75872  D   R 2048 + 1 (    3785) 512 () [dd]
 65,97   2        2    13.943098186     0  C   R 2048 + 1 (  388280) () [0]

But without the elapsed time unit change, the latter would be:

 65,97   3        4    13.942706121 75872  I   R 2048 + 1 (       5) 512 () [dd]
 65,97   3        5    13.942709906 75872  D   R 2048 + 1 (       3) 512 () [dd]
 65,97   2        2    13.943098186     0  C   R 2048 + 1 (     388) () [0]

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 blkparse_fmt.c   | 5 ++---
 doc/blkparse.1   | 3 +--
 doc/blktrace.tex | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 818208808198..1bcd028918b5 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -242,10 +242,9 @@ static void print_field(char *act, struct per_cpu_info *pci,
 		break;
 	case 'u':
 		if (elapsed = -1ULL) {
-			fprintf(stderr, "Expecting elapsed value\n");
-			exit(1);
+			break;
 		}
-		fprintf(ofp, strcat(format, "llu"), elapsed / 1000);
+		fprintf(ofp, strcat(format, "llu"), elapsed);
 		break;
 	case 'U':
 		fprintf(ofp, strcat(format, "u"), get_pdu_int(t));
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index 69d05cabe333..4ec9c098a49f 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -386,12 +386,11 @@ default width 9 if no width specified
 Time stamp (seconds), decimal integer
 
 .IP \fBu\fR 4
-Elapsed value in microseconds (\fB\-t\fR command line option),
+Elapsed value in nanoseconds (\fB\-t\fR command line option),
 unsigned long long decimal integer. You can use this with \fB-F,--format\fR
 option and event types I, D, C (for insert, issue, complete) to provide
 intervals Q2I, I2D, D2C respectively [see also btt (1)]. Elapsed values are
 only provided for file system requests (fs) [see REQUEST TYPES in blktrace (8)].
-Otherwise blkparse exits with error once any other event type appears on the input.
 
 .IP \fBU\fR 4
 Payload, unsigned integer
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index aad19e2ff38d..408b3dcb6298 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -1100,7 +1100,7 @@ the \\
 \emph{t} & Time stamp (nanoseconds), long unsigned decimal integer, \\
          & default width 9 if no width specified \\ \hline
 \emph{T} & Time stamp (seconds), decimal integer \\ \hline
-\emph{u} & Elapsed value in microseconds (\emph{-t} command line option), \\
+\emph{u} & Elapsed value in nanoseconds (\emph{-t} command line option), \\
          & unsigned long long decimal integer \\ \hline
 \emph{U} & Payload, unsigned integer \\ \hline
 \emph{z} & Calendar time of time stamp, string with format hh:mm:ss.uuuuuu \\
-- 
2.14.2

