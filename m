From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 14 Jan 2011 08:07:48 +0000
Subject: Re: [PATCH] blkiomon: Fix an output error.
Message-Id: <4D300454.9000301@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1294991770-16405-1-git-send-email-tm@tao.ma>
In-Reply-To: <1294991770-16405-1-git-send-email-tm@tao.ma>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 2011-01-14 08:56, Tao Ma wrote:
> From: Tao Ma <boyu.mt@taobao.com>
> 
> When we give out some statistics in blkiomon, we don't consider
> the situation that the device has no correspoinding action. See
> if there is no disk read during the interval, the output in my box is
> like:
> sizes read (bytes): num 0, min -1, max 0, sum 0, squ 0, avg nan, var nan
> 
> With the fix, now it looks like:
> sizes read (bytes): num 0, min -1, max 0, sum 0, squ 0, avg 0.0, var 0.0

Thanks, applied!

-- 
Jens Axboe

