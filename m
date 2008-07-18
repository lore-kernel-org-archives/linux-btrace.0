From: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>
Date: Fri, 18 Jul 2008 10:45:37 +0000
Subject: Re: [Patch] blkiomon: repost with some fixes and improvements
Message-Id: <48807451.6060906@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216377086.8497.4.camel@kitka.ibm.com>
In-Reply-To: <1216377086.8497.4.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 2008-07-18 13:31, Martin Peschke wrote:
> recent changes:
> - added man page
> - beautified human-readable output
> - fixed an x86 compile error caused by incomplete endianess handling
> - fixed some x86 __u64 vs. unsigned long compiler warnings
> - fixed checking of a command line argument
>
>
> blkiomon periodicaly generates per devive request size and request latency
> statistics from blktrace data. It provides histograms as well as data that
>   

Does it also measure latency caused by the request queues being full?
(which happens around here):
blk-core.c:get_request:
/*
                     * The queue is full and the allocating
                     * process is not a "batcher", and not
                     * exempted by the IO scheduler
                     */
                    goto out;

That would be very useful to trace some high latencies I am seeing, see
discussion here:
http://lkml.org/lkml/2008/7/12/104

Best regards,
--Edwin
