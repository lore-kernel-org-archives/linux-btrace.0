From: Tom Zanussi <zanussi@comcast.net>
Date: Thu, 24 Apr 2008 04:32:33 +0000
Subject: Re: blktrace/relay/s390: Oops in subbuf_splice_actor
Message-Id: <1209011553.9808.10.camel@charm-linux>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080314084337.GA9436@schmichrtp.de.ibm.com>
	 <20080314115802.GK17940@kernel.dk>
	 <20080314130552.GA9352@schmichrtp.de.ibm.com>
	 <20080314131007.GQ17940@kernel.dk>
	 <20080314132238.GA9815@schmichrtp.de.ibm.com>
	 <1207628587.7535.8.camel@charm-linux>  <20080423074518.GA12774@kernel.dk>
In-Reply-To: <20080423074518.GA12774@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Christof Schmitt <christof.schmitt@de.ibm.com>, linux-btrace@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, wilder@us.ibm.com


On Wed, 2008-04-23 at 09:45 +0200, Jens Axboe wrote:
> On Mon, Apr 07 2008, Tom Zanussi wrote:
> > 
> > On Fri, 2008-03-14 at 14:22 +0100, Christof Schmitt wrote:
> > > plain text document attachment (Re: blktrace/relay/s390: Oops in
> > > subbuf_splice_actor.eml)
> > > On Fri, Mar 14, 2008 at 02:10:07PM +0100, Jens Axboe wrote:
> > > > On Fri, Mar 14 2008, Christof Schmitt wrote:
> > > > > On Fri, Mar 14, 2008 at 12:58:03PM +0100, Jens Axboe wrote:
> > > > > > That is indeed a bug, does this work for you?
> > > > > > 
> > > > > > diff --git a/kernel/relay.c b/kernel/relay.c
> > > > > > index d080b9d..39d1fa8 100644
> > > > > > --- a/kernel/relay.c
> > > > > > +++ b/kernel/relay.c
> > > > > > @@ -1066,7 +1066,7 @@ static int subbuf_splice_actor(struct file *in,
> > > > > >  			       unsigned int flags,
> > > > > >  			       int *nonpad_ret)
> > > > > >  {
> > > > > > -	unsigned int pidx, poff, total_len, subbuf_pages, ret;
> > > > > > +	unsigned int pidx, poff, total_len, subbuf_pages, nr_pages, ret;
> > > > > >  	struct rchan_buf *rbuf = in->private_data;
> > > > > >  	unsigned int subbuf_size = rbuf->chan->subbuf_size;
> > > > > >  	uint64_t pos = (uint64_t) *ppos;
> > > > > > @@ -1098,7 +1098,9 @@ static int subbuf_splice_actor(struct file *in,
> > > > > >  	pidx = (read_start / PAGE_SIZE) % subbuf_pages;
> > > > > >  	poff = read_start & ~PAGE_MASK;
> > > > > > 
> > > > > > -	for (total_len = 0; spd.nr_pages < subbuf_pages; spd.nr_pages++) {
> > > > > > +	nr_pages = min_t(unsigned int, subbuf_pages, PIPE_BUFFERS);
> > > > > > +
> > > > > > +	for (total_len = 0; spd.nr_pages < nr_pages; spd.nr_pages++) {
> > > > > >  		unsigned int this_len, this_end, private;
> > > > > >  		unsigned int cur_pos = read_start + total_len;
> > > > > 
> > > > > With the patch, i can run dd and 'blktrace -h traceserver' without the
> > > > > oops. But the output from blktrace only contains only zeros and no
> > > > > usable data for blkparse. Using blktrace to write the data directly to
> > > > > disk, without using the blktrace server works. Is there anything i
> > > > > should look for to help debugging the problem?
> > > > 
> > > > We should probably get Tom in the loop, as he is the relay expert. I'll
> > > > make sure the above patch gets into 2.6.25, as it is definitely a bug
> > > > that needs fixing.
> > > 
> > > http://relayfs.sourceforge.net/contact.html mentions Tom Zanussi, but
> > > his email address seems to be no longer valid. I copy Dave Wilder
> > > here, since he is mentioned as relay maintainer on the web page.
> > > 
> > 
> > Hi,
> > 
> > Yeah, I no longer work for IBM - I need to update the relayfs site to
> > reflect that.
> > 
> > > Dave, can you have a look at this? I can easily reproduce the problem
> > > on s390 Linux for testing and getting more debug information.
> > > 
> > 
> > Not sure anyone's still looking into this, but it doesn't look like an
> > s390 problem specifically.  Apparently what happened was that some
> > internal changes to splice seem to have broken the relay splice_read
> > implementation.  The above patch fixes part of the problem; the patch
> > below should fix the rest, and AFAICT it doesn't break anything else.
> > 
> > Signed-off-by: Tom Zanussi <zanussi@comcast.net>
> > 
> > diff --git a/fs/splice.c b/fs/splice.c
> > index a861bb3..068b210 100644
> > --- a/fs/splice.c
> > +++ b/fs/splice.c
> > @@ -1094,7 +1094,7 @@ long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
> >  
> >  	ret = splice_direct_to_actor(in, &sd, direct_splice_actor);
> >  	if (ret > 0)
> > -		*ppos += ret;
> > +		*ppos = sd.pos;
> 
> Tom, did you verify that sd.pos is always updated?
> 

Yeah, everything else that can be a sendfile source ends up using
generic_file_splice_read(), which updates sd.pos as expected.

Tom



