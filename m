From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 13 Apr 2007 05:30:56 +0000
Subject: Re: BLK_TA_ISSUE
Message-Id: <20070413053056.GF2567@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1176341579.3409.2.camel@localhost.localdomain>
In-Reply-To: <1176341579.3409.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Thu, Apr 12 2007, Ming Zhang wrote:
> On Thu, 2007-04-12 at 23:16 +0200, Jens Axboe wrote:
> > On Thu, Apr 12 2007, Ming Zhang wrote:
> > > On Thu, 2007-04-12 at 13:29 +0200, Jens Axboe wrote:
> > > > On Wed, Apr 11 2007, Ming Zhang wrote:
> > > > > Hi All
> > > > > 
> > > > > For this ISSUE event, currently it is in elv_next_request(), any idea
> > > > > why it is not in elv_dequeue_request() which is where the request marked
> > > > > as on-the-fly and send to lower level?
> > > > 
> > > > elv_next_request() is the driver hand-off point, so should be pretty
> > > > close to the issue time unless the request gets requeued due to some
> > > > busy condition (which will also be logged). elv_dequeue_request() may
> > > > happen much later, some drivers do it right before calling the io
> > > > completion handler - IDE does this - since it leaves the request on the
> > > > queue list for the duration of the operation. So moving the ISSUE event
> > > > to elv_dequeue_request() would not be correct.
> > > > 
> > > 
> > > ic. i assumed all requests will be removed from queue before llDD handle
> > > it.
> > > 
> > > in 2.6.20 ele_dequeue_request
> > > 
> > > 771 
> > > 772         /*
> > > 773          * the time frame between a request being removed from the lists
> > > 774          * and to it is freed is accounted as io that is in progress at
> > > 775          * the driver side.
> > > 776          */
> > > 777         if (blk_account_rq(rq))
> > > 778                 q->in_flight++;
> > > 
> > > then this in_flight counter is more likely to be how many outstanding
> > > requests that not in the queue and before it is free. and it might be
> > > less than how many undergoing IOs?
> > 
> > It's good enough for what ->in_flight is used for. Your assumption on
> > that all low level drivers dequeue before handling a request is wrong.
> > Usually only drivers that do queueing do this.
> 
> so u meant most driver will leave request in queue unless they do
> internal queuing?

Not internal queuing, queuing at the device level. No drivers should do
internal queuing, they should always push requests back if they cannot
handle them.

> does this mean the queue can be unnecessary long and travel the list
> will go through some requests that under io already?

Typically no, because such devices will only have 1 request active at
the time.

-- 
Jens Axboe

