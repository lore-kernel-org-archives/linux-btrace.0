From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Mon, 04 May 2009 20:27:26 +0000
Subject: [PATCH 1/2] blktrace: correct remap names
Message-Id: <49FF4FAE.3000301@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030402030707010405070806"
List-Id: <linux-btrace.vger.kernel.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: linux-btrace <linux-btrace@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Li Zefan <lizf@cn.fujitsu.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>

This is a multi-part message in MIME format.
--------------030402030707010405070806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------030402030707010405070806
Content-Type: text/x-diff;
 name="0001-blktrace-correct-remap-names.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-blktrace-correct-remap-names.patch"

This attempts to clarify names utilized during block I/O remap
operations (partition, volume manager). It correctly matches up the
/from/ information for both device & sector. This takes in the concept
from Kosaki Motohiro and extends it to include better naming for the
"device_from" field.

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
Cc: Jens Axboe <jens.axboe@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Li Zefan <lizf@cn.fujitsu.com>
Reviewed-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
---
 include/linux/blktrace_api.h |    4 ++--
 include/trace/block.h        |    4 ++--
 kernel/trace/blktrace.c      |   24 ++++++++++++------------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index d960889..da1a14e 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -116,9 +116,9 @@ struct blk_io_trace {
  * The remap event
  */
 struct blk_io_trace_remap {
-	__be32 device;
 	__be32 device_from;
-	__be64 sector;
+	__be32 device_to;
+	__be64 sector_from;
 };
 
 enum {
diff --git a/include/trace/block.h b/include/trace/block.h
index 25b7068..87f6456 100644
--- a/include/trace/block.h
+++ b/include/trace/block.h
@@ -70,7 +70,7 @@ DECLARE_TRACE(block_split,
 
 DECLARE_TRACE(block_remap,
 	TP_PROTO(struct request_queue *q, struct bio *bio, dev_t dev,
-		 sector_t from, sector_t to),
-	      TP_ARGS(q, bio, dev, from, to));
+		 sector_t to, sector_t from),
+	      TP_ARGS(q, bio, dev, to, from));
 
 #endif
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 921ef5d..bc72d53 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -808,8 +808,8 @@ static void blk_add_trace_split(struct request_queue *q, struct bio *bio,
  * @q:		queue the io is for
  * @bio:	the source bio
  * @dev:	target device
- * @from:	source sector
  * @to:		target sector
+ * @from:	source sector
  *
  * Description:
  *     Device mapper or raid target sometimes need to split a bio because
@@ -817,7 +817,7 @@ static void blk_add_trace_split(struct request_queue *q, struct bio *bio,
  *
  **/
 static void blk_add_trace_remap(struct request_queue *q, struct bio *bio,
-				       dev_t dev, sector_t from, sector_t to)
+				       dev_t dev, sector_t to, sector_t from)
 {
 	struct blk_trace *bt = q->blk_trace;
 	struct blk_io_trace_remap r;
@@ -825,9 +825,9 @@ static void blk_add_trace_remap(struct request_queue *q, struct bio *bio,
 	if (likely(!bt))
 		return;
 
-	r.device = cpu_to_be32(dev);
-	r.device_from = cpu_to_be32(bio->bi_bdev->bd_dev);
-	r.sector = cpu_to_be64(to);
+	r.device_from = cpu_to_be32(dev);
+	r.device_to   = cpu_to_be32(bio->bi_bdev->bd_dev);
+	r.sector_from = cpu_to_be64(from);
 
 	__blk_add_trace(bt, from, bio->bi_size, bio->bi_rw, BLK_TA_REMAP,
 			!bio_flagged(bio, BIO_UPTODATE), sizeof(r), &r);
@@ -996,11 +996,11 @@ static void get_pdu_remap(const struct trace_entry *ent,
 			  struct blk_io_trace_remap *r)
 {
 	const struct blk_io_trace_remap *__r = pdu_start(ent);
-	__u64 sector = __r->sector;
+	__u64 sector_from = __r->sector_from;
 
-	r->device = be32_to_cpu(__r->device);
 	r->device_from = be32_to_cpu(__r->device_from);
-	r->sector = be64_to_cpu(sector);
+	r->device_to   = be32_to_cpu(__r->device_to);
+	r->sector_from = be64_to_cpu(sector_from);
 }
 
 typedef int (blk_log_action_t) (struct trace_iterator *iter, const char *act);
@@ -1054,13 +1054,13 @@ static int blk_log_with_error(struct trace_seq *s,
 
 static int blk_log_remap(struct trace_seq *s, const struct trace_entry *ent)
 {
-	struct blk_io_trace_remap r = { .device = 0, };
+	struct blk_io_trace_remap r = { .device_from = 0, };
 
 	get_pdu_remap(ent, &r);
 	return trace_seq_printf(s, "%llu + %u <- (%d,%d) %llu\n",
-			       t_sector(ent),
-			       t_sec(ent), MAJOR(r.device), MINOR(r.device),
-			       (unsigned long long)r.sector);
+				t_sector(ent), t_sec(ent),
+				MAJOR(r.device_from), MINOR(r.device_from),
+				(unsigned long long)r.sector_from);
 }
 
 static int blk_log_plug(struct trace_seq *s, const struct trace_entry *ent)
-- 
1.6.0.4


--------------030402030707010405070806--
