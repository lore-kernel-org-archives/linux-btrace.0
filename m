From: Christof Schmitt <christof.schmitt@de.ibm.com>
Date: Mon, 07 Jan 2008 07:50:58 +0000
Subject: [patch 1/2] blkparse: Add PC requests to depth trace
Message-Id: <20080107075445.459210000@de.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Christof Schmitt <christof.schmitt@de.ibm.com>

The PC requests use the same queue and also contribute to the
queue length, so they should be added to the queue depth trace.

Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>

--- a/blkparse.c	2008-01-04 09:11:54.000000000 +0100
+++ b/blkparse.c	2008-01-04 11:30:36.000000000 +0100
@@ -1347,8 +1347,10 @@ static void log_pc(struct per_cpu_info *
 	process_fmt(act, pci, t, -1ULL, t->pdu_len, buf);
 }
 
-static void dump_trace_pc(struct blk_io_trace *t, struct per_cpu_info *pci)
+static void dump_trace_pc(struct blk_io_trace *t, struct per_dev_info *pdi,
+			  struct per_cpu_info *pci)
 {
+	int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
 	int act = t->action & 0xffff;
 
 	switch (act) {
@@ -1362,12 +1364,25 @@ static void dump_trace_pc(struct blk_io_
 			log_generic(pci, t, "S");
 			break;
 		case __BLK_TA_REQUEUE:
+			/*
+			 * can happen if we miss traces, don't let it go
+			 * below zero
+			 */
+			if (pdi->cur_depth[w])
+				pdi->cur_depth[w]--;
 			log_generic(pci, t, "R");
 			break;
 		case __BLK_TA_ISSUE:
+			pdi->cur_depth[w]++;
+			if (pdi->cur_depth[w] > pdi->max_depth[w])
+				pdi->max_depth[w] = pdi->cur_depth[w];
+
 			log_pc(pci, t, "D");
 			break;
 		case __BLK_TA_COMPLETE:
+			if (pdi->cur_depth[w])
+				pdi->cur_depth[w]--;
+
 			log_pc(pci, t, "C");
 			break;
 		case __BLK_TA_INSERT:
@@ -1463,7 +1478,7 @@ static void dump_trace(struct blk_io_tra
 {
 	if (text_output) {
 		if (t->action & BLK_TC_ACT(BLK_TC_PC))
-			dump_trace_pc(t, pci);
+			dump_trace_pc(t, pdi, pci);
 		else
 			dump_trace_fs(t, pdi, pci);
 	}

-- 
