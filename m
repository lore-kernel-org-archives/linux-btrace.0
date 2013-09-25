From: Jeff Moyer <jmoyer@redhat.com>
Date: Wed, 25 Sep 2013 16:39:03 +0000
Subject: Re: blktrace: Don't tear down devices we didn't set up
Message-Id: <x49k3i4etzs.fsf@segfault.boston.devel.redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <5242553D.2040300@suse.com>
In-Reply-To: <5242553D.2040300@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Jeff Mahoney <jeffm@suse.com> writes:

> If we have two copies of blktrace trying to operate on the same device, one
> will fail to set up, as expected. It then tears down the devices it was
> configured to use, but does so even if they weren't setup by that instance.
>
> This can result in tearing down running traces, which will end up leaving
> the debugfs files around without a way to clean them up. Further instances
> of blktrace on that device will fail.
>
> This patch ensures we only clean up the devices we've set up.

First, thanks for tackling more of these long-standing issues with
cleaning up failed traces.  They really are annoying, especially when
you need to reboot the box to recover.

Now, the real problem is that the blktrace instance is global (tied to
the request queue) when it should be restricted to the process that
created it, and there is no enforcement of ownership.  See also the kill
running trace option.  And that whole option seems to have been a way to
punt on cleaning things up properly if a userspace blktrace process
failed.  Hmm, and looking at the struct blk_trace in the kernel, we
already store the pid (but as a u32, so I'm not sure how well this works
with pid namespaces...).

I'm not against the proposed patch, but I think we should get rid of
this two-faced approach.  Either you can have multiple processes mucking
about with the same device or not.  No more of this let's hope userspace
does the right thing.

As an aside, I think that there is no technical reason why we can't have
multiple tracers for the same block device.  Of course, we've made it
this far without that feature, so there's no clear argument that such a
feature is desirable.

Jens, what do you think about restricting blktrace ioctl operations to
the process that initiated the trace?

Regardless of this whole discussion, I'm in favor of adding Jeff's
patch, so you can add my:

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

Cheers,
Jeff

>
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  blktrace.c |   21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> --- a/blktrace.c
> +++ b/blktrace.c
> @@ -1048,7 +1048,7 @@ static void close_client_connections(voi
>  	}
>  }
>  
> -static void setup_buts(void)
> +static int setup_buts(void)
>  {
>  	struct list_head *p;
>  
> @@ -1068,10 +1068,13 @@ static void setup_buts(void)
>  				free(dpp->stats);
>  			dpp->stats = calloc(dpp->ncpus, sizeof(*dpp->stats));
>  			memset(dpp->stats, 0, dpp->ncpus * sizeof(*dpp->stats));
> -		} else
> -			fprintf(stderr, "BLKTRACESETUP(2) %s failed: %d/%s\n",
> +		} else {
> +			fprintf(stderr, "BLKTRACESETUP for %s failed: %d/%s\n",
>  				dpp->path, errno, strerror(errno));
> +			return -1;
> +		}
>  	}
> +	return 0;
>  }
>  
>  static void start_buts(void)
> @@ -1262,7 +1265,10 @@ static void rel_devpaths(void)
>  		struct devpath *dpp = list_entry(p, struct devpath, head);
>  
>  		list_del(&dpp->head);
> -		__stop_trace(dpp->fd);
> +
> +		/* Only stop it if we set it up */
> +		if (dpp->buts_name)
> +			__stop_trace(dpp->fd);
>  		close(dpp->fd);
>  
>  		if (dpp->heads)
> @@ -2597,11 +2603,16 @@ out:
>  
>  static int run_tracers(void)
>  {
> +	int ret;
>  	atexit(exit_tracing);
>  	if (net_mode = Net_client)
>  		printf("blktrace: connecting to %s\n", hostname);
>  
> -	setup_buts();
> +	ret = setup_buts();
> +	if (ret) {
> +		fprintf(stderr, "Failed to enable some targets. Exiting.\n");
> +		return ret;
> +	}
>  
>  	if (use_tracer_devpaths()) {
>  		if (setup_tracer_devpaths())
