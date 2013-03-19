From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 19 Mar 2013 14:17:25 +0000
Subject: Re: patch  for blkparse
Message-Id: <20130319141725.GA2642@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <51481779.10404@samsung.com>
In-Reply-To: <51481779.10404@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, Mar 19 2013, Ivan Dyukov wrote:
> ame="read_write_bytes.patch"
> Content-Transfer-Encoding: 7bit
> Content-Disposition: attachment;
>  filename="read_write_bytes.patch"
> 
> commit 2602a606b51f9893756bd1916ec3c3911349922f
> Author: Ivan Dyukov <i.dyukov@samsung.com>
> Date:   Tue Mar 19 11:13:09 2013 +0400
> 
>     More accurate calculation of the total read/write values. If block device has many request with size less than 1K, blkparse ignore such requests because it treat each request in Kb.

Thanks, applied.

-- 
Jens Axboe

