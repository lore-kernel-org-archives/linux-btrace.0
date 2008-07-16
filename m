From: Martin Peschke <mp3@de.ibm.com>
Date: Wed, 16 Jul 2008 15:08:04 +0000
Subject: Re: [Patch 0/3] driver data: blktrace pass-through support
Message-Id: <1216220884.26621.119.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216207494.26621.82.camel@kitka.ibm.com>
In-Reply-To: <1216207494.26621.82.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


On Wed, 2008-07-16 at 10:47 -0400, Alan D. Brunelle wrote:
> Hm, again, if the blktrace | blkiomon (direct, no blkparse) is how you
> do things,

no, it's blktrace | blkparse | blkiomon

Isn't blkparse needed to sort all those per-CPU traces by time?
I want this feature.

> I would think that it would /not/ take all that much
> processing power to parse character strings.

Anyway, it's more expensive.

>  (I've heard that IBM makes some pretty fast processors... :-) )

Sure. But we don't make our money from wasting their CPU power :-)

