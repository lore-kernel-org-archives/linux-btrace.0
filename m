From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 21 Apr 2009 07:21:33 +0000
Subject: Re: [Patch] fix include statement in stats.h
Message-Id: <20090421072133.GW4593@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1240236318.4039.2.camel@kitka.ibm.com>
In-Reply-To: <1240236318.4039.2.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


Applied both, thanks Martin!


On Mon, Apr 20 2009, Martin Peschke wrote:
> From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
> 
> Some endianess conversion macros have been moved and the corresponding
> header file is gone. Need to adapt an include statement in stats.h. The
> compiler did not complain because blkiomon.c accidently included blktrace.h
> prior to stats.h. Introduced by blktrace rewrite which became version 2.
> 
> Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>
> 
> ---
>  stats.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/stats.h
> +++ b/stats.h
> @@ -23,7 +23,7 @@
>  #define STATS_H
>  
>  #include <linux/types.h>
> -#include "endian.h"
> +#include "blktrace.h"
>  
>  struct minmax {
>  	__u64 min;
> 
> 

On Mon, Apr 20 2009, Martin Peschke wrote:
> From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
> 
> Fix two off-by-one issues. Last bucket of histogram was ommitted by mistake
> when being converted to big-endian or when being merged with another bucket.
> 
> Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>
> 
> ---
>  stats.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/stats.h
> +++ b/stats.h
> @@ -124,7 +124,7 @@ static inline void histlog2_merge(struct
>  {
>  	int i;
>  
> -	for (i = 0; i < h->num - 1; i++)
> +	for (i = 0; i < h->num; i++)
>  		dst[i] += src[i];
>  }
>  
> @@ -132,7 +132,7 @@ static inline void histlog2_to_be(__u32 
>  {
>  	int i;
>  
> -	for (i = 0; i < h->num - 1; i++)
> +	for (i = 0; i < h->num; i++)
>  		a[i] = cpu_to_be32(a[i]);
>  }
>  
> 
> 


-- 
Jens Axboe

