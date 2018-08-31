From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 31 Aug 2018 20:58:13 +0000
Subject: Re: [patch] iowatcher: spwan NPROCESSORS_ONLN rsvg-convert-s
Message-Id: <238a78af-758b-8be3-7e8a-57d6ba71cc84@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <x49pnxywbj5.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49pnxywbj5.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 8/31/18 2:01 PM, Jeff Moyer wrote:
> iowatcher currently always spawns 8 rsvg-convert processes, no matter
> how many CPUs a system has.  I did some limited testing of different
> numbers of rsvg-convert processes.  Here are the results:
> 
> 8 processes:
> real	4m2.194s
> user	23m36.665s
> sys	0m38.523s
> 
> 20 processes:
> real	2m28.935s
> user	24m51.817s
> sys	0m49.227s
> 
> 40 processes:
> real	2m28.150s
> user	24m56.994s
> sys	0m49.621s
> 
> Note that this is the time it takes for a full run of iowatcher -- I
> didn't separate out just the rsvg-convert portion.
> 
> Given the above results, it seems like a reasonable thing to spawn one
> rsvg-convert process per cpu.

Applied, with the typo fixed.

-- 
Jens Axboe
