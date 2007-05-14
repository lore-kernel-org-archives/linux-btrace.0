From: Jens Axboe <jens.axboe@oracle.com>
Date: Mon, 14 May 2007 08:08:19 +0000
Subject: Re: [blktrace] unplug queue trace action is missed at some places
Message-Id: <20070514080819.GE7572@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1178897976.3335.20.camel@dhcp0-54.sw.ru>
In-Reply-To: <1178897976.3335.20.camel@dhcp0-54.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Mon, May 14 2007, Vasily Tarasov wrote:
> On Mon, 2007-05-14 at 09:40 +0200, Jens Axboe wrote:
> > On Fri, May 11 2007, Vasily Tarasov wrote:
> > > Hello all,
> > > 
> > > The function blk_start_queueing() calls __generic_unplug_device()
> > > function directly without tracing BLK_TA_UNPLUG_IO action. So I have an
> > > odd output of blktrace, when requests go through the plugged queue. I
> > > suppose it's a BUG, or do I miss something?
> > 
> > The unplug trace is meant to log upper layers doing an unplug to start
> > IO, not internal use that wants to kick the queue for whatever reasons.
> > We could log those as well, but it would be preferential to seperate
> > them.
> > 
> > blk_start_queuing() is one such call, for instance.
> > 
> 
> Thank you, now I understand it. I believe it is very necessary to trace
> internal unplugging (as a separate case), because such trace:
> 
>   3,64   1       46     5.227907883 10539  P   R [randreader]
>   3,64   1       47     5.227908103 10539  I   R 2068072 + 8
> [randreader]
>   3,64   1       48     5.227909288 10539  D   R 2068072 + 8
> [randreader]
>   3,64   1       49     5.227931205 10539  Q   R 2068088 + 112
> [randreader]
>   3,64   1       50     5.227932222 10539  G   R 2068088 + 112
> [randreader]
>   3,64   1       51     5.227932827 10539  I   R 2068088 + 112
> [randreader]
>   3,64   1       52     5.227985593 10539  C   R 2068072 + 8 [0]
> 
> looks a bit confusing.

I agree, it should definitely be added. I'll make sure it does!

-- 
Jens Axboe

