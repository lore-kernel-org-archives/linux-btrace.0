From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 20 Apr 2010 07:50:45 +0000
Subject: Re: [patch 4/5] blktrace: disable kill option
Message-Id: <20100420075045.GD27497@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <4B27CBD6.6060807@redhat.com>
In-Reply-To: <4B27CBD6.6060807@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, Dec 15 2009, Edward Shishkin wrote:
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
> . Disable non-working "kill" option;
> . Update documentation, advise to send SIGINT signal
>   via kill(1) to the running background blktrace for
>   its correct termination.

Patch does not compile:

gcc -o blktrace.o -c -Wall -O2 -g -W -D_GNU_SOURCE -D_LARGEFILE_SOURCE
-D_FILE_OFFSET_BITSd blktrace.c
blktrace.c:446: error: stray ?#? in program
blktrace.c:453: error: expected ?,? or ?;? before ?if?
blktrace.c:454: error: stray ?#? in program
make: *** [blktrace.o] Error 1


        "\t-D Directory to prepend to output file names\n" \
#if KILL_OPT_ENABLED
        "\t-k Kill a running trace\n" \
#endif /* KILL_OPT_ENABLED */
        "\t-w Stop after defined time, in seconds\n" \


-- 
Jens Axboe

