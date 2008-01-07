From: Christof Schmitt <christof.schmitt@de.ibm.com>
Date: Mon, 07 Jan 2008 07:50:59 +0000
Subject: [patch 2/2] blkparse: Introduce optional accounting of PC requests
Message-Id: <20080107075446.155572000@de.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Christof Schmitt <christof.schmitt@de.ibm.com>

The current blkparse lists only PC requests, but does not
account for number of PC requests and the size of the attached
data. This makes sense for block devices where requests originate
from file systems.

When tracing SCSI tape drives via the sg device files, then all requests are PC
requests. This patch introduces optional accounting for PC requests with the -p
or --pc flags to blkparse. For disk drives and CD-ROMs this could also be
useful to see a summary of the number and transferred data of PC requests.

Accounting the completion events does not work, since the kernel uses the
data_len field as residual bytes count on event completion, so this has been
left out.

Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>

--- a/blktrace.h	2008-01-04 11:31:00.000000000 +0100
+++ b/blktrace.h	2008-01-04 13:14:36.000000000 +0100
@@ -32,6 +32,10 @@ struct io_stats {
 	unsigned long long qread_kb, qwrite_kb, cread_kb, cwrite_kb;
 	unsigned long long iread_kb, iwrite_kb;
 	unsigned long long mread_kb, mwrite_kb;
+	unsigned long qreads_pc, qwrites_pc, creads_pc, cwrites_pc;
+	unsigned long ireads_pc, iwrites_pc;
+	unsigned long long qread_kb_pc, qwrite_kb_pc, cread_kb_pc, cwrite_kb_pc;
+	unsigned long long iread_kb_pc, iwrite_kb_pc;
 	unsigned long io_unplugs, timer_unplugs;
 };
 
--- a/blkparse.c	2008-01-04 12:21:42.000000000 +0100
+++ b/blkparse.c	2008-01-04 13:44:07.000000000 +0100
@@ -104,7 +104,7 @@ static struct per_process_info *ppi_hash
 static struct per_process_info *ppi_list;
 static int ppi_list_entries;
 
-#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vV"
+#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Opqstw:vV"
 static struct option l_opts[] = {
  	{
 		.name = "act-mask",
@@ -209,6 +209,12 @@ static struct option l_opts[] = {
 		.val = 'V'
 	},
 	{
+		.name = "pc",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'p'
+	},
+	{
 		.name = NULL,
 	}
 };
@@ -271,6 +277,7 @@ static int verbose;
 static unsigned int act_mask = -1U;
 static int stats_printed;
 int data_is_native = -1;
+static int trace_pc = 0;
 
 static FILE *dump_fp;
 static char *dump_binary;
@@ -1168,6 +1175,77 @@ static inline void account_m(struct blk_
 	}
 }
 
+static inline void __account_pc_queue(struct io_stats *ios,
+				      struct blk_io_trace *t, int rw)
+{
+	if (rw) {
+		ios->qwrites_pc++;
+		ios->qwrite_kb_pc += t_kb(t);
+	} else {
+		ios->qreads_pc++;
+		ios->qread_kb += t_kb(t);
+	}
+}
+
+static inline void account_pc_queue(struct blk_io_trace *t,
+				    struct per_cpu_info *pci, int rw)
+{
+	__account_pc_queue(&pci->io_stats, t, rw);
+
+	if (per_process_stats) {
+		struct io_stats *ios = find_process_io_stats(t->pid);
+
+		__account_pc_queue(ios, t, rw);
+	}
+}
+
+static inline void __account_pc_issue(struct io_stats *ios, int rw,
+				      unsigned int bytes)
+{
+	if (rw) {
+		ios->iwrites_pc++;
+		ios->iwrite_kb_pc += bytes >> 10;
+	} else {
+		ios->ireads_pc++;
+		ios->iread_kb_pc += bytes >> 10;
+	}
+}
+
+static inline void account_pc_issue(struct blk_io_trace *t,
+				    struct per_cpu_info *pci, int rw)
+{
+	__account_pc_issue(&pci->io_stats, rw, t->bytes);
+
+	if (per_process_stats) {
+		struct io_stats *ios = find_process_io_stats(t->pid);
+
+		__account_pc_issue(ios, rw, t->bytes);
+	}
+}
+
+static inline void __account_pc_c(struct io_stats *ios, int rw, int bytes)
+{
+	if (rw) {
+		ios->cwrites_pc++;
+		ios->cwrite_kb_pc += bytes >> 10;
+	} else {
+		ios->creads_pc++;
+		ios->cread_kb_pc += bytes >> 10;
+	}
+}
+
+static inline void account_pc_c(struct blk_io_trace *t, struct per_cpu_info *pci,
+				int rw, int bytes)
+{
+	__account_pc_c(&pci->io_stats, rw, bytes);
+
+	if (per_process_stats) {
+		struct io_stats *ios = find_process_io_stats(t->pid);
+
+		__account_pc_c(ios, rw, bytes);
+	}
+}
+
 static inline void __account_queue(struct io_stats *ios, struct blk_io_trace *t,
 				   int rw)
 {
@@ -1356,6 +1434,7 @@ static void dump_trace_pc(struct blk_io_
 	switch (act) {
 		case __BLK_TA_QUEUE:
 			log_generic(pci, t, "Q");
+			account_pc_queue(t, pci, w);
 			break;
 		case __BLK_TA_GETRQ:
 			log_generic(pci, t, "G");
@@ -1370,9 +1449,11 @@ static void dump_trace_pc(struct blk_io_
 			 */
 			if (pdi->cur_depth[w])
 				pdi->cur_depth[w]--;
+			account_requeue(t, pci, w);
 			log_generic(pci, t, "R");
 			break;
 		case __BLK_TA_ISSUE:
+			account_pc_issue(t, pci, w);
 			pdi->cur_depth[w]++;
 			if (pdi->cur_depth[w] > pdi->max_depth[w])
 				pdi->max_depth[w] = pdi->cur_depth[w];
@@ -1383,6 +1464,7 @@ static void dump_trace_pc(struct blk_io_
 			if (pdi->cur_depth[w])
 				pdi->cur_depth[w]--;
 
+			account_pc_c(t, pci, w, t->bytes);
 			log_pc(pci, t, "C");
 			break;
 		case __BLK_TA_INSERT:
@@ -1533,6 +1615,14 @@ static void dump_io_stats(struct per_dev
 		fprintf(ofp, " Read depth:      %'8u%8c\t", pdi->max_depth[0], ' ');
 		fprintf(ofp, " Write depth:      %'8u\n", pdi->max_depth[1]);
 	}
+	if (trace_pc) {
+		fprintf(ofp, " PC Reads Queued:    %s, %siB\t", size_cnv(x, ios->qreads_pc, 0), size_cnv(y, ios->qread_kb_pc, 1));
+		fprintf(ofp, " PC Writes Queued:    %s, %siB\n", size_cnv(x, ios->qwrites_pc, 0), size_cnv(y, ios->qwrite_kb_pc, 1));
+		fprintf(ofp, " PC Read Dispatches: %s, %siB\t", size_cnv(x, ios->ireads_pc, 0), size_cnv(y, ios->iread_kb_pc, 1));
+		fprintf(ofp, " PC Write Dispatches: %s, %siB\n", size_cnv(x, ios->iwrites_pc, 0), size_cnv(y, ios->iwrite_kb_pc, 1));
+		fprintf(ofp, " PC Reads Completed: %s, %siB\t", size_cnv(x, ios->creads_pc, 0), size_cnv(y, ios->cread_kb_pc, 1));
+		fprintf(ofp, " PC Writes Completed: %s, %siB\n", size_cnv(x, ios->cwrites_pc, 0), size_cnv(y, ios->cwrite_kb_pc, 1));
+	}
 	fprintf(ofp, " IO unplugs:      %'8lu%8c\t", ios->io_unplugs, ' ');
 	fprintf(ofp, " Timer unplugs:    %'8lu\n", ios->timer_unplugs);
 }
@@ -1662,6 +1752,14 @@ static void show_device_and_cpu_stats(vo
 			total.iwrite_kb += ios->iwrite_kb;
 			total.mread_kb += ios->mread_kb;
 			total.mwrite_kb += ios->mwrite_kb;
+
+			total.qreads_pc += ios->qreads_pc;
+			total.qwrites_pc += ios->qwrites_pc;
+			total.creads_pc += ios->creads_pc;
+			total.cwrites_pc += ios->cwrites_pc;
+			total.ireads_pc += ios->ireads_pc;
+			total.iwrites_pc += ios->iwrites_pc;
+
 			total.timer_unplugs += ios->timer_unplugs;
 			total.io_unplugs += ios->io_unplugs;
 
@@ -2494,7 +2592,7 @@ static int is_pipe(const char *str)
 	return 0;
 }
 
-#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vV"
+#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Opqstw:vV"
 static char usage_str[] =    "\n\n" \
 	"-i <file>           | --input=<file>\n" \
 	"[ -a <action field> | --act-mask=<action field> ]\n" \
@@ -2507,6 +2605,7 @@ static char usage_str[] =    "\n\n" \
 	"[ -h                | --hash-by-name ]\n" \
 	"[ -o <file>         | --output=<file> ]\n" \
 	"[ -O                | --no-text-output ]\n" \
+	"[ -p                | --pc ]\n" \
 	"[ -q                | --quiet ]\n" \
 	"[ -s                | --per-program-stats ]\n" \
 	"[ -t                | --track-ios ]\n" \
@@ -2523,6 +2622,7 @@ static char usage_str[] =    "\n\n" \
 	"\t-i Input file containing trace data, or '-' for stdin\n" \
 	"\t-o Output file. If not given, output is stdout\n" \
 	"\t-O Do NOT output text data\n" \
+	"\t-p Show statistics for PC requests\n"
 	"\t-q Quiet. Don't display any stats at the end of the trace\n" \
 	"\t-s Show per-program io statistics\n" \
 	"\t-t Track individual ios. Will tell you the time a request took\n" \
@@ -2619,6 +2719,9 @@ int main(int argc, char *argv[])
 		case 'd':
 			dump_binary = optarg;
 			break;
+		case 'p':
+			trace_pc = 1;
+			break;
 		default:
 			usage(argv[0]);
 			return 1;

-- 
