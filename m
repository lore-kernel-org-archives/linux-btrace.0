From: Jens Axboe <jens.axboe@oracle.com>
Date: Mon, 26 Jan 2009 11:42:15 +0000
Subject: Re: [PATCH tip][0/2] ftrace interface for blktrace
Message-Id: <20090126114214.GH30821@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20090123140617.GB21737@ghostprotocols.net>
In-Reply-To: <20090123140617.GB21737@ghostprotocols.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org

On Fri, Jan 23 2009, Arnaldo Carvalho de Melo wrote:
> Hi Jens,
> 
> 	Here is a third version, that also implements blk_add_trace_msg,
> using ftrace_vprintk.
> 
> 	As soon as the TRACE_ITER_CONTEXT_INFO option is implemented
> I'll provide the struct trace_event->bin() callback to synthesize the
> old blktrace record format so that we can test the output of trace_pipe
> with blkparse -i -.
> 
> 	Please let me know if this is acceptable for inclusion on
> linux-tip.

Sure, go ahead and add it!

-- 
Jens Axboe

