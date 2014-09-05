From: Christoph Hellwig <hch@infradead.org>
Date: Fri, 05 Sep 2014 22:59:12 +0000
Subject: Re: [RFC] merge seekwatcher into the blktrace repository?
Message-Id: <20140905225912.GA8053@infradead.org>
List-Id: <linux-btrace.vger.kernel.org>
References: <20140905184806.GA32325@infradead.org>
In-Reply-To: <20140905184806.GA32325@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Fri, Sep 05, 2014 at 04:22:35PM -0400, Chris Mason wrote:
> > seekwatcher is dead, long live iowatcher, right?
> > 
> 
> Yeah, iowatcher is the new hotness.

You really should cut a release and announce it to linux-fsdevel and
linu-scsi so people know.  It's already been around for 2 years
according to git history and I hadn't heard about it until today.

> > Still, I've be happy to have any graphing functionality bundled
> > with blktrace.
> 
> Jens and I have bounced this around a few times, and now that iowatcher
> doesn't have any crazy dependencies, it makes sense.

I'd be absolutely in favor of it.

