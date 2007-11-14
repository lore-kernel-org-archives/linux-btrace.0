From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 14 Nov 2007 09:53:01 +0000
Subject: Re: blktrace segfault.
Message-Id: <20071114095300.GC26602@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <4724673E.1090404@linux.vnet.ibm.com>
In-Reply-To: <4724673E.1090404@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Wed, Nov 14 2007, Christoph Hellwig wrote:
> On Wed, Nov 14, 2007 at 10:45:30AM +0100, Jens Axboe wrote:
> > > > 	size = ncpus * sizeof(struct thread_information);
> > > > 	thread_information = malloc(size * ndevs);
> > > > +	memset(thread_information, 0, size*ndevs);
> > > > 	if (!thread_information) {
> > > > 		fprintf(stderr, "Out of memory, threads (%d)\n", size * ndevs);
> > > > 		return 1;
> > > 
> > > I'm pretty sure you want to make the memset after the NULL-pointer check. If
> > > malloc fails this is segfaulting too.
> > 
> > Ehm that's indeed a good point, I'll check in a fix for that.
> 
> Even better just use calloc..

I considered it, but it holds ndevs * ncpus * size, so I thought it was
cleaner to keep it as-is and just move the memset.

-- 
Jens Axboe

