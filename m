From: Ming Zhang <blackmagic02881@gmail.com>
Date: Tue, 10 Apr 2007 17:15:20 +0000
Subject: Re: [BTT PATCH] Add back in combined seek output file
Message-Id: <1176225320.3696.32.camel@fs0004.ibrix.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <461BC38D.5040405@hp.com>
In-Reply-To: <461BC38D.5040405@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, 2007-04-10 at 13:04 -0400, Alan D. Brunelle wrote:
> @@ -149,9 +150,12 @@ void seeki_add(void *handle, struct io *iop)
>         struct seeki *sip = handle;
>         long long dist = seek_dist(sip, iop);
>         FILE *fp = IOP_READ(iop) ? sip->rfp : sip->wfp;
> +       double tstamp = BIT_TIME(iop->t.time);
>  
>         if (fp)
> -               fprintf(fp, "%15.9lf %13lld\n", BIT_TIME(iop->t.time),
> dist);
> +               fprintf(fp, "%15.9lf %13lld\n", tstamp, dist);
> +       if (sip->cfp)
> +               fprintf(sip->cfp, "%15.9lf %13lld\n", tstamp, dist);
>   

thx for adding this. it might be better if in combined file, print out
current io is read or write. 

Ming


