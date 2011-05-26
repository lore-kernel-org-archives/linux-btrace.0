From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 26 May 2011 19:11:51 +0000
Subject: Re: [PATCH v2] blkparse: Avoid segfault for wrong cpu number.
Message-Id: <4DDEA5F7.5050404@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1306338552-11529-1-git-send-email-tm@tao.ma>
In-Reply-To: <1306338552-11529-1-git-send-email-tm@tao.ma>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 2011-05-25 17:49, Tao Ma wrote:
> From: Tao Ma <boyu.mt@taobao.com>
> 
> Currently we only check the magic number to see whether
> a blktrace is valid or not, but Bill Broadley did meet
> with a case that the cpu info is wrong with a number
> of 1725552676. So in resize_cpu_info, we meet with a
> overflow when calculating
> size = new_count * sizeof(struct per_cpu_info);
> And the program will be either segfault or has the error
> of out of memory. Although this is more likely a kernel
> problem, the blkparse shoudn't segfault for it.
> 
> So this patch just check whether the cpu stored in the
> trace is the same as the file, if not, just warn it out
> and skip it.

Being a bit conservative doesn't hurt. Applied.

-- 
Jens Axboe

