From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 16 Oct 2008 06:07:46 +0000
Subject: Re: [Patch 3/3] driver data: add support to blktrace user space code
Message-Id: <20081016060746.GR19428@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216207574.26621.85.camel@kitka.ibm.com>
In-Reply-To: <1216207574.26621.85.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Sun, Oct 05 2008, Martin Peschke wrote:
> From: Stefan Raspl <raspl@linux.vnet.ibm.com>
> 
> Adds a new type of action 'drv_data' for blktrace to handle binary
> driver-specific data. Since the data is binary, blkparse will only put it in
> a binary file, not in the regular human-readable output.

I wonder if that should display some kind of informational message on
blkparse exit, if you are not dumping binary? Just to notify the user
that there was extra data available, but that it wasn't dumped.

Otherwise looks fine, I've applied 1-3.

-- 
Jens Axboe

