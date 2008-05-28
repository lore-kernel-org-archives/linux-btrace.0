From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 28 May 2008 13:00:57 +0000
Subject: Re: [PATCH] Changed blk trace msgs to directly use relay buffer
Message-Id: <20080528130056.GW25504@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <483C1C5A.5000001@hp.com> <20080528121329.GU25504@kernel.dk> <483D4F73.5020503@hp.com>
In-Reply-To: <483D4F73.5020503@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-btrace@vger.kernel.org

On Wed, May 28 2008, Alan D. Brunelle wrote:
> Jens Axboe wrote:
> > On Tue, May 27 2008, Alan D. Brunelle wrote:
> > 
> >> From 43c8ea2b78f31d7ccd349384a9a2084e787aafc1 Mon Sep 17 00:00:00 2001
> >> From: Alan D. Brunelle <alan.brunelle@hp.com>
> >> Date: Tue, 27 May 2008 10:32:36 -0400
> >> Subject: [PATCH] Changed blk trace msgs to directly use relay buffer
> >>
> >> Allows for SMP-usage without corruption, and removes an extra copy at
> >> the expense of copying extra bytes. Reduced message size from 1024 to 128.
> > 
> > Or, alternatively, something like the below. Then we don't
> > unconditionally reserve and copy 128 bytes for each message, at the
> > cost 128 bytes per-cpu per trace.
> 
> I looked into something like this, but thought the added complexity
> wasn't worth it. Besides the extra per-cpu stuff, you also have an
> extra memcopy involved - in my patch you print directly into the relay
> buffer.  I figure that /if/ copying (128-msg_size) extra bytes is too
> much, one could always shrink the 128 down further. [I would think 64
> bytes is probably ok.]
> 
> I'd bet that the reduced complexity, and skipping the extra memcopy
> more than offsets having to copy a few extra bytes...

The complexity is the same imho, both versions are fairly trivial.
I wasn't out to optimize this in a memory copy sense. To me the most
precious resource is the data stream to the app, and 128 bytes
is probably 6 times larger than the normal message would be. With
the actual trace structure, we are down to about 3 times the byte
size.

So it was just an idea, I don't care much either way. With 128 bytes,
we could just put the buffer on the stack (and still do the copy to
the relay buffer). The per-cpu buffers has the advantage that we
could grow the size easily if we wanted to.

So, given everything, which do you prefer?

-- 
Jens Axboe

