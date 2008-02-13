From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Wed, 13 Feb 2008 16:50:43 +0000
Subject: Re: [PATCH] btt: fix iostat interval default
Message-Id: <47B31FE3.2060709@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <47B2A060.3020602@gelato.unsw.edu.au>
In-Reply-To: <47B2A060.3020602@gelato.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Aaron Carroll wrote:
> Change the default iostat interval from 1ns to 1s, which is the
> default implied by btt.1 and common sense.
> 
> Signed-off-by: Aaron Carroll <aaronc@gelato.unsw.edu.au>
> ---
>  btt/iostat.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/btt/iostat.c b/btt/iostat.c
> index f46d572..e920c80 100644
> --- a/btt/iostat.c
> +++ b/btt/iostat.c
> @@ -49,7 +49,7 @@
>  	} while (0)
>  
>  __u64 last_start, iostat_last_stamp;
> -__u64 iostat_interval = 1;
> +__u64 iostat_interval = 1000000000;
>  char *iostat_name = NULL;
>  FILE *iostat_ofp = NULL;
> 

Looks good, applied, thanks!

Alan
