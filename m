From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 10 Oct 2007 08:15:28 +0000
Subject: Re: [PATCH] Fix crash with btreplay -v
Message-Id: <20071010081528.GH4984@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <47086412.90601@gelato.unsw.edu.au>
In-Reply-To: <47086412.90601@gelato.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Sun, Oct 07 2007, Joshua Root wrote:
> tip->vfp is only initialised when verbose > 1, so we must only use it
> under the same circumstance.

Alan, I'll let you verify and commit btt/btreplay patches so we don't
step on each others feet.

> -- 
> Joshua Root,  jmr AT gelato.unsw.edu.au
> http://www.gelato.unsw.edu.au

>  btreplay/btreplay.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
> index 89881cb..1808b35 100644
> --- a/btreplay/btreplay.c
> +++ b/btreplay/btreplay.c
> @@ -1327,7 +1327,7 @@ static void *replay_sub(void *arg)
>         set_replay_ready();
>         while (!is_send_done(tip) && tip->iterations--) {
>                 wait_iter_start();
> -               if (verbose)
> +               if (verbose > 1)
>                         fprintf(tip->vfp, "\n== %d ==\n", tip->iterations);
>                 while (!is_send_done(tip) && next_bunch(tip, &bunch))
>                         process_bunch(tip, &bunch);


-- 
Jens Axboe

