From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 06 Feb 2009 08:03:01 +0000
Subject: Re: Question: blktrace server mode & orderly shut down
Message-Id: <20090206080301.GT30821@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <4988C599.6070909@hp.com>
In-Reply-To: <4988C599.6070909@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, Feb 03 2009, Alan D. Brunelle wrote:
> According to the recv(2) man page:
> 
> The return value will be 0 when the peer has performed an orderly
> shutdown.
> 
> Yet the code in read_data_net and net_get_header both attempt to re-read
> from a socket that will _never_ have data. (I hit this problem today on
> blktrace2 - I've got orderly shut downs in place.)
> 
> Does this pseudo-patch break something?
> 
> diff --git a/blktrace.c b/blktrace.c
> index c55b491..9ef7313 100644
> --- a/blktrace.c
> +++ b/blktrace.c
> @@ -550,7 +550,7 @@ static int read_data_net(struct thread_information
> *tip, voi
>                 ret = recv(nc->in_fd, buf, bytes_left, MSG_WAITALL);
> 
>                 if (!ret)
> -                       continue;
> +                       return 0;
>                 else if (ret < 0) {
>                         if (errno != EAGAIN) {
>                                 perror(tip->fn);
> @@ -1466,8 +1466,7 @@ static int net_get_header(struct net_connection *nc,
>                         usleep(1000);
>                         continue;
>                 } else if (!ret) {
> -                       usleep(1000);
> -                       continue;
> +                       return 0;
>                 } else {
>                         p += ret;
>                         bytes_left -= ret;

My bad, I think the patch looks correct. Feel free to commit it, you can
add my acked-by to it.

-- 
Jens Axboe

