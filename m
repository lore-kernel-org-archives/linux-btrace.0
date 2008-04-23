From: Christof Schmitt <christof.schmitt@de.ibm.com>
Date: Wed, 23 Apr 2008 07:06:05 +0000
Subject: Re: blktrace/relay/s390: Oops in subbuf_splice_actor
Message-Id: <20080423070605.GA5450@schmichrtp.de.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080314084337.GA9436@schmichrtp.de.ibm.com> <20080314115802.GK17940@kernel.dk> <20080314130552.GA9352@schmichrtp.de.ibm.com> <20080314131007.GQ17940@kernel.dk> <20080314132238.GA9815@schmichrtp.de.ibm.com> <1207628587.7535.8.camel@charm-linux>
In-Reply-To: <1207628587.7535.8.camel@charm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom Zanussi <zanussi@comcast.net>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-btrace@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, wilder@us.ibm.com

On Mon, Apr 07, 2008 at 11:23:07PM -0500, Tom Zanussi wrote:
> > Dave, can you have a look at this? I can easily reproduce the problem
> > on s390 Linux for testing and getting more debug information.
> > 
> 
> Not sure anyone's still looking into this, but it doesn't look like an
> s390 problem specifically.  Apparently what happened was that some
> internal changes to splice seem to have broken the relay splice_read
> implementation.  The above patch fixes part of the problem; the patch
> below should fix the rest, and AFAICT it doesn't break anything else.
> 
> Signed-off-by: Tom Zanussi <zanussi@comcast.net>
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index a861bb3..068b210 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1094,7 +1094,7 @@ long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
> 
>  	ret = splice_direct_to_actor(in, &sd, direct_splice_actor);
>  	if (ret > 0)
> -		*ppos += ret;
> +		*ppos = sd.pos;
> 
>  	return ret;
>  }
> diff --git a/kernel/relay.c b/kernel/relay.c
> index d6204a4..dc873fb 100644
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -1162,7 +1162,7 @@ static ssize_t relay_file_splice_read(struct file *in,
>  	ret = 0;
>  	spliced = 0;
> 
> -	while (len) {
> +	while (len && !spliced) {
>  		ret = subbuf_splice_actor(in, ppos, pipe, len, flags, &nonpad_ret);
>  		if (ret < 0)
>  			break;
> 
> 

Sorry for the late response and yes, our tests on s390 are still
tracking the issue. I just ran a short test on 2.6.25 with the above
patch applied. With this patch, blktrace client/server mode works
again with the sendfile() call and returns valid data for blkparse.

Thanks everybody for helping with this problem.

Jens, will you pick up this patch for inclusion?

Christof
