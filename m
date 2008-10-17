From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 17 Oct 2008 13:08:58 +0000
Subject: Re: [Patch] blkparse: add hint for discarded drv_data traces
Message-Id: <20081017130857.GI19428@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1224248784.4348.7.camel@kitka.ibm.com>
In-Reply-To: <1224248784.4348.7.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Fri, Oct 17 2008, Martin Peschke wrote:
> From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
> 
> Display an informational message on blkparse exit to notify users that
> additional data was available which would require to be dumped to binary
> output.
> 
> Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>

Thanks, applied!

-- 
Jens Axboe

