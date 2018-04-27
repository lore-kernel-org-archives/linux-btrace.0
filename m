From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:36 +0000
Subject: [PATCH 29/31] blkparse: enable custom output format also for message event type
Message-Id: <20180427130738.102806-30-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Call regular processing chain rather than hardcoded direct output.

Introduce a new format %g to output the message content from the
payload as (length-limited) string. The other existing payload
formats %P (hexdump) or %U (unsigned int) cannot reproduce the
old hardcoded default message content output.

$ blkparse -t -q sdw1
 65,97   1        0     0.000000000     0  m   N foo

$ blkparse -t -q sdw1 -F m,"%D %2c %8s %5T.%9t %5p %2a %3d %g\n"
 65,97   1        0     0.000000000     0  m   N foo

Fixes: 1a15f6a82d62 ("Added in handling of MESSAGE notes")

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 blkparse.c       | 9 +++------
 blkparse_fmt.c   | 5 ++++-
 doc/blkparse.1   | 9 +++++----
 doc/blktrace.tex | 1 +
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 227cc444c280..8049bb55bb0e 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -576,6 +576,8 @@ static void handle_notify(struct blk_io_trace *bit)
 {
 	void	*payload = (caddr_t) bit + sizeof(*bit);
 	__u32	two32[2];
+	/* sparse per_cpu_info contains only what process_fmt() chain uses */
+	struct per_cpu_info pci = { .cpu = bit->cpu };
 
 	switch (bit->action) {
 	case BLK_TN_PROCESS:
@@ -607,12 +609,7 @@ static void handle_notify(struct blk_io_trace *bit)
 			memcpy(msg, (char *)payload, bit->pdu_len);
 			msg[bit->pdu_len] = '\0';
 
-			fprintf(ofp,
-				"%3d,%-3d %2d %8s %5d.%09lu %5u %2s %3s %s\n",
-				MAJOR(bit->device), MINOR(bit->device),
-				bit->cpu, "0", (int) SECONDS(bit->time),
-				(unsigned long) NANO_SECONDS(bit->time),
-				0, "m", "N", msg);
+			process_fmt("m", &pci, bit, -1, bit->pdu_len, payload);
 		}
 		break;
 
diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 551cb14d06db..14737f81c78d 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -11,7 +11,7 @@
 
 #include "blktrace.h"
 
-#define VALID_SPECS	"ABCDFGIMPQRSTUX"
+#define VALID_SPECS	"ABCDFGIMPQRSTUXm"
 
 #define HEADER		"%D %2c %8s %5T.%9t %5p %2a %3d "
 
@@ -213,6 +213,9 @@ static void print_field(char *act, struct per_cpu_info *pci,
 	case 'e':
 		fprintf(ofp, strcat(format, "d"), t->error);
 		break;
+	case 'g':
+		fprintf(ofp, strcat(format, "*s"), pdu_len, pdu_buf);
+		break;
 	case 'M':
 		fprintf(ofp, strcat(format, "d"), MAJOR(t->device));
 		break;
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index 52fb84a788cb..5bc84d3ed5c2 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -354,6 +354,9 @@ the event's device (separated by a comma).
 .IP \fBe\fR 4
 Error value, decimal integer
 
+.IP \fBg\fR 4
+Message from payload, string limited by payload length
+
 .IP \fBm\fR 4
 Minor number of event's device, decimal integer.
 
@@ -641,15 +644,13 @@ the following and modify individual parts as you like:
     -F U,"%D %2c %8s %5T.%9t %5p %2a %3d [%C] %U\\n" \\
     -F T,"%D %2c %8s %5T.%9t %5p %2a %3d [%C] %U\\n" \\
     -F X,"%D %2c %8s %5T.%9t %5p %2a %3d %S / %U [%C]\\n" \\
-    -F A,"%D %2c %8s %5T.%9t %5p %2a %3d %S + %n <- (\fIOmaj\fR,\fIOmin\fR) \fIOsec\fR\\n"
+    -F A,"%D %2c %8s %5T.%9t %5p %2a %3d %S + %n <- (\fIOmaj\fR,\fIOmin\fR) \fIOsec\fR\\n" \\
+    -F m,"%D %2c %8s %5T.%9t %5p %2a %3d %g\\n"
 
 The custom format syntax from section OUTPUT DESCRIPTION AND FORMATTING
 does not support conditional output. Thus, the example output differs
 by printing all information instead of skipping some based on conditions.
 
-Currently it is not possible to specify 'm' as custom type specifier
-for message events. A custom field for the message text as string does
-not exist, %P for a hexdump comes closest.
 Also, for remap events (A), the major and minor number of the original
 device as well as the original sector offset are currently not
 available as custom fields.
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index aba3b3d87071..036bff283568 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -1089,6 +1089,7 @@ Specifier & \\ \hline\hline
 the \\
          & event's device (separated by a comma). \\ \hline
 \emph{e} & Error value, decimal integer \\ \hline
+\emph{g} & Message from payload, string limited by payload length \\ \hline
 \emph{m} & Minor number of event's device, decimal integer. \\ \hline
 \emph{M} & Major number of event's device, decimal integer. \\ \hline
 \emph{n} & Number of blocks, unsigned decimal integer \\ \hline
-- 
2.14.2

