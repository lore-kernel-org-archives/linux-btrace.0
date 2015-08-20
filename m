From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 20 Aug 2015 15:59:38 +0000
Subject: Re: [PATCH] btreplay: Fix typo in scaling up the dynamic cpu set size.
Message-Id: <55D5F96A.2060102@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <55D5F7D3.7090005@suse.com>
In-Reply-To: <55D5F7D3.7090005@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 08/20/2015 08:52 AM, Jeff Mahoney wrote:
> From: Josef Cejka <jcejka@suse.com>
>
> In get_ncpus, we default to using 4096 CPUs if _SC_NPROCESSORS_CONF isn't
> enabled.  If that is insufficient, sched_getaffinity will fail and we
> retry after doubling the size of the cpu_set_t allocation.  There's a typo
> in there that means we don't actually double the size and will loop
> forever allocating the same sized cpu_set_t instead.
>
> Signed-off-by: Josef Cejka <jcejka@suse.com>
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>
>   btreplay/btreplay.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/btreplay/btreplay.c
> +++ b/btreplay/btreplay.c
> @@ -516,7 +516,7 @@ realloc:
>   	if (sched_getaffinity(getpid(), size, cpus)) {
>   		if( errno = EINVAL && nrcpus < (4096<<4) ) {
>   			CPU_FREE(cpus);
> -			nrcpus <= 1;
> +			nrcpus <<= 1;

Hah, well that sucks. Looks like commit 0a915aabe88ff added that 
problem, and wasn't caught in review.

Thanks, applied.

-- 
Jens Axboe

