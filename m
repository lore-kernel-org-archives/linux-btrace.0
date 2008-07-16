From: Martin Peschke <mp3@de.ibm.com>
Date: Wed, 16 Jul 2008 15:15:38 +0000
Subject: Re: [Patch 0/2] blkiomon: I/O monitor based on blktrace data
Message-Id: <1216221339.26621.128.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <487E0913.1080502@hp.com>
In-Reply-To: <487E0913.1080502@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-s390@vger.kernel.org, linux-btrace@vger.kernel.org


On Wed, 2008-07-16 at 10:43 -0400, Alan D. Brunelle wrote:
> Haven't had time to think this through, but if blktrace is sending
> binary data to blkparse, why not just replace blkparse w/ blkiomon?
> Taking data directly from blktrace itself?

Good point.

Still I think I want all the trace sorting blkparse does for me.
I didn't want to reimplement that functionality.

I don't need other capabilities of blkparse, though, like generating
some basic statistics.

Perhaps, it would make sense to move some blkparse code to a separate
c-file, which could be linked by other tools in the package, blkiomon?

Would be fine with me to make this all as light-weight as possible, e.g.
get rid of blkparse and a pipe.

Martin

