From: Jens Axboe <jens.axboe@oracle.com>
Date: Mon, 14 May 2007 07:40:46 +0000
Subject: Re: [blktrace] unplug queue trace action is missed at some places
Message-Id: <20070514074046.GC7572@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1178897976.3335.20.camel@dhcp0-54.sw.ru>
In-Reply-To: <1178897976.3335.20.camel@dhcp0-54.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Fri, May 11 2007, Vasily Tarasov wrote:
> Hello all,
> 
> The function blk_start_queueing() calls __generic_unplug_device()
> function directly without tracing BLK_TA_UNPLUG_IO action. So I have an
> odd output of blktrace, when requests go through the plugged queue. I
> suppose it's a BUG, or do I miss something?

The unplug trace is meant to log upper layers doing an unplug to start
IO, not internal use that wants to kick the queue for whatever reasons.
We could log those as well, but it would be preferential to seperate
them.

blk_start_queuing() is one such call, for instance.

-- 
Jens Axboe

