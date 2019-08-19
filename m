From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 19 Aug 2019 04:40:31 +0000
Subject: [RFC PATCH 00/38] blktrace: add block trace extension support
Message-Id: <20190819044109.3405-1-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

Hi,

This is an updated RFC which adds support for newly introduced
request operation REQ_OP_ZONE_RESET_ALL. Please find the test log at
the end of this patch. For more details about the test and
REQ_OP_ZONE_RESET_ALL please have a look at :-

https://www.spinics.net/lists/linux-block/msg43298.html

The new "ZRA" string represents the Zone Reset all ->
REQ_OP_ZONE_RESET_ALL in the blkparse output. The -y command line option
is used to trace only REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL.
-E options for blktrace enables the blktrace extension in the kernel.=20

Please have a look at the following blktrace test log for reference.
For this test we configure null_blk device with 8 zones:-

#./blktrace -E -y zone_reset_all -y zone_reset -d /dev/nullb0 -o - | \
 ./blkparse -E -i -

Initial Zone Reset All :-=20
252,0    0        1    21.040708984  4216  Q ZRAS 0 + 0 [blkzone]
252,0    0        2    21.040723364  4216  G ZRAS 0 + 0 [blkzone]
Resetting Zone 7 -> 1 Reset -> REQ_OP_ZONE_RESET requests :-
252,0    2        1    30.179248205  4244  Q ZRS 1835008 + 0 [blkzone]
252,0    2        2    30.179260735  4244  G ZRS 1835008 + 0 [blkzone]
Resetting Zone 6 -> 2 Reset -> REQ_OP_ZONE_RESET requests :-
252,0    1        1    35.753906431  4248  Q  ZR 1572864 + 0 [blkzone]
252,0    1        2    35.753924128  4248  G  ZR 1572864 + 0 [blkzone]
252,0    1        3    35.753934571  4248  Q ZRS 1835008 + 0 [blkzone]
252,0    1        4    35.753939495  4248  G ZRS 1835008 + 0 [blkzone]
Resetting Zone 5 -> 3 Reset -> REQ_OP_ZONE_RESET requests :-
252,0    2        3    40.601533403  4254  Q  ZR 1310720 + 0 [blkzone]
252,0    2        4    40.601542827  4254  G  ZR 1310720 + 0 [blkzone]
252,0    2        5    40.601551333  4254  Q  ZR 1572864 + 0 [blkzone]
252,0    2        6    40.601556097  4254  G  ZR 1572864 + 0 [blkzone]
252,0    2        7    40.601561707  4254  Q ZRS 1835008 + 0 [blkzone]
252,0    2        8    40.601565623  4254  G ZRS 1835008 + 0 [blkzone]
Resetting Zone 4 -> 4 Reset -> REQ_OP_ZONE_RESET requests :-
252,0   11        1    46.377099922  4259  Q  ZR 1048576 + 0 [blkzone]
252,0   11        2    46.377108469  4259  G  ZR 1048576 + 0 [blkzone]
252,0   11        3    46.377116735  4259  Q  ZR 1310720 + 0 [blkzone]
252,0   11        4    46.377121535  4259  G  ZR 1310720 + 0 [blkzone]
252,0   11        5    46.377127349  4259  Q  ZR 1572864 + 0 [blkzone]
252,0   11        6    46.377131339  4259  G  ZR 1572864 + 0 [blkzone]
252,0   11        7    46.377137182  4259  Q ZRS 1835008 + 0 [blkzone]
252,0   11        8    46.377140802  4259  G ZRS 1835008 + 0 [blkzone]
Resetting Zone 3 -> 5 Reset -> REQ_OP_ZONE_RESET requests :-
252,0    6        1    50.945615223  4264  Q  ZR 786432 + 0 [blkzone]
252,0    6        2    50.945624123  4264  G  ZR 786432 + 0 [blkzone]
252,0    6        3    50.945632746  4264  Q  ZR 1048576 + 0 [blkzone]
252,0    6        4    50.945637676  4264  G  ZR 1048576 + 0 [blkzone]
252,0    6        5    50.945644108  4264  Q  ZR 1310720 + 0 [blkzone]
252,0    6        6    50.945647928  4264  G  ZR 1310720 + 0 [blkzone]
252,0    6        7    50.945653639  4264  Q  ZR 1572864 + 0 [blkzone]
252,0    6        8    50.945657286  4264  G  ZR 1572864 + 0 [blkzone]
252,0    6        9    50.945662543  4264  Q ZRS 1835008 + 0 [blkzone]
252,0    6       10    50.945666256  4264  G ZRS 1835008 + 0 [blkzone]
Resetting Zone 2 -> 6 Reset -> REQ_OP_ZONE_RESET requests :-
252,0    7        1    54.673804750  4269  Q  ZR 524288 + 0 [blkzone]
252,0    7        2    54.673812680  4269  G  ZR 524288 + 0 [blkzone]
252,0    7        3    54.673860150  4269  Q  ZR 786432 + 0 [blkzone]
252,0    7        4    54.673864977  4269  G  ZR 786432 + 0 [blkzone]
252,0    7        5    54.673870750  4269  Q  ZR 1048576 + 0 [blkzone]
252,0    7        6    54.673874603  4269  G  ZR 1048576 + 0 [blkzone]
252,0    7        7    54.673880343  4269  Q  ZR 1310720 + 0 [blkzone]
252,0    7        8    54.673886383  4269  G  ZR 1310720 + 0 [blkzone]
252,0    7        9    54.673892030  4269  Q  ZR 1572864 + 0 [blkzone]
252,0    7       10    54.673896097  4269  G  ZR 1572864 + 0 [blkzone]
252,0    7       11    54.673901643  4269  Q ZRS 1835008 + 0 [blkzone]
252,0    7       12    54.673905730  4269  G ZRS 1835008 + 0 [blkzone]
Resetting Zone 1 -> 7 Reset -> REQ_OP_ZONE_RESET requests :-
252,0    7       13    59.568550348  4274  Q  ZR 262144 + 0 [blkzone]
252,0    7       14    59.568557825  4274  G  ZR 262144 + 0 [blkzone]
252,0    7       15    59.568565005  4274  Q  ZR 524288 + 0 [blkzone]
252,0    7       16    59.568568660  4274  G  ZR 524288 + 0 [blkzone]
252,0    7       17    59.568573768  4274  Q  ZR 786432 + 0 [blkzone]
252,0    7       18    59.568577340  4274  G  ZR 786432 + 0 [blkzone]
252,0    7       19    59.568582291  4274  Q  ZR 1048576 + 0 [blkzone]
252,0    7       20    59.568587282  4274  G  ZR 1048576 + 0 [blkzone]
252,0    7       21    59.568592254  4274  Q  ZR 1310720 + 0 [blkzone]
252,0    7       22    59.568595937  4274  G  ZR 1310720 + 0 [blkzone]
252,0    7       23    59.568600728  4274  Q  ZR 1572864 + 0 [blkzone]
252,0    7       24    59.568604205  4274  G  ZR 1572864 + 0 [blkzone]
252,0    7       25    59.568608908  4274  Q ZRS 1835008 + 0 [blkzone]
252,0    7       26    59.568612274  4274  G ZRS 1835008 + 0 [blkzone]
Resetting Zone 0 Reset ->  REQ_OP_ZONE_RESET_ALL requests :-
252,0    7       27    66.545378413  4279  Q ZRAS 0 + 0 [blkzone]
252,0    7       28    66.545386283  4279  G ZRAS 0 + 0 [blkzone]
Just REQ_OP_ZONE_RESET_ALL:-
252,0    7       29    80.260511190  4330  Q ZRAS 0 + 0 [blkzone]
252,0    7       30    80.260519220  4330  G ZRAS 0 + 0 [blkzone]

I do have userspace code changes for this if anyone is interested I'll
post them.

Following is the link to the kernel and userspace RFC and cover-letter:-

1. Original Kernel RFC :-
        https://marc.info/?l=3Dlinux-btrace&m=155949445123407&w=3D2

2. Original Userspace RFC :-
        https://marc.info/?l=3Dlinux-btrace&m=155950039424783&w=3D2

3. Original Cover letter :-

This patch series adds support to track more request based flags and
different request fields to the blktrace infrastructure.

In this series, we increase the action, action mask field and add=20
priority and priority mask field to existing infrastructure.

We add new structures to hold the trace where we increase the size of
the action field and add a new member to track the priority of the I/O.
For the trace management side we add new IOCTLs so that user can=20
configure trace extensions from the blktrace user-space tools.

The RFC is still light on the details but with new IOCTLs I was able to
get the code running with user-space tools. There is still some more
scope to optimize the code and reduce the duplicate code, but I kept
it simple for now so that it is easy to review. I'm aware of some
checkpatch.pl warnings mostly about 80 col, I'll fix that in the
next version.

It will be great if someone can review this code and provide some
feedback.

Regards,
Chaitanya

Chaitanya Kulkarni (38):
  blktrace_api: add new trace definitions
  blktrace_api: add new trace definition
  blkdev.h: add new trace ext as a queue member
  blktrace: introduce new ioctls
  blktrace: add a new global list
  blktrace: add trace note APIs
  blktrace: add act and prio check helpers
  blktrace: add core trace API
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
  blktrace: add a new formatting routine
  blktrace: add trace entry & pdu helpers
  blktrace: add blk_log_xxx helpers()
  blktrace: link blk_log_xxx() to trace action
  blktrace: add trace event print helper
  blktrace: add trace_synthesize helper
  blktrace: add trace print helpers
  blktrace: add blkext tracer
  blktrace: implement setup-start-stop ioclts
  block: update blkdev_ioctl with new trace ioctls
  blktrace: add integrity tracking support

 block/ioctl.c                     |    4 +
 include/linux/blkdev.h            |    3 +
 include/linux/blktrace_api.h      |   18 +
 include/uapi/linux/blktrace_api.h |  108 ++-
 include/uapi/linux/fs.h           |    4 +
 kernel/trace/blktrace.c           | 1283 +++++++++++++++++++++++++++--
 kernel/trace/trace.h              |    1 +
 7 files changed, 1330 insertions(+), 91 deletions(-)

Test Log :-=20

dd if=3D/dev/zero of=3D/dev/nullb0 bs@96 count=3D2 seek2768
dd if=3D/dev/zero of=3D/dev/nullb0 bs@96 count=3D4 seeke536
dd if=3D/dev/zero of=3D/dev/nullb0 bs@96 count=3D8 seek=98304
dd if=3D/dev/zero of=3D/dev/nullb0 bs@96 count=16 seek=131072
dd if=3D/dev/zero of=3D/dev/nullb0 bs@96 count2 seek=163840
dd if=3D/dev/zero of=3D/dev/nullb0 bs@96 countd seek=196608
dd if=3D/dev/zero of=3D/dev/nullb0 bs@96 count=128 seek"9376
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000080 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000100 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000200 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000400 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
Starting REQ_OP_ZONE_RESET test :-=20
blkzone reset -o 1835008 /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000080 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000100 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000200 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 7 :- blkzone reset -o 1572864 /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000080 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000100 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 6 :- blkzone reset -o 1310720 /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000080 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 5 :- blkzone reset -o 1048576 /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 4 :- blkzone reset -o 786432 /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 3 :- blkzone reset -o 524288 /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 2 :- blkzone reset -o 262144 /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 1 :- blkzone reset -o 0 /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 0 :- dd if=3D/dev/zero of=3D/dev/nullb0 bs@96 count=3D1 seek=3D0
dd if=3D/dev/zero of=3D/dev/nullb0 bs@96 count=3D2 seek2768
dd if=3D/dev/zero of=3D/dev/nullb0 bs@96 count=3D4 seeke536
dd if=3D/dev/zero of=3D/dev/nullb0 bs@96 count=3D8 seek=98304
dd if=3D/dev/zero of=3D/dev/nullb0 bs@96 count=16 seek=131072
dd if=3D/dev/zero of=3D/dev/nullb0 bs@96 count2 seek=163840
dd if=3D/dev/zero of=3D/dev/nullb0 bs@96 countd seek=196608
dd if=3D/dev/zero of=3D/dev/nullb0 bs@96 count=128 seek"9376
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000080 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000100 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000200 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000400 reset:0 non-seq:0, zcond:=
 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
-------------------------------------------------
  start: 0x000000000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond:=
 1(em) [type: 2(SEQ_WRITE_REQUIRED)]

--=20
2.17.0
