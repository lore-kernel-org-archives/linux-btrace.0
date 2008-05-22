From: "M. Edward (Ed) Borasky" <znmeb@cesmail.net>
Date: Thu, 22 May 2008 02:14:41 +0000
Subject: Re: [PATCH] Handled no difference in seek times
Message-Id: <4834D711.2070803@cesmail.net>
List-Id: <linux-btrace.vger.kernel.org>
References: <48347F9C.1080509@hp.com>
In-Reply-To: <48347F9C.1080509@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Alan D. Brunelle wrote:
> For some reason recent kernels (2.6.25.4, for example) have lost a lot
> of resolution in our blktrace times. This can result in lots of things
> happening "simultaneously." This change at least tries to handle the
> case where all the seeks happen at once.
> 
> Probably have other issues that need to be looked into...
> 
> [[Jens: I've pushed this, so you don't need to apply this, but I'm
> wondering have others seen this? I'm seeing 0.01 - which I think means
> we're gated by HZ (set to 100 on this .config, I'm trying w/ HZ00 to
> check this theory). A /lot/ happens in 1/100th of a second on modern
> computers! :-) ]]
> 
> Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
> ---
>  btt/doc/btt.tex |    4 +++-
>  btt/seek.c      |    7 ++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/btt/doc/btt.tex b/btt/doc/btt.tex
> index 9938f67..87e7082 100644
> --- a/btt/doc/btt.tex
> +++ b/btt/doc/btt.tex
> @@ -769,7 +769,9 @@ Device:       rrqm/s   wrqm/s     r/s     w/s
> rsec/s    wsec/s
> 
>    When there is only a single data point within a 1-second window,
>    \texttt{btt} will just output the time value for the point, and the
> -  value 1.0 in the second column.
> +  value 1.0 in the second column. If there is no perceived difference
> +  in the times present for the current sample, then the second columns
> +  value is the number of seeks present at that time.
> 
>    Otherwise, if $\alpha$ and $\Omega$ are the first and last times
>    seen within a 1-second window, and $\nu$ are the number of seeks seen
> diff --git a/btt/seek.c b/btt/seek.c
> index fec57c4..69400c8 100644
> --- a/btt/seek.c
> +++ b/btt/seek.c
> @@ -18,6 +18,7 @@
>   *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
> 02111-1307  USA
>   *
>   */
> +#include <float.h>
>  #include "globals.h"
> 
>  static struct file_info *seek_files = NULL;
> @@ -102,13 +103,13 @@ static void sps_emit(struct seeki *sip)
>  {
>  	double tstamp, s_p_s;
>  	struct sps_bkt *sps = &sip->sps;
> +	double delta = sps->t_last - sps->t_start;
> 
> -	if (sps->nseeks = 1) {
> -		s_p_s = 1.0;
> +	if ((sps->nseeks = 1) || (delta < DBL_EPSILON)) {
> +		s_p_s = (double)(sps->nseeks);
>  		tstamp = sps->t_start;
>  	}
>  	else {
> -		double delta = sps->t_last - sps->t_start;
> 
>  		s_p_s = (double)(sps->nseeks) / delta;
>  		tstamp = sps->t_start + (delta / 2);

I just upgraded to 2.6.25.4 -- is there something I should try?

I am running Gentoo Linux and collecting data on various things like 
kernel builds, recompiling PHP, running a Windows guest with VMware 
Workstation 6, and if I can get it working in the next day or so, a Ruby 
on Rails benchmark.

So far everything I've tried has turned out to be processor bound 
(Athlon64 X2 2.2 GHz dual-core with 4 GB of RAM), so I may boot with 
only 1 GB to try to get the disk utilization up. :)
