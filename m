From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Tue, 28 Oct 2008 16:08:07 +0000
Subject: [Patch 4/6] blkiomon: fix some debug messages
Message-Id: <1225210087.1060.32.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Martin Peschke <mpeschke@linux.vnet.ibm.com>

Cleaning up error messages. Some perror()'s didn't make sense. 

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>
---
 blkiomon.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

--- a/blkiomon.c
+++ b/blkiomon.c
@@ -163,7 +163,8 @@ static struct dstat *blkiomon_alloc_dsta
 	} else
 		dstat = malloc(sizeof(*dstat));
 	if (!dstat) {
-		perror("blkiomon: could not allocate device statistic");
+		fprintf(stderr,
+			"blkiomon: could not allocate device statistic");
 		return NULL;
 	}
 
@@ -279,7 +280,7 @@ static void *blkiomon_interval(void *dat
 	while (1) {
 		wake.tv_sec += interval;
 		if (clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &wake, &r)) {
-			perror("blkiomon: interrupted sleep");
+			fprintf(stderr, "blkiomon: interrupted sleep");
 			continue;
 		}
 
@@ -466,17 +467,19 @@ static int blkiomon_do_fifo(void)
 		}
 		if (ferror(ifp)) {
 			clearerr(ifp);
-			perror("blkiomon: error while reading trace");
+			fprintf(stderr, "blkiomon: error while reading trace");
 			break;
 		}
 
-		if (data_is_native = -1 && check_data_endianness(bit->magic))
+		if (data_is_native = -1 && check_data_endianness(bit->magic)) {
+			fprintf(stderr, "blkiomon: endianess problem\n");
 			break;
+		}
 
 		/* endianess */
 		trace_to_cpu(bit);
 		if (verify_trace(bit)) {
-			perror("blkiomon: bad trace");
+			fprintf(stderr, "blkiomon: bad trace\n");
 			break;
 		}
 
@@ -485,7 +488,7 @@ static int blkiomon_do_fifo(void)
 			pdu_buf = realloc(pdu_buf, bit->pdu_len);
 			if (fread(pdu_buf, bit->pdu_len, 1, ifp) != 1) {
 				clearerr(ifp);
-				perror("blkiomon: could not read payload");
+				fprintf(stderr, "blkiomon: could not read payload\n");
 				break;
 			}
 		}
@@ -495,8 +498,10 @@ static int blkiomon_do_fifo(void)
 		/* forward low-level device driver trace to other tool */
 		if (bit->action & BLK_TC_ACT(BLK_TC_DRV_DATA)) {
 			driverdata++;
-			if (blkiomon_dump_drvdata(bit, pdu_buf))
+			if (blkiomon_dump_drvdata(bit, pdu_buf)) {
+				fprintf(stderr, "blkiomon: could not send trace\n");
 				break;
+			}
 			continue;
 		}
 
@@ -505,8 +510,10 @@ static int blkiomon_do_fifo(void)
 
 		/* try to find matching trace and update statistics */
 		t = blkiomon_do_trace(t);
-		if (!t)
+		if (!t) {
+			fprintf(stderr, "blkiomon: could not alloc trace\n");
 			break;
+		}
 		bit = &t->bit;
 		/* t and bit will be recycled for next incoming trace */
 	}
@@ -737,7 +744,7 @@ int main(int argc, char *argv[])
 		return 1;
 
 	if (pthread_create(&interval_thread, NULL, blkiomon_interval, NULL)) {
-		perror("blkiomon: could not create thread");
+		fprintf(stderr, "blkiomon: could not create thread");
 		return 1;
 	}
 


