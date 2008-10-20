From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Mon, 20 Oct 2008 14:16:50 +0000
Subject: [Patch] blkiomon: drv_data traces pass-through
Message-Id: <1224512210.4628.9.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Jens,

I removed this feature when I posted blkiomon in order to be able to
post independent blkiomon and drv_data patches.
Could you apply it as well?

Thanks,
Martin



From: Martin Peschke <mpeschke@linux.vnet.ibm.com>

This patch adds pass-through support for device driver specific traces
to blkiomon. This way we can aggregate block I/O statistics and device
driver specific statistics at the same time.

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>

---
 blkiomon.c |   44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

--- a/blkiomon.c
+++ b/blkiomon.c
@@ -88,7 +88,7 @@ static struct rb_root dstat_tree[2] = { 
 static struct dstat *dstat_list[2] = {};
 static int dstat_curr = 0;
 
-static struct output human, binary, debug;
+static struct output drvdata, human, binary, debug;
 
 static char *msg_q_name = NULL;
 static int msg_q_id = -1, msg_q = -1;
@@ -427,6 +427,26 @@ static struct trace *blkiomon_do_trace(s
 	return t_old;
 }
 
+static int blkiomon_dump_drvdata(struct blk_io_trace *bit, void *pdu_buf)
+{
+	if (!drvdata.fn)
+		return 0;
+
+	if (fwrite(bit, sizeof(*bit), 1, drvdata.fp) != 1)
+		goto failed;
+	if (fwrite(pdu_buf, bit->pdu_len, 1, drvdata.fp) != 1)
+		goto failed;
+	if (drvdata.pipe && fflush(drvdata.fp))
+		goto failed;
+	return 0;
+
+failed:
+	fprintf(stderr, "blkiomon: could not write to %s\n", drvdata.fn);
+	fclose(drvdata.fp);
+	drvdata.fn = NULL;
+	return 1;
+}
+
 static int blkiomon_do_fifo(void)
 {
 	struct trace *t;
@@ -473,6 +493,14 @@ static int blkiomon_do_fifo(void)
 
 		t->sequence = sequence++;
 
+		/* forward low-level device driver trace to other tool */
+		if (bit->action & BLK_TC_ACT(BLK_TC_DRV_DATA)) {
+			driverdata++;
+			if (blkiomon_dump_drvdata(bit, pdu_buf))
+				break;
+			continue;
+		}
+
 		if (!(bit->action & BLK_TC_ACT(BLK_TC_ISSUE | BLK_TC_COMPLETE)))
 			continue;
 
@@ -557,7 +585,7 @@ static void blkiomon_debug(void)
 		leftover, match, mismatch, driverdata, sequence);
 }
 
-#define S_OPTS "b:D:h:I:Q:q:m:V"
+#define S_OPTS "b:d:D:h:I:Q:q:m:V"
 
 static char usage_str[] = "\n\nblkiomon " \
 	"-I <interval>       | --interval=<interval>\n" \
@@ -571,6 +599,7 @@ static char usage_str[] = "\n\nblkiomon 
 	"\t-I   Sample interval.\n" \
 	"\t-h   Human-readable output file.\n" \
 	"\t-b   Binary output file.\n" \
+	"\t-d   Output file for data emitted by low level device driver.\n" \
 	"\t-D   Output file for debugging data.\n" \
 	"\t-Qqm Output to message queue using given ID for messages.\n" \
 	"\t-V   Print program version.\n\n";
@@ -589,6 +618,12 @@ static struct option l_opts[] = {
 		.val = 'b'
 	},
 	{
+		.name = "dump-lldd",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'd'
+	},
+	{
 		.name = "debug",
 		.has_arg = required_argument,
 		.flag = NULL,
@@ -652,6 +687,9 @@ int main(int argc, char *argv[])
 		case 'b':
 			binary.fn = optarg;
 			break;
+		case 'd':
+			drvdata.fn = optarg;
+			break;
 		case 'D':
 			debug.fn = optarg;
 			break;
@@ -691,6 +729,8 @@ int main(int argc, char *argv[])
 		return 1;
 	if (blkiomon_open_output(&binary))
 		return 1;
+	if (blkiomon_open_output(&drvdata))
+		return 1;
 	if (blkiomon_open_output(&debug))
 		return 1;
 	if (blkiomon_open_msg_q())


