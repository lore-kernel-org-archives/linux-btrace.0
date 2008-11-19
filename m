From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 19 Nov 2008 11:49:00 +0000
Subject: Re: bad trace magic
Message-Id: <20081119114859.GB26308@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1227094718.10046.29.camel@kitka.ibm.com>
In-Reply-To: <1227094718.10046.29.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Wed, Nov 19 2008, Martin Peschke wrote:
> Hi,
> 
> I run across blktrace complaints about broken traces once in a while.
> I have pimped up the debugging output in verify_trace():
> 
>   --- bad trace magic ---
>   magic    0x00000000
>   sequence 0x00000000
>   time     0x0000000000000000
>   sector   0x0000000000000000
>   bytes	   0x65617407		<--- begin of trace (trace magic)
>   action   0x000005b0
>   pid      0x0000029c
>   device   0x7c185ac0
>   cpu      0x00000000
>   error    0x0036
>   pdu_len  0x18c0
> 
>   00000000 00000000 00000000 00000000 00000000 00000000
>   65617407 000005b0 0000029c 7c185ac0 00000000 003618c0
> 
>   bad trace in /sys/kernel/debug/block/sdbm/trace1
> 
> Traces appear to get out of place by some bytes. The offset varies.
> 
> 
> I have got a couple of questions:
> 
> Does blktrace stop processing of a trace stream in this case, doesn't
> it?
> 
> Next I am going to dump the trace which precedes a broken trace.
> Any better ideas how to debug this one?

I think Alan and I debugged something like this in the early days of
blktrace. Is your stream consistently off when this happens? Does the
sequence numbers jump?

The most likely culprit is a relay bug, and there's recently been some
fixing for that.

-- 
Jens Axboe

