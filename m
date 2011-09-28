From: Adam Crume <adamcrume@gmail.com>
Date: Wed, 28 Sep 2011 17:59:03 +0000
Subject: [PATCH] Adding read/write flag to per-io output.
Message-Id: <4e836c93.1dc4e70a.6d9d.093b@mx.google.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------1.7.0.4"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------1.7.0.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


The per-io dump option for btt (-p) does not print the read/write flag.  This patch adds that flag.

Signed-off-by: Adam Crume <adamcrume@gmail.com>
---
 btt/trace_complete.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)


--------------1.7.0.4
Content-Type: text/x-patch; name="0001-Adding-read-write-flag-to-per-io-output.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-Adding-read-write-flag-to-per-io-output.patch"

diff --git a/btt/trace_complete.c b/btt/trace_complete.c
index 44732c5..ac10480 100644
--- a/btt/trace_complete.c
+++ b/btt/trace_complete.c
@@ -21,31 +21,32 @@
 #include "globals.h"
 
 static inline void __out(FILE *ofp, __u64 tm, enum iop_type type,
-					__u64 sec, __u32 nsec, int indent)
+					__u64 sec, __u32 nsec, int write, int indent)
 {
 	if (tm != (__u64)-1) {
 		if (indent)
 			fprintf(ofp, "         ");
-		fprintf(ofp, "%5d.%09lu %c %10llu+%-4u\n",
+		fprintf(ofp, "%5d.%09lu %c %10llu+%-4u %c\n",
 			(int)SECONDS(tm), (unsigned long)NANO_SECONDS(tm),
-			type2c(type), (unsigned long long)sec, nsec);
+			type2c(type), (unsigned long long)sec, nsec, write?'W':'R');
 	}
 }
 
 static void display_io_track(FILE *ofp, struct io *iop)
 {
+	int w = (iop->t.action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
 	fprintf(ofp, "%3d,%-3d: ", MAJOR(iop->t.device), MINOR(iop->t.device));
-	__out(ofp, iop->t.time, IOP_Q, iop->t.sector, t_sec(&iop->t), 0);
+	__out(ofp, iop->t.time, IOP_Q, iop->t.sector, t_sec(&iop->t), w, 0);
 
 	if (iop->g_time != (__u64)-1)
-		__out(ofp, iop->g_time, IOP_G, iop->t.sector, t_sec(&iop->t),1);
+		__out(ofp, iop->g_time, IOP_G, iop->t.sector, t_sec(&iop->t), w, 1);
 	if (iop->i_time != (__u64)-1)
-		__out(ofp, iop->i_time, IOP_I, iop->t.sector, t_sec(&iop->t),1);
+		__out(ofp, iop->i_time, IOP_I, iop->t.sector, t_sec(&iop->t), w, 1);
 	if (iop->m_time != (__u64)-1)
-		__out(ofp, iop->m_time, IOP_M, iop->t.sector, t_sec(&iop->t),1);
+		__out(ofp, iop->m_time, IOP_M, iop->t.sector, t_sec(&iop->t), w, 1);
 
-	__out(ofp, iop->d_time, IOP_D, iop->d_sec, iop->d_nsec, 1);
-	__out(ofp, iop->c_time, IOP_C, iop->c_sec, iop->c_nsec, 1);
+	__out(ofp, iop->d_time, IOP_D, iop->d_sec, iop->d_nsec, w, 1);
+	__out(ofp, iop->c_time, IOP_C, iop->c_sec, iop->c_nsec, w, 1);
 	fprintf(ofp, "\n");
 }
 

--------------1.7.0.4--


