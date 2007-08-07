From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 07 Aug 2007 13:32:52 +0000
Subject: Re: [PATCH] Fix remap handling by blktrace
Message-Id: <20070807133252.GY5245@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46B87357.8040802@hp.com>
In-Reply-To: <46B87357.8040802@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Cc: btrace <linux-btrace@vger.kernel.org>, dm-devel@redhat.com, linux-kernel@vger.kernel.org

On Tue, Aug 07 2007, Alan D. Brunelle wrote:
> 

> 
> This patch provides more information concerning REMAP operations on block
> IOs. The additional information provides clearer details at the user level,
> and supports post-processing analysis in btt.
> 
> o  Adds in partition remaps on the same device.
> o  Fixed up the remap information in DM to be in the right order
> o  Sent up mapped-from and mapped-to device information
> 
> Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>

Thanks (again) Alan, applied!

-- 
Jens Axboe

