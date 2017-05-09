From: Chris Worley <worleys@gmail.com>
Date: Tue, 09 May 2017 17:03:06 +0000
Subject: Re: What does FWFSM as an RBWS mean?
Message-Id: <CANWz5fjM24iu5XZD8nF+fbQDnzHOTOkwS4p5zg8byjFgHB+Xaw@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CANWz5fjBj_zNfCGGX4LMi2yghP1N80SNQZ__FgAOd=8n=mC01A@mail.gmail.com>
In-Reply-To: <CANWz5fjBj_zNfCGGX4LMi2yghP1N80SNQZ__FgAOd=8n=mC01A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, May 9, 2017 at 6:43 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, May 09, 2017 at 06:40:28AM -1000, Chris Worley wrote:
>> The documentation doesn't define anything but R, W, and S (and barriers).
>>
>> I'm guessing F is a FUA/flush, but why two F's?
>
> Pre-Flush and Fua.

So one is pre-flush and the second is FUA?  How do you tell which F
you're looking at if just one?  I'm seeing lots of both FWS and FWFSM.

>
>> Is M no-merge?
>
> Metadata.

So, really no effect, just informational (this is an XFS fs doing the I/O).

Any hints on when sync, flushes, or FUAs force flash to write to
media?  We're using NVMe drives.  All these operations should be
power-cut safe... I'm not sure if any force the driver/controller to
commit to NAND when buffering (in power-cut safe memory) would be
better for performance/lifespan.  I'm guessing this isn't an easy
question... any idea how to find out?

Thanks,

Chris
