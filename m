From: Steffen Maier <maier@linux.ibm.com>
Date: Mon, 09 Apr 2018 14:35:28 +0000
Subject: Re: [PATCH 2/2] blkparse: add documetation for 'R' requeue request
Message-Id: <96649be5-a5bc-4fe1-153d-998db2fc47a1@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <40db37bc1b8b836495d699ce0250172f8be97629.1523092071.git.zhangweiping@didichuxing.com>
In-Reply-To: <40db37bc1b8b836495d699ce0250172f8be97629.1523092071.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-btrace@vger.kernel.org


On 04/07/2018 11:12 AM, Weiping Zhang wrote:
> Signed-off-by: Weiping Zhang <zhangweiping@didichuxing.com>
> ---
>   doc/blkparse.1 | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/doc/blkparse.1 b/doc/blkparse.1
> index b1cb6ef..cb21fea 100644
> --- a/doc/blkparse.1
> +++ b/doc/blkparse.1
> @@ -285,6 +285,10 @@ this and will clone lots of i/o.
>   For stacked devices, incoming i/o is remapped to device below it in the i/o
>   stack. The remap action details what exactly is being remapped to what.
> 
> +.HP 4
> +\fBR -- requeue\fR
> +Put a request back on queue.
> +
> 
> 
> 

I also found this (and other things) and plan to submit them later.

Reviewed-by: Steffen Maier <maier@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Steffen Maier

Linux on z Systems Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

