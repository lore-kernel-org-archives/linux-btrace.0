From: Christof Schmitt <christof.schmitt@de.ibm.com>
Date: Fri, 29 Feb 2008 11:59:38 +0000
Subject: [patch 2/2] blkparse: Introduce optional accounting of PC requests
Message-Id: <20080229120314.552422000@de.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080107075446.155572000@de.ibm.com>
In-Reply-To: <20080107075446.155572000@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The current blkparse lists only PC requests, but does not account for
number of PC requests and the size of the attached data.  This patch
introduces optional accounting for PC requests.  If any PC event was
encountered, the summary output will also include data from PC
requests.

For PC completion events the amount of transferred data is not
available, since the kernel uses the data_len field as residual bytes
count on event completion.

Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>

--- a/blktrace.h	2008-01-14 07:42:45.000000000 +0100
+++ b/blktrace.h	2008-01-14 07:59:24.000000000 +0100
@@ -32,6 +32,9 @@ struct io_stats {
 	unsigned long long qread_kb, qwrite_kb, cread_kb, cwrite_kb;
 	unsigned long long iread_kb, iwrite_kb;
 	unsigned long long mread_kb, mwrite_kb;
+	unsigned long qreads_pc, qwrites_pc, ireads_pc, iwrites_pc;
+	unsigned long rrqueue_pc, wrqueue_pc, creads_pc, cwrites_pc;
+	unsigned long long qread_kb_pc, qwrite_kb_pc, iread_kb_pc, iwrite_kb_pc;
 	unsigned long io_unplugs, timer_unplugs;
 };
 
--- a/blkparse.c	2008-01-14 07:45:20.000000000 +0100
+++ b/blkparse.c	2008-01-14 08:10:28.000000000 +0100
@@ -1168,6 +1168,98 @@ static inline void account_m(struct blk_
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
+static inline void __account_pc_requeue(struct io_stats *ios,
+					struct blk_io_trace *t, int rw)
+{
+	if (rw) {
+		ios->wrqueue_pc++;
+		ios->iwrite_kb_pc -= t_kb(t);
+	} else {
+		ios->rrqueue_pc++;
+		ios->iread_kb_pc -= t_kb(t);
+	}
+}
+
+static inline void account_pc_requeue(struct blk_io_trace *t,
+				      struct per_cpu_info *pci, int rw)
+{
+	__account_pc_requeue(&pci->io_stats, t, rw);
+
+	if (per_process_stats) {
+		struct io_stats *ios = find_process_io_stats(t->pid);
+
+		__account_pc_requeue(ios, t, rw);
+	}
+}
+
+static inline void __account_pc_c(struct io_stats *ios, int rw)
+{
+	if (rw)
+		ios->cwrites_pc++;
+	else
+		ios->creads_pc++;
+}
+
+static inline void account_pc_c(struct blk_io_trace *t,
+				struct per_cpu_info *pci, int rw)
+{
+	__account_pc_c(&pci->io_stats, rw);
+
+	if (per_process_stats) {
+		struct io_stats *ios = find_process_io_stats(t->pid);
+
+		__account_pc_c(ios, rw);
+	}
+}
+
 static inline void __account_queue(struct io_stats *ios, struct blk_io_trace *t,
 				   int rw)
 {
@@ -1356,6 +1448,7 @@ static void dump_trace_pc(struct blk_io_
 	switch (act) {
 		case __BLK_TA_QUEUE:
 			log_generic(pci, t, "Q");
+			account_pc_queue(t, pci, w);
 			break;
 		case __BLK_TA_GETRQ:
 			log_generic(pci, t, "G");
@@ -1370,9 +1463,11 @@ static void dump_trace_pc(struct blk_io_
 			 */
 			if (pdi->cur_depth[w])
 				pdi->cur_depth[w]--;
+			account_pc_requeue(t, pci, w);
 			log_generic(pci, t, "R");
 			break;
 		case __BLK_TA_ISSUE:
+			account_pc_issue(t, pci, w);
 			pdi->cur_depth[w]++;
 			if (pdi->cur_depth[w] > pdi->max_depth[w])
 				pdi->max_depth[w] = pdi->cur_depth[w];
@@ -1382,6 +1477,7 @@ static void dump_trace_pc(struct blk_io_
 			if (pdi->cur_depth[w])
 				pdi->cur_depth[w]--;
 			log_pc(pci, t, "C");
+			account_pc_c(t, pci, w);
 			break;
 		case __BLK_TA_INSERT:
 			log_pc(pci, t, "I");
@@ -1531,6 +1627,17 @@ static void dump_io_stats(struct per_dev
 		fprintf(ofp, " Read depth:      %'8u%8c\t", pdi->max_depth[0], ' ');
 		fprintf(ofp, " Write depth:      %'8u\n", pdi->max_depth[1]);
 	}
+	if (ios->qreads_pc || ios->qwrites_pc || ios->ireads_pc || ios->iwrites_pc ||
+	    ios->rrqueue_pc || ios->wrqueue_pc || ios->creads_pc || ios->cwrites_pc) {
+		fprintf(ofp, " PC Reads Queued: %s, %siB\t", size_cnv(x, ios->qreads_pc, 0), size_cnv(y, ios->qread_kb_pc, 1));
+		fprintf(ofp, " PC Writes Queued: %s, %siB\n", size_cnv(x, ios->qwrites_pc, 0), size_cnv(y, ios->qwrite_kb_pc, 1));
+		fprintf(ofp, " PC Read Disp.:   %s, %siB\t", size_cnv(x, ios->ireads_pc, 0), size_cnv(y, ios->iread_kb_pc, 1));
+		fprintf(ofp, " PC Write Disp.:   %s, %siB\n", size_cnv(x, ios->iwrites_pc, 0), size_cnv(y, ios->iwrite_kb_pc, 1));
+		fprintf(ofp, " PC Reads Req.:   %s\t\t", size_cnv(x, ios->rrqueue_pc, 0));
+		fprintf(ofp, " PC Writes Req.:   %s\n", size_cnv(x, ios->wrqueue_pc, 0));
+		fprintf(ofp, " PC Reads Compl.: %s\t\t", size_cnv(x, ios->creads_pc, 0));
+		fprintf(ofp, " PC Writes Compl.: %s\n", size_cnv(x, ios->cwrites, 0));
+	}
 	fprintf(ofp, " IO unplugs:      %'8lu%8c\t", ios->io_unplugs, ' ');
 	fprintf(ofp, " Timer unplugs:    %'8lu\n", ios->timer_unplugs);
 }
@@ -1660,6 +1767,20 @@ static void show_device_and_cpu_stats(vo
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
+			total.rrqueue_pc += ios->rrqueue_pc;
+			total.wrqueue_pc += ios->wrqueue_pc;
+			total.qread_kb_pc += ios->qread_kb_pc;
+			total.qwrite_kb_pc += ios->qwrite_kb_pc;
+			total.iread_kb_pc += ios->iread_kb_pc;
+			total.iwrite_kb_pc += ios->iwrite_kb_pc;
+
 			total.timer_unplugs += ios->timer_unplugs;
 			total.io_unplugs += ios->io_unplugs;
 

-- 
