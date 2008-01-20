From: Jens Axboe <jens.axboe@oracle.com>
Date: Sun, 20 Jan 2008 20:02:22 +0000
Subject: Re: blktrace & btrace usability
Message-Id: <20080120200222.GA6258@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <47906577.8090604@tlinx.org>
In-Reply-To: <47906577.8090604@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Fri, Jan 18 2008, Linda Walsh wrote:
> Jens Axboe wrote:
> >On Fri, Jan 18 2008, Linda Walsh wrote:
> >  
> >>I was examining the SuSE10.3 boot process and noted
> >>it is setup to start & stop blktrace while the system
> >>is booting.  Odd think is that it checks to verify that
> >>the root file system is of type "ext3". 
> >>
> >>Is that a "SuSEism" or is there some reason why it wouldn't
> >>work with any file system?
> >>    
> >
> >Interesting, I never noticed that before. Don't know why they check for
> >ext3, perhaps their post processing tools map blocks to files and only
> >works for ext3?
> >  
> --- 
>    Would be nice if they left a comment to that effect.
>    ext2 should be the same, and I think xfs has all the
> data needed to process it under a perl script -- xfs_bmap,
> for example, prints off all of the blocks used by a file (so
> it's easy to compute fragmentation).
> 
>    They don't seem to include a util in the blktrace package
> to map blocks to to files.  Anyway, you answer my question --
> blktracing doesn't rely on something ext3 specific.

There's definitely nothing fs specific in blktrace. IIRC, Olaf Kirch
wrote something called fsmap while at SUSE. Perhaps that is a clue to
what they are doing there?

-- 
Jens Axboe

