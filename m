From: Jens Axboe <jens.axboe@oracle.com>
Date: Mon, 14 Jan 2008 07:53:54 +0000
Subject: Re: [patch 0/2] blkparse extensions for PC requests
Message-Id: <20080114075353.GL6258@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080107075057.066746000@de.ibm.com>
In-Reply-To: <20080107075057.066746000@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Mon, Jan 14 2008, Christof Schmitt wrote:
> On Fri, Jan 11, 2008 at 10:10:35AM +0100, Jens Axboe wrote:
> > Patches look fine, however should it just not default do this
> > accounting? But only print the status fields, if we actually saw a PC
> > request.
> 
> My intent was to not change the data shown in the current summary
> output. But you are right, it makes more sense to simply output the PC
> summary when a PC request has been seen. I will post an updated patch
> that does this without the --pc flag.

Yep I think so. If you send a patch that does that, I'll apply it.

-- 
Jens Axboe

