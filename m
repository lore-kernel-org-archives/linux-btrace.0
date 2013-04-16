From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 16 Apr 2013 06:02:15 +0000
Subject: Re: [PATCH 0/5] Improve scaling and hotplugging tolerance in blktrace and friends
Message-Id: <20130416060214.GA12244@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1366037616-20159-1-git-send-email-nzimmer@sgi.com>
In-Reply-To: <1366037616-20159-1-git-send-email-nzimmer@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Mon, Apr 15 2013, Nathan Zimmer wrote:
> While looking for issues at 4096 cpus I noticed that blktrace was behaving 
> oddly.  Upon reviewing I discovered some parts of the code were written at at
> time when boxes were limited to 512 and holes in cpu maps were impossible.
> 
> This patch series should correct that.

Thanks Nathan. I reviewed all 5 and have applied them.

-- 
Jens Axboe

