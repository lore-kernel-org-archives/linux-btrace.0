From: Ming Zhang <blackmagic02881@gmail.com>
Date: Thu, 12 Apr 2007 13:18:39 +0000
Subject: Re: BLK_TA_ISSUE
Message-Id: <1176383919.3465.16.camel@fs0004.ibrix.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1176341579.3409.2.camel@localhost.localdomain>
In-Reply-To: <1176341579.3409.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Thu, 2007-04-12 at 13:29 +0200, Jens Axboe wrote:
> On Wed, Apr 11 2007, Ming Zhang wrote:
> > Hi All
> > 
> > For this ISSUE event, currently it is in elv_next_request(), any idea
> > why it is not in elv_dequeue_request() which is where the request marked
> > as on-the-fly and send to lower level?
> 
> elv_next_request() is the driver hand-off point, so should be pretty
> close to the issue time unless the request gets requeued due to some
> busy condition (which will also be logged). elv_dequeue_request() may
> happen much later, some drivers do it right before calling the io
> completion handler - IDE does this - since it leaves the request on the
> queue list for the duration of the operation. So moving the ISSUE event
> to elv_dequeue_request() would not be correct.
> 

ic. i assumed all requests will be removed from queue before llDD handle
it.

in 2.6.20 ele_dequeue_request

771 
772         /*
773          * the time frame between a request being removed from the lists
774          * and to it is freed is accounted as io that is in progress at
775          * the driver side.
776          */
777         if (blk_account_rq(rq))
778                 q->in_flight++;

then this in_flight counter is more likely to be how many outstanding
requests that not in the queue and before it is free. and it might be
less than how many undergoing IOs?


