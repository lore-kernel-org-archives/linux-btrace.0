From: Jens Axboe <jaxboe@fusionio.com>
Date: Thu, 11 Aug 2011 10:50:06 +0000
Subject: Re: [PATCH] Add FLUSH/FUA support
Message-Id: <4E43B3DE.5080906@fusionio.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1313058750-1719-1-git-send-email-namhyung@gmail.com>
In-Reply-To: <1313058750-1719-1-git-send-email-namhyung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 2011-08-11 12:32, Namhyung Kim wrote:
> Add FLUSH/FUA support to blktrace. As FLUSH precedes WRITE and/or
> FUA follows WRITE, use the same 'F' flag for both cases and
> distinguish them by their (relative) position. The end results
> look like (other flags might be shown also):
> 
>  - WRITE:            W
>  - WRITE_FLUSH:      FW
>  - WRITE_FUA:        WF
>  - WRITE_FLUSH_FUA:  FWF
> 
> Note that we reuse TC_BARRIER due to lack of bit space of act_mask.

Thanks, applied. I've tagged 1.0.3 as well now, with the hopes of that
expediting distros updating the package.

-- 
Jens Axboe

