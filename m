From: Tao Ma <tm@tao.ma>
Date: Sat, 04 Jun 2011 08:46:21 +0000
Subject: Re: No "Unplug" or "Unplug due to timer" observed in the output of
Message-Id: <4DE9F0DD.6010502@tao.ma>
List-Id: <linux-btrace.vger.kernel.org>
References: <BANLkTi=VkspzpuyetXti0ZHZB6yMXgbFyw@mail.gmail.com>
In-Reply-To: <BANLkTi=VkspzpuyetXti0ZHZB6yMXgbFyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 06/04/2011 10:55 AM, Pallav Bose wrote:
> Hello,
> 
> I'm working on the 2.6.35.9 version of the linux kernel and am trying
> to understand the latency observed in write requests sent from my
> driver. To start off, my userlevel program - read_write_ioctl - issues
> an ioctl() which is intercepted by my driver. Next, the driver issues
> a couple of read requests to position the disk head on the first
> track. My driver then composes a struct bio and calls the
> make_request_fn of the lower level driver, followed by a call to the
> unplug function so that this particular write request is serviced
> immediately:
> 
> subq = bio->bi_bdev->bd_disk->queue;
> if (subq && subq->make_request_fn) {
>    subq->make_request_fn(subq, bio);
> }
> 
> if (subq && subq->unplug_fn)
>    subq->unplug_fn(subq);
> }
> 
> The output of blkparse (as shown below) seems to suggest that there
> were zero IO unplugs, which is strange because one would expect at
> least an unplug due to a timeout to occur after 3 milliseconds has
> elapsed (please refer to the function blk_queue_make_request()
> <http://lxr.linux.no/linux+v2.6.35.9/block/blk-settings.c#L137>).
> Plus, if an "unplug" action doesn't take place, how would the write
> request be actually serviced?
I am quite familiar with blktrace/parse, but maybe you can try my
suggestion to see if it helps.

The reason why unplug event does show up in blkparse is because you
don't call it. Here "it" means trace_block_unplug.Your driver calls
subq->unplug_fn, so the trace_block_unplug isn't called and blktrace
can't catch it.
So just before you call subq->unplug_fn, call trace_block_unplug
directly and I guess you will see what you need.

Regards,
Tao
