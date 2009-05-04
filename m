From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Mon, 04 May 2009 20:35:08 +0000
Subject: [PATCH 2/2] from-sector redundant in trace_block_remap
Message-Id: <49FF517C.7000503@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000205030007050505000701"
List-Id: <linux-btrace.vger.kernel.org>
References: <49FF4FAE.3000301@hp.com>
In-Reply-To: <49FF4FAE.3000301@hp.com>
To: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-btrace <linux-btrace@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Li Zefan <lizf@cn.fujitsu.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>

This is a multi-part message in MIME format.
--------------000205030007050505000701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



--------------000205030007050505000701
Content-Type: text/x-diff;
 name="0002-from-sector-redundant-in-trace_block_remap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-from-sector-redundant-in-trace_block_remap.patch"

Removed redundant from-sector parameter: it's /always/ the bio's sector
passed in.

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
Cc: Jens Axboe <jens.axboe@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Li Zefan <lizf@cn.fujitsu.com>
Reviewed-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
---
 block/blk-core.c        |    5 ++---
 drivers/md/dm.c         |    3 +--
 include/trace/block.h   |    4 ++--
 kernel/trace/blktrace.c |    8 ++++----
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2998fe3..d028baf 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1277,7 +1277,7 @@ static inline void blk_partition_remap(struct bio *bio)
 		bio->bi_bdev = bdev->bd_contains;
 
 		trace_block_remap(bdev_get_queue(bio->bi_bdev), bio,
-				    bdev->bd_dev, bio->bi_sector,
+				    bdev->bd_dev,
 				    bio->bi_sector - p->start_sect);
 	}
 }
@@ -1446,8 +1446,7 @@ static inline void __generic_make_request(struct bio *bio)
 			goto end_io;
 
 		if (old_sector != -1)
-			trace_block_remap(q, bio, old_dev, bio->bi_sector,
-					    old_sector);
+			trace_block_remap(q, bio, old_dev, old_sector);
 
 		trace_block_bio_queue(q, bio);
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 424f7b0..e2ee4a7 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -656,8 +656,7 @@ static void __map_bio(struct dm_target *ti, struct bio *clone,
 		/* the bio has been remapped so dispatch it */
 
 		trace_block_remap(bdev_get_queue(clone->bi_bdev), clone,
-				    tio->io->bio->bi_bdev->bd_dev,
-				    clone->bi_sector, sector);
+				    tio->io->bio->bi_bdev->bd_dev, sector);
 
 		generic_make_request(clone);
 	} else if (r < 0 || r == DM_MAPIO_REQUEUE) {
diff --git a/include/trace/block.h b/include/trace/block.h
index 87f6456..8ac945b 100644
--- a/include/trace/block.h
+++ b/include/trace/block.h
@@ -70,7 +70,7 @@ DECLARE_TRACE(block_split,
 
 DECLARE_TRACE(block_remap,
 	TP_PROTO(struct request_queue *q, struct bio *bio, dev_t dev,
-		 sector_t to, sector_t from),
-	      TP_ARGS(q, bio, dev, to, from));
+		 sector_t to),
+	      TP_ARGS(q, bio, dev, to));
 
 #endif
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index bc72d53..4c1ed52 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -808,7 +808,6 @@ static void blk_add_trace_split(struct request_queue *q, struct bio *bio,
  * @q:		queue the io is for
  * @bio:	the source bio
  * @dev:	target device
- * @to:		target sector
  * @from:	source sector
  *
  * Description:
@@ -817,7 +816,7 @@ static void blk_add_trace_split(struct request_queue *q, struct bio *bio,
  *
  **/
 static void blk_add_trace_remap(struct request_queue *q, struct bio *bio,
-				       dev_t dev, sector_t to, sector_t from)
+				       dev_t dev, sector_t from)
 {
 	struct blk_trace *bt = q->blk_trace;
 	struct blk_io_trace_remap r;
@@ -829,8 +828,9 @@ static void blk_add_trace_remap(struct request_queue *q, struct bio *bio,
 	r.device_to   = cpu_to_be32(bio->bi_bdev->bd_dev);
 	r.sector_from = cpu_to_be64(from);
 
-	__blk_add_trace(bt, from, bio->bi_size, bio->bi_rw, BLK_TA_REMAP,
-			!bio_flagged(bio, BIO_UPTODATE), sizeof(r), &r);
+	__blk_add_trace(bt, bio->bi_sector, bio->bi_size, bio->bi_rw,
+			BLK_TA_REMAP, !bio_flagged(bio, BIO_UPTODATE),
+			sizeof(r), &r);
 }
 
 /**
-- 
1.6.0.4


--------------000205030007050505000701--
