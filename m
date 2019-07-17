From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 17 Jul 2019 21:23:57 +0000
Subject: [RFC PATCH 00/38] blktrace: add block trace extension support
Message-Id: <20190717212435.2990-1-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

This is an updated RFC with added support to track the block layer
integrity fields from the feedback I got from Martin. The only change
from the original series is the following patch:-

        blktrace: add integrity tracking support

Also, I've removed the other patches which are part of the auxiliary 
work and kept this RFC only for blktrace code.

I've not made the userspace changes for the integrity related code yet,
as I'm still waiting for some feedback.

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

Please find the patch distribution at the end.

Regards,
Chaitanya

Chaitanya Kulkarni (38):

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
Integrity related code chanegs.
  blktrace: add integrity tracking support

 block/ioctl.c                     |    4 +
 include/linux/blkdev.h            |    3 +
 include/linux/blktrace_api.h      |   18 +
 include/uapi/linux/blktrace_api.h |  109 ++-
 include/uapi/linux/fs.h           |    4 +
 kernel/trace/blktrace.c           | 1281 +++++++++++++++++++++++++++--
 kernel/trace/trace.h              |    1 +
 7 files changed, 1329 insertions(+), 91 deletions(-)

-- 
2.17.0
