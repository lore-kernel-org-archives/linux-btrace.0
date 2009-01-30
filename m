From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 30 Jan 2009 07:39:36 +0000
Subject: Re: Documentation on the binary file format?
Message-Id: <20090130073936.GD30821@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <4981F463.1050905@cesmail.net>
In-Reply-To: <4981F463.1050905@cesmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Thu, Jan 29 2009, M. Edward (Ed) Borasky wrote:
> Is there some documentation on the binary file format out of "blktrace"?
> I'm interested in writing some post-processing routines that extend what
> "blkparse" and "btt" do, and there is a substantial disk space hit if I
> generate the "blkparse" output and post-process that. I'm also
> considering a network server that takes the binary data from a
> "blktrace" client and does the analysis "on the fly", rather than saving
> off a binary trace.

Look at blktrace_api.h, that basically defines the binary format and
API. In short, the binary trace is just a multiple of blk_io_trace{}
structures. Note that they are always in big endian format, so the
parser needs to convert them to machine local byte ordering first.

> A side question ... how likely are changes in the binary format? The
> language(s) I want to use -- Perl and/or Ruby -- are pretty flexible at
> re-factoring to match format changes, but I'd like to have a clue on how
> much maintenance activity I'm taking on.

Not very likely. If a new format is incompatible with existing tools,
the BLK_IO_TRACE_VERSION will change. So in your program, you basically
do:

        if ((trace->magic & 0xff) != BLK_IO_TRACE_VERSION)
                err;

for starters, and then later if you want to handle different versions,
you can just check for what version is reports and punt to the
appropriate handler.

-- 
Jens Axboe

