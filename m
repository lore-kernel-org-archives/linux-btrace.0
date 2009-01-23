From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 23 Jan 2009 10:02:27 +0000
Subject: Re: [PATCH]  Increased limits to allow for large system runs
Message-Id: <20090123100227.GX30821@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <4978C127.3060307@hp.com>
In-Reply-To: <4978C127.3060307@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Thu, Jan 22 2009, Alan D. Brunelle wrote:

> On 16-way w/ 104 disks and a 32-way w/ 96 disks, I was getting:
> 
> $ sudo blktrace -b 1024 -n 8 -I ../files
> ./cciss_c1d6.blktrace.10: Too many open files
> Failed to start worker threads
> 
> Due to the nature of our N(cpus) X N(devices) order of file opens, and
> our N(cpus) X N(devices) X N(buffers) X (buffer size) amount of mmaps()
> going on we're exceeding both the RLIMIT_NOFILE and RLIMIT_MEMLOCK
> limits.
> 
> This patch raises limits for RLIMIT_NOFILE and RLIMIT_MEMLOCK to
> "infinity", and allows blktrace to handle the large(ish) systems. (If
> these settings fail, we "guestimate" about how much we really need.)

Thanks Alan, I pushed it out.

> There is still an underlying blktrace and/or kernel problem: The
> directory /sys/kernel/debug/block/<DSF> where <DSF> is the device that
> encountered the limit is left behind (not cleaned up correctly). This
> stops blktrace from running a second time (even on another device):
> 
> $  ls /sys/kernel/debug/block
> cciss_c1d6
> $ sudo blktrace /dev/sda
> BLKTRACESETUP: No such file or directory
> Failed to start trace on /dev/sda
> 
> and requires a reboot. (Looking into that next, as this patch - whilst
> stopping the original problem from happening - does not address the
> secondary problem. And there may be some other ways for the secondary
> problem to still occur...)

Would be nice if you have time to get to the bottom of that!

-- 
Jens Axboe

