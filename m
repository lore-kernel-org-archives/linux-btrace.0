From: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>
Date: Fri, 18 Jul 2008 15:18:24 +0000
Subject: Re: [Patch] blkiomon: repost with some fixes and improvements
Message-Id: <4880B440.4040902@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216377086.8497.4.camel@kitka.ibm.com>
In-Reply-To: <1216377086.8497.4.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

On 2008-07-18 18:15, Alan D. Brunelle wrote:
> T=F6r=F6k Edwin wrote:
>  =20
>> On 2008-07-18 13:31, Martin Peschke wrote:
>>    =20
>>> recent changes:
>>> - added man page
>>> - beautified human-readable output
>>> - fixed an x86 compile error caused by incomplete endianess handling
>>> - fixed some x86 __u64 vs. unsigned long compiler warnings
>>> - fixed checking of a command line argument
>>>
>>>
>>> blkiomon periodicaly generates per devive request size and request late=
ncy
>>> statistics from blktrace data. It provides histograms as well as data t=
hat
>>>  =20
>>>      =20
>> Does it also measure latency caused by the request queues being full?
>> (which happens around here):
>> blk-core.c:get_request:
>> /*
>>                      * The queue is full and the allocating
>>                      * process is not a "batcher", and not
>>                      * exempted by the IO scheduler
>>                      */
>>                     goto out;
>>
>> That would be very useful to trace some high latencies I am seeing, see
>> discussion here:
>> http://lkml.org/lkml/2008/7/12/104
>>
>> Best regards,
>> --Edwin
>>    =20
>
> Hi Edwin -
>
> If you could try this, it might provide some more data. This is very
> hastily thrown together, so it may need some work. Basically: I wrote a
> Python script which chains together blktrace | blkparse and takes the
> output looking for sleep requests, and then a successful get request on
> that same device. It then outputs min/avg/max as in:
>
>    1 sleepers                         0.142157151
>    1 sleepers                         0.174224178
>    3 sleepers min=3D  0.027375521 avg=3D  0.048117339 max=3D  0.075909947
>    1 sleepers                         0.132267452
>    1 sleepers                         0.030572955
>    2 sleepers min=3D  0.060603135 avg=3D  0.071087077 max=3D  0.081571020
>    1 sleepers                         0.002082554
>    1 sleepers                         0.033337675
>    1 sleepers                         0.010796369
>
> (with 1 sleeper, I leave off the min/max stuff). The values are in
> seconds (so above I'm seeing 0.01 to 0.17+ seconds of sleeping...)
>
> To run it (as root):
>
> # ./qsg.py <device> [<device> ...]
>
> So, for me:
>
> # ./qsg.py /dev/sda
>
> This will produce output only when sleeps-for-requests occur. (I think
> other logic in the block I/O layer will put off other potential
> requesters - I'm looking into how to measure that next.)
>
> For now the script just assumes that the debugfs stuff is mounted at
> /sys/kernel/debug...
>
> Let me know if this needs some tweaking...
>
> BTW: I can't seem to reproduce your problem (I do see the sleeps from my
> script, but the system seems responsive otherwise). I have a 4-core
> (dual-socket) Xeon box w/ 8GB RAM plus 5 SAS drives. I'm using Ubuntu
> 8.04 w/ an Ext3 FS for root (where I was running the test). I tried
> bumping the dd' counts (large amount of RAM), but that didn't make a
> difference.
>
> I will try some more dd's just in case...
>
> Alan
>  =20


Thanks for the patch, I'll give it a try today.
The most  reliable way to reproduce is to run a dd that copies about
10-20Gb, and rm the file immediately.
Then try that find / ^C stuff, it usually occurs right at the end of the
dd (when the file is probably removed).

Best regards,
--Edwin


