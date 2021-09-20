From: Jeff Moyer <jmoyer@redhat.com>
Date: Mon, 20 Sep 2021 18:08:28 +0000
Subject: Re: [PATCH] btt: fix potential memory leak problem in io_free_all()
Message-Id: <x49r1djqfvn.fsf@segfault.boston.devel.redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20210917091845.133913-1-songkai01@inspur.com>
In-Reply-To: <20210917091845.133913-1-songkai01@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-btrace@vger.kernel.org

songkai <songkai01@inspur.com> writes:

> In “struct io” , the "void *pdu" member points to the memory
> which is allocated in convert_to_cpu(). We should free memory
> pdu point to before we free "struct io", or memory leak occurred.

That should be freed via io_release.  Do you know of a case where that
doesn't happen?  Also, io_free_all is only called right before exit.
I'm not sure this patch really plugs a leak that would impact normal
operations.

The patch seems harmless, but I'm not sure it's needed.

Cheers,
Jeff

>
> Signed-off-by: songkai <songkai01@inspur.com>
> ---
>  btt/inlines.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/btt/inlines.h b/btt/inlines.h
> index 64b5a2c..fa5a546 100644
> --- a/btt/inlines.h
> +++ b/btt/inlines.h
> @@ -153,6 +153,9 @@ static inline void io_free_all(void)
>  
>  	list_for_each_safe(p, q, &all_ios) {
>  		iop = list_entry(p, struct io, a_head);
> +
> +		if (iop->pdu)
> +			free(iop->pdu);
>  		free(iop);
>  	}
>  }
