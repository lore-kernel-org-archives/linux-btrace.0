From: Jens Axboe <jens.axboe@oracle.com>
Date: Sun, 18 May 2008 18:54:26 +0000
Subject: Re: segfault in "blkparse -s"?
Message-Id: <20080518185426.GL16538@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <482F9A7D.3060001@cesmail.net>
In-Reply-To: <482F9A7D.3060001@cesmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Sun, May 18 2008, Jens Axboe wrote:
> On Sat, May 17 2008, M. Edward (Ed) Borasky wrote:
> > Environment: Gentoo Linux 2.6.25 kernel, AMD Athlon64 X2 dual core, 4 GB 
> > of RAM, single disk drive sda, reiserfs filesystems.
> > 
> > I started up blktrace with "blktrace -d /dev/sda". Version is
> > $ blktrace -V
> > blktrace version 0.99.3
> > 
> > Then I recompiled php to generate some I/O. Then I stopped blktrace and 
> > ran blkparse. Version is
> > $ blkparse -V
> > blkparse version 0.99.3
> > 
> > Both "blkparse sda" and "blkparse -t sda" run fine, but "blkparse -s 
> > sda" segfaults:
> > 
> > $ blkparse -s sda > blkparse.out
> > Segmentation fault
> > 
> > It generates partial output before crashing.
> > 
> > I'm planning to try this again under gdb to get a traceback. The Gentoo 
> > "btrace" package is sys-block/btrace-0.0.20071210202527 -- if this is 
> > too old, let me know and I'll install something more recent from the 
> > repositories.
> 
> Could you send me the blktrace output files so that I can reproduce?
> You could try self-compiling
> 
> http://brick.kernel.dk/snaps/blktrace-git-latest.tar.gz
> 
> just to see if it reproduces in current HEAD.

This turned out to be missing notify events, for some (as of yet)
undiagnosed reason. I committed a fix to handle those, it's not unlikely
that we COULD miss a notify event and we should cope with that anyway.

-- 
Jens Axboe

