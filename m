From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Date: Tue, 20 Oct 2020 23:12:21 +0000
Subject: Re: [RFC PATCH 00/39] blktrace: add block trace extension support
Message-Id: <BYAPR04MB496580CA119D332CD95BA5CF861F0@BYAPR04MB4965.namprd04.prod.outlook.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 8/25/20 15:10, Chaitanya Kulkarni wrote:
> Hi,
>
> This is an updated RFC which adds support for newly introduced
> request operations REQ_OP_ZONE_APPEND along with rest of the 
> REQ_OP_ZONE_XXX. Please find the test log at the end of this patch.
>
> The new strings "ZA" -> Zone APPEND, I do have userspace code changes
> for this if anyone is interested I'll post them.
>
> Original Cover letter stays the same :-
>
> This patch series adds support to track more request based flags and
> different request fields to the blktrace infrastructure.
>
> In this series, we increase the action, action mask field and add 
> priority and priority mask field to existing infrastructure.
>
> We add new structures to hold the trace where we increase the size of
> the action field and add a new member to track the priority of the I/O.
> For the trace management side we add new IOCTLs so that user can 
> configure trace extensions from the blktrace user-space tools.
>
> The RFC is still light on the details but with new IOCTLs I was able to
> get the code running with user-space tools. There is still some more
> scope to optimize the code and reduce the duplicate code, but I kept
> it simple for now so that it is easy to review. I'm aware of some
> checkpatch.pl warnings mostly about 80 col, I'll fix that in the
> next version.
>
> It will be great if someone can review this code and provide some
> feedback.
>
> Regards,
> Chaitanya
>
> Chaitanya Kulkarni (39):
>   blktrace_api: add new trace definitions
>   blktrace_api: add new trace definition
>   blkdev.h: add new trace ext as a queue member
>   blktrace: add a new global list
>   blktrace: add trace note APIs
>   blktrace: add act and prio check helpers
>   blktrace: add core trace API
>   blktrace: update blk_add_trace_rq()
>   blktrace: update blk_add_trace_rq_insert()
>   blktrace: update blk_add_trace_rq_issue()
>   blktrace: update blk_add_trace_rq_requeue()
>   blktrace: update blk_add_trace_rq_complete()
>   blktrace: update blk_add_trace_bio()
>   blktrace: update blk_add_trace_bio_bounce()
>   blktrace: update blk_add_trace_bio_complete()
>   blktrace: update blk_add_trace_bio_backmerge()
>   blktrace: update blk_add_trace_bio_frontmerge()
>   blktrace: update blk_add_trace_bio_queue()
>   blktrace: update blk_add_trace_getrq()
>   blktrace: update blk_add_trace_sleeprq()
>   blktrace: update blk_add_trace_plug()
>   blktrace: update blk_add_trace_unplug()
>   blktrace: update blk_add_trace_split()
>   blktrace: update blk_add_trace_bio_remap()
>   blktrace: update blk_add_trace_rq_remap()
>   blktrace: update blk_add_driver_data()
>   blktrace: add trace entry & pdu helpers
>   blktrace: add a new formatting routine
>   blktrace: add blk_log_xxx helpers()
>   blktrace: link blk_log_xxx() to trace action
>   blktrace: add trace event print helper
>   blktrace: add trace_synthesize helper
>   blktrace: add trace print helpers
>   blktrace: add blkext tracer
>   blktrace: implement setup-start-stop ioclts
>   block: update blkdev_ioctl with new trace ioctls
>   blktrace: add integrity tracking support
>   blktrace: update blk_fill_rwbs() with new requests
>   blktrace: track zone appaend completion sector
>
>  block/ioctl.c                     |    4 +
>  include/linux/blkdev.h            |    1 +
>  include/linux/blktrace_api.h      |   18 +
>  include/uapi/linux/blktrace_api.h |  113 ++-
>  include/uapi/linux/fs.h           |    4 +
>  kernel/trace/blktrace.c           | 1471 +++++++++++++++++++++++++++--
>  kernel/trace/trace.h              |    1 +
>  7 files changed, 1537 insertions(+), 75 deletions(-)
Gentle ping ?
