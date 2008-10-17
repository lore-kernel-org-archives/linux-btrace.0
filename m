From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Fri, 17 Oct 2008 13:06:24 +0000
Subject: [Patch] blkparse: add hint for discarded drv_data traces
Message-Id: <1224248784.4348.7.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Martin Peschke <mpeschke@linux.vnet.ibm.com>

Display an informational message on blkparse exit to notify users that
additional data was available which would require to be dumped to binary
output.

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>

---
 blkparse.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/blkparse.c
+++ b/blkparse.c
@@ -292,6 +292,8 @@ static volatile int done;
 struct timespec		abs_start_time;
 static unsigned long long start_timestamp;
 
+static int have_drv_data = 0;
+
 #define JHASH_RANDOM	(0x3af5f2ee)
 
 #define CPUS_PER_LONG	(8 * sizeof(unsigned long))
@@ -1584,6 +1586,7 @@ static void dump_trace_fs(struct blk_io_
 			log_generic(pci, t, "A");
 			break;
 		case __BLK_TA_DRV_DATA:
+			have_drv_data = 1;
 			/* dump to binary file only */
 			break;
 		default:
@@ -2844,6 +2847,10 @@ int main(int argc, char *argv[])
 	if (!ret)
 		show_stats();
 
+	if (have_drv_data && !dump_binary)
+		printf("\ndiscarded traces containing low-level device driver "
+		       "specific data (only available in binary output)\n");
+
 	if (ofp_buffer) {
 		fflush(ofp);
 		free(ofp_buffer);


