From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 26 Sep 2008 08:50:39 +0000
Subject: Re: [Patch] include blktrace_api.h in headers_install
Message-Id: <20080926085036.GT2677@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216207465.26621.80.camel@kitka.ibm.com>
In-Reply-To: <1216207465.26621.80.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Fri, Sep 26 2008, Jan Blunck wrote:
> On Wed, Jul 16, Martin Peschke wrote:
> 
> > From: Sven Schuetz <sven@linux.vnet.ibm.com>
> > 
> > This header file is of interest for user space programming, i.e.
> > for tools that process blktrace data.
> > 
> > We would like to use it for a tool on-top of blktrace which processes
> > data provided by blktrace. For this purpose, it would be helpful
> > if the blktrace API would make it to /usr/include/linux.
> > 
> > The git tree for the blktrace tools comes with its own copy of this header
> > file. I didn't manage to replace that copy with the file generated 
> > by the patch below yet. A few more cleanups would be needed.
> > For example, the blktrace ioctl numbers, which are currently defined in
> > usr/include/fs.h, might need to be moved. Should be feasible, though.
> > 
> 
> Any reason why this patch isn't upstream yet?

Nope, I'll add it.

-- 
Jens Axboe

