From: Christoph Hellwig <hch@infradead.org>
Date: Thu, 19 Feb 2009 18:59:19 +0000
Subject: Re: GFS2: Add blktrace support to glocks
Message-Id: <20090219185919.GB28490@infradead.org>
List-Id: <linux-btrace.vger.kernel.org>
References: <1235062539.9571.771.camel@quoit>
In-Reply-To: <1235062539.9571.771.camel@quoit>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, axboe@kernel.dk

On Thu, Feb 19, 2009 at 04:55:39PM +0000, Steven Whitehouse wrote:
> Hi,
> 
> Since I last posted this pair of patches, I've done some extensive
> updating of the kernel patch, so it should now be happy to compile
> under all possible Kconfigs (fingers crossed) and also its a fair
> bit cleaner too.
> 
> I'm adding the linux-btrace list, since I didn't know about that
> list when I made the initial posting.
> 
> Since there is probably more GFS2 changes than blktrace changes, I
> could push this through the GFS2 tree. Let me know if you'd prefer
> it to go via the blktrace tree. I'd like to be able to push this
> in at the next merge window if possible. This patch is against the
> head of the GFS2 -nmw git tree (obviously that makes no difference
> to the blktrace side of the patch).
> 
> An updated blktrace userland patch follows in the next email, although
> the changes from the last version are fairly minor,

Umm, why would you put fs internal stuff into blktrace?  Just use
the generic ringbuffer directly and trace into that one.

