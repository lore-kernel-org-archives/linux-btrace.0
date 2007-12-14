From: Christof Schmitt <christof.schmitt@de.ibm.com>
Date: Fri, 14 Dec 2007 08:42:37 +0000
Subject: blkparse: account PC block requests for stats
Message-Id: <20071214084236.GA7417@schmichrtp.de.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

When trying to analyze I/O data for SCSI tape drives (with the patch
to enable tracing on sg devices), i found that blkparse does not
include the requests in the stats summary at the end.

The requests i am looking at are passed from scsi_execute_async() (in
drivers/scsi/scsi_lib.c) to the block layer and are marked as
REQ_TYPE_BLOCK_PC. In blkparse, these requests are only logged, but
not included in the overall accounting. I added some calls to log the
data in the draft patch below. But then i am wondering what is the
difference between dump_trace_pc() and dump_trace_fs(). Could these
functions be merged to get the same data for fs and pc requests?

Christof Schmitt

---
 blkparse.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/blkparse.c	2007-11-01 17:28:23.000000000 +0100
+++ b/blkparse.c	2007-12-14 09:04:55.000000000 +0100
@@ -1350,9 +1350,11 @@ static void log_pc(struct per_cpu_info *
 static void dump_trace_pc(struct blk_io_trace *t, struct per_cpu_info *pci)
 {
 	int act = t->action & 0xffff;
+	int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
 
 	switch (act) {
 		case __BLK_TA_QUEUE:
+			account_queue(t, pci, w);
 			log_generic(pci, t, "Q");
 			break;
 		case __BLK_TA_GETRQ:
@@ -1362,12 +1364,15 @@ static void dump_trace_pc(struct blk_io_
 			log_generic(pci, t, "S");
 			break;
 		case __BLK_TA_REQUEUE:
+			account_requeue(t, pci, w);
 			log_generic(pci, t, "R");
 			break;
 		case __BLK_TA_ISSUE:
+			account_issue(t, pci, w);
 			log_pc(pci, t, "D");
 			break;
 		case __BLK_TA_COMPLETE:
+			account_c(t, pci, w, t->bytes);
 			log_pc(pci, t, "C");
 			break;
 		case __BLK_TA_INSERT:
