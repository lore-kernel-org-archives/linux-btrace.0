From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 12 Apr 2007 11:29:20 +0000
Subject: Re: BLK_TA_ISSUE
Message-Id: <20070412112920.GB19066@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1176341579.3409.2.camel@localhost.localdomain>
In-Reply-To: <1176341579.3409.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Wed, Apr 11 2007, Ming Zhang wrote:
> Hi All
> 
> For this ISSUE event, currently it is in elv_next_request(), any idea
> why it is not in elv_dequeue_request() which is where the request marked
> as on-the-fly and send to lower level?

elv_next_request() is the driver hand-off point, so should be pretty
close to the issue time unless the request gets requeued due to some
busy condition (which will also be logged). elv_dequeue_request() may
happen much later, some drivers do it right before calling the io
completion handler - IDE does this - since it leaves the request on the
queue list for the duration of the operation. So moving the ISSUE event
to elv_dequeue_request() would not be correct.

-- 
Jens Axboe

