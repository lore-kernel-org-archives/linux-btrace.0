From: Steffen Maier <maier@linux.ibm.com>
Date: Mon, 09 Apr 2018 14:33:10 +0000
Subject: Re: [PATCH 1/2] blkparse: remove duplicated entry for flag M
Message-Id: <2e2165c8-24ca-e7ec-fbbd-4beca9eef743@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <3b4a1adbd6869ab90dd2818e0248b4a8c425c188.1523092071.git.zhangweiping@didichuxing.com>
In-Reply-To: <3b4a1adbd6869ab90dd2818e0248b4a8c425c188.1523092071.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-btrace@vger.kernel.org


On 04/07/2018 11:12 AM, Weiping Zhang wrote:
> remove dupliated entry 'M' for man page of blkparse.
> 
> Signed-off-by: Weiping Zhang <zhangweiping@didichuxing.com>
> ---
>   doc/blkparse.1 | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/doc/blkparse.1 b/doc/blkparse.1
> index be9b34b..b1cb6ef 100644
> --- a/doc/blkparse.1
> +++ b/doc/blkparse.1
> @@ -243,10 +243,6 @@ Same as the back merge, except this i/o ends where a previously inserted
>   requests starts.
> 
>   .HP 4
> -\fBM --front or back merge\fR
> -One of the above
> -
> -.HP 4
>   \fBM -- front or back merge\fR
>   One of the above.
> 

I also found this (and other things) and plan to submit them later.

Additionally, I had the impression that 'M' is nowadays always a "back 
merge", not "front or back merge".

Anyway, dropping the duplicate seems right:

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

