From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Wed, 10 Dec 2008 21:41:12 +0000
Subject: [PATCH] Added no messages option to blkparse.c
Message-Id: <49403778.1090802@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060202040207090203080300"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------060202040207090203080300
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------060202040207090203080300
Content-Type: text/x-diff;
 name="0001-Added-no-messages-option-to-blkparse.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Added-no-messages-option-to-blkparse.c.patch"

Added a new option (-M, --no-msgs) option to blkparse: I have found that
the CFQ I/O scheduler sends a *tremendous* amount of messages, that
bloat the .bin file generated when using the -d option. The file sizes
can shrink by >50% when using the -M option in those case.

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 blkparse.c       |   20 +++++++++++++++++---
 doc/blkparse.1   |    9 +++++++++
 doc/blktrace.tex |    1 +
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index d869da6..ef55697 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -104,7 +104,6 @@ static struct per_process_info *ppi_hash_table[PPI_HASH_SIZE];
 static struct per_process_info *ppi_list;
 static int ppi_list_entries;
 
-#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vV"
 static struct option l_opts[] = {
  	{
 		.name = "act-mask",
@@ -161,6 +160,12 @@ static struct option l_opts[] = {
 		.val = 'i'
 	},
 	{
+		.name = "no-msgs",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'M'
+	},
+	{
 		.name = "output",
 		.has_arg = required_argument,
 		.flag = NULL,
@@ -270,6 +275,7 @@ static int ppi_hash_by_pid = 1;
 static int verbose;
 static unsigned int act_mask = -1U;
 static int stats_printed;
+static int bin_output_msgs = 1;
 int data_is_native = -1;
 
 static FILE *dump_fp;
@@ -1612,7 +1618,10 @@ static void dump_trace(struct blk_io_trace *t, struct per_cpu_info *pci,
 
 	pdi->events++;
 
-	output_binary(t, sizeof(*t) + t->pdu_len);
+	if (bin_output_msgs ||
+			    !(t->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+			      t->action == BLK_TN_MESSAGE))
+		output_binary(t, sizeof(*t) + t->pdu_len);
 }
 
 /*
@@ -2645,7 +2654,7 @@ static int is_pipe(const char *str)
 	return 0;
 }
 
-#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vV"
+#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vVM"
 static char usage_str[] =    "\n\n" \
 	"-i <file>           | --input=<file>\n" \
 	"[ -a <action field> | --act-mask=<action field> ]\n" \
@@ -2662,6 +2671,7 @@ static char usage_str[] =    "\n\n" \
 	"[ -s                | --per-program-stats ]\n" \
 	"[ -t                | --track-ios ]\n" \
 	"[ -w <time>         | --stopwatch=<time> ]\n" \
+	"[ -M                | --no-msgs\n" \
 	"[ -v                | --verbose ]\n" \
 	"[ -V                | --version ]\n\n" \
 	"\t-b stdin read batching\n" \
@@ -2680,6 +2690,7 @@ static char usage_str[] =    "\n\n" \
 	"\t   to get queued, to get dispatched, and to get completed\n" \
 	"\t-w Only parse data between the given time interval in seconds.\n" \
 	"\t   If 'start' isn't given, blkparse defaults the start time to 0\n" \
+	"\t-M Do not output messages to binary file\n" \
 	"\t-v More verbose for marginal errors\n" \
 	"\t-V Print program version info\n\n";
 
@@ -2770,6 +2781,9 @@ int main(int argc, char *argv[])
 		case 'd':
 			dump_binary = optarg;
 			break;
+		case 'M':
+			bin_output_msgs = 0;
+			break;
 		default:
 			usage(argv[0]);
 			return 1;
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index e97581c..fde29d0 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -101,6 +101,15 @@ action specifiers described in ACTION IDENTIFIERS.
 Print missing entries
 .RE
 
+\-M
+.br
+\-\-no-msgs
+.RS
+When \-d is specified, this will stop messages from being output to the
+file. (Can seriously reduce the size of the resultant file when using
+the CFQ I/O scheduler.)
+.RE
+
 \-h
 .br
 \-\-hash\-by\-name
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 1e69240..781bb79 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -506,6 +506,7 @@ Short              & Long                       & Description \\ \hline\hline
 		   &                            & \emph{start:end-time} -- Display traces from time \emph{start} \\
 		   &                            & through {end-time} (in ns). \\ \hline
 
+-M                 & --no-msgs                  & Do not add messages to binary output file \\\hline
 -v                 & --verbose                  & More verbose marginal on marginal errors \\ \hline
 -V                 & --version                  & Display version \\ \hline
 
-- 
1.5.6.3


--------------060202040207090203080300--
