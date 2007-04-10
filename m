From: Ming Zhang <blackmagic02881@gmail.com>
Date: Tue, 10 Apr 2007 17:18:16 +0000
Subject: Re: [BTT PATCH] Add in option to change seek distance calculations
Message-Id: <1176225496.3696.34.camel@fs0004.ibrix.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <461BC3C5.5060307@hp.com>
In-Reply-To: <461BC3C5.5060307@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, 2007-04-10 at 13:05 -0400, Alan D. Brunelle wrote:
> +
> +  \begin{description}
> +    \item[default] By default, the seek distance is calculated as the
> +    \emph{closest} distance between the previous IO and this IO. The
> +    concept of \emph{closeness} means that it could either be the
> +    \emph{end} of the previous IO and the beginning of the next, or
> the
> +    end of this IO and the start of the next.
> +
> +    \item[\texttt{-a}] If the \texttt{-a} or \texttt{seek-absolute}
> +    option is specified, then the seek distance is simply the
> difference
> +    between the start of the previous IO and the start of this IO.
> +  \end{description}
>   

a typo? the distance between 2 start? or end of previous IO and start of
this IO?

Ming


