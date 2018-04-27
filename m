From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:37 +0000
Subject: [PATCH 30/31] blkparse: add custom format field specifiers for remapping event
Message-Id: <20180427130738.102806-31-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Now we can self-describe the default output format with a
custom output format, e.g. to change the output header but
still get the remapping action details as in the default output format.

$ blkparse sdw1
 65,96   3        1    13.942389864 75872  A   R 2048 + 1 <- (65,97) 0

$ blkparse sdw1 \
    -F A,"%D %2c %8s %5T.%9t %5p %2a %3d %S + %n <- (%i,%j) %k\n"
 65,96   3        1    13.942389864 75872  A   R 2048 + 1 <- (65,97) 0

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 blkparse_fmt.c   | 28 ++++++++++++++++++++++++----
 doc/blkparse.1   | 15 ++++++++++-----
 doc/blktrace.tex |  3 +++
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 14737f81c78d..45ffe04d71c1 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -175,7 +175,8 @@ static void get_pdu_remap(struct blk_io_trace *t, struct blk_io_trace_remap *r)
 static void print_field(char *act, struct per_cpu_info *pci,
 			struct blk_io_trace *t, unsigned long long elapsed,
 			int pdu_len, unsigned char *pdu_buf, char field,
-			int minus, int has_w, int width)
+			int minus, int has_w, int width,
+			struct blk_io_trace_remap *r)
 {
 	char format[64];
 
@@ -216,6 +217,16 @@ static void print_field(char *act, struct per_cpu_info *pci,
 	case 'g':
 		fprintf(ofp, strcat(format, "*s"), pdu_len, pdu_buf);
 		break;
+	case 'i':
+		fprintf(ofp, strcat(format, "d"), MAJOR(r->device_from));
+		break;
+	case 'j':
+		fprintf(ofp, strcat(format, "d"), MINOR(r->device_from));
+		break;
+	case 'k':
+		fprintf(ofp, strcat(format, "llu"),
+			(unsigned long long)r->sector_from);
+		break;
 	case 'M':
 		fprintf(ofp, strcat(format, "d"), MAJOR(t->device));
 		break;
@@ -275,7 +286,7 @@ static void print_field(char *act, struct per_cpu_info *pci,
 static char *parse_field(char *act, struct per_cpu_info *pci,
 			 struct blk_io_trace *t, unsigned long long elapsed,
 			 int pdu_len, unsigned char *pdu_buf,
-			 char *master_format)
+			 char *master_format, struct blk_io_trace_remap *r)
 {
 	int minus = 0;
 	int has_w = 0;
@@ -294,7 +305,7 @@ static char *parse_field(char *act, struct per_cpu_info *pci,
 	}
 	if (*p) {
 		print_field(act, pci, t, elapsed, pdu_len, pdu_buf, *p++,
-			    minus, has_w, width);
+			    minus, has_w, width, r);
 	}
 	return p;
 }
@@ -438,6 +449,7 @@ void process_fmt(char *act, struct per_cpu_info *pci, struct blk_io_trace *t,
 		 unsigned long long elapsed, int pdu_len,
 		 unsigned char *pdu_buf)
 {
+	struct blk_io_trace_remap r = { .device_from = 0, };
 	char *p = override_format[(int) *act];
 
 	if (!p) {
@@ -445,6 +457,14 @@ void process_fmt(char *act, struct per_cpu_info *pci, struct blk_io_trace *t,
 		return;
 	}
 
+	/*
+	 * For remaps we have to modify the device using the remap structure
+	 * passed up.
+	 */
+	if (act[0] = 'A') {
+		get_pdu_remap(t, &r);
+		t->device = r.device_to;
+	}
 	while (*p) {
 		switch (*p) {
 		case '%': 	/* Field specifier */
@@ -455,7 +475,7 @@ void process_fmt(char *act, struct per_cpu_info *pci, struct blk_io_trace *t,
 				fprintf(ofp, "%c", '%');
 			else
 				p = parse_field(act, pci, t, elapsed,
-						pdu_len, pdu_buf, p);
+						pdu_len, pdu_buf, p, &r);
 			break;
 		case '\\': {	/* escape */
 			switch (p[1]) {
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index 5bc84d3ed5c2..dc1d0b393714 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -357,6 +357,15 @@ Error value, decimal integer
 .IP \fBg\fR 4
 Message from payload, string limited by payload length
 
+.IP \fBi\fR 4
+Major number of original device if remap (A) event, decimal integer.
+
+.IP \fBj\fR 4
+Minor number of original device if remap (A) event, decimal integer.
+
+.IP \fBk\fR 4
+Original sector offset if remap (A) event, long long unsigned decimal integer
+
 .IP \fBm\fR 4
 Minor number of event's device, decimal integer.
 
@@ -644,17 +653,13 @@ the following and modify individual parts as you like:
     -F U,"%D %2c %8s %5T.%9t %5p %2a %3d [%C] %U\\n" \\
     -F T,"%D %2c %8s %5T.%9t %5p %2a %3d [%C] %U\\n" \\
     -F X,"%D %2c %8s %5T.%9t %5p %2a %3d %S / %U [%C]\\n" \\
-    -F A,"%D %2c %8s %5T.%9t %5p %2a %3d %S + %n <- (\fIOmaj\fR,\fIOmin\fR) \fIOsec\fR\\n" \\
+    -F A,"%D %2c %8s %5T.%9t %5p %2a %3d %S + %n <- (%i,%j) %k\\n" \\
     -F m,"%D %2c %8s %5T.%9t %5p %2a %3d %g\\n"
 
 The custom format syntax from section OUTPUT DESCRIPTION AND FORMATTING
 does not support conditional output. Thus, the example output differs
 by printing all information instead of skipping some based on conditions.
 
-Also, for remap events (A), the major and minor number of the original
-device as well as the original sector offset are currently not
-available as custom fields.
-
 
 .SH AUTHORS
 \fIblkparse\fR was written by Jens Axboe, Alan D. Brunelle and Nathan Scott.  This
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 036bff283568..008767e2010b 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -1090,6 +1090,9 @@ the \\
          & event's device (separated by a comma). \\ \hline
 \emph{e} & Error value, decimal integer \\ \hline
 \emph{g} & Message from payload, string limited by payload length \\ \hline
+\emph{i} & Major number of original device if remap (A) event, decimal integer. \\ \hline
+\emph{j} & Minor number of original device if remap (A) event, decimal integer. \\ \hline
+\emph{k} & Original sector offset if remap (A) event, long long unsigned decimal integer. \\ \hline
 \emph{m} & Minor number of event's device, decimal integer. \\ \hline
 \emph{M} & Major number of event's device, decimal integer. \\ \hline
 \emph{n} & Number of blocks, unsigned decimal integer \\ \hline
-- 
2.14.2

