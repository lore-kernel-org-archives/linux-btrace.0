From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Wed, 19 Nov 2008 12:43:36 +0000
Subject: Re: bad trace magic
Message-Id: <1227098616.10046.36.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1227094718.10046.29.camel@kitka.ibm.com>
In-Reply-To: <1227094718.10046.29.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


On Wed, 2008-11-19 at 12:49 +0100, Jens Axboe wrote:
> On Wed, Nov 19 2008, Martin Peschke wrote:
> > Hi,
> > 
> > I run across blktrace complaints about broken traces once in a while.
> > I have pimped up the debugging output in verify_trace():
> > ...
> I think Alan and I debugged something like this in the early days of
> blktrace. Is your stream consistently off when this happens? Does the
> sequence numbers jump?

Well, consistently off? If it's off once, is there a next trace?

Sequence numbers appear to jump, from 183e8 to f1b1 in this case:

--- bad trace magic ---
magic    0x00000001
sequence 0x0001007a
time     0x000000000000fb40
sector   0x000000000005925e
bytes    0x65617407
action   0x0000f1b1
pid      0x00000773
device   0xec86baa8
cpu      0x00000000
error    0x007f
pdu_len  0x8430

00000001 0001007a 00000000 0000fb40 00000000 0005925e 65617407 0000f1b1
00000773 ec86baa8 00000000 007f8430

bad trace in /sys/kernel/debug/block/sdae/trace0

--- previous trace ---
magic    0x65617407
sequence 0x000183e8
time     0x00000815371024d2
sector   0x000000000052cdf0
bytes    0x00001000
action   0x09820008
pid      0x000019bf
device   0x041000e0
cpu      0x00000000
error    0x0000
pdu_len  0x0000

65617407 000183e8 00000815 371024d2 00000000 0052cdf0 00001000 09820008
000019bf 041000e0 00000000 00000000

