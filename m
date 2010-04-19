From: Eric Sandeen <sandeen@redhat.com>
Date: Mon, 19 Apr 2010 17:13:38 +0000
Subject: Re: [PATCH] blkparse: exit with error if no tracefiles found
Message-Id: <4BCC8F42.5000708@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <4A0B46BD.4030202@redhat.com>
In-Reply-To: <4A0B46BD.4030202@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Eric Sandeen wrote:
> If no tracefiles are found, exit with non-0 status
> 
> Resolves Red Hat Bugzilla #500118
> 
> Reported-by: Milos Malik <mmalik@redhat.com>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---

Re-ping on this?

Thanks,
-Eric

> 
> diff --git a/blkparse.c b/blkparse.c
> index eec4952..db6a418 100644
> --- a/blkparse.c
> +++ b/blkparse.c
> @@ -2518,6 +2518,12 @@ static int do_file(void)
>  
>  		for (cpu = 0; setup_file(pdi, cpu); cpu++)
>  			;
> +
> +		if (!cpu) {
> +			fprintf(stderr,"No input files found for %s\n",
> +				pdi->name);
> +			return 1;
> +		}
>  	}
>  
>  	/*
> 
> 

