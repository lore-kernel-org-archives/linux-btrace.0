From: Ye Lu <luye.yelu@bytedance.com>
Date: Sun, 18 Jul 2021 11:27:45 +0000
Subject: [PATCH] blkparse: add core-based binary file output option to blkparse
Message-Id: <20210718112745.11821-1-luye.yelu@bytedance.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: luye <luye.yelu@bytedance.com>

Add a new option -c to support core-based binary file output.
One binary output file would be generated for each CPU core if enabled.

Signed-off-by: luye <luye.yelu@bytedance.com>
---
 README     |  1 +
 blkparse.c | 72 ++++++++++++++++++++++++++++++++++++++++++++----------
 blktrace.h |  1 +
 3 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/README b/README
index d7d1fbf..2c0f09b 100644
--- a/README
+++ b/README
@@ -86,6 +86,7 @@ $ blkparse -i <input> [ -o <output> ] [ -b rb_batch ] [ -s ] [ -t ] [ -q ]
 	-w Only parse data between the given time interval in seconds. If
 	   'start' isn't given, blkparse defaults the start time to 0.
 	-d Dump sorted data in binary format
+	-c Dump sorted data in binary format, one binary file for each CPU core
 	-f Output format. Customize the output format. The format field
 	   identifiers are:
 
diff --git a/blkparse.c b/blkparse.c
index 33dd023..17d9e14 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -233,6 +233,12 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 'V'
 	},
+    {
+ 	    .name = "cpu-based-output",
+ 	    .has_arg = no_argument,
+ 	    .flag = NULL,
+ 	    .val = 'c'
+    },
 	{
 		.name = NULL,
 	}
@@ -301,6 +307,7 @@ static int verbose;
 static unsigned int act_mask = -1U;
 static int stats_printed;
 static int bin_output_msgs = 1;
+static int dump_binary_cpu_based = 0;
 int data_is_native = -1;
 
 static FILE *dump_fp;
@@ -346,13 +353,13 @@ static void io_warn_unless(struct blk_io_trace *t, int condition,
 	va_end(ap);
 }
 
-static void output_binary(void *buf, int len)
+static void output_binary(void *buf, int len, FILE *fp)
 {
-	if (dump_binary) {
-		size_t n = fwrite(buf, len, 1, dump_fp);
+	if (dump_binary || dump_binary_cpu_based) {
+		size_t n = fwrite(buf, len, 1, fp);
 		if (n != 1) {
 			perror(dump_binary);
-			fclose(dump_fp);
+			fclose(fp);
 			dump_binary = NULL;
 		}
 	}
@@ -1759,9 +1766,13 @@ static void dump_trace(struct blk_io_trace *t, struct per_cpu_info *pci,
 	pdi->events++;
 
 	if (bin_output_msgs ||
-			    !(t->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
-			      (t->action & ~__BLK_TN_CGROUP) = BLK_TN_MESSAGE))
-		output_binary(t, sizeof(*t) + t->pdu_len);
+		!(t->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+		(t->action & ~__BLK_TN_CGROUP) = BLK_TN_MESSAGE)) {
+			if (dump_binary_cpu_based)
+				output_binary(t, sizeof(*t) + t->pdu_len, pci->out_bin);
+			else
+				output_binary(t, sizeof(*t) + t->pdu_len, dump_fp);
+	}
 }
 
 /*
@@ -2484,7 +2495,7 @@ static int read_events(int fd, int always_block, int *fdblock)
 		 */
 		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
 			handle_notify(bit);
-			output_binary(bit, sizeof(*bit) + bit->pdu_len);
+			output_binary(bit, sizeof(*bit) + bit->pdu_len, dump_fp);
 			continue;
 		}
 
@@ -2633,7 +2644,7 @@ static int ms_prime(struct ms_stream *msp)
 
 		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
 			handle_notify(bit);
-			output_binary(bit, sizeof(*bit) + bit->pdu_len);
+			output_binary(bit, sizeof(*bit) + bit->pdu_len, pci->out_bin);
 			bit_free(bit);
 
 			i -= 1;
@@ -2719,6 +2730,25 @@ static int setup_file(struct per_dev_info *pdi, int cpu)
 		return 0;
 	}
 
+	/*
+	 * Prepare for cpu-based binary output file
+	 */
+	if (dump_binary_cpu_based) {
+		char fname[PATH_MAX];
+		if (input_dir)
+			sprintf(fname, "%s/", input_dir);
+
+		snprintf(fname + len, sizeof(pci->fname)-1-len,
+			"%s.blkparse.%d.bin", pdi->name, pci->cpu);
+
+		pci->out_bin = fopen(fname, "w");
+		if (!pci->out_bin) {
+			perror(fname);
+			pci->out_bin = NULL;
+			return 0;
+		}
+	}
+
 	printf("Input file %s added\n", pci->fname);
 	cpu_mark_online(pdi, pci->cpu);
 
@@ -2825,6 +2855,18 @@ static int do_file(void)
 	while (!is_done() && ms_head && handle(ms_head))
 		;
 
+	/*
+	 * Flush cpu based binary output files in the end
+	 */
+	if (pdi && dump_binary_cpu_based) {
+		struct per_cpu_info *pci;
+		for (cpu = 0; cpu < pdi->ncpus; cpu++) {
+			pci = get_cpu_info(pdi, cpu);
+			fflush(pci->out_bin);
+			printf("CPU%d binary file flushed\n", cpu);
+		}
+	}
+
 	return 0;
 }
 
@@ -2837,7 +2879,7 @@ static void do_pipe(int fd)
 	fdblock = -1;
 	while ((events = read_events(fd, 0, &fdblock)) > 0) {
 		read_sequence++;
-	
+
 #if 0
 		smallest_seq_read = -1U;
 #endif
@@ -2986,7 +3028,7 @@ static int get_program_sort_event(const char *str)
 	return 0;
 }
 
-#define S_OPTS  "a:A:b:D:d:f:F:hi:o:OqsS:tw:vVM"
+#define S_OPTS  "a:A:b:D:d:f:F:hi:o:OqsS:tw:vVMc"
 static char usage_str[] =    "\n\n" \
 	"-i <file>           | --input=<file>\n" \
 	"[ -a <action field> | --act-mask=<action field> ]\n" \
@@ -3010,7 +3052,8 @@ static char usage_str[] =    "\n\n" \
 	"\t-a Only trace specified actions. See documentation\n" \
 	"\t-A Give trace mask as a single value. See documentation\n" \
 	"\t-b stdin read batching\n" \
-	"\t-d Output file. If specified, binary data is written to file\n" \
+	"\t-c Output file. If specified, binary data is written to multiple files, one for each CPU core"
+	"\t-d Output file. If specified, binary data is written to one single file\n" \
 	"\t-D Directory to prepend to input file names\n" \
 	"\t-f Output format. Customize the output format. The format field\n" \
 	"\t   identifies can be found in the documentation\n" \
@@ -3059,7 +3102,7 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'A':
-			if ((sscanf(optarg, "%x", &i) != 1) || 
+			if ((sscanf(optarg, "%x", &i) != 1) ||
 							!valid_act_opt(i)) {
 				fprintf(stderr,
 					"Invalid set action mask %s/0x%x\n",
@@ -3129,6 +3172,9 @@ int main(int argc, char *argv[])
 		case 'M':
 			bin_output_msgs = 0;
 			break;
+		case 'c':
+			dump_binary_cpu_based = 1;
+			break;
 		default:
 			usage(argv[0]);
 			return 1;
diff --git a/blktrace.h b/blktrace.h
index 944fc08..15fddaf 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -51,6 +51,7 @@ struct per_cpu_info {
 	int fd;
 	int fdblock;
 	char fname[PATH_MAX];
+	FILE *out_bin;
 
 	struct io_stats io_stats;
 
-- 
2.20.1
