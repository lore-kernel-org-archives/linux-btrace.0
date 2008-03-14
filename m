From: Christof Schmitt <christof.schmitt@de.ibm.com>
Date: Fri, 14 Mar 2008 16:28:08 +0000
Subject: Re: blktrace/relay/s390: Oops in subbuf_splice_actor
Message-Id: <20080314162807.GA4488@schmichrtp.de.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080314084337.GA9436@schmichrtp.de.ibm.com> <20080314115802.GK17940@kernel.dk> <20080314130552.GA9352@schmichrtp.de.ibm.com> <20080314131007.GQ17940@kernel.dk> <20080314132238.GA9815@schmichrtp.de.ibm.com> <47DA97DF.6010008@us.ibm.com>
In-Reply-To: <47DA97DF.6010008@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Wilder <dwilder@us.ibm.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-btrace@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, wilder@us.ibm.com

On Fri, Mar 14, 2008 at 08:21:03AM -0700, David Wilder wrote:
> Christof Schmitt wrote:
> >On Fri, Mar 14, 2008 at 02:10:07PM +0100, Jens Axboe wrote:
> >>On Fri, Mar 14 2008, Christof Schmitt wrote:
> >>>On Fri, Mar 14, 2008 at 12:58:03PM +0100, Jens Axboe wrote:
> >>>>That is indeed a bug, does this work for you?
> >>>>
> >>>>diff --git a/kernel/relay.c b/kernel/relay.c
> >>>>index d080b9d..39d1fa8 100644
> >>>>--- a/kernel/relay.c
> >>>>+++ b/kernel/relay.c
> >>>>@@ -1066,7 +1066,7 @@ static int subbuf_splice_actor(struct file *in,
> >>>> 			       unsigned int flags,
> >>>> 			       int *nonpad_ret)
> >>>> {
> >>>>-	unsigned int pidx, poff, total_len, subbuf_pages, ret;
> >>>>+	unsigned int pidx, poff, total_len, subbuf_pages, nr_pages, ret;
> >>>> 	struct rchan_buf *rbuf = in->private_data;
> >>>> 	unsigned int subbuf_size = rbuf->chan->subbuf_size;
> >>>> 	uint64_t pos = (uint64_t) *ppos;
> >>>>@@ -1098,7 +1098,9 @@ static int subbuf_splice_actor(struct file *in,
> >>>> 	pidx = (read_start / PAGE_SIZE) % subbuf_pages;
> >>>> 	poff = read_start & ~PAGE_MASK;
> >>>>
> >>>>-	for (total_len = 0; spd.nr_pages < subbuf_pages; spd.nr_pages++) {
> >>>>+	nr_pages = min_t(unsigned int, subbuf_pages, PIPE_BUFFERS);
> >>>>+
> >>>>+	for (total_len = 0; spd.nr_pages < nr_pages; spd.nr_pages++) {
> >>>> 		unsigned int this_len, this_end, private;
> >>>> 		unsigned int cur_pos = read_start + total_len;
> >>>With the patch, i can run dd and 'blktrace -h traceserver' without the
> >>>oops. But the output from blktrace only contains only zeros and no
> >>>usable data for blkparse. Using blktrace to write the data directly to
> >>>disk, without using the blktrace server works. Is there anything i
> >>>should look for to help debugging the problem?
> >>We should probably get Tom in the loop, as he is the relay expert. I'll
> >>make sure the above patch gets into 2.6.25, as it is definitely a bug
> >>that needs fixing.
> >
> >http://relayfs.sourceforge.net/contact.html mentions Tom Zanussi, but
> >his email address seems to be no longer valid. I copy Dave Wilder
> >here, since he is mentioned as relay maintainer on the web page.
> >
> >Dave, can you have a look at this? I can easily reproduce the problem
> >on s390 Linux for testing and getting more debug information.
> >
> >Christof
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> I will take a look at the problem.
> Any thing special about the test you are running I need to know?

The test is about using the blktrace network feature on a 64 bit s390
guest on z/VM. I don't know if 64 bit and z/VM are related to the
problem scenario, it is the only setup i tested. To reproduce, start
somewhere 'blktrace -l' as a server and issue 
blktrace -h tracehostname
dd if=/dev/sda of=/dev/null
to start blktrace and some I/O load.

Christof
