From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 29 Jan 2009 10:59:36 +0000
Subject: Re: [RFC] blktrace 2.0
Message-Id: <20090129105936.GV30821@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <497F844F.4010402@hp.com>
In-Reply-To: <497F844F.4010402@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, Jan 27 2009, Alan D. Brunelle wrote:
> I've been having some issues with blktrace on large(-ish) systems that
> are primarily due to the N(devs) X N(cpus) nature of blktrace: we fire
> off 1 thread for each device on each CPU. With (say) 32 cores and (say)
> 100 devices, we're seeing 3,200 threads competing for cores just to
> handle the data transfer from the relay interface out to long-term storage.
> 
> Today I whipped up a prototype new implementation of blktrace (only
> handles the "standard" read-from-relay and write-to-file mode, *not*
> network or piped modes). This implementation fires off a single thread
> per CPU only - each thread than manages all the relay files for its CPU
> (opens them all, and uses poll() to determine which ones need
> processing). This cuts down a lot on the scheduling issue, and hopefully
> will cause less of an impact on the overall system.
> 
> I've down some testing on a small-ish machine - using valgrind to ensure
> proper handling of all memory, as well as a 16-way w/ >100 disks and
> things are working as expected. (At least blkrawverify, blkparse, btt,
> ... are all working fine for some test cases.)
> 
> I've attached the current sources - a lot of this is just ripped out of
> blktrace.c in the tree currently, some of it is reformatted... Comments?

I think this is the right direction to go, as long as the thread never
blocks waiting for IO. So please, feel free to completel this
implementation and I'll be happy to switch it over.

-- 
Jens Axboe

