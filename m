From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 20 Nov 2019 04:24:30 +0000
Subject: [RFC PATCH 00/39] blktrace: add block trace extension support
Message-Id: <20191120042509.12835-1-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

This is an updated RFC which adds support for newly introduced
request operations REQ_OP_ZONE_[OPEN/CLOSE/FINISH]. Please find the
test log at the end of this patch.

The new strings "ZO" -> Zone Open, "ZC" -> Zone Close,
"ZF" -> Zone Finish.

I do have userspace code changes for this if anyone is interested I'll
post them.

Following is the link to the kernel and userspace RFC and cover-letter:-

1. Original Kernel RFC :-
        https://marc.info/?l=linux-btrace&m5949445123407&w=2

2. Original Userspace RFC :-
        https://marc.info/?l=linux-btrace&m5950039424783&w=2

3. Original Cover letter :-

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
scope to optimize the code and reduce the duplicate code, but I kept
it simple for now so that it is easy to review. I'm aware of some
checkpatch.pl warnings mostly about 80 col, I'll fix that in the
next version.

It will be great if someone can review this code and provide some
feedback.

Regards,
Chaitanya

Please have a look at the following blktrace test log for reference.
For this test we configure null_blk device with 8 zones:-
# blkzone report /dev/nullb0 | awk '{print $11" "$12}'
zcond: 1(em)
zcond: 1(em)
zcond: 1(em)
zcond: 1(em)
zcond: 1(em)
zcond: 1(em)
zcond: 1(em)
zcond: 1(em)
# blkzone open   /dev/nullb0
# blkzone report /dev/nullb0 | awk '{print $11" "$12}'
zcond: 3(oe)
zcond: 3(oe)
zcond: 3(oe)
zcond: 3(oe)
zcond: 3(oe)
zcond: 3(oe)
zcond: 3(oe)
zcond: 3(oe)
# blkzone close  /dev/nullb0
# blkzone report /dev/nullb0 | awk '{print $11" "$12}'
zcond: 4(cl)
zcond: 4(cl)
zcond: 4(cl)
zcond: 4(cl)
zcond: 4(cl)
zcond: 4(cl)
zcond: 4(cl)
zcond: 4(cl)
#blkzone finish /dev/nullb0
#blkzone report /dev/nullb0 | awk '{print $11" "$12}'
zcond:14(fu) [type:
zcond:14(fu) [type:
zcond:14(fu) [type:
zcond:14(fu) [type:
zcond:14(fu) [type:
zcond:14(fu) [type:
zcond:14(fu) [type:
zcond:14(fu) [type:

# blktrace -P -E -y zone_open -y zone_reset -y zone_close \
  -y zone_finish -d /dev/nullb0 -o - | blkparse -P -E -i -
252,0    8        1     2.189492669  4544  Q  ZO N 0 + 0 [blkzone]
252,0    8        2     2.189498940  4544  G  ZO N 0 + 0 [blkzone]
252,0    8        3     2.189527825  4544  Q  ZO N 262144 + 0 [blkzone]
252,0    8        4     2.189528456  4544  G  ZO N 262144 + 0 [blkzone]
252,0    8        5     2.189534958  4544  Q  ZO N 524288 + 0 [blkzone]
252,0    8        6     2.189535369  4544  G  ZO N 524288 + 0 [blkzone]
252,0    8        7     2.189540759  4544  Q  ZO N 786432 + 0 [blkzone]
252,0    8        8     2.189541190  4544  G  ZO N 786432 + 0 [blkzone]
252,0    8        9     2.189546470  4544  Q  ZO N 1048576 + 0 [blkzone]
252,0    8       10     2.189546880  4544  G  ZO N 1048576 + 0 [blkzone]
252,0    8       11     2.189551890  4544  Q  ZO N 1310720 + 0 [blkzone]
252,0    8       12     2.189552331  4544  G  ZO N 1310720 + 0 [blkzone]
252,0    8       13     2.189557340  4544  Q  ZO N 1572864 + 0 [blkzone]
252,0    8       14     2.189557751  4544  G  ZO N 1572864 + 0 [blkzone]
252,0    8       15     2.189563061  4544  Q ZOS N 1835008 + 0 [blkzone]
252,0    8       16     2.189563632  4544  G ZOS N 1835008 + 0 [blkzone]
252,0    0        1    18.056920184  4563  Q  ZC N 0 + 0 [blkzone]
252,0    0        2    18.056924843  4563  G  ZC N 0 + 0 [blkzone]
252,0    0        3    18.056980006  4563  Q  ZC N 262144 + 0 [blkzone]
252,0    0        4    18.056980748  4563  G  ZC N 262144 + 0 [blkzone]
252,0    0        5    18.056988041  4563  Q  ZC N 524288 + 0 [blkzone]
252,0    0        6    18.056988462  4563  G  ZC N 524288 + 0 [blkzone]
252,0    0        7    18.056994153  4563  Q  ZC N 786432 + 0 [blkzone]
252,0    0        8    18.056995035  4563  G  ZC N 786432 + 0 [blkzone]
252,0    0        9    18.057000835  4563  Q  ZC N 1048576 + 0 [blkzone]
252,0    0       10    18.057001396  4563  G  ZC N 1048576 + 0 [blkzone]
252,0    0       11    18.057006736  4563  Q  ZC N 1310720 + 0 [blkzone]
252,0    0       12    18.057007147  4563  G  ZC N 1310720 + 0 [blkzone]
252,0    0       13    18.057012217  4563  Q  ZC N 1572864 + 0 [blkzone]
252,0    0       14    18.057012628  4563  G  ZC N 1572864 + 0 [blkzone]
252,0    0       15    18.057017717  4563  Q ZCS N 1835008 + 0 [blkzone]
252,0    0       16    18.057018128  4563  G ZCS N 1835008 + 0 [blkzone]
252,0    0       17    25.520929840  4573  Q  ZF N 0 + 0 [blkzone]
252,0    0       18    25.520934359  4573  G  ZF N 0 + 0 [blkzone]
252,0    0       19    25.520954526  4573  Q  ZF N 262144 + 0 [blkzone]
252,0    0       20    25.520955027  4573  G  ZF N 262144 + 0 [blkzone]
252,0    0       21    25.520961029  4573  Q  ZF N 524288 + 0 [blkzone]
252,0    0       22    25.520961409  4573  G  ZF N 524288 + 0 [blkzone]
252,0    0       23    25.520966659  4573  Q  ZF N 786432 + 0 [blkzone]
252,0    0       24    25.520967070  4573  G  ZF N 786432 + 0 [blkzone]
252,0    0       25    25.520971889  4573  Q  ZF N 1048576 + 0 [blkzone]
252,0    0       26    25.520972260  4573  G  ZF N 1048576 + 0 [blkzone]
252,0    0       27    25.520976878  4573  Q  ZF N 1310720 + 0 [blkzone]
252,0    0       28    25.520977279  4573  G  ZF N 1310720 + 0 [blkzone]
252,0    0       29    25.520981918  4573  Q  ZF N 1572864 + 0 [blkzone]
252,0    0       30    25.520982349  4573  G  ZF N 1572864 + 0 [blkzone]
252,0    0       31    25.520987037  4573  Q ZFS N 1835008 + 0 [blkzone]
252,0    0       32    25.520987418  4573  G ZFS N 1835008 + 0 [blkzone]

Chaitanya Kulkarni (39):
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
  blktrace: add support for zone-mgmt ops

 block/ioctl.c                     |    4 +
 include/linux/blkdev.h            |    3 +
 include/linux/blktrace_api.h      |   18 +
 include/uapi/linux/blktrace_api.h |  111 ++-
 include/uapi/linux/fs.h           |    4 +
 kernel/trace/blktrace.c           | 1289 +++++++++++++++++++++++++++--
 kernel/trace/trace.h              |    1 +
 7 files changed, 1339 insertions(+), 91 deletions(-)

-- 
2.22.1
