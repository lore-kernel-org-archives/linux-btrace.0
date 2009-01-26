From: Ingo Molnar <mingo@elte.hu>
Date: Mon, 26 Jan 2009 13:43:20 +0000
Subject: Re: [PATCH tip][0/2] ftrace interface for blktrace
Message-Id: <20090126134320.GB18859@elte.hu>
List-Id: <linux-btrace.vger.kernel.org>
References: <20090123140617.GB21737@ghostprotocols.net> <20090126114214.GH30821@kernel.dk>
In-Reply-To: <20090126114214.GH30821@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org


* Jens Axboe <jens.axboe@oracle.com> wrote:

> On Fri, Jan 23 2009, Arnaldo Carvalho de Melo wrote:
> > Hi Jens,
> > 
> > 	Here is a third version, that also implements blk_add_trace_msg,
> > using ftrace_vprintk.
> > 
> > 	As soon as the TRACE_ITER_CONTEXT_INFO option is implemented
> > I'll provide the struct trace_event->bin() callback to synthesize the
> > old blktrace record format so that we can test the output of trace_pipe
> > with blkparse -i -.
> > 
> > 	Please let me know if this is acceptable for inclusion on
> > linux-tip.
> 
> Sure, go ahead and add it!

Cool - i've started tracking Arnaldo's patch by picking up the latest 
version into tip/tracing/blktrace and merging it into tip/master.

Arnaldo, could you please check latest tip/master:

   http://people.redhat.com/mingo/tip.git/README

to see whether it's all OK, integrated with the latest tracing bits?

	Ingo
