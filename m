From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 30 Oct 2008 17:25:34 +0000
Subject: Re: Version 1.0.0
Message-Id: <20081030172534.GX31673@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20081030140800.GV31673@kernel.dk>
In-Reply-To: <20081030140800.GV31673@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Thu, Oct 30 2008, Christof Schmitt wrote:
> On Thu, Oct 30, 2008 at 03:08:00PM +0100, Jens Axboe wrote:
> > Hi everyone,
> > 
> > I've bumped version numbers and tagged version 1.0.0 in the repo. Of
> > course I had to do one change before doing that, so I updated the red
> > black tree code to a more recent version that unifies the parent pointer
> > and color information, saving space in the rb_node. That's quite
> > important on blktrace, where we can have millions of nodes.
> > 
> > Anyway, enjoy :-)
> 
> That was a quick response to my request, thanks very much,

You're welcome, it was indeed long overdue so thanks for the nudge.

-- 
Jens Axboe

