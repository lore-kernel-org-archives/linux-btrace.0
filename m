From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Fri, 23 Jan 2009 14:06:17 +0000
Subject: [PATCH tip][0/2] ftrace interface for blktrace
Message-Id: <20090123140617.GB21737@ghostprotocols.net>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org

Hi Jens,

	Here is a third version, that also implements blk_add_trace_msg,
using ftrace_vprintk.

	As soon as the TRACE_ITER_CONTEXT_INFO option is implemented
I'll provide the struct trace_event->bin() callback to synthesize the
old blktrace record format so that we can test the output of trace_pipe
with blkparse -i -.

	Please let me know if this is acceptable for inclusion on
linux-tip.

Best Regards,

- Arnaldo

 block/blktrace.c       |  651 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/partitions/check.c  |    7 
 include/linux/ftrace.h |    8 
 kernel/trace/trace.c   |    9 
 kernel/trace/trace.h   |    1 
 5 files changed, 671 insertions(+), 5 deletions(-)
