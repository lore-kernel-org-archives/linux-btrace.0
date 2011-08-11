From: Namhyung Kim <namhyung@gmail.com>
Date: Thu, 11 Aug 2011 10:32:30 +0000
Subject: [PATCH] Add FLUSH/FUA support
Message-Id: <1313058750-1719-1-git-send-email-namhyung@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Add FLUSH/FUA support to blktrace. As FLUSH precedes WRITE and/or
FUA follows WRITE, use the same 'F' flag for both cases and
distinguish them by their (relative) position. The end results
look like (other flags might be shown also):

 - WRITE:            W
 - WRITE_FLUSH:      FW
 - WRITE_FUA:        WF
 - WRITE_FLUSH_FUA:  FWF

Note that we reuse TC_BARRIER due to lack of bit space of act_mask.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 act_mask.c     |    3 ++-
 blkparse_fmt.c |   17 +++++++++++------
 blkrawverify.c |    3 ++-
 blktrace_api.h |    5 +++--
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/act_mask.c b/act_mask.c
index 6d5c193..8f1b8d7 100644
--- a/act_mask.c
+++ b/act_mask.c
@@ -15,7 +15,7 @@ struct mask_map {
 static struct mask_map mask_maps[] = {
 	DECLARE_MASK_MAP(READ),
 	DECLARE_MASK_MAP(WRITE),
-	DECLARE_MASK_MAP(BARRIER),
+	DECLARE_MASK_MAP(FLUSH),
 	DECLARE_MASK_MAP(SYNC),
 	DECLARE_MASK_MAP(QUEUE),
 	DECLARE_MASK_MAP(REQUEUE),
@@ -28,6 +28,7 @@ static struct mask_map mask_maps[] = {
 	DECLARE_MASK_MAP(META),
 	DECLARE_MASK_MAP(DISCARD),
 	DECLARE_MASK_MAP(DRV_DATA),
+	DECLARE_MASK_MAP(FUA),
 };
 
 int find_mask_map(char *string)
diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index ed6cd5c..c42e6d7 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -54,12 +54,16 @@ static inline void fill_rwbs(char *rwbs, struct blk_io_trace *t)
 {
 	int w = t->action & BLK_TC_ACT(BLK_TC_WRITE);
 	int a = t->action & BLK_TC_ACT(BLK_TC_AHEAD);
-	int b = t->action & BLK_TC_ACT(BLK_TC_BARRIER);
 	int s = t->action & BLK_TC_ACT(BLK_TC_SYNC);
 	int m = t->action & BLK_TC_ACT(BLK_TC_META);
 	int d = t->action & BLK_TC_ACT(BLK_TC_DISCARD);
+	int f = t->action & BLK_TC_ACT(BLK_TC_FLUSH);
+	int u = t->action & BLK_TC_ACT(BLK_TC_FUA);
 	int i = 0;
 
+	if (f)
+		rwbs[i++] = 'F'; /* flush */
+
 	if (d)
 		rwbs[i++] = 'D';
 	else if (w)
@@ -68,10 +72,11 @@ static inline void fill_rwbs(char *rwbs, struct blk_io_trace *t)
 		rwbs[i++] = 'R';
 	else
 		rwbs[i++] = 'N';
+
+	if (u)
+		rwbs[i++] = 'F'; /* fua */
 	if (a)
 		rwbs[i++] = 'A';
-	if (b)
-		rwbs[i++] = 'B';
 	if (s)
 		rwbs[i++] = 'S';
 	if (m)
@@ -188,7 +193,7 @@ static void print_field(char *act, struct per_cpu_info *pci,
 		break;
 	}
 	case 'd': {
-		char rwbs[6];
+		char rwbs[8];
 
 		fill_rwbs(rwbs, t);
 		fprintf(ofp, strcat(format, "s"), rwbs);
@@ -285,7 +290,7 @@ static void process_default(char *act, struct per_cpu_info *pci,
 			    int pdu_len, unsigned char *pdu_buf)
 {
 	struct blk_io_trace_remap r = { .device_from = 0, };
-	char rwbs[6];
+	char rwbs[8];
 	char *name;
 
 	fill_rwbs(rwbs, t);
@@ -445,7 +450,7 @@ void process_fmt(char *act, struct per_cpu_info *pci, struct blk_io_trace *t,
 			case 'r': fprintf(ofp, "\r"); break;
 			case 't': fprintf(ofp, "\t"); break;
 			default:
-				fprintf(stderr,	
+				fprintf(stderr,
 					"Invalid escape char in format %c\n",
 					p[1]);
 				exit(1);
diff --git a/blkrawverify.c b/blkrawverify.c
index e669179..b6ceb9d 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -39,7 +39,7 @@ int data_is_native = -1;
 static struct trace_info traces[] = {
 	TRACE_TO_STRING( BLK_TC_READ ),
 	TRACE_TO_STRING( BLK_TC_WRITE ),
-	TRACE_TO_STRING( BLK_TC_BARRIER ),
+	TRACE_TO_STRING( BLK_TC_FLUSH ),
 	TRACE_TO_STRING( BLK_TC_SYNC ),
 	TRACE_TO_STRING( BLK_TC_QUEUE ),
 	TRACE_TO_STRING( BLK_TC_REQUEUE ),
@@ -50,6 +50,7 @@ static struct trace_info traces[] = {
 	TRACE_TO_STRING( BLK_TC_AHEAD ),
 	TRACE_TO_STRING( BLK_TC_META ),
 	TRACE_TO_STRING( BLK_TC_DISCARD ),
+	TRACE_TO_STRING( BLK_TC_FUA ),
 };
 #define N_TRACES (sizeof(traces) / sizeof(struct trace_info))
 
diff --git a/blktrace_api.h b/blktrace_api.h
index ba9ee60..b222218 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -9,7 +9,7 @@
 enum {
 	BLK_TC_READ	= 1 << 0,	/* reads */
 	BLK_TC_WRITE	= 1 << 1,	/* writes */
-	BLK_TC_BARRIER	= 1 << 2,	/* barrier */
+	BLK_TC_FLUSH	= 1 << 2,	/* flush */
 	BLK_TC_SYNC	= 1 << 3,	/* sync */
 	BLK_TC_QUEUE	= 1 << 4,	/* queueing/merging */
 	BLK_TC_REQUEUE	= 1 << 5,	/* requeueing */
@@ -22,8 +22,9 @@ enum {
 	BLK_TC_META	= 1 << 12,	/* metadata */
 	BLK_TC_DISCARD	= 1 << 13,	/* discard requests */
 	BLK_TC_DRV_DATA	= 1 << 14,	/* binary driver data */
+	BLK_TC_FUA	= 1 << 15,	/* fua requests */
 
-	BLK_TC_END	= 1 << 15,	/* only 16-bits, reminder */
+	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
 };
 
 #define BLK_TC_SHIFT		(16)
-- 
1.7.6

