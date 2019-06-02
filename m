From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:09 +0000
Subject: [RFC PATCH 00/46] blktrace: add block trace extension support
Message-Id: <20190602165055.14424-1-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

This patch series adds support to track more request based flags and 
different request fields to the blktrace infrastructure.

In this series, we increase the action, action mask field and add 
priority and priority mask field to existing infrastructure.

We add new structures to hold the trace where we increase the size of
the action field and add a new member to track the priority of the I/O.
For the trace management side we add new IOCTLs so that user can 
configure trace extensions from the blktrace user-space tools.

The RFC is still light on the details but with new IOCTLs I was able to
get the code running with user-space tools. There is still some more
scope to optimize the code and reducing the duplicate code, but I kept
it simple for now so that it is easy to review.

For sample execution please refer the output at the end of the this
file. Folllwing is the patch distribution :-

It will be great if someone can review this code and provide some
feedback.

Chaitanya Kulkarni (46):
Update headers and introduce new structures and IOCTLs.
  blktrace_api: add new trace definitions
  blktrace_api: add new trace definition
  blkdev.h: add new trace ext as a queue member
  blktrace: introduce new ioctls
Update blktrace.c with core APIs.
  blktrace: add a new global list
  blktrace: add trace note APIs
  blktrace: add act and prio check helpers
  blktrace: add core trace API
Update indivisual tracepoints.
  blktrace: update blk_add_trace_rq()
  blktrace: update blk_add_trace_rq_insert()
  blktrace: update blk_add_trace_rq_issue()
  blktrace: update blk_add_trace_rq_requeue()
  blktrace: update blk_add_trace_rq_complete()
  blktrace: update blk_add_trace_bio()
  blktrace: update blk_add_trace_bio_bounce()
  blktrace: update blk_add_trace_bio_complete()
  blktrace: update blk_add_trace_bio_backmerge()
  blktrace: update blk_add_trace_bio_frontmerge()
  blktrace: update blk_add_trace_bio_queue()
  blktrace: update blk_add_trace_getrq()
  blktrace: update blk_add_trace_sleeprq()
  blktrace: update blk_add_trace_plug()
  blktrace: update blk_add_trace_unplug()
  blktrace: update blk_add_trace_split()
  blktrace: update blk_add_trace_bio_remap()
  blktrace: update blk_add_trace_rq_remap()
  blktrace: update blk_add_driver_data()
Misc updates for tracer.
  blktrace: add a new formatting routine
  blktrace: add trace entry & pdu helpers
  blktrace: add blk_log_xxx helpers()
  blktrace: link blk_log_xxx() to trace action
  blktrace: add trace event print helper
  blktrace: add trace_synthesize helper
  blktrace: add trace print helpers
  blktrace: add blkext tracer
Implement new IOCTLs.
  blktrace: implement setup-start-stop ioclts
  block: update blkdev_ioctl with new trace ioctls
Update block layer and rest of fs/drivers/mm so that we can report
correct priority value also update null_blk for testing.
  block: set ioprio for zone-reset bio
  block: set ioprio for flush bio
  block: set ioprio for write-zeroes, discard etc
  null_blk: add write-zeroes flag to nullb_device
  null_blk: add module param discard/write-zeroes
  drivers: set bio iopriority field
  fs: set bio iopriority field
  power/swap: set bio iopriority field
  mm: set bio iopriority field

 block/blk-flush.c                   |    2 +
 block/blk-lib.c                     |    6 +
 block/blk-zoned.c                   |    1 +
 block/ioctl.c                       |    4 +
 drivers/block/drbd/drbd_actlog.c    |    2 +
 drivers/block/drbd/drbd_bitmap.c    |    3 +
 drivers/block/null_blk.h            |    1 +
 drivers/block/null_blk_main.c       |   37 +-
 drivers/block/xen-blkback/blkback.c |    3 +
 drivers/block/zram/zram_drv.c       |    2 +
 drivers/lightnvm/pblk-read.c        |    2 +
 drivers/lightnvm/pblk-read.c.rej    |   10 +
 drivers/lightnvm/pblk-write.c       |    2 +
 drivers/md/bcache/journal.c         |    2 +
 drivers/md/bcache/super.c           |    2 +
 drivers/md/dm-bufio.c               |    2 +
 drivers/md/dm-cache-target.c        |    1 +
 drivers/md/dm-io.c                  |    2 +
 drivers/md/dm-log-writes.c          |    5 +
 drivers/md/dm-thin.c                |    1 +
 drivers/md/dm-writecache.c          |    2 +
 drivers/md/dm-zoned-metadata.c      |    4 +
 drivers/md/md.c                     |    4 +
 drivers/md/raid5-cache.c            |    4 +
 drivers/md/raid5-ppl.c              |    3 +
 drivers/nvme/target/io-cmd-bdev.c   |    7 +
 drivers/nvme/target/io-cmd-file.c   |    1 +
 drivers/staging/erofs/internal.h    |    3 +
 drivers/target/target_core_iblock.c |    3 +
 fs/btrfs/disk-io.c                  |    1 +
 fs/btrfs/extent_io.c                |    2 +
 fs/btrfs/raid56.c                   |    5 +
 fs/btrfs/scrub.c                    |    2 +
 fs/btrfs/volumes.c                  |    2 +
 fs/buffer.c                         |    1 +
 fs/crypto/bio.c                     |    1 +
 fs/direct-io.c                      |    1 +
 fs/ext4/page-io.c                   |    1 +
 fs/ext4/readpage.c                  |    1 +
 fs/f2fs/data.c                      |    3 +-
 fs/f2fs/segment.c                   |    1 +
 fs/gfs2/lops.c                      |    1 +
 fs/gfs2/meta_io.c                   |    1 +
 fs/gfs2/ops_fstype.c                |    1 +
 fs/hfsplus/wrapper.c                |    1 +
 fs/iomap.c                          |    1 +
 fs/jfs/jfs_logmgr.c                 |    2 +
 fs/jfs/jfs_metapage.c               |    2 +
 fs/mpage.c                          |    1 +
 fs/nfs/blocklayout/blocklayout.c    |    1 +
 fs/nilfs2/segbuf.c                  |    1 +
 fs/ocfs2/cluster/heartbeat.c        |    1 +
 fs/xfs/xfs_aops.c                   |    2 +
 fs/xfs/xfs_buf.c                    |    1 +
 include/linux/blkdev.h              |    3 +
 include/linux/blktrace_api.h        |   18 +
 include/uapi/linux/blktrace_api.h   |  105 ++-
 include/uapi/linux/fs.h             |    4 +
 kernel/power/swap.c                 |    1 +
 kernel/trace/blktrace.c             | 1254 +++++++++++++++++++++++++--
 kernel/trace/trace.h                |    1 +
 mm/page_io.c                        |    1 +
 62 files changed, 1449 insertions(+), 96 deletions(-)
 create mode 100644 drivers/lightnvm/pblk-read.c.rej

Following is the sample execution of the newly added trace request
operations zone-reset and write-zeroes along with the support for 
priority tracking.

Tracing Zone Reset (REQ_OP_ZONE_RESET) with blktrace extensions:- 

for i in 1 2 3 4 5 6 7 8 9 A B C D E F;
do
	echo Using "Prio Mask : 0x${i} ";
#	specify '-P' priority '-E' extension '-y' actiom
	./blktrace -P -E -X ${i} -y zone_reset -d /dev/nullb0 -o - \
	| ./blkparse -P -X ${i} -E -i -
done

From other terminal :- 

for ((i=0; i<16; i++))
do
	local len&21440
	local dev=/dev/nullb0
	for prio in `seq 0 3`
		do echo "$prio"
                ionice -c ${prio} blkzone reset ${dev} -o 0 -l ${len} 
	done
	sleep 2 
	killall blkparse
	killall blktrace
	sleep 2
done


Using Prio Mask : 0x1 
252,0    5        1     2.834441556  5654  Q  ZR N 0 + 0 [blkzone]
252,0    5        2     2.834448323  5654  G  ZR N 0 + 0 [blkzone]
252,0    5        3     2.834451419  5654  Q  ZR N 524288 + 0 [blkzone]
252,0    5        4     2.834453433  5654  G  ZR N 524288 + 0 [blkzone]
252,0    5        5     2.834454419  5654  Q  ZR N 1048576 + 0 [blkzone]
252,0    5        6     2.834455833  5654  G  ZR N 1048576 + 0 [blkzone]
252,0    5        7     2.834456799  5654  Q  ZR N 1572864 + 0 [blkzone]
252,0    5        8     2.834458339  5654  G  ZR N 1572864 + 0 [blkzone]
252,0    5        9     2.834459273  5654  Q ZRS N 2097152 + 0 [blkzone]
252,0    5       10     2.834460849  5654  G ZRS N 2097152 + 0 [blkzone]
Using Prio Mask : 0x2 
252,0    8        1     1.881561353  5679  Q  ZR R 0 + 0 [blkzone]
252,0    8        2     1.881564976  5679  G  ZR R 0 + 0 [blkzone]
252,0    8        3     1.881566829  5679  Q  ZR R 524288 + 0 [blkzone]
252,0    8        4     1.881568806  5679  G  ZR R 524288 + 0 [blkzone]
252,0    8        5     1.881569789  5679  Q  ZR R 1048576 + 0 [blkzone]
252,0    8        6     1.881571229  5679  G  ZR R 1048576 + 0 [blkzone]
252,0    8        7     1.881572233  5679  Q  ZR R 1572864 + 0 [blkzone]
252,0    8        8     1.881573309  5679  G  ZR R 1572864 + 0 [blkzone]
252,0    8        9     1.881574099  5679  Q ZRS R 2097152 + 0 [blkzone]
252,0    8       10     1.881575163  5679  G ZRS R 2097152 + 0 [blkzone]
Using Prio Mask : 0x3 
252,0    4        1     1.880523631  5711  Q  ZR R 0 + 0 [blkzone]
252,0    4        2     1.880527443  5711  G  ZR R 0 + 0 [blkzone]
252,0    4        3     1.880529246  5711  Q  ZR R 524288 + 0 [blkzone]
252,0    4        4     1.880530916  5711  G  ZR R 524288 + 0 [blkzone]
252,0    4        5     1.880531881  5711  Q  ZR R 1048576 + 0 [blkzone]
252,0    4        6     1.880533056  5711  G  ZR R 1048576 + 0 [blkzone]
252,0    4        7     1.880533986  5711  Q  ZR R 1572864 + 0 [blkzone]
252,0    4        8     1.880535116  5711  G  ZR R 1572864 + 0 [blkzone]
252,0    4        9     1.880535911  5711  Q ZRS R 2097152 + 0 [blkzone]
252,0    4       10     1.880536883  5711  G ZRS R 2097152 + 0 [blkzone]
252,0    3        1     1.877350251  5710  Q  ZR N 0 + 0 [blkzone]
252,0    3        2     1.877359550  5710  G  ZR N 0 + 0 [blkzone]
252,0    3        3     1.877362833  5710  Q  ZR N 524288 + 0 [blkzone]
252,0    3        4     1.877365046  5710  G  ZR N 524288 + 0 [blkzone]
252,0    3        5     1.877366100  5710  Q  ZR N 1048576 + 0 [blkzone]
252,0    3        6     1.877367580  5710  G  ZR N 1048576 + 0 [blkzone]
252,0    3        7     1.877368526  5710  Q  ZR N 1572864 + 0 [blkzone]
252,0    3        8     1.877369570  5710  G  ZR N 1572864 + 0 [blkzone]
252,0    3        9     1.877370470  5710  Q ZRS N 2097152 + 0 [blkzone]
252,0    3       10     1.877371806  5710  G ZRS N 2097152 + 0 [blkzone]
Using Prio Mask : 0x4 
252,0    4        1     1.881693118  5737  Q  ZR B 0 + 0 [blkzone]
252,0    4        2     1.881696768  5737  G  ZR B 0 + 0 [blkzone]
252,0    4        3     1.881698931  5737  Q  ZR B 524288 + 0 [blkzone]
252,0    4        4     1.881712511  5737  G  ZR B 524288 + 0 [blkzone]
252,0    4        5     1.881713791  5737  Q  ZR B 1048576 + 0 [blkzone]
252,0    4        6     1.881715584  5737  G  ZR B 1048576 + 0 [blkzone]
252,0    4        7     1.881716501  5737  Q  ZR B 1572864 + 0 [blkzone]
252,0    4        8     1.881717991  5737  G  ZR B 1572864 + 0 [blkzone]
252,0    4        9     1.881718728  5737  Q ZRS B 2097152 + 0 [blkzone]
252,0    4       10     1.881720051  5737  G ZRS B 2097152 + 0 [blkzone]
Using Prio Mask : 0x5 
252,0    1        1     1.883719603  5763  Q  ZR B 0 + 0 [blkzone]
252,0    1        2     1.883722846  5763  G  ZR B 0 + 0 [blkzone]
252,0    1        3     1.883724859  5763  Q  ZR B 524288 + 0 [blkzone]
252,0    1        4     1.883727359  5763  G  ZR B 524288 + 0 [blkzone]
252,0    1        5     1.883728363  5763  Q  ZR B 1048576 + 0 [blkzone]
252,0    1        6     1.883729849  5763  G  ZR B 1048576 + 0 [blkzone]
252,0    1        7     1.883730806  5763  Q  ZR B 1572864 + 0 [blkzone]
252,0    1        8     1.883732039  5763  G  ZR B 1572864 + 0 [blkzone]
252,0    1        9     1.883732793  5763  Q ZRS B 2097152 + 0 [blkzone]
252,0    1       10     1.883733889  5763  G ZRS B 2097152 + 0 [blkzone]
252,0    4        1     1.877114899  5760  Q  ZR N 0 + 0 [blkzone]
252,0    4        2     1.877124353  5760  G  ZR N 0 + 0 [blkzone]
252,0    4        3     1.877127613  5760  Q  ZR N 524288 + 0 [blkzone]
252,0    4        4     1.877129806  5760  G  ZR N 524288 + 0 [blkzone]
252,0    4        5     1.877130716  5760  Q  ZR N 1048576 + 0 [blkzone]
252,0    4        6     1.877132076  5760  G  ZR N 1048576 + 0 [blkzone]
252,0    4        7     1.877132946  5760  Q  ZR N 1572864 + 0 [blkzone]
252,0    4        8     1.877134016  5760  G  ZR N 1572864 + 0 [blkzone]
252,0    4        9     1.877134833  5760  Q ZRS N 2097152 + 0 [blkzone]
252,0    4       10     1.877136286  5760  G ZRS N 2097152 + 0 [blkzone]
Using Prio Mask : 0x6 
252,0    4        1     1.880316987  5794  Q  ZR R 0 + 0 [blkzone]
252,0    4        2     1.880320737  5794  G  ZR R 0 + 0 [blkzone]
252,0    4        3     1.880322433  5794  Q  ZR R 524288 + 0 [blkzone]
252,0    4        4     1.880324030  5794  G  ZR R 524288 + 0 [blkzone]
252,0    4        5     1.880324813  5794  Q  ZR R 1048576 + 0 [blkzone]
252,0    4        6     1.880325990  5794  G  ZR R 1048576 + 0 [blkzone]
252,0    4        7     1.880326763  5794  Q  ZR R 1572864 + 0 [blkzone]
252,0    4        8     1.880327777  5794  G  ZR R 1572864 + 0 [blkzone]
252,0    4        9     1.880328597  5794  Q ZRS R 2097152 + 0 [blkzone]
252,0    4       10     1.880330040  5794  G ZRS R 2097152 + 0 [blkzone]
252,0    6        1     1.883474794  5796  Q  ZR B 0 + 0 [blkzone]
252,0    6        2     1.883478534  5796  G  ZR B 0 + 0 [blkzone]
252,0    6        3     1.883480888  5796  Q  ZR B 524288 + 0 [blkzone]
252,0    6        4     1.883482694  5796  G  ZR B 524288 + 0 [blkzone]
252,0    6        5     1.883483674  5796  Q  ZR B 1048576 + 0 [blkzone]
252,0    6        6     1.883485031  5796  G  ZR B 1048576 + 0 [blkzone]
252,0    6        7     1.883485984  5796  Q  ZR B 1572864 + 0 [blkzone]
252,0    6        8     1.883487511  5796  G  ZR B 1572864 + 0 [blkzone]
252,0    6        9     1.883488328  5796  Q ZRS B 2097152 + 0 [blkzone]
252,0    6       10     1.883490664  5796  G ZRS B 2097152 + 0 [blkzone]
Using Prio Mask : 0x7 
252,0    4        1     1.883072943  5817  Q  ZR N 0 + 0 [blkzone]
252,0    4        2     1.883077257  5817  G  ZR N 0 + 0 [blkzone]
252,0    4        3     1.883079241  5817  Q  ZR N 524288 + 0 [blkzone]
252,0    4        4     1.883081038  5817  G  ZR N 524288 + 0 [blkzone]
252,0    4        5     1.883082011  5817  Q  ZR N 1048576 + 0 [blkzone]
252,0    4        6     1.883083371  5817  G  ZR N 1048576 + 0 [blkzone]
252,0    4        7     1.883084281  5817  Q  ZR N 1572864 + 0 [blkzone]
252,0    4        8     1.883085423  5817  G  ZR N 1572864 + 0 [blkzone]
252,0    4        9     1.883086192  5817  Q ZRS N 2097152 + 0 [blkzone]
252,0    4       10     1.883087288  5817  G ZRS N 2097152 + 0 [blkzone]
252,0    5        1     1.886300681  5818  Q  ZR R 0 + 0 [blkzone]
252,0    5        2     1.886304525  5818  G  ZR R 0 + 0 [blkzone]
252,0    5        3     1.886306417  5818  Q  ZR R 524288 + 0 [blkzone]
252,0    5        4     1.886308041  5818  G  ZR R 524288 + 0 [blkzone]
252,0    5        5     1.886308952  5818  Q  ZR R 1048576 + 0 [blkzone]
252,0    5        6     1.886310325  5818  G  ZR R 1048576 + 0 [blkzone]
252,0    5        7     1.886311257  5818  Q  ZR R 1572864 + 0 [blkzone]
252,0    5        8     1.886312217  5818  G  ZR R 1572864 + 0 [blkzone]
252,0    5        9     1.886312965  5818  Q ZRS R 2097152 + 0 [blkzone]
252,0    5       10     1.886314088  5818  G ZRS R 2097152 + 0 [blkzone]
252,0    6        1     1.889706711  5820  Q  ZR B 0 + 0 [blkzone]
252,0    6        2     1.889710471  5820  G  ZR B 0 + 0 [blkzone]
252,0    6        3     1.889712545  5820  Q  ZR B 524288 + 0 [blkzone]
252,0    6        4     1.889714351  5820  G  ZR B 524288 + 0 [blkzone]
252,0    6        5     1.889715441  5820  Q  ZR B 1048576 + 0 [blkzone]
252,0    6        6     1.889716765  5820  G  ZR B 1048576 + 0 [blkzone]
252,0    6        7     1.889717708  5820  Q  ZR B 1572864 + 0 [blkzone]
252,0    6        8     1.889718795  5820  G  ZR B 1572864 + 0 [blkzone]
252,0    6        9     1.889719571  5820  Q ZRS B 2097152 + 0 [blkzone]
252,0    6       10     1.889725381  5820  G ZRS B 2097152 + 0 [blkzone]
Using Prio Mask : 0x8 
252,0    6        1     1.894128638  5845  Q  ZR I 0 + 0 [blkzone]
252,0    6        2     1.894135178  5845  G  ZR I 0 + 0 [blkzone]
252,0    6        3     1.894137652  5845  Q  ZR I 524288 + 0 [blkzone]
252,0    6        4     1.894139588  5845  G  ZR I 524288 + 0 [blkzone]
252,0    6        5     1.894140378  5845  Q  ZR I 1048576 + 0 [blkzone]
252,0    6        6     1.894141765  5845  G  ZR I 1048576 + 0 [blkzone]
252,0    6        7     1.894142522  5845  Q  ZR I 1572864 + 0 [blkzone]
252,0    6        8     1.894143628  5845  G  ZR I 1572864 + 0 [blkzone]
252,0    6        9     1.894144392  5845  Q ZRS I 2097152 + 0 [blkzone]
252,0    6       10     1.894145422  5845  G ZRS I 2097152 + 0 [blkzone]
Using Prio Mask : 0x9 
252,0    1        1     1.890156939  5865  Q  ZR N 0 + 0 [blkzone]
252,0    1        2     1.890160815  5865  G  ZR N 0 + 0 [blkzone]
252,0    1        3     1.890163022  5865  Q  ZR N 524288 + 0 [blkzone]
252,0    1        4     1.890164472  5865  G  ZR N 524288 + 0 [blkzone]
252,0    1        5     1.890165285  5865  Q  ZR N 1048576 + 0 [blkzone]
252,0    1        6     1.890166315  5865  G  ZR N 1048576 + 0 [blkzone]
252,0    1        7     1.890167285  5865  Q  ZR N 1572864 + 0 [blkzone]
252,0    1        8     1.890168285  5865  G  ZR N 1572864 + 0 [blkzone]
252,0    1        9     1.890169135  5865  Q ZRS N 2097152 + 0 [blkzone]
252,0    1       10     1.890170099  5865  G ZRS N 2097152 + 0 [blkzone]
252,0    4        1     1.900328523  5869  Q  ZR I 0 + 0 [blkzone]
252,0    4        2     1.900332132  5869  G  ZR I 0 + 0 [blkzone]
252,0    4        3     1.900334123  5869  Q  ZR I 524288 + 0 [blkzone]
252,0    4        4     1.900335772  5869  G  ZR I 524288 + 0 [blkzone]
252,0    4        5     1.900336753  5869  Q  ZR I 1048576 + 0 [blkzone]
252,0    4        6     1.900338184  5869  G  ZR I 1048576 + 0 [blkzone]
252,0    4        7     1.900339083  5869  Q  ZR I 1572864 + 0 [blkzone]
252,0    4        8     1.900340397  5869  G  ZR I 1572864 + 0 [blkzone]
252,0    4        9     1.900341107  5869  Q ZRS I 2097152 + 0 [blkzone]
252,0    4       10     1.900342470  5869  G ZRS I 2097152 + 0 [blkzone]
Using Prio Mask : 0xA 
252,0    1        1     1.881118090  5890  Q  ZR R 0 + 0 [blkzone]
252,0    1        2     1.881121093  5890  G  ZR R 0 + 0 [blkzone]
252,0    1        3     1.881122797  5890  Q  ZR R 524288 + 0 [blkzone]
252,0    1        4     1.881124074  5890  G  ZR R 524288 + 0 [blkzone]
252,0    1        5     1.881124822  5890  Q  ZR R 1048576 + 0 [blkzone]
252,0    1        6     1.881125908  5890  G  ZR R 1048576 + 0 [blkzone]
252,0    1        7     1.881126613  5890  Q  ZR R 1572864 + 0 [blkzone]
252,0    1        8     1.881127763  5890  G  ZR R 1572864 + 0 [blkzone]
252,0    1        9     1.881128505  5890  Q ZRS R 2097152 + 0 [blkzone]
252,0    1       10     1.881129853  5890  G ZRS R 2097152 + 0 [blkzone]
252,0    3        1     1.887667345  5893  Q  ZR I 0 + 0 [blkzone]
252,0    3        2     1.887671162  5893  G  ZR I 0 + 0 [blkzone]
252,0    3        3     1.887673430  5893  Q  ZR I 524288 + 0 [blkzone]
252,0    3        4     1.887675750  5893  G  ZR I 524288 + 0 [blkzone]
252,0    3        5     1.887676895  5893  Q  ZR I 1048576 + 0 [blkzone]
252,0    3        6     1.887678300  5893  G  ZR I 1048576 + 0 [blkzone]
252,0    3        7     1.887679232  5893  Q  ZR I 1572864 + 0 [blkzone]
252,0    3        8     1.887680170  5893  G  ZR I 1572864 + 0 [blkzone]
252,0    3        9     1.887680955  5893  Q ZRS I 2097152 + 0 [blkzone]
252,0    3       10     1.887682355  5893  G ZRS I 2097152 + 0 [blkzone]
Using Prio Mask : 0xB 
252,0    3        1     1.877653462  5914  Q  ZR R 0 + 0 [blkzone]
252,0    3        2     1.877657497  5914  G  ZR R 0 + 0 [blkzone]
252,0    3        3     1.877659827  5914  Q  ZR R 524288 + 0 [blkzone]
252,0    3        4     1.877662193  5914  G  ZR R 524288 + 0 [blkzone]
252,0    3        5     1.877663120  5914  Q  ZR R 1048576 + 0 [blkzone]
252,0    3        6     1.877664750  5914  G  ZR R 1048576 + 0 [blkzone]
252,0    3        7     1.877665830  5914  Q  ZR R 1572864 + 0 [blkzone]
252,0    3        8     1.877667316  5914  G  ZR R 1572864 + 0 [blkzone]
252,0    3        9     1.877668052  5914  Q ZRS R 2097152 + 0 [blkzone]
252,0    3       10     1.877669489  5914  G ZRS R 2097152 + 0 [blkzone]
252,0    6        1     1.884158989  5917  Q  ZR I 0 + 0 [blkzone]
252,0    6        2     1.884162489  5917  G  ZR I 0 + 0 [blkzone]
252,0    6        3     1.884164559  5917  Q  ZR I 524288 + 0 [blkzone]
252,0    6        4     1.884166292  5917  G  ZR I 524288 + 0 [blkzone]
252,0    6        5     1.884167249  5917  Q  ZR I 1048576 + 0 [blkzone]
252,0    6        6     1.884168696  5917  G  ZR I 1048576 + 0 [blkzone]
252,0    6        7     1.884169686  5917  Q  ZR I 1572864 + 0 [blkzone]
252,0    6        8     1.884170902  5917  G  ZR I 1572864 + 0 [blkzone]
252,0    6        9     1.884171692  5917  Q ZRS I 2097152 + 0 [blkzone]
252,0    6       10     1.884172946  5917  G ZRS I 2097152 + 0 [blkzone]
252,0    2        1     1.873935412  5913  Q  ZR N 0 + 0 [blkzone]
252,0    2        2     1.873939768  5913  G  ZR N 0 + 0 [blkzone]
252,0    2        3     1.873941699  5913  Q  ZR N 524288 + 0 [blkzone]
252,0    2        4     1.873943554  5913  G  ZR N 524288 + 0 [blkzone]
252,0    2        5     1.873944291  5913  Q  ZR N 1048576 + 0 [blkzone]
252,0    2        6     1.873946251  5913  G  ZR N 1048576 + 0 [blkzone]
252,0    2        7     1.873946994  5913  Q  ZR N 1572864 + 0 [blkzone]
252,0    2        8     1.873948462  5913  G  ZR N 1572864 + 0 [blkzone]
252,0    2        9     1.873949179  5913  Q ZRS N 2097152 + 0 [blkzone]
252,0    2       10     1.873950688  5913  G ZRS N 2097152 + 0 [blkzone]
Using Prio Mask : 0xC 
252,0    8        1     1.883974886  5940  Q  ZR B 0 + 0 [blkzone]
252,0    8        2     1.883978509  5940  G  ZR B 0 + 0 [blkzone]
252,0    8        3     1.883980416  5940  Q  ZR B 524288 + 0 [blkzone]
252,0    8        4     1.883982116  5940  G  ZR B 524288 + 0 [blkzone]
252,0    8        5     1.883983136  5940  Q  ZR B 1048576 + 0 [blkzone]
252,0    8        6     1.883984593  5940  G  ZR B 1048576 + 0 [blkzone]
252,0    8        7     1.883985386  5940  Q  ZR B 1572864 + 0 [blkzone]
252,0    8        8     1.883986299  5940  G  ZR B 1572864 + 0 [blkzone]
252,0    8        9     1.883987073  5940  Q ZRS B 2097152 + 0 [blkzone]
252,0    8       10     1.883988379  5940  G ZRS B 2097152 + 0 [blkzone]
252,0    8       11     1.887235783  5941  Q  ZR I 0 + 0 [blkzone]
252,0    8       12     1.887238943  5941  G  ZR I 0 + 0 [blkzone]
252,0    8       13     1.887240726  5941  Q  ZR I 524288 + 0 [blkzone]
252,0    8       14     1.887264623  5941  G  ZR I 524288 + 0 [blkzone]
252,0    8       15     1.887265776  5941  Q  ZR I 1048576 + 0 [blkzone]
252,0    8       16     1.887267393  5941  G  ZR I 1048576 + 0 [blkzone]
252,0    8       17     1.887268139  5941  Q  ZR I 1572864 + 0 [blkzone]
252,0    8       18     1.887269196  5941  G  ZR I 1572864 + 0 [blkzone]
252,0    8       19     1.887269996  5941  Q ZRS I 2097152 + 0 [blkzone]
252,0    8       20     1.887270959  5941  G ZRS I 2097152 + 0 [blkzone]
Using Prio Mask : 0xD 
252,0    5        1     1.881926167  5961  Q  ZR N 0 + 0 [blkzone]
252,0    5        2     1.881936013  5961  G  ZR N 0 + 0 [blkzone]
252,0    5        3     1.881939187  5961  Q  ZR N 524288 + 0 [blkzone]
252,0    5        4     1.881941407  5961  G  ZR N 524288 + 0 [blkzone]
252,0    5        5     1.881942450  5961  Q  ZR N 1048576 + 0 [blkzone]
252,0    5        6     1.881944610  5961  G  ZR N 1048576 + 0 [blkzone]
252,0    5        7     1.881945593  5961  Q  ZR N 1572864 + 0 [blkzone]
252,0    5        8     1.881947180  5961  G  ZR N 1572864 + 0 [blkzone]
252,0    5        9     1.881948110  5961  Q ZRS N 2097152 + 0 [blkzone]
252,0    5       10     1.881949443  5961  G ZRS N 2097152 + 0 [blkzone]
252,0    8        1     1.888756648  5964  Q  ZR B 0 + 0 [blkzone]
252,0    8        2     1.888760021  5964  G  ZR B 0 + 0 [blkzone]
252,0    8        3     1.888762038  5964  Q  ZR B 524288 + 0 [blkzone]
252,0    8        4     1.888763528  5964  G  ZR B 524288 + 0 [blkzone]
252,0    8        5     1.888764401  5964  Q  ZR B 1048576 + 0 [blkzone]
252,0    8        6     1.888765661  5964  G  ZR B 1048576 + 0 [blkzone]
252,0    8        7     1.888766531  5964  Q  ZR B 1572864 + 0 [blkzone]
252,0    8        8     1.888767675  5964  G  ZR B 1572864 + 0 [blkzone]
252,0    8        9     1.888768458  5964  Q ZRS B 2097152 + 0 [blkzone]
252,0    8       10     1.888769921  5964  G ZRS B 2097152 + 0 [blkzone]
252,0    8       11     1.891879776  5965  Q  ZR I 0 + 0 [blkzone]
252,0    8       12     1.891882879  5965  G  ZR I 0 + 0 [blkzone]
252,0    8       13     1.891884736  5965  Q  ZR I 524288 + 0 [blkzone]
252,0    8       14     1.891886419  5965  G  ZR I 524288 + 0 [blkzone]
252,0    8       15     1.891887246  5965  Q  ZR I 1048576 + 0 [blkzone]
252,0    8       16     1.891888552  5965  G  ZR I 1048576 + 0 [blkzone]
252,0    8       17     1.891889409  5965  Q  ZR I 1572864 + 0 [blkzone]
252,0    8       18     1.891891532  5965  G  ZR I 1572864 + 0 [blkzone]
252,0    8       19     1.891892242  5965  Q ZRS I 2097152 + 0 [blkzone]
252,0    8       20     1.891893712  5965  G ZRS I 2097152 + 0 [blkzone]
Using Prio Mask : 0xE 
252,0    3        1     1.883515105  5988  Q  ZR B 0 + 0 [blkzone]
252,0    3        2     1.883523278  5988  G  ZR B 0 + 0 [blkzone]
252,0    3        3     1.883525945  5988  Q  ZR B 524288 + 0 [blkzone]
252,0    3        4     1.883528088  5988  G  ZR B 524288 + 0 [blkzone]
252,0    3        5     1.883529042  5988  Q  ZR B 1048576 + 0 [blkzone]
252,0    3        6     1.883530365  5988  G  ZR B 1048576 + 0 [blkzone]
252,0    3        7     1.883531268  5988  Q  ZR B 1572864 + 0 [blkzone]
252,0    3        8     1.883532295  5988  G  ZR B 1572864 + 0 [blkzone]
252,0    3        9     1.883533208  5988  Q ZRS B 2097152 + 0 [blkzone]
252,0    3       10     1.883534558  5988  G ZRS B 2097152 + 0 [blkzone]
252,0    8        1     1.886945018  5989  Q  ZR I 0 + 0 [blkzone]
252,0    8        2     1.886949388  5989  G  ZR I 0 + 0 [blkzone]
252,0    8        3     1.886951582  5989  Q  ZR I 524288 + 0 [blkzone]
252,0    8        4     1.886953608  5989  G  ZR I 524288 + 0 [blkzone]
252,0    8        5     1.886954631  5989  Q  ZR I 1048576 + 0 [blkzone]
252,0    8        6     1.886956341  5989  G  ZR I 1048576 + 0 [blkzone]
252,0    8        7     1.886957144  5989  Q  ZR I 1572864 + 0 [blkzone]
252,0    8        8     1.886958211  5989  G  ZR I 1572864 + 0 [blkzone]
252,0    8        9     1.886958967  5989  Q ZRS I 2097152 + 0 [blkzone]
252,0    8       10     1.886960384  5989  G ZRS I 2097152 + 0 [blkzone]
252,0    2        1     1.879882785  5986  Q  ZR R 0 + 0 [blkzone]
252,0    2        2     1.879885951  5986  G  ZR R 0 + 0 [blkzone]
252,0    2        3     1.879887731  5986  Q  ZR R 524288 + 0 [blkzone]
252,0    2        4     1.879889601  5986  G  ZR R 524288 + 0 [blkzone]
252,0    2        5     1.879890405  5986  Q  ZR R 1048576 + 0 [blkzone]
252,0    2        6     1.879891408  5986  G  ZR R 1048576 + 0 [blkzone]
252,0    2        7     1.879892135  5986  Q  ZR R 1572864 + 0 [blkzone]
252,0    2        8     1.879893505  5986  G  ZR R 1572864 + 0 [blkzone]
252,0    2        9     1.879894291  5986  Q ZRS R 2097152 + 0 [blkzone]
252,0    2       10     1.879895691  5986  G ZRS R 2097152 + 0 [blkzone]
Using Prio Mask : 0xF 
252,0    3        1     1.883856995  6012  Q  ZR B 0 + 0 [blkzone]
252,0    3        2     1.883861375  6012  G  ZR B 0 + 0 [blkzone]
252,0    3        3     1.883863435  6012  Q  ZR B 524288 + 0 [blkzone]
252,0    3        4     1.883865559  6012  G  ZR B 524288 + 0 [blkzone]
252,0    3        5     1.883866469  6012  Q  ZR B 1048576 + 0 [blkzone]
252,0    3        6     1.883868035  6012  G  ZR B 1048576 + 0 [blkzone]
252,0    3        7     1.883868815  6012  Q  ZR B 1572864 + 0 [blkzone]
252,0    3        8     1.883870282  6012  G  ZR B 1572864 + 0 [blkzone]
252,0    3        9     1.883871189  6012  Q ZRS B 2097152 + 0 [blkzone]
252,0    3       10     1.883872595  6012  G ZRS B 2097152 + 0 [blkzone]
252,0    6        1     1.887079805  6013  Q  ZR I 0 + 0 [blkzone]
252,0    6        2     1.887083840  6013  G  ZR I 0 + 0 [blkzone]
252,0    6        3     1.887086234  6013  Q  ZR I 524288 + 0 [blkzone]
252,0    6        4     1.887088234  6013  G  ZR I 524288 + 0 [blkzone]
252,0    6        5     1.887089191  6013  Q  ZR I 1048576 + 0 [blkzone]
252,0    6        6     1.887090506  6013  G  ZR I 1048576 + 0 [blkzone]
252,0    6        7     1.887091405  6013  Q  ZR I 1572864 + 0 [blkzone]
252,0    6        8     1.887092380  6013  G  ZR I 1572864 + 0 [blkzone]
252,0    6        9     1.887093140  6013  Q ZRS I 2097152 + 0 [blkzone]
252,0    6       10     1.887094194  6013  G ZRS I 2097152 + 0 [blkzone]
252,0    2        1     1.877553702  6009  Q  ZR N 0 + 0 [blkzone]
252,0    2        2     1.877563306  6009  G  ZR N 0 + 0 [blkzone]
252,0    2        3     1.877566219  6009  Q  ZR N 524288 + 0 [blkzone]
252,0    2        4     1.877568449  6009  G  ZR N 524288 + 0 [blkzone]
252,0    2        5     1.877569469  6009  Q  ZR N 1048576 + 0 [blkzone]
252,0    2        6     1.877570862  6009  G  ZR N 1048576 + 0 [blkzone]
252,0    2        7     1.877571822  6009  Q  ZR N 1572864 + 0 [blkzone]
252,0    2        8     1.877572932  6009  G  ZR N 1572864 + 0 [blkzone]
252,0    2        9     1.877573859  6009  Q ZRS N 2097152 + 0 [blkzone]
252,0    2       10     1.877575349  6009  G ZRS N 2097152 + 0 [blkzone]
252,0    2       11     1.880596504  6010  Q  ZR R 0 + 0 [blkzone]
252,0    2       12     1.880599754  6010  G  ZR R 0 + 0 [blkzone]
252,0    2       13     1.880601564  6010  Q  ZR R 524288 + 0 [blkzone]
252,0    2       14     1.880603211  6010  G  ZR R 524288 + 0 [blkzone]
252,0    2       15     1.880604004  6010  Q  ZR R 1048576 + 0 [blkzone]
252,0    2       16     1.880605181  6010  G  ZR R 1048576 + 0 [blkzone]
252,0    2       17     1.880605961  6010  Q  ZR R 1572864 + 0 [blkzone]
252,0    2       18     1.880606908  6010  G  ZR R 1572864 + 0 [blkzone]
252,0    2       19     1.880607658  6010  Q ZRS R 2097152 + 0 [blkzone]
252,0    2       20     1.880608911  6010  G ZRS R 2097152 + 0 [blkzone]

Tracing write-zeroes (REQ_OP_WRITE_ZEROES) with blktrace extensions:-

for i in 1 2 3 4 5 6 7 8 9 A B C D E F
do
	echo Using "Prio Mask : 0x${i} " 
	./blktrace -P -E -X ${i} -y write_zeroes -d /dev/nullb0 -o - \
		| ./blkparse -P -X ${i} -E -i -
done

# We use null_blk write_zeroes=1 with the patch present in this RFC.
for ((i=0; i<16; i++))
do
	for prio in `seq 0 3`; do echo "$prio"; 
		ionice -c ${prio} blkdiscard -z -o 0 -l 4096 /dev/nullb0;
	done;
	sleep 2; 
	killall blkparse;
	killall blktrace;
	sleep 2;
done


Using Prio Mask : 0x1 
252,0    5        1     8.065350073  4655  Q WZS N 0 + 8 [blkdiscard]
252,0    5        2     8.065358706  4655  G WZS N 0 + 8 [blkdiscard]
Using Prio Mask : 0x3 
252,0    6        1     1.880889501  4707  Q WZS R 0 + 8 [blkdiscard]
252,0    6        2     1.880896026  4707  G WZS R 0 + 8 [blkdiscard]
252,0    5        1     1.878376120  4706  Q WZS N 0 + 8 [blkdiscard]
252,0    5        2     1.878383914  4706  G WZS N 0 + 8 [blkdiscard]
Using Prio Mask : 0x4 
252,0    4        1     1.883751843  4757  Q WZS B 0 + 8 [blkdiscard]
252,0    4        2     1.883755619  4757  G WZS B 0 + 8 [blkdiscard]
Using Prio Mask : 0x5 
252,0    3        1     1.877904141  4791  Q WZS N 0 + 8 [blkdiscard]
252,0    3        2     1.877912598  4791  G WZS N 0 + 8 [blkdiscard]
252,0   10        1     1.884097021  4794  Q WZS B 0 + 8 [blkdiscard]
252,0   10        2     1.884100467  4794  G WZS B 0 + 8 [blkdiscard]
Using Prio Mask : 0x6 
252,0   10        1     1.883680861  4818  Q WZS B 0 + 8 [blkdiscard]
252,0   10        2     1.883684191  4818  G WZS B 0 + 8 [blkdiscard]
252,0    6        1     1.880637705  4816  Q WZS R 0 + 8 [blkdiscard]
252,0    6        2     1.880641438  4816  G WZS R 0 + 8 [blkdiscard]
Using Prio Mask : 0x7 
252,0    6        1     1.881971533  4840  Q WZS R 0 + 8 [blkdiscard]
252,0    6        2     1.881975043  4840  G WZS R 0 + 8 [blkdiscard]
252,0    5        1     1.878780508  4839  Q WZS N 0 + 8 [blkdiscard]
252,0    5        2     1.878788882  4839  G WZS N 0 + 8 [blkdiscard]
252,0   10        1     1.885047668  4842  Q WZS B 0 + 8 [blkdiscard]
252,0   10        2     1.885051246  4842  G WZS B 0 + 8 [blkdiscard]
Using Prio Mask : 0x8 
252,0   10        1     1.890996473  4880  Q WZS I 0 + 8 [blkdiscard]
252,0   10        2     1.890999809  4880  G WZS I 0 + 8 [blkdiscard]
Using Prio Mask : 0x9 
252,0    6        1     1.871078216  4900  Q WZS N 0 + 8 [blkdiscard]
252,0    6        2     1.871086841  4900  G WZS N 0 + 8 [blkdiscard]
252,0    2        1     1.880381208  4904  Q WZS I 0 + 8 [blkdiscard]
252,0    2        2     1.880384705  4904  G WZS I 0 + 8 [blkdiscard]
Using Prio Mask : 0xA 
252,0    5        1     1.881201109  4925  Q WZS R 0 + 8 [blkdiscard]
252,0    5        2     1.881204649  4925  G WZS R 0 + 8 [blkdiscard]
252,0    1        1     1.886961182  4928  Q WZS I 0 + 8 [blkdiscard]
252,0    1        2     1.886964216  4928  G WZS I 0 + 8 [blkdiscard]
Using Prio Mask : 0xB 
252,0    6        1     1.874810856  4948  Q WZS N 0 + 8 [blkdiscard]
252,0    6        2     1.874814623  4948  G WZS N 0 + 8 [blkdiscard]
252,0    6        3     1.877785918  4949  Q WZS R 0 + 8 [blkdiscard]
252,0    6        4     1.877789028  4949  G WZS R 0 + 8 [blkdiscard]
252,0    7        1     1.883500596  4952  Q WZS I 0 + 8 [blkdiscard]
252,0    7        2     1.883503596  4952  G WZS I 0 + 8 [blkdiscard]
Using Prio Mask : 0xC 
252,0   11        1     1.882699917  4975  Q WZS B 0 + 8 [blkdiscard]
252,0   11        2     1.882703620  4975  G WZS B 0 + 8 [blkdiscard]
252,0    0        1     1.885972593  4976  Q WZS I 0 + 8 [blkdiscard]
252,0    0        2     1.885976013  4976  G WZS I 0 + 8 [blkdiscard]
Using Prio Mask : 0xD 
252,0    7        1     1.878177296  4996  Q WZS N 0 + 8 [blkdiscard]
252,0    7        2     1.878180859  4996  G WZS N 0 + 8 [blkdiscard]
252,0    0        1     1.884480996  4999  Q WZS B 0 + 8 [blkdiscard]
252,0    0        2     1.884484218  4999  G WZS B 0 + 8 [blkdiscard]
252,0    1        1     1.887563890  5000  Q WZS I 0 + 8 [blkdiscard]
252,0    1        2     1.887567576  5000  G WZS I 0 + 8 [blkdiscard]
Using Prio Mask : 0xE 
252,0    3        1     1.881435821  5021  Q WZS R 0 + 8 [blkdiscard]
252,0    3        2     1.881438889  5021  G WZS R 0 + 8 [blkdiscard]
252,0    4        1     1.884607718  5023  Q WZS B 0 + 8 [blkdiscard]
252,0    4        2     1.884611292  5023  G WZS B 0 + 8 [blkdiscard]
252,0    5        1     1.887815663  5024  Q WZS I 0 + 8 [blkdiscard]
252,0    5        2     1.887818945  5024  G WZS I 0 + 8 [blkdiscard]
Using Prio Mask : 0xF 
252,0    3        1     1.876575303  5044  Q WZS N 0 + 8 [blkdiscard]
252,0    3        2     1.876585245  5044  G WZS N 0 + 8 [blkdiscard]
252,0    3        3     1.879540097  5045  Q WZS R 0 + 8 [blkdiscard]
252,0    3        4     1.879543080  5045  G WZS R 0 + 8 [blkdiscard]
252,0    4        1     1.882700388  5047  Q WZS B 0 + 8 [blkdiscard]
252,0    4        2     1.882704065  5047  G WZS B 0 + 8 [blkdiscard]
252,0    5        1     1.885891499  5048  Q WZS I 0 + 8 [blkdiscard]
252,0    5        2     1.885895119  5048  G WZS I 0 + 8 [blkdiscard]


-- 
2.19.1
