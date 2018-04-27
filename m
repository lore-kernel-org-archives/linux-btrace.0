From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:35 +0000
Subject: [PATCH 28/31] blkparse: add custom format for calendar date of time stamp
Message-Id: <20180427130738.102806-29-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 blkparse_fmt.c   | 15 +++++++++++++--
 doc/blkparse.1   |  5 +++++
 doc/blktrace.tex |  2 ++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 1bcd028918b5..551cb14d06db 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -86,7 +86,7 @@ static inline void fill_rwbs(char *rwbs, struct blk_io_trace *t)
 }
 
 static const char *
-print_time(unsigned long long timestamp)
+print_time(unsigned long long timestamp, int date)
 {
 	static char	timebuf[128];
 	struct tm	*tm;
@@ -101,6 +101,14 @@ print_time(unsigned long long timestamp)
 	}
 
 	tm = localtime(&sec);
+	if (date) {
+		snprintf(timebuf, sizeof(timebuf),
+			 "%04u-%02u-%02u",
+			 tm->tm_year + 1900,
+			 tm->tm_mon + 1,
+			 tm->tm_mday);
+		return timebuf;
+	}
 	snprintf(timebuf, sizeof(timebuf),
 			"%02u:%02u:%02u.%06lu",
 			tm->tm_hour,
@@ -250,7 +258,10 @@ static void print_field(char *act, struct per_cpu_info *pci,
 		fprintf(ofp, strcat(format, "u"), get_pdu_int(t));
 		break;
 	case 'z':
-		fprintf(ofp, strcat(format, "s"), print_time(t->time));
+		fprintf(ofp, strcat(format, "s"), print_time(t->time, 0));
+		break;
+	case 'Z':
+		fprintf(ofp, strcat(format, "s"), print_time(t->time, 1));
 		break;
 	default:
 		fprintf(ofp,strcat(format, "c"), field);
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index 4ec9c098a49f..52fb84a788cb 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -399,6 +399,11 @@ Payload, unsigned integer
 Calendar time of time stamp, string with format hh:mm:ss.uuuuuu
 relative to the user's time zone (localtime (3))
 
+.IP \fBZ\fR 4
+Calendar date of time stamp, string with format YYYY-MM-DD
+relative to the user's time zone (localtime (3)).
+%ZT%z provides full calendar date and time according to RFC 3339 / ISO 8601.
+
 .PP
 Field specifiers start with a '%' character.
 Note that the user can optionally specify a left-alignment,
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 408b3dcb6298..aba3b3d87071 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -1105,6 +1105,8 @@ the \\
 \emph{U} & Payload, unsigned integer \\ \hline
 \emph{z} & Calendar time of time stamp, string with format hh:mm:ss.uuuuuu \\
          & relative to the user's time zone (localtime(3)) \\ \hline
+\emph{Z} & Calendar date of time stamp, string with format YYYY-MM-DD \\
+         & relative to the user's time zone (localtime(3)). \\ \hline
 \end{tabular}
 
 Field specifiers start with a '\%' character.
-- 
2.14.2

