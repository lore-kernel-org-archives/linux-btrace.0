From: Ming Zhang <blackmagic02881@gmail.com>
Date: Mon, 26 Mar 2007 13:28:40 +0000
Subject: Re: [PATCH BTT]: Re: typo?
Message-Id: <1174915720.3667.1.camel@dhcp-119.ibrix.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <4607B84E.4030600@hp.com>
In-Reply-To: <4607B84E.4030600@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Mon, 2007-03-26 at 08:10 -0400, Alan D. Brunelle wrote:
> plain text document attachment (fix-output-unplug)
> From: Alan D. Brunelle <Alan.Brunelle@hp.com>
> 
> Fix output of unplug totals (cut-and-paste error with total caption).
> 

thx!


> Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>
> ---
> 
>  btt/output.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/btt/output.c b/btt/output.c
> index 1278434..6851848 100644
> --- a/btt/output.c
> +++ b/btt/output.c
> @@ -466,8 +466,8 @@ void __dip_output_plug_all(FILE *ofp, struct plug_info *p)
>  {
>  	fprintf(ofp, "---------- | ---------- ----------  | ----------------\n");
>  	fprintf(ofp, "%10s | %10s %10s  | %s\n", 
> -	        "DEV", "# Plugs", "# Timer Us", "% Time Q Plugged");
> -	fprintf(ofp, "%10s | %10ld(%10ld) | %13.9lf%%\n", "OVERALL",
> +	        "Overall", "# Plugs", "# Timer Us", "% Time Q Plugged");
> +	fprintf(ofp, "%10s | %10ld(%10ld) | %13.9lf%%\n", "Average",
>  	        p->n_plugs / n_plugs, p->n_timer_unplugs / n_plugs, 
>  		p->t_percent / n_plugs);
>  

