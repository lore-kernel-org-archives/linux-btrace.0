From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Mon, 06 Aug 2007 14:36:03 +0000
Subject: Re: Blkparse weirdness with "A" (remap) action
Message-Id: <46B731D3.7050409@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20070726193952.GN32546@stingr.net>
In-Reply-To: <20070726193952.GN32546@stingr.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

This is the previously submitted patch, ported to 2.6.23-rc1-git13 - I'm
building a kernel to try out now, but I think this should work... After
I test it, I'll submit an official patch...

Alan

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 8c2caff..a15845c 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -3047,6 +3047,10 @@ static inline void blk_partition_remap(struct bio
*bio)
 
                bio->bi_sector += p->start_sect;
                bio->bi_bdev = bdev->bd_contains;
+
+               blk_add_trace_remap(bdev_get_queue(bio->bi_bdev), bio,
+                                   bdev->bd_dev, bio->bi_sector,
+                                   bio->bi_sector - p->start_sect);
        }
 }
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 141ff9f..2120155 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -580,8 +580,8 @@ static void __map_bio(struct dm_target *ti, struct
bio *clone                /* the bio has been remapped so dispatch it */
 
                blk_add_trace_remap(bdev_get_queue(clone->bi_bdev), clone,
-                                   tio->io->bio->bi_bdev->bd_dev, sector,
-                                   clone->bi_sector);
+                                   tio->io->bio->bi_bdev->bd_dev,
+                                   clone->bi_sector, sector);
 
                generic_make_request(clone);
        } else if (r < 0 || r = DM_MAPIO_REQUEUE) {
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 90874a5..7b5d56b 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -105,7 +105,7 @@ struct blk_io_trace {
  */
 struct blk_io_trace_remap {
        __be32 device;
-       u32 __pad;
+       __be32 device_from;
        __be64 sector;
 };
 
@@ -272,6 +272,7 @@ static inline void blk_add_trace_remap(struct
request_queue *                return;
 
        r.device = cpu_to_be32(dev);
+       r.device_from = cpu_to_be32(bio->bi_bdev->bd_dev);
        r.sector = cpu_to_be64(to);
 

