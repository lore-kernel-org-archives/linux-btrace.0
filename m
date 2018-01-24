From: weiping zhang <zwp10758@gmail.com>
Date: Wed, 24 Jan 2018 13:16:09 +0000
Subject: Re: [PATCH] blktrace: don't stop tracer if not setup trace successfully
Message-Id: <CAA70yB4ZBk30dQJQpy86QULAN6Qv8-yovH+RBi9jFNBm8fOoEw@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20180115155338.GA15313@bogon.didichuxing.com>
In-Reply-To: <20180115155338.GA15313@bogon.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi Jens,

Will you consider this patch ?

Thanks

2018-01-15 23:53 GMT+08:00 weiping zhang <zhangweiping@didichuxing.com>:
> if we run blktrace on same device twice, the second time will failed
> to ioctl(BLKTRACESETUP), then it will call __stop_tracer, which lead
> the first blktrace failed to access debugfs entries. So this patch add
> a check to handle this case, to avoid stop tracer uncondionally.
>
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  blktrace.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/blktrace.c b/blktrace.c
> index e048f68..d0d271f 100644
> --- a/blktrace.c
> +++ b/blktrace.c
> @@ -112,6 +112,7 @@ struct devpath {
>         struct cl_host *ch;
>         u32 cl_id;
>         time_t cl_connect_time;
> +       int setup_done; /* ioctl BLKTRACESETUP done */
>         struct io_info *ios;
>  };
>
> @@ -1083,6 +1084,7 @@ static int setup_buts(void)
>                 if (ioctl(dpp->fd, BLKTRACESETUP, &buts) >= 0) {
>                         dpp->ncpus = max_cpus;
>                         dpp->buts_name = strdup(buts.name);
> +                       dpp->setup_done = 1;
>                         if (dpp->stats)
>                                 free(dpp->stats);
>                         dpp->stats = calloc(dpp->ncpus, sizeof(*dpp->stats));
> @@ -1285,7 +1287,8 @@ static void rel_devpaths(void)
>                 struct devpath *dpp = list_entry(p, struct devpath, head);
>
>                 list_del(&dpp->head);
> -               __stop_trace(dpp->fd);
> +               if (dpp->setup_done)
> +                       __stop_trace(dpp->fd);
>                 close(dpp->fd);
>
>                 if (dpp->heads)
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
