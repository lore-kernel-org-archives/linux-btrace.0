From: Jens Axboe <jens.axboe@oracle.com>
Date: Mon, 12 Oct 2009 07:18:14 +0000
Subject: Re: lots of unplugged by timer normal or abnormal?
Message-Id: <20091012071814.GW9228@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20091006185337.GF26949@hostway.ca>
In-Reply-To: <20091006185337.GF26949@hostway.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Sun, Oct 11 2009, Simon Kirby wrote:
> On Sun, Oct 11, 2009 at 08:35:36PM +0200, Jens Axboe wrote:
> 
> > It depends a lot on the workload. The UT will trigger if the amount of
> > writes isn't very high - if you go above 4 queued writes, a regular
> > unplug will trigger. So if you see if for write intensive workloads, it
> > is almost surely a bug. For background firefox activity on your desktop,
> > it's not unusual.
> > 
> > If you see if for reads, it's almost always a bug.
> 
> Ok, so this came up because we're having performance issues on a NFS
> head which serves files on XFS from a bunch of AOE devices.  iostat is
> reporting near-100% utilization for the device I've traced here,
> /dev/etherd/e7.0.
> 
> I noticed blkparse doesn't seem to run anywhere (it takes the local
> number of CPUs even though the trace may have involved more?), so I've
> uploaded blkparse output from the trace machine:

Huh really, if so that's surely a bug. You should be able to parse the
traces anywhere, even on different architectures. The format is designed
to be machine independent. But if blkparse has such a dumb bug, that is
troublesome :-)

> 	http://0x.ca/sim/ref/2.6.30.5-hw-fixedxfs/blkparse_out.txt.gz
> 	http://0x.ca/sim/ref/2.6.30.5-hw-fixedxfs/blkparse-t_out.txt.gz
> 
> See near the beginning of that, CPU #7:
> 
> 152,32   7        5     0.006609360  3228  C   R 7739498616 + 248 ( 4103734) [0]
> 152,32   7        6     0.007504725  2787  A   R 4393342696 + 248 <- (252,43) 98375016
> 152,32   7        7     0.007505633  2787  Q   R 4393342696 + 248 [nfsd]
> 152,32   7        8     0.007507379  2787  G   R 4393342696 + 248 [nfsd]
> 152,32   7        9     0.007509055  2787  P   N [nfsd]
> 152,32   7       10     0.007514922  2787  I   R 4393342696 + 248 (    7543) [nfsd]
> 152,32   7       11     0.007520998  2787  A   R 4393342944 + 8 <- (252,43) 98375264
> 152,32   7       12     0.007521696  2787  Q   R 4393342944 + 8 [nfsd]
> 152,32   7       13     0.007528750  2787  G   R 4393342944 + 8 [nfsd]
> 152,32   7       14     0.007529519  2787  I   R 4393342944 + 8 (     769) [nfsd]
> 152,32   7       15     0.011107417     0 UT   N [swapper] 3
> 152,32   7       16     0.011121386   207  U   N [kblockd/7] 3
> 152,32   7       17     0.011129347   207  D   R 4393342696 + 248 ( 3614425) [kblockd/7]
> 
> Is that a bug?

It very much looks like a bug. After that last reas is inserted (seq
14), it's idling for 3.6ms before the unplug timer kicks things into
gear. I wonder if nfsd is missing a backing device or mapping run.

What kernel is this?

-- 
Jens Axboe

