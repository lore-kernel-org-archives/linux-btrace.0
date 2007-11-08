From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 08 Nov 2007 20:15:45 +0000
Subject: Re: [PATCH] Add UNPLUG traces to all appropriate places
Message-Id: <20071108201544.GB13741@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <473319F3.30706@hp.com>
In-Reply-To: <473319F3.30706@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com, btrace <linux-btrace@vger.kernel.org>

On Thu, Nov 08 2007, Alan D. Brunelle wrote:
> Added blk_unplug interface, allowing all invocations of unplugs to result
> in a generated blktrace UNPLUG. Previously, we saw a PLUG on each of the
> underlying devices, and an UNPLUG on the volume. This patch ensures that
> we see the UNPLUG calls for each of the underlying devices.

Looks fine Alan, applied.

-- 
Jens Axboe

