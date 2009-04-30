From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Thu, 30 Apr 2009 17:15:50 +0000
Subject: [PATCH] Converted to using the correct remap entries
Message-Id: <49F9DCC6.3030505@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030507020508000307020302"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------030507020508000307020302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------030507020508000307020302
Content-Type: text/x-diff;
 name="0001-Converted-to-using-the-correct-remap-entries.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Converted-to-using-the-correct-remap-entries.patch"

From ba8b1a0720c0342f397c3cd12f9531b53906c451 Mon Sep 17 00:00:00 2001
From: Alan D. Brunelle <alan.brunelle@hp.com>
Date: Thu, 30 Apr 2009 13:10:31 -0400
Subject: [PATCH] Converted to using the correct remap entries

This follows the kernel changes to the blk_io_trace_remap structure to
better align the names of the structure elements with the real intent of
"from" and "to" (devices & sectors).

See the kernel patches @

http://lkml.org/lkml/2009/4/30/340
http://lkml.org/lkml/2009/4/30/341

(Note: since the ABI order didn't change, old user code will work with
the new kernel code & vice versa.)

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 blkparse_fmt.c    |   27 ++++++++++++++++-----------
 blktrace_api.h    |    4 ++--
 btt/trace_remap.c |    9 ++++-----
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 83a8504..ed6cd5c 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -152,11 +152,11 @@ static unsigned int get_pdu_int(struct blk_io_trace *t)
 static void get_pdu_remap(struct blk_io_trace *t, struct blk_io_trace_remap *r)
 {
 	struct blk_io_trace_remap *__r = pdu_start(t);
-	__u64 sector = __r->sector;
+	__u64 sector_from = __r->sector_from;
 
-	r->device = be32_to_cpu(__r->device);
 	r->device_from = be32_to_cpu(__r->device_from);
-	r->sector = be64_to_cpu(sector);
+	r->device_to   = be32_to_cpu(__r->device_to);
+	r->sector_from = be64_to_cpu(sector_from);
 }
 
 static void print_field(char *act, struct per_cpu_info *pci,
@@ -284,20 +284,24 @@ static void process_default(char *act, struct per_cpu_info *pci,
 			    struct blk_io_trace *t, unsigned long long elapsed,
 			    int pdu_len, unsigned char *pdu_buf)
 {
-	struct blk_io_trace_remap r = { .device = 0, };
+	struct blk_io_trace_remap r = { .device_from = 0, };
 	char rwbs[6];
 	char *name;
 
 	fill_rwbs(rwbs, t);
 
+	 /*
+	  * For remaps we have to modify the device using the remap structure
+	  * passed up.
+	  */
+	 if (act[0] == 'A') {
+		 get_pdu_remap(t, &r);
+		 t->device = r.device_to;
+	 }
+
 	/*
 	 * The header is always the same
 	 */
-	if (act[0] == 'A') {	/* Remap */
-		get_pdu_remap(t, &r);
-		t->device = r.device_from;
-	}
-
 	fprintf(ofp, "%3d,%-3d %2d %8d %5d.%09lu %5u %2s %3s ",
 		MAJOR(t->device), MINOR(t->device), pci->cpu, t->sequence,
 		(int) SECONDS(t->time), (unsigned long) NANO_SECONDS(t->time),
@@ -388,10 +392,11 @@ static void process_default(char *act, struct per_cpu_info *pci,
 		break;
 
 	case 'A': 	/* remap */
+		get_pdu_remap(t, &r);
 		fprintf(ofp, "%llu + %u <- (%d,%d) %llu\n",
 			(unsigned long long) t->sector, t_sec(t),
-			MAJOR(r.device), MINOR(r.device),
-			(unsigned long long) r.sector);
+			MAJOR(r.device_from), MINOR(r.device_from),
+			(unsigned long long) r.sector_from);
 		break;
 
 	case 'X': 	/* Split */
diff --git a/blktrace_api.h b/blktrace_api.h
index 7218845..ba9ee60 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -110,9 +110,9 @@ struct blk_io_trace {
  * The remap event
  */
 struct blk_io_trace_remap {
-	__u32 device;
 	__u32 device_from;
-	__u64 sector;
+	__u32 device_to;
+	__u64 sector_from;
 };
 
 /*
diff --git a/btt/trace_remap.c b/btt/trace_remap.c
index 8739cda..560ae2b 100644
--- a/btt/trace_remap.c
+++ b/btt/trace_remap.c
@@ -22,9 +22,9 @@
 
 static inline void cvt_pdu_remap(struct blk_io_trace_remap *rp)
 {
-	rp->device = be32_to_cpu(rp->device);
 	rp->device_from = be32_to_cpu(rp->device_from);
-	rp->sector = be64_to_cpu(rp->sector);
+	rp->device_to   = be32_to_cpu(rp->device_to);
+	rp->sector_from = be64_to_cpu(rp->sector_from);
 }
 
 /*
@@ -43,15 +43,14 @@ void trace_remap(struct io *a_iop)
 	rp = a_iop->pdu;
 	cvt_pdu_remap(rp);
 
-	a_iop->t.device = rp->device_from;
 	if (!io_setup(a_iop, IOP_A))
 		goto out;
 
-	q_dip = __dip_find(rp->device);
+	q_dip = __dip_find(rp->device_from);
 	if (!q_dip)
 		goto out;
 
-	q_iop = dip_find_sec(q_dip, IOP_Q, rp->sector);
+	q_iop = dip_find_sec(q_dip, IOP_Q, rp->sector_from);
 	if (q_iop)
 		update_q2a(q_iop, tdelta(q_iop->t.time, a_iop->t.time));
 
-- 
1.6.0.4


--------------030507020508000307020302--
