From: Chris Worley <worleys@gmail.com>
Date: Tue, 09 May 2017 16:40:28 +0000
Subject: What does FWFSM as an RBWS mean?
Message-Id: <CANWz5fjBj_zNfCGGX4LMi2yghP1N80SNQZ__FgAOd=8n=mC01A@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The documentation doesn't define anything but R, W, and S (and barriers).

I'm guessing F is a FUA/flush, but why two F's?

Is M no-merge?

Out of this list of RBWS's:

WS
FWS
FWFSM

... will any cause NAND/flash to thrash (i.e. shorten the life by
constantly clearing/garbage collecting large "blocks" for small
writes)?

Thanks,

Chris
