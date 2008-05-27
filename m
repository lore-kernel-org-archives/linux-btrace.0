From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 27 May 2008 12:47:11 +0000
Subject: [PATCH 1/2] Added in handling of MESSAGE notes
Message-Id: <483C02CF.4040508@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


Sample output:

  8,16   1   691118    17.417000000     0  C   R 2660776 + 8 [0]
  8,16   1   691119    17.417000000     0  D   R 2660792 + 8 [swapper]
  8,16   1   691120    17.417000000  4688  U   N [dd] 42
  8,16   1        0    17.418000000     0  m   N elv switch: noop
  8,16   1   691121    17.418000000  4638  C   R 2660784 + 8 [0]
  8,16   1   691122    17.418000000  4638  D   R 2660800 + 8 [bash]
  8,16   1   691123    17.418000000  4638  C   R 2660792 + 8 [0]

Thanks to Carl Henrik Lunde <chlunde@ping.uio.no> for adding in sequence
printing & time-stamp correction.

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 blkparse.c     |   24 +++++++++++++++++++++---
 blkparse_fmt.c |    6 +++++-
 blktrace_api.h |    2 ++
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 517dde5..3c31db6 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -590,6 +590,22 @@ static void handle_notify(struct blk_io_trace *bit)

 		break;

+	case BLK_TN_MESSAGE:
+		if (bit->pdu_len > 0) {
+			char msg[bit->pdu_len+1];
+
+			memcpy(msg, (char *)payload, bit->pdu_len);
+			msg[bit->pdu_len] = '\0';
+
+			fprintf(ofp,
+				"%3d,%-3d %2d %8s %5d.%09lu %5u %2s %3s %s\n",
+				MAJOR(bit->device), MINOR(bit->device),
+				bit->cpu, "0", (int) SECONDS(bit->time),
+				(unsigned long) NANO_SECONDS(bit->time),
+				0, "m", "N", msg);
+		}
+		break;
+
 	default:
 		/* Ignore unknown notify events */
 		;
@@ -1577,7 +1593,9 @@ static void dump_trace(struct blk_io_trace *t,
struct per_cpu_info *pci,
 		       struct per_dev_info *pdi)
 {
 	if (text_output) {
-		if (t->action & BLK_TC_ACT(BLK_TC_PC))
+		if (t->action = BLK_TN_MESSAGE)
+			handle_notify(t);
+		else if (t->action & BLK_TC_ACT(BLK_TC_PC))
 			dump_trace_pc(t, pdi, pci);
 		else
 			dump_trace_fs(t, pdi, pci);
@@ -2176,7 +2194,7 @@ static int read_events(int fd, int always_block,
int *fdblock)
 		/*
 		 * not a real trace, so grab and handle it here
 		 */
-		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY)) {
+		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && bit->action !BLK_TN_MESSAGE) {
 			handle_notify(bit);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
 			continue;
@@ -2319,7 +2337,7 @@ static int ms_prime(struct ms_stream *msp)
 		if (verify_trace(bit))
 			goto err;

-		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY)) {
+		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && bit->action !BLK_TN_MESSAGE) {
 			handle_notify(bit);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
 			bit_free(bit);
diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 2f21f6b..364f27c 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -390,12 +390,16 @@ static void process_default(char *act, struct
per_cpu_info *pci,
 			MAJOR(r.device), MINOR(r.device),
 			(unsigned long long) r.sector);
 		break;
-		
+
 	case 'X': 	/* Split */
 		fprintf(ofp, "%llu / %u [%s]\n", (unsigned long long) t->sector,
 			get_pdu_int(t), name);
 		break;

+	case 'm':	/* Message */
+		fprintf(ofp, "%*s\n", pdu_len, pdu_buf);
+		break;
+
 	default:
 		fprintf(stderr, "Unknown action %c\n", act[0]);
 		break;
diff --git a/blktrace_api.h b/blktrace_api.h
index 61b405a..67720de 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -54,6 +54,7 @@ enum {
 enum blktrace_notify {
 	__BLK_TN_PROCESS = 0,		/* establish pid/name mapping */
 	__BLK_TN_TIMESTAMP,		/* include system clock */
+	__BLK_TN_MESSAGE,               /* Character string message */
 };

 /*
@@ -77,6 +78,7 @@ enum blktrace_notify {

 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
+#define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))

 #define BLK_IO_TRACE_MAGIC	0x65617400
 #define BLK_IO_TRACE_VERSION	0x07
-- 
1.5.4.3

