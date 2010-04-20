From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 20 Apr 2010 13:41:29 +0000
Subject: Re: [patch] blktrace: disable kill option - take 2
Message-Id: <20100420134129.GO27497@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <4BCDABCD.4050800@redhat.com>
In-Reply-To: <4BCDABCD.4050800@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, Apr 20 2010, Edward Shishkin wrote:
>

> Fixup for 513950.
> 
> Problem:
> 'blktrace -d <device> -k' does not kill a running
> backgound trace. Executing 'blktrace -d <device> -k'
> for the second time results in "BLKTRACETEARDOWN:
> Invalid argument" message and then each run of
> blktrace on that machine prints the following output:
> BLKTRACESETUP: No such file or directory.
> 
> The bug:
> The option -k results in clobbering information
> about running trace by kernel (blk_trace_remove),
> while resources (files open in debugfs by the running
> background blktrace) are not released.
> 
> Solution:
> Update documentation:
> Undocument the non-working "kill" option. Advise
> to send SIGINT signall via kill(1) to the running
> background blktrace for its correct termination.

Applied, thanks.

-- 
Jens Axboe

