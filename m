From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 21 Oct 2021 14:45:29 +0000
Subject: Re: [PATCH 0/2] Fix issues in check_cpu_map
Message-Id: <340516b3-b928-9013-aa9f-507233585fb1@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20211021141620.2878-1-jeffm@suse.com>
In-Reply-To: <20211021141620.2878-1-jeffm@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 10/21/21 8:16 AM, jeffm@suse.com wrote:
> From: Jeff Mahoney <jeffm@suse.com>
> 
> Hi folks -
> 
> I received a bug report[1] where blkparse would crash on pipe input.  It
> was not reproducible and, looking at the core dump, it appears to be due
> to the first event being dropped such that we end up going down the
> check_sequence path to check_cpu_map with bit->sequence = 2 first the
> first sequence.  check_cpu_map would do a malloc(0) and then write past
> the end of the (empty) range, ultimately causing a crash in free() due
> to glibc's magic byte at the end of the buffer being overwritten.  Since we
> don't do CPU online tracking on pipe input and file input will online at
> least one CPU or exit, we can skip the rest of the body if the CPU map
> is empty.
> 
> While looking at this, I also found that the memset always uses
> sizeof(unsigned long *) as its size regardless of the allocated since.
> I've replaced that with a calloc.

Applied, thanks Jeff.

-- 
Jens Axboe
