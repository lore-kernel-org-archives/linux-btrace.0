From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Wed, 16 Jul 2008 14:47:34 +0000
Subject: Re: [Patch 0/3] driver data: blktrace pass-through support for	device
Message-Id: <487E0A06.6080307@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216207494.26621.82.camel@kitka.ibm.com>
In-Reply-To: <1216207494.26621.82.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Martin Peschke wrote:
> On Wed, 2008-07-16 at 10:22 -0400, Alan D. Brunelle wrote:
>> Martin Peschke wrote:
>>> Low-level device drivers might have additional data which complements
>>> blktrace data. For example, zfcp, a SCSI HBA driver, is capable of
>>> obtaining additional latency information per request from HBAs. Those
>>> latencies allow to further break down the overall D2C request latency
>>> provided by blktrace.
>>>
>>> We propose an additional trace for blktrace, called "driver data". It is
>>> a sort of small binary blob, which contains a low-level driver specific
>>> struct. Blktrace would be able to filter this trace (-a option) and
>>> include it within its binary output. A small device driver specific tool
>>> on top of blktrace would then analyze "driver data" traces.
>>>
>>> Patch 1/3 makes the blktrace kernel code provide blk_add_driver_data()
>>> for use by device drivers.
>>>
>>> Patch 2/3 adds support for driver data traces to blktrace tools.
>>>
>>> Patch 3/3 makes zfcp provide additional request latency and queue
>>> utilization data through blktrace.
>>>
>>>
>>> Patches are against scsi-misc and blktrace git.
>>>
>>>
>>> Martin
>> Hi Martin -
>>
>> Have you thought about just using blk_add_trace_msg instead?
> 
> Hi Alan,
> good point. Yes, we thought about it. It actually inspired
> blk_add_drv_data().
> 
> blk_add_trace_msg adds information to the textual output of blkparse.
> There is no point in forwarding it to the binary output.
> 
> We need the opposite. We want driver data to show up in binary ouput.
> But there is no point in blkparse trying to generate some ascii message
> from low-level device driver specific data.
> 
> Besides this would lead us down the path of parsing textual output for
> our monitoring tool. This would burn more CPU than a c-program which
> consumes binary data.
> 
> Martin
> 
> 

Hm, again, if the blktrace | blkiomon (direct, no blkparse) is how you
do things, I would think that it would /not/ take all that much
processing power to parse character strings. (I've heard that IBM makes
some pretty fast processors... :-) ) In particular, if you make the
character strings more machine readable (no text, just numbers) for
example it's just some atoi's going on.

Alan
