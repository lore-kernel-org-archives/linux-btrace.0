From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Sun, 05 Oct 2008 13:07:56 +0000
Subject: [Patch 3/3] driver data: add support to blktrace user space code
Message-Id: <1223212076.4591.26.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216207574.26621.85.camel@kitka.ibm.com>
In-Reply-To: <1216207574.26621.85.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Stefan Raspl <raspl@linux.vnet.ibm.com>

Adds a new type of action 'drv_data' for blktrace to handle binary
driver-specific data. Since the data is binary, blkparse will only put it in
a binary file, not in the regular human-readable output.


Signed-off-by: Stefan Raspl <raspl@linux.vnet.ibm.com>
Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>

---
 act_mask.c     |    1 +
 blkparse.c     |    3 +++
 blktrace_api.h |    3 +++
 3 files changed, 7 insertions(+)

--- a/act_mask.c
+++ b/act_mask.c
@@ -25,6 +25,7 @@ static struct mask_map mask_maps[] = {
 	DECLARE_MASK_MAP(PC),
 	DECLARE_MASK_MAP(AHEAD),
 	DECLARE_MASK_MAP(META),
+	DECLARE_MASK_MAP(DRV_DATA),
 };
 
 int find_mask_map(char *string)
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -20,6 +20,7 @@ enum {
 	BLK_TC_NOTIFY	= 1 << 10,	/* special message */
 	BLK_TC_AHEAD	= 1 << 11,	/* readahead */
 	BLK_TC_META	= 1 << 12,	/* metadata */
+	BLK_TC_DRV_DATA	= 1 << 13,	/* binary driver data */
 
 	BLK_TC_END	= 1 << 15,	/* only 16-bits, reminder */
 };
@@ -46,6 +47,7 @@ enum {
 	__BLK_TA_SPLIT,			/* bio was split */
 	__BLK_TA_BOUNCE,		/* bio was bounced */
 	__BLK_TA_REMAP,			/* bio was remapped */
+	__BLK_TA_DRV_DATA,		/* binary driver data */
 };
 
 /*
@@ -75,6 +77,7 @@ enum blktrace_notify {
 #define BLK_TA_SPLIT		(__BLK_TA_SPLIT)
 #define BLK_TA_BOUNCE		(__BLK_TA_BOUNCE)
 #define BLK_TA_REMAP		(__BLK_TA_REMAP | BLK_TC_ACT(BLK_TC_QUEUE))
+#define BLK_TA_DRV_DATA	(__BLK_TA_DRV_DATA | BLK_TC_ACT(BLK_TC_DRV_DATA))
 
 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
--- a/blkparse.c
+++ b/blkparse.c
@@ -1583,6 +1583,9 @@ static void dump_trace_fs(struct blk_io_
 		case __BLK_TA_REMAP:
 			log_generic(pci, t, "A");
 			break;
+		case __BLK_TA_DRV_DATA:
+			/* dump to binary file only */
+			break;
 		default:
 			fprintf(stderr, "Bad fs action %x\n", t->action);
 			break;


