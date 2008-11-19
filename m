From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Wed, 19 Nov 2008 17:41:30 +0000
Subject: Re: bad trace magic
Message-Id: <1227116490.10046.79.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1227094718.10046.29.camel@kitka.ibm.com>
In-Reply-To: <1227094718.10046.29.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


On Wed, 2008-11-19 at 16:07 +0100, Jens Axboe wrote:
> On Wed, Nov 19 2008, Martin Peschke wrote:
> > On Wed, 2008-11-19 at 13:44 +0100, Jens Axboe wrote:
> > > How are you running blktrace?
> > 
> > blktrace -a issue -a drv_data -a complete -w 43200 -o
> > - /dev/sda ... /dev/sdz | blkiomon
> 
> Ah ok. How hard is this to reproduce?

It's not too hard. I get several bad traces within about half an hour.

> If you could try a non-pipe approach, then it would be nice to see if
> it happens there as well.

I have tried this for about 90 minutes:

blktrace -a complete -a issue -a
drv_data /dev/sda   /dev/sdae  /dev/sdaj  /dev/sdao  /dev/sdat  /dev/sday
/dev/sdbc  /dev/sdbh  /dev/sdbm  /dev/sdbr  /dev/sdbw  /dev/sdca
/dev/sdg  /dev/sdl  /dev/sdq  /dev/sdv /dev/sdaa

No bad traces. Need to check whether verify_trace() was called at all...

For this test I had to reduce the number of devices traced due to
the oom-killer picking on blktrace.

Or did you have something else in mind?

> So you don't happen to have a stream of data we can inspect _after_
> the bad magic occured?

I was trying with the command line above.
Would be blktrace in network mode worth another try?


I have just run the my initial test case on a recent linux git tree.
Same issue, bad traces:

--- bad trace magic ---
magic    0x00000000
sequence 0x00000000
time     0x65617407000014d5    <--- first trace magic
sector   0x656174070000a75c    <--- another trace magic?!
bytes    0x0000011e
action   0x473dbce5
pid      0x00000000
device   0x0095b5e0
cpu      0x00004000
error    0x0181
pdu_len  0x0008

00000000 00000000 65617407 000014d5 65617407 0000a75c
0000011e 473dbce5 00000000 0095b5e0 00004000 01810008

bad trace in /sys/kernel/debug/block/sdaa/trace0
no previous trace
ts->buf 0x0x81fa0610, ts->len 0x958, ts->max_len 0x80000, offset 0x0, t
0x0x81fa0610

Then I ran blkrawverify /dev/sdaa - no issue found.


