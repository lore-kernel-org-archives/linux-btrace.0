From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 07 Aug 2007 13:27:51 +0000
Subject: [PATCH] Fix remap handling by blktrace
Message-Id: <46B87357.8040802@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060602090101050504070809"
List-Id: <linux-btrace.vger.kernel.org>
To: 
Cc: Jens Axboe <jens.axboe@oracle.com>, btrace <linux-btrace@vger.kernel.org>, dm-devel@redhat.com, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060602090101050504070809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------060602090101050504070809
Content-Type: text/x-patch;
 name="0001-Fix-remap-handling-by-blktrace.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Fix-remap-handling-by-blktrace.patch"


This patch provides more information concerning REMAP operations on block
IOs. The additional information provides clearer details at the user level,
and supports post-processing analysis in btt.

o  Adds in partition remaps on the same device.
o  Fixed up the remap information in DM to be in the right order
o  Sent up mapped-from and mapped-to device information

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>

---
 block/ll_rw_blk.c            |    4 ++++
 drivers/md/dm.c              |    4 ++--
 include/linux/blktrace_api.h |    3 ++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 8c2caff..a15845c 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -3047,6 +3047,10 @@ static inline void blk_partition_remap(struct bio *bio)
 
 		bio->bi_sector += p->start_sect;
 		bio->bi_bdev = bdev->bd_contains;
+
+		blk_add_trace_remap(bdev_get_queue(bio->bi_bdev), bio,
+				    bdev->bd_dev, bio->bi_sector,
+				    bio->bi_sector - p->start_sect);
 	}
 }
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 141ff9f..2120155 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -580,8 +580,8 @@ static void __map_bio(struct dm_target *ti, struct bio *clone,
 		/* the bio has been remapped so dispatch it */
 
 		blk_add_trace_remap(bdev_get_queue(clone->bi_bdev), clone,
-				    tio->io->bio->bi_bdev->bd_dev, sector,
-				    clone->bi_sector);
+				    tio->io->bio->bi_bdev->bd_dev,
+				    clone->bi_sector, sector);
 
 		generic_make_request(clone);
 	} else if (r < 0 || r == DM_MAPIO_REQUEUE) {
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 90874a5..7b5d56b 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -105,7 +105,7 @@ struct blk_io_trace {
  */
 struct blk_io_trace_remap {
 	__be32 device;
-	u32 __pad;
+	__be32 device_from;
 	__be64 sector;
 };
 
@@ -272,6 +272,7 @@ static inline void blk_add_trace_remap(struct request_queue *q, struct bio *bio,
 		return;
 
 	r.device = cpu_to_be32(dev);
+	r.device_from = cpu_to_be32(bio->bi_bdev->bd_dev);
 	r.sector = cpu_to_be64(to);
 
 	__blk_add_trace(bt, from, bio->bi_size, bio->bi_rw, BLK_TA_REMAP, !bio_flagged(bio, BIO_UPTODATE), sizeof(r), &r);

--------------060602090101050504070809--
