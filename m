From: Martin Peschke <mp3@de.ibm.com>
Date: Mon, 29 Sep 2008 15:30:34 +0000
Subject: Re: [Patch] include blktrace_api.h in headers_install
Message-Id: <1222702234.20048.26.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080926193434.GA16003@wavehammer.waldi.eu.org>
In-Reply-To: <20080926193434.GA16003@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-s390@vger.kernel.org, linux-btrace@vger.kernel.org


On Fri, 2008-09-26 at 21:34 +0200, Bastian Blank wrote:
> On Wed, Jul 16, 2008 at 01:24:25PM +0200, Martin Peschke wrote:
> > +#ifdef __KERNEL__
> > +	char name[BDEVNAME_SIZE];	/* output */
> > +#else
> > +	char name[32];			/* output */
> > +#endif
> 
> Bad idea. BDEVNAME_SIZE is not exported and therfor not part of the
> public API. As this defines a userspace API it must not change anyway.

So this should be simply  char name[32]  both for kernel and user space?

Martin

