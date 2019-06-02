From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:53 +0000
Subject: [RFC PATCH 44/46] fs: set bio iopriority field
Message-Id: <20190602165055.14424-45-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/btrfs/disk-io.c               | 1 +
 fs/btrfs/extent_io.c             | 2 ++
 fs/btrfs/raid56.c                | 5 +++++
 fs/btrfs/scrub.c                 | 2 ++
 fs/btrfs/volumes.c               | 2 ++
 fs/buffer.c                      | 1 +
 fs/crypto/bio.c                  | 1 +
 fs/direct-io.c                   | 1 +
 fs/ext4/page-io.c                | 1 +
 fs/ext4/readpage.c               | 1 +
 fs/f2fs/data.c                   | 3 ++-
 fs/f2fs/segment.c                | 1 +
 fs/gfs2/lops.c                   | 1 +
 fs/gfs2/meta_io.c                | 1 +
 fs/gfs2/ops_fstype.c             | 1 +
 fs/hfsplus/wrapper.c             | 1 +
 fs/iomap.c                       | 1 +
 fs/jfs/jfs_logmgr.c              | 2 ++
 fs/jfs/jfs_metapage.c            | 2 ++
 fs/mpage.c                       | 1 +
 fs/nfs/blocklayout/blocklayout.c | 1 +
 fs/nilfs2/segbuf.c               | 1 +
 fs/ocfs2/cluster/heartbeat.c     | 1 +
 fs/xfs/xfs_aops.c                | 2 ++
 fs/xfs/xfs_buf.c                 | 1 +
 25 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c333e79408ff..1530f36e2cf2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3603,6 +3603,7 @@ static void write_dev_flush(struct btrfs_device *device)
 	bio_reset(bio);
 	bio->bi_end_io = btrfs_end_empty_barrier;
 	bio_set_dev(bio, device->bdev);
+	bio_set_prio(bio, get_current_ioprio());
 	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH;
 	init_completion(&device->flush_wait);
 	bio->bi_private = &device->flush_wait;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c85505c36fa6..11ac391c83c3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -160,6 +160,7 @@ static int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 	start = page_offset(bv.bv_page) + bv.bv_offset;
 
 	bio->bi_private = NULL;
+	bio_set_prio(bio, get_current_ioprio());
 
 	if (tree->ops)
 		ret = tree->ops->submit_bio_hook(tree->private_data, bio,
@@ -2043,6 +2044,7 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	bio_set_dev(bio, dev->bdev);
 	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
 	bio_add_page(bio, page, length, pg_offset);
+	bio_set_prio(bio, get_current_ioprio());
 
 	if (btrfsic_submit_bio_wait(bio)) {
 		/* try to remap that extent elsewhere? */
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index f3d0576dd327..a48da4ec6c0e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1324,6 +1324,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 		bio->bi_private = rbio;
 		bio->bi_end_io = raid_write_end_io;
 		bio->bi_opf = REQ_OP_WRITE;
+		bio_set_prio(bio, get_current_ioprio());
 
 		submit_bio(bio);
 	}
@@ -1566,6 +1567,7 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 		bio->bi_private = rbio;
 		bio->bi_end_io = raid_rmw_end_io;
 		bio->bi_opf = REQ_OP_READ;
+		bio_set_prio(bio, get_current_ioprio());
 
 		btrfs_bio_wq_end_io(rbio->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
@@ -2113,6 +2115,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 		bio->bi_private = rbio;
 		bio->bi_end_io = raid_recover_end_io;
 		bio->bi_opf = REQ_OP_READ;
+		bio_set_prio(bio, get_current_ioprio());
 
 		btrfs_bio_wq_end_io(rbio->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
@@ -2486,6 +2489,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 		bio->bi_private = rbio;
 		bio->bi_end_io = raid_write_end_io;
 		bio->bi_opf = REQ_OP_WRITE;
+		bio_set_prio(bio, get_current_ioprio());
 
 		submit_bio(bio);
 	}
@@ -2668,6 +2672,7 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 		bio->bi_private = rbio;
 		bio->bi_end_io = raid56_parity_scrub_end_io;
 		bio->bi_opf = REQ_OP_READ;
+		bio_set_prio(bio, get_current_ioprio());
 
 		btrfs_bio_wq_end_io(rbio->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a99588536c79..53068ec434a5 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1489,6 +1489,7 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 		bio_add_page(bio, page->page, PAGE_SIZE, 0);
 		bio->bi_iter.bi_sector = page->physical >> 9;
 		bio->bi_opf = REQ_OP_READ;
+		bio_set_prio(bio, get_current_ioprio());
 
 		if (btrfsic_submit_bio_wait(bio)) {
 			page->io_error = 1;
@@ -2058,6 +2059,7 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 		bio->bi_private = sbio;
 		bio->bi_end_io = scrub_bio_end_io;
 		bio_set_dev(bio, sbio->dev->bdev);
+		bio_set_prio(bio, get_current_ioprio());
 		bio->bi_iter.bi_sector = sbio->physical >> 9;
 		bio->bi_opf = REQ_OP_READ;
 		sbio->status = 0;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index db934ceae9c1..3b7307131e4f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -641,6 +641,7 @@ static noinline void run_scheduled_bios(struct btrfs_device *device)
 			sync_pending = 0;
 		}
 
+		bio_set_prio(cur, get_current_ioprio());
 		btrfsic_submit_bio(cur);
 		num_run++;
 		batch_run++;
@@ -6499,6 +6500,7 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 	struct btrfs_fs_info *fs_info = bbio->fs_info;
 
 	bio->bi_private = bbio;
+	bio_set_prio(bio, get_current_ioprio());
 	btrfs_io_bio(bio)->stripe_index = dev_nr;
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
diff --git a/fs/buffer.c b/fs/buffer.c
index ce357602f471..ec5b126c0602 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3073,6 +3073,7 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
+	bio_set_prio(bio, get_current_ioprio());
 	bio->bi_write_hint = write_hint;
 
 	bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 8f3a8bc15d98..a936294b6cc6 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -129,6 +129,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 		bio->bi_iter.bi_sector  			pblk << (inode->i_sb->s_blocksize_bits - 9);
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+		bio_set_prio(bio, get_current_ioprio());
 		ret = bio_add_page(bio, ciphertext_page,
 					inode->i_sb->s_blocksize, 0);
 		if (ret != inode->i_sb->s_blocksize) {
diff --git a/fs/direct-io.c b/fs/direct-io.c
index fbe885d68035..d6ab1cc96e3b 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -440,6 +440,7 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	bio_set_dev(bio, bdev);
 	bio->bi_iter.bi_sector = first_sector;
 	bio_set_op_attrs(bio, dio->op, dio->op_flags);
+	bio_set_prio(bio, get_current_ioprio());
 	if (dio->is_async)
 		bio->bi_end_io = dio_bio_end_aio;
 	else
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 4690618a92e9..9f1928abc802 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -376,6 +376,7 @@ static int io_submit_init_bio(struct ext4_io_submit *io,
 		return -ENOMEM;
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
+	bio_set_prio(bio, get_current_ioprio());
 	bio->bi_end_io = ext4_end_bio;
 	bio->bi_private = ext4_get_io_end(io->io_end);
 	io->io_bio = bio;
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 3629a74b7f94..f3efa354ace6 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -255,6 +255,7 @@ int ext4_mpage_readpages(struct address_space *mapping,
 				goto set_error_page;
 			}
 			bio_set_dev(bio, bdev);
+			bio_set_prio(bio, get_current_ioprio()); 
 			bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
 			bio->bi_end_io = mpage_end_io;
 			bio->bi_private = ctx;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 64040e998439..a8b1b36edbc3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -274,6 +274,7 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
 	if (wbc)
 		wbc_init_bio(wbc, bio);
 
+	bio_set_prio(bio, get_current_ioprio()); 
 	return bio;
 }
 
@@ -579,7 +580,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 		ctx->enabled_steps = post_read_steps;
 		bio->bi_private = ctx;
 	}
-
+	bio_set_prio(bio, get_current_ioprio()); 
 	return bio;
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index aa7fe79b62b2..d1b67ff8ce66 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -567,6 +567,7 @@ static int __submit_flush_wait(struct f2fs_sb_info *sbi,
 
 	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH;
 	bio_set_dev(bio, bdev);
+	bio_set_prio(bio, get_current_ioprio());
 	ret = submit_bio_wait(bio);
 	bio_put(bio);
 
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 6f09b5e3dd6e..1d47f7a07e5a 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -269,6 +269,7 @@ static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd *sdp, u64 blkno,
 
 	bio->bi_iter.bi_sector = blkno * (sb->s_blocksize >> 9);
 	bio_set_dev(bio, sb->s_bdev);
+	bio_set_prio(bio, get_current_ioprio());
 	bio->bi_end_io = end_io;
 	bio->bi_private = sdp;
 
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index ff86e1d4f8ff..be52def5380b 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -222,6 +222,7 @@ static void gfs2_submit_bhs(int op, int op_flags, struct buffer_head *bhs[],
 		bio = bio_alloc(GFP_NOIO, num);
 		bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 		bio_set_dev(bio, bh->b_bdev);
+		bio_set_prio(bio, get_current_ioprio());
 		while (num > 0) {
 			bh = *bhs;
 			if (!bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh))) {
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index b041cb8ae383..df5ec9015c07 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -243,6 +243,7 @@ static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int silent)
 	bio = bio_alloc(GFP_NOFS, 1);
 	bio->bi_iter.bi_sector = sector * (sb->s_blocksize >> 9);
 	bio_set_dev(bio, sb->s_bdev);
+	bio_set_prio(bio, get_current_ioprio());
 	bio_add_page(bio, page, PAGE_SIZE, 0);
 
 	bio->bi_end_io = end_bio_io_page;
diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 08c1580bdf7a..9fd890f07924 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -67,6 +67,7 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
 	bio = bio_alloc(GFP_NOIO, 1);
 	bio->bi_iter.bi_sector = sector;
 	bio_set_dev(bio, sb->s_bdev);
+	bio_set_prio(bio, get_current_ioprio());
 	bio_set_op_attrs(bio, op, op_flags);
 
 	if (op != WRITE && data)
diff --git a/fs/iomap.c b/fs/iomap.c
index 12a656271076..3b564cf350fc 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1616,6 +1616,7 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 	get_page(page);
 	__bio_add_page(bio, page, len, 0);
 	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
+	bio_set_prio(bio, get_current_ioprio());
 	iomap_dio_submit_bio(dio, iomap, bio);
 }
 
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 6b68df395892..e78a503eb25c 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1996,6 +1996,7 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
 	bio_set_dev(bio, log->bdev);
+	bio_set_prio(bio, get_current_ioprio());
 
 	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
@@ -2140,6 +2141,7 @@ static void lbmStartIO(struct lbuf * bp)
 	bio = bio_alloc(GFP_NOFS, 1);
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
 	bio_set_dev(bio, log->bdev);
+	bio_set_prio(bio, get_current_ioprio());
 
 	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index fa2c6824c7f2..5b9bc9484ea7 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -435,6 +435,7 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 		bio->bi_end_io = metapage_write_end_io;
 		bio->bi_private = page;
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		/* Don't call bio_add_page yet, we may add to this vec */
 		bio_offset = offset;
@@ -516,6 +517,7 @@ static int metapage_readpage(struct file *fp, struct page *page)
 			bio->bi_end_io = metapage_read_end_io;
 			bio->bi_private = page;
 			bio_set_op_attrs(bio, REQ_OP_READ, 0);
+			bio_set_prio(bio, get_current_ioprio());
 			len = xlen << inode->i_blkbits;
 			offset = block_offset << inode->i_blkbits;
 			if (bio_add_page(bio, page, len, offset) < len)
diff --git a/fs/mpage.c b/fs/mpage.c
index 436a85260394..c9959d235fa8 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -86,6 +86,7 @@ mpage_alloc(struct block_device *bdev,
 	if (bio) {
 		bio_set_dev(bio, bdev);
 		bio->bi_iter.bi_sector = first_sector;
+		bio_set_prio(bio, get_current_ioprio());
 	}
 	return bio;
 }
diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 690221747b47..f28441ab5b6f 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -133,6 +133,7 @@ bl_alloc_init_bio(int npg, struct block_device *bdev, sector_t disk_sector,
 		bio_set_dev(bio, bdev);
 		bio->bi_end_io = end_io;
 		bio->bi_private = par;
+		bio_set_prio(bio, get_current_ioprio());
 	}
 	return bio;
 }
diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 20c479b5e41b..4dbd906b2c55 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -392,6 +392,7 @@ static struct bio *nilfs_alloc_seg_bio(struct the_nilfs *nilfs, sector_t start,
 	}
 	if (likely(bio)) {
 		bio_set_dev(bio, nilfs->ns_bdev);
+		bio_set_prio(bio, get_current_ioprio());
 		bio->bi_iter.bi_sector  			start << (nilfs->ns_blocksize_bits - 9);
 	}
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index f3c20b279eb2..25f88fbdd43b 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -557,6 +557,7 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 	bio->bi_private = wc;
 	bio->bi_end_io = o2hb_bio_end_io;
 	bio_set_op_attrs(bio, op, op_flags);
+	bio_set_prio(bio, get_current_ioprio());
 
 	vec_start = (cs << bits) % PAGE_SIZE;
 	while(cs < max_slots) {
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 47941bbaac02..8ad9c98905d1 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -584,6 +584,7 @@ xfs_alloc_ioend(
 
 	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, &xfs_ioend_bioset);
 	bio_set_dev(bio, bdev);
+       	bio_set_prio(bio, get_current_ioprio());
 	bio->bi_iter.bi_sector = sector;
 
 	ioend = container_of(bio, struct xfs_ioend, io_inline_bio);
@@ -617,6 +618,7 @@ xfs_chain_bio(
 
 	new = bio_alloc(GFP_NOFS, BIO_MAX_PAGES);
 	bio_set_dev(new, bdev);
+       	bio_set_prio(new, get_current_ioprio());
 	new->bi_iter.bi_sector = sector;
 	bio_chain(ioend->io_bio, new);
 	bio_get(ioend->io_bio);		/* for xfs_destroy_ioend */
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 548344e25128..559234596370 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1376,6 +1376,7 @@ xfs_buf_ioapply_map(
 	nr_pages = min(total_nr_pages, BIO_MAX_PAGES);
 
 	bio = bio_alloc(GFP_NOIO, nr_pages);
+       	bio_set_prio(bio, get_current_ioprio());
 	bio_set_dev(bio, bp->b_target->bt_bdev);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = xfs_buf_bio_end_io;
-- 
2.19.1
