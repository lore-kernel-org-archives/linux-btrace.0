From: Christoph Hellwig <hch@infradead.org>
Date: Tue, 09 May 2017 19:08:02 +0000
Subject: Re: What does FWFSM as an RBWS mean?
Message-Id: <20170509190802.GA10037@infradead.org>
List-Id: <linux-btrace.vger.kernel.org>
References: <CANWz5fjBj_zNfCGGX4LMi2yghP1N80SNQZ__FgAOd=8n=mC01A@mail.gmail.com>
In-Reply-To: <CANWz5fjBj_zNfCGGX4LMi2yghP1N80SNQZ__FgAOd=8n=mC01A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, May 09, 2017 at 07:03:06AM -1000, Chris Worley wrote:
> So one is pre-flush and the second is FUA?  How do you tell which F
> you're looking at if just one?  I'm seeing lots of both FWS and FWFSM.

A Pre-flush is before the 'W', a FUA is after the 'W'.

> So, really no effect, just informational (this is an XFS fs doing the I/O).

Yes.

> 
> Any hints on when sync, flushes, or FUAs force flash to write to
> media?  We're using NVMe drives.  All these operations should be
> power-cut safe... I'm not sure if any force the driver/controller to
> commit to NAND when buffering (in power-cut safe memory) would be
> better for performance/lifespan.  I'm guessing this isn't an easy
> question... any idea how to find out?

The answer is it depends.  For enterprice drivers writes are usually
buffered on SRAM before going to the media, but those usually don't
even claim to have a volatile write cache (e.g. do not set the
Volatile Write Cache (VWC) bit in Identify Controller in nvme, you
can check that using 'nvme id-ctrl -H /dev/nvme0').

For consumer drivers chances are every flush or fua will go out
to the media, or the device is not actually power fail safe.
