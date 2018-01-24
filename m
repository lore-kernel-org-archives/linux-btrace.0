From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 24 Jan 2018 15:41:04 +0000
Subject: Re: [PATCH] blktrace: don't stop tracer if not setup trace successfully
Message-Id: <3643e780-5e88-f210-22f4-034b607ffbb4@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20180115155338.GA15313@bogon.didichuxing.com>
In-Reply-To: <20180115155338.GA15313@bogon.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 1/15/18 8:53 AM, weiping zhang wrote:
> if we run blktrace on same device twice, the second time will failed
> to ioctl(BLKTRACESETUP), then it will call __stop_tracer, which lead
> the first blktrace failed to access debugfs entries. So this patch add
> a check to handle this case, to avoid stop tracer uncondionally.

Thanks, looks good to me, applied.

-- 
Jens Axboe

