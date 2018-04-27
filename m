From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:29 +0000
Subject: [PATCH 22/31] blkrawverify: fix dumping of erroneous trace
Message-Id: <20180427130738.102806-23-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Bytes field was output twice.
PID field was missing.

Sort device field among other fields as in struct blk_io_trace.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 blkrawverify.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/blkrawverify.c b/blkrawverify.c
index ed5d258da438..17e36bcf05bb 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -111,12 +111,12 @@ static void dump_trace(FILE *ofp, char *prefix, struct blk_io_trace *bit)
 	fprintf(ofp, "        %8s: %llu\n", "sector", (unsigned long long) bit->sector);
 	fprintf(ofp, "        %8s: %u\n", "bytes", bit->bytes);
 	fprintf(ofp, "        %8s: %s\n", "action", act_to_str(bit->action));
-	fprintf(ofp, "        %8s: %u\n", "bytes", bit->bytes);
+	fprintf(ofp, "        %8s: %u\n", "pid", bit->pid);
+	fprintf(ofp, "        %8s: (%u,%u)\n\n", "device", MAJOR(bit->device),
+							   MINOR(bit->device));
 	fprintf(ofp, "        %8s: %u\n", "cpu", bit->cpu);
 	fprintf(ofp, "        %8s: %u\n", "error", bit->error);
 	fprintf(ofp, "        %8s: %u\n", "pdu_len", bit->pdu_len);
-	fprintf(ofp, "        %8s: (%u,%u)\n\n", "device", MAJOR(bit->device),
-						           MINOR(bit->device));
 }
 
 static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
-- 
2.14.2

