From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 26 May 2011 19:11:23 +0000
Subject: Re: [PATCH v2] blktrace: Use be32_to_cpu for blk_io_trace->cpu.
Message-Id: <4DDEA5DB.9090401@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1306338488-11426-1-git-send-email-tm@tao.ma>
In-Reply-To: <1306338488-11426-1-git-send-email-tm@tao.ma>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 2011-05-25 17:48, Tao Ma wrote:
> From: Tao Ma <boyu.mt@taobao.com>
> 
> blk_io_trace->cpu is u32, so use be32_to_cpu instead.

Good catch, applied!

-- 
Jens Axboe

