From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 19 Nov 2008 15:07:51 +0000
Subject: Re: bad trace magic
Message-Id: <20081119150751.GM26308@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1227094718.10046.29.camel@kitka.ibm.com>
In-Reply-To: <1227094718.10046.29.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Wed, Nov 19 2008, Martin Peschke wrote:
> 
> On Wed, 2008-11-19 at 13:44 +0100, Jens Axboe wrote:
> > How are you running blktrace?
> 
> blktrace -a issue -a drv_data -a complete -w 43200 -o
> - /dev/sda ... /dev/sdz | blkiomon

Ah ok. How hard is this to reproduce? If you could try a non-pipe
approach, then it would be nice to see if it happens there as well.

> > If you have the blktrace output files, you
> > can inspect what it would have done next.
> 
> I am concerned about pdu_len being some random number then.
> I don't think blktrace would find a valid trace after taking a random
> number of bytes for a trace payload.

You are right, it's definitely a rocky road...

> > > Sequence numbers appear to jump, from 183e8 to f1b1 in this case:
> > > 
> > > --- bad trace magic ---
> > > magic    0x00000001
> > > sequence 0x0001007a
> > > time     0x000000000000fb40
> > > sector   0x000000000005925e
> > > bytes    0x65617407
> > > action   0x0000f1b1
> > > pid      0x00000773
> > > device   0xec86baa8
> > > cpu      0x00000000
> > > error    0x007f
> > > pdu_len  0x8430
> > > 
> > > 00000001 0001007a 00000000 0000fb40 00000000 0005925e 65617407 0000f1b1
> > > 00000773 ec86baa8 00000000 007f8430
> > 
> > So that's interesting. What byte offset did this happen at? And what is
> > your subbuffer size for blktrace?
> 
> see tip_subbuf output (from flush_subbuf_file()) below
> 
> --- bad trace magic ---
> magic    0x00017000
> sequence 0x40010011
> time     0x0000346f04100080
> sector   0x0000000100000018
> bytes    0x00000001
> action   0x00010080
> pid      0x00000000
> device   0x0000bbea
> cpu      0x00000000
> error    0x0014
> pdu_len  0x8d98
> 
> 00017000 40010011 0000346f 04100080 00000001 00000018
> 00000001 00010080 00000000 0000bbea 00000000 00148d98
> 
> bad trace in /sys/kernel/debug/block/sdy/trace1
> 
> ts->buf 0x2004c5027c0, ts->len 0x108, ts->max_len 0x80000,
> offset 0x48, t 0x2004c502808
> 
> --- previous trace ---
> magic    0x65617407
> sequence 0x0001a232
> time     0x00000e5bb87cd096
> sector   0x0000000000843c08
> bytes    0x00001000
> action   0x40010011
> pid      0x00003467
> device   0x04100080
> cpu      0x00000001
> error    0x0000
> pdu_len  0x0018
> 
> 65617407 0001a232 00000e5b b87cd096 00000000 00843c08
> 00001000 40010011 00003467 04100080 00000001 00000018
> 
> 
> --- bad trace magic ---
> magic    0x00001000
> sequence 0x09410007
> time     0x00003469008000c0
> sector   0x0000000000000000
> bytes    0x65617407
> action   0x0000fae2
> pid      0x00000e44
> device   0xbbefaa91
> cpu      0x00000000
> error    0x008f
> pdu_len  0xd358
> 
> 00001000 09410007 00003469 008000c0 00000000 00000000
> 65617407 0000fae2 00000e44 bbefaa91 00000000 008fd358
> 
> bad trace in /sys/kernel/debug/block/sdm/trace0
> 
> ts->buf 0x20060280910, ts->len 0xc00, ts->max_len 0x80000,
> offset 0xf0, t 0x20060280a00
> 
> --- previous trace ---
> magic    0x65617407
> sequence 0x0000fadd
> time     0x65617407000067d8
> sector   0x00000d9ba13e3b74
> bytes    0x00000000
> action   0x00500030
> pid      0x00001000
> device   0x40010011
> cpu      0x00003466
> error    0x0080
> pdu_len  0x00c0
> 
> 65617407 0000fadd 65617407 000067d8 00000d9b a13e3b74
> 00000000 00500030 00001000 40010011 00003466 008000c0

So you don't happen to have a stream of data we can inspect _after_ the
bad magic occured?

-- 
Jens Axboe

