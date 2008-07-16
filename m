From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Wed, 16 Jul 2008 15:15:25 +0000
Subject: Re: [Patch 0/3] driver data: blktrace pass-through support	for	device
Message-Id: <487E108D.4050004@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216207494.26621.82.camel@kitka.ibm.com>
In-Reply-To: <1216207494.26621.82.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Martin Peschke wrote:
> On Wed, 2008-07-16 at 10:47 -0400, Alan D. Brunelle wrote:
>> Hm, again, if the blktrace | blkiomon (direct, no blkparse) is how you
>> do things,
> 
> no, it's blktrace | blkparse | blkiomon
> 
> Isn't blkparse needed to sort all those per-CPU traces by time?
> I want this feature.

The traces should come out pretty close from blktrace itself - I'm
assuming you're interested in putting out statistics in multiples of
seconds. Perhaps some test cases should be tried, but...

> 
>> I would think that it would /not/ take all that much
>> processing power to parse character strings.
> 
> Anyway, it's more expensive.

... it certainly seems to me that if one could remove blkparse
completely you'd save a /tremendous/ amount of CPU at the slight cost of
perhaps having some off-by-a-few counts. (Meaning: You may have a few
C's that you could not match up with D's (because they come out "later"
from blktrace).)

Alan
