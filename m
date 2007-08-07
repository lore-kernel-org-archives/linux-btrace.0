From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 07 Aug 2007 08:22:47 +0000
Subject: Re: Blkparse weirdness with "A" (remap) action
Message-Id: <20070807082246.GS5245@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20070726193952.GN32546@stingr.net>
In-Reply-To: <20070726193952.GN32546@stingr.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Mon, Aug 06 2007, Alan D. Brunelle wrote:
> Jens Axboe wrote:
> > On Fri, Jul 27 2007, Paul P Komkoff Jr wrote:
> >   
> >> Replying to Paul P Komkoff Jr:
> >>     
> >>> I'm having a little problem here. I have a setup with md over some
> >>> disks, and I'm running blktrace /dev/md? /dev/sd?, then doing blkparse
> >>> *.blktrace.*, I'm getting this kind of stuff:
> >>>
> >>>  40,131071  1       67     3.043450168   420  A   W 4274944 + 8 <- (253,0) 4275328
> >>>  40,131071  1       67     3.043450168   420  A   W 4274944 + 8 <- (253,0) 4275328
> >>>       
> >> Replying to my own message.
> >> I assume this is because we have this in kernel:
> >>
> >> /*
> >>  * The remap event
> >>  */
> >> struct blk_io_trace_remap {
> >>         __be32 device;
> >>         u32 __pad;
> >>         __be64 sector;
> >> };
> >>
> >> but this in blktrace:
> >>
> >> /*
> >>  * The remap event
> >>  */
> >> struct blk_io_trace_remap {
> >>         __u32 device;
> >>         __u32 device_from;
> >>         __u64 sector;
> >> };
> >>     
> >
> > I think Alan had a patch for filling in that missing device_from value,
> > currently it's not used in the kernel (as you spotted). Alan?
> >
> >   
> I have submitted these patches at least twice - once last fall, and once
> again this spring - the latter time a certain someone named Axboe said
> they'd be going in for sure... :-)

Sorry Alan :-)

> I'm back from holiday and will get cracking on getting an updated set of
> patches out soon...

Thanks, I'll be sure to merge them into an upstream-headed branch so
they'll make 2.6.23.

-- 
Jens Axboe

