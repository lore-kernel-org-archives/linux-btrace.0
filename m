From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 17 Apr 2009 06:49:51 +0000
Subject: Re: [patch] handle race to mkdir at startup
Message-Id: <20090417064951.GI4593@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <x49y6u01l1c.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49y6u01l1c.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Thu, Apr 16 2009, Jeff Moyer wrote:
> Hi,
> 
> I ran into a problem when specifying -D dirname-that-doesnt-yet-exist.
> Blktrace would fail, spewing the following messages:
> 
> [root@megadeth blktrace]# ./blktrace -d /dev/cciss/c0d1 -D ./2.6.30-rc2-cfq-local
> Destination dir ./2.6.30-rc2-cfq-local/ can't be made: 17/File exists
> Destination dir ./2.6.30-rc2-cfq-local/ can't be made: 17/File exists
> Destination dir ./2.6.30-rc2-cfq-local/ can't be made: 17/File exists
> Destination dir ./2.6.30-rc2-cfq-local/ can't be made: 17/File exists
> Destination dir ./2.6.30-rc2-cfq-local/ can't be made: 17/File exists
> FAILED to start thread on CPU 0: 1/Operation not permitted
> FAILED to start thread on CPU 4: 1/Operation not permitted
> FAILED to start thread on CPU 5: 1/Operation not permitted
> FAILED to start thread on CPU 6: 1/Operation not permitted
> FAILED to start thread on CPU 7: 1/Operation not permitted
> 
> I tracked it down to the fact that there is no synchronization between
> threads when trying to create the output directory.  The fix is simple,
> just allow the race to happen and detect it.  It's not really worth
> putting in any extra synchronization.  It looks like no place else in
> that startup path needs synchronization either.
> 
> This patch fixes the issue for me.  I tested it by running the very
> command that caused me headaches 100% of the time before.  I also did a
> chattr +i on the directory and verified that it would really fail in the
> case where it couldn't create the directory.
> 
> Cheers,
> Jeff
> 
> diff --git a/blktrace.c b/blktrace.c
> index 656ab7a..b4c919d 100644
> --- a/blktrace.c
> +++ b/blktrace.c
> @@ -1477,7 +1477,12 @@ static int fill_ofname(struct io_info *iop, int cpu)
>  				iop->ofn, errno, strerror(errno));
>  			return 1;
>  		}
> -		if (mkdir(iop->ofn, 0755) < 0) {
> +		/*
> +		 * There is no synchronization between multiple threads
> +		 * trying to create the directory at once.  It's harmless
> +		 * to let them try, so just detect the problem and move on.
> +		 */
> +		if (mkdir(iop->ofn, 0755) < 0 && errno != EEXIST) {
>  			fprintf(stderr,
>  				"Destination dir %s can't be made: %d/%s\n",
>  				iop->ofn, errno, strerror(errno));

Thanks Jeff, applied!

-- 
Jens Axboe

