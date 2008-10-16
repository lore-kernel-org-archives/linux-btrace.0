From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 16 Oct 2008 08:53:17 +0000
Subject: Re: [Patch 3/3] driver data: add support to blktrace user space code
Message-Id: <20081016085317.GX19428@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1224146144.8197.8.camel@kitka.ibm.com>
In-Reply-To: <1224146144.8197.8.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-s390@vger.kernel.org, linux-btrace@vger.kernel.org

On Thu, Oct 16 2008, Martin Peschke wrote:
> 
> On Thu, 2008-10-16 at 08:07 +0200, Jens Axboe wrote:
> > On Sun, Oct 05 2008, Martin Peschke wrote:
> > > From: Stefan Raspl <raspl@linux.vnet.ibm.com>
> > > 
> > > Adds a new type of action 'drv_data' for blktrace to handle binary
> > > driver-specific data. Since the data is binary, blkparse will only put it in
> > > a binary file, not in the regular human-readable output.
> > 
> > I wonder if that should display some kind of informational message on
> > blkparse exit, if you are not dumping binary? Just to notify the user
> > that there was extra data available, but that it wasn't dumped.
> 
> Don't know.
> 
> But I can volunteer to send a patch if you think so.

I think it would be beneficial, so if you could that would be great ;)

-- 
Jens Axboe

