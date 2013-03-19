From: Ivan Dyukov <i.dyukov@samsung.com>
Date: Tue, 19 Mar 2013 07:44:57 +0000
Subject: patch  for blkparse
Message-Id: <51481779.10404@samsung.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090607040207050502050304"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------090607040207050502050304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello, I have made patch for blkparse utility. I have added more 
accurate calculation of total read/write values. in my test case, I had 
tried to write  small chunks of data(512 bytes each), but blkparse 
ignore such data and that data didn't appear in summary section. I have 
made patch for this mater and attached to this email.

Best regards,
Ivan.

--------------090607040207050502050304
Content-Type: text/x-patch;
 name="read_write_bytes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="read_write_bytes.patch"

commit 2602a606b51f9893756bd1916ec3c3911349922f
Author: Ivan Dyukov <i.dyukov@samsung.com>
Date:   Tue Mar 19 11:13:09 2013 +0400

    More accurate calculation of the total read/write values. If block device has many request with size less than 1K, blkparse ignore such requests because it treat each request in Kb.

diff --git a/blkparse.c b/blkparse.c
index a7ff0f7..a27b3ed 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -1182,9 +1182,11 @@ static inline void __account_m(struct io_stats *ios, struct blk_io_trace *t,
 	if (rw) {
 		ios->mwrites++;
 		ios->mwrite_kb += t_kb(t);
+		ios->mwrite_b += t_b(t);
 	} else {
 		ios->mreads++;
 		ios->mread_kb += t_kb(t);
+		ios->mread_b += t_b(t);
 	}
 }
 
@@ -1206,9 +1208,11 @@ static inline void __account_pc_queue(struct io_stats *ios,
 	if (rw) {
 		ios->qwrites_pc++;
 		ios->qwrite_kb_pc += t_kb(t);
+		ios->qwrite_b_pc += t_b(t);
 	} else {
 		ios->qreads_pc++;
 		ios->qread_kb += t_kb(t);
+		ios->qread_b_pc += t_b(t);
 	}
 }
 
@@ -1230,9 +1234,11 @@ static inline void __account_pc_issue(struct io_stats *ios, int rw,
 	if (rw) {
 		ios->iwrites_pc++;
 		ios->iwrite_kb_pc += bytes >> 10;
+		ios->iwrite_b_pc += bytes & 1023;
 	} else {
 		ios->ireads_pc++;
 		ios->iread_kb_pc += bytes >> 10;
+		ios->iread_b_pc += bytes & 1023;
 	}
 }
 
@@ -1254,9 +1260,11 @@ static inline void __account_pc_requeue(struct io_stats *ios,
 	if (rw) {
 		ios->wrqueue_pc++;
 		ios->iwrite_kb_pc -= t_kb(t);
+		ios->iwrite_b_pc -= t_b(t);
 	} else {
 		ios->rrqueue_pc++;
 		ios->iread_kb_pc -= t_kb(t);
+		ios->iread_b_pc -= t_b(t);
 	}
 }
 
@@ -1298,9 +1306,11 @@ static inline void __account_queue(struct io_stats *ios, struct blk_io_trace *t,
 	if (rw) {
 		ios->qwrites++;
 		ios->qwrite_kb += t_kb(t);
+		ios->qwrite_b += t_b(t);
 	} else {
 		ios->qreads++;
 		ios->qread_kb += t_kb(t);
+		ios->qread_b += t_b(t);
 	}
 }
 
@@ -1321,9 +1331,11 @@ static inline void __account_c(struct io_stats *ios, int rw, int bytes)
 	if (rw) {
 		ios->cwrites++;
 		ios->cwrite_kb += bytes >> 10;
+		ios->cwrite_b += bytes & 1023;
 	} else {
 		ios->creads++;
 		ios->cread_kb += bytes >> 10;
+		ios->cread_b += bytes & 1023;
 	}
 }
 
@@ -1345,9 +1357,11 @@ static inline void __account_issue(struct io_stats *ios, int rw,
 	if (rw) {
 		ios->iwrites++;
 		ios->iwrite_kb += bytes >> 10;
+		ios->iwrite_b  += bytes & 1023;
 	} else {
 		ios->ireads++;
 		ios->iread_kb += bytes >> 10;
+		ios->iread_b  += bytes & 1023;
 	}
 }
 
@@ -1389,9 +1403,11 @@ static inline void __account_requeue(struct io_stats *ios,
 	if (rw) {
 		ios->wrqueue++;
 		ios->iwrite_kb -= t_kb(t);
+		ios->iwrite_b -= t_b(t);
 	} else {
 		ios->rrqueue++;
 		ios->iread_kb -= t_kb(t);
+		ios->iread_b -= t_b(t);
 	}
 }
 
@@ -1654,26 +1670,55 @@ static void dump_io_stats(struct per_dev_info *pdi, struct io_stats *ios,
 
 	fprintf(ofp, "%s\n", msg);
 
-	fprintf(ofp, " Reads Queued:    %s, %siB\t", size_cnv(x, ios->qreads, 0), size_cnv(y, ios->qread_kb, 1));
-	fprintf(ofp, " Writes Queued:    %s, %siB\n", size_cnv(x, ios->qwrites, 0), size_cnv(y, ios->qwrite_kb, 1));
-	fprintf(ofp, " Read Dispatches: %s, %siB\t", size_cnv(x, ios->ireads, 0), size_cnv(y, ios->iread_kb, 1));
-	fprintf(ofp, " Write Dispatches: %s, %siB\n", size_cnv(x, ios->iwrites, 0), size_cnv(y, ios->iwrite_kb, 1));
+	fprintf(ofp, " Reads Queued:    %s, %siB\t",
+			size_cnv(x, ios->qreads, 0),
+			size_cnv(y, ios->qread_kb + (ios->qread_b>>10), 1));
+	fprintf(ofp, " Writes Queued:    %s, %siB\n",
+			size_cnv(x, ios->qwrites, 0),
+			size_cnv(y, ios->qwrite_kb + (ios->qwrite_b>>10), 1));
+	fprintf(ofp, " Read Dispatches: %s, %siB\t",
+			size_cnv(x, ios->ireads, 0),
+			size_cnv(y, ios->iread_kb + (ios->iread_b>>10), 1));
+	fprintf(ofp, " Write Dispatches: %s, %siB\n",
+			size_cnv(x, ios->iwrites, 0),
+			size_cnv(y, ios->iwrite_kb + (ios->iwrite_b>>10), 1));
 	fprintf(ofp, " Reads Requeued:  %s\t\t", size_cnv(x, ios->rrqueue, 0));
 	fprintf(ofp, " Writes Requeued:  %s\n", size_cnv(x, ios->wrqueue, 0));
-	fprintf(ofp, " Reads Completed: %s, %siB\t", size_cnv(x, ios->creads, 0), size_cnv(y, ios->cread_kb, 1));
-	fprintf(ofp, " Writes Completed: %s, %siB\n", size_cnv(x, ios->cwrites, 0), size_cnv(y, ios->cwrite_kb, 1));
-	fprintf(ofp, " Read Merges:     %s, %siB\t", size_cnv(x, ios->mreads, 0), size_cnv(y, ios->mread_kb, 1));
-	fprintf(ofp, " Write Merges:     %s, %siB\n", size_cnv(x, ios->mwrites, 0), size_cnv(y, ios->mwrite_kb, 1));
+	fprintf(ofp, " Reads Completed: %s, %siB\t",
+			size_cnv(x, ios->creads, 0),
+			size_cnv(y, ios->cread_kb + (ios->cread_b>>10), 1));
+	fprintf(ofp, " Writes Completed: %s, %siB\n",
+			size_cnv(x, ios->cwrites, 0),
+			size_cnv(y, ios->cwrite_kb + (ios->cwrite_b>>10), 1));
+	fprintf(ofp, " Read Merges:     %s, %siB\t",
+			size_cnv(x, ios->mreads, 0),
+			size_cnv(y, ios->mread_kb + (ios->mread_b>>10), 1));
+	fprintf(ofp, " Write Merges:     %s, %siB\n",
+			size_cnv(x, ios->mwrites, 0),
+			size_cnv(y, ios->mwrite_kb + (ios->mwrite_b>>10), 1));
 	if (pdi) {
 		fprintf(ofp, " Read depth:      %'8u%8c\t", pdi->max_depth[0], ' ');
 		fprintf(ofp, " Write depth:      %'8u\n", pdi->max_depth[1]);
 	}
 	if (ios->qreads_pc || ios->qwrites_pc || ios->ireads_pc || ios->iwrites_pc ||
 	    ios->rrqueue_pc || ios->wrqueue_pc || ios->creads_pc || ios->cwrites_pc) {
-		fprintf(ofp, " PC Reads Queued: %s, %siB\t", size_cnv(x, ios->qreads_pc, 0), size_cnv(y, ios->qread_kb_pc, 1));
-		fprintf(ofp, " PC Writes Queued: %s, %siB\n", size_cnv(x, ios->qwrites_pc, 0), size_cnv(y, ios->qwrite_kb_pc, 1));
-		fprintf(ofp, " PC Read Disp.:   %s, %siB\t", size_cnv(x, ios->ireads_pc, 0), size_cnv(y, ios->iread_kb_pc, 1));
-		fprintf(ofp, " PC Write Disp.:   %s, %siB\n", size_cnv(x, ios->iwrites_pc, 0), size_cnv(y, ios->iwrite_kb_pc, 1));
+		fprintf(ofp, " PC Reads Queued: %s, %siB\t",
+			size_cnv(x, ios->qreads_pc, 0),
+			size_cnv(y,
+				ios->qread_kb_pc + (ios->qread_b_pc>>10), 1));
+		fprintf(ofp, " PC Writes Queued: %s, %siB\n",
+			size_cnv(x, ios->qwrites_pc, 0),
+			size_cnv(y,
+				ios->qwrite_kb_pc + (ios->qwrite_b_pc>>10), 1));
+		fprintf(ofp, " PC Read Disp.:   %s, %siB\t",
+			size_cnv(x, ios->ireads_pc, 0),
+			size_cnv(y,
+				ios->iread_kb_pc + (ios->iread_b_pc>>10), 1));
+		fprintf(ofp, " PC Write Disp.:   %s, %siB\n",
+			size_cnv(x, ios->iwrites_pc, 0),
+			size_cnv(y,
+				ios->iwrite_kb_pc + (ios->iwrite_b_pc>>10),
+				1));
 		fprintf(ofp, " PC Reads Req.:   %s\t\t", size_cnv(x, ios->rrqueue_pc, 0));
 		fprintf(ofp, " PC Writes Req.:   %s\n", size_cnv(x, ios->wrqueue_pc, 0));
 		fprintf(ofp, " PC Reads Compl.: %s\t\t", size_cnv(x, ios->creads_pc, 0));
@@ -1808,6 +1853,14 @@ static void show_device_and_cpu_stats(void)
 			total.iwrite_kb += ios->iwrite_kb;
 			total.mread_kb += ios->mread_kb;
 			total.mwrite_kb += ios->mwrite_kb;
+			total.qread_b += ios->qread_b;
+			total.qwrite_b += ios->qwrite_b;
+			total.cread_b += ios->cread_b;
+			total.cwrite_b += ios->cwrite_b;
+			total.iread_b += ios->iread_b;
+			total.iwrite_b += ios->iwrite_b;
+			total.mread_b += ios->mread_b;
+			total.mwrite_b += ios->mwrite_b;
 
 			total.qreads_pc += ios->qreads_pc;
 			total.qwrites_pc += ios->qwrites_pc;
@@ -1821,6 +1874,10 @@ static void show_device_and_cpu_stats(void)
 			total.qwrite_kb_pc += ios->qwrite_kb_pc;
 			total.iread_kb_pc += ios->iread_kb_pc;
 			total.iwrite_kb_pc += ios->iwrite_kb_pc;
+			total.qread_b_pc += ios->qread_b_pc;
+			total.qwrite_b_pc += ios->qwrite_b_pc;
+			total.iread_b_pc += ios->iread_b_pc;
+			total.iwrite_b_pc += ios->iwrite_b_pc;
 
 			total.timer_unplugs += ios->timer_unplugs;
 			total.io_unplugs += ios->io_unplugs;
@@ -1841,8 +1898,10 @@ static void show_device_and_cpu_stats(void)
 		wrate = rrate = 0;
 		msec = (pdi->last_reported_time - pdi->first_reported_time) / 1000000;
 		if (msec) {
-			rrate = 1000 * total.cread_kb / msec;
-			wrate = 1000 * total.cwrite_kb / msec;
+			rrate = ((1000 * total.cread_kb) + total.cread_b) /
+									msec;
+			wrate = ((1000 * total.cwrite_kb) + total.cwrite_b) /
+									msec;
 		}
 
 		fprintf(ofp, "\nThroughput (R/W): %'LuKiB/s / %'LuKiB/s\n",
diff --git a/blktrace.h b/blktrace.h
index 5da6dbc..380aec7 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -23,6 +23,7 @@
 
 #define t_sec(t)	((t)->bytes >> 9)
 #define t_kb(t)		((t)->bytes >> 10)
+#define t_b(t)		((t)->bytes & 1023)
 
 typedef __u32 u32;
 typedef __u8 u8;
@@ -31,11 +32,14 @@ struct io_stats {
 	unsigned long qreads, qwrites, creads, cwrites, mreads, mwrites;
 	unsigned long ireads, iwrites, rrqueue, wrqueue;
 	unsigned long long qread_kb, qwrite_kb, cread_kb, cwrite_kb;
+	unsigned long long qread_b, qwrite_b, cread_b, cwrite_b;
 	unsigned long long iread_kb, iwrite_kb;
 	unsigned long long mread_kb, mwrite_kb;
+	unsigned long long mread_b, mwrite_b, iread_b, iwrite_b;
 	unsigned long qreads_pc, qwrites_pc, ireads_pc, iwrites_pc;
 	unsigned long rrqueue_pc, wrqueue_pc, creads_pc, cwrites_pc;
 	unsigned long long qread_kb_pc, qwrite_kb_pc, iread_kb_pc, iwrite_kb_pc;
+	unsigned long long qread_b_pc, qwrite_b_pc, iread_b_pc, iwrite_b_pc;
 	unsigned long io_unplugs, timer_unplugs;
 };
 

--------------090607040207050502050304--
