From: Christoph Hellwig <hch@infradead.org>
Date: Tue, 09 May 2017 16:43:15 +0000
Subject: Re: What does FWFSM as an RBWS mean?
Message-Id: <20170509164315.GA21780@infradead.org>
List-Id: <linux-btrace.vger.kernel.org>
References: <CANWz5fjBj_zNfCGGX4LMi2yghP1N80SNQZ__FgAOd=8n=mC01A@mail.gmail.com>
In-Reply-To: <CANWz5fjBj_zNfCGGX4LMi2yghP1N80SNQZ__FgAOd=8n=mC01A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, May 09, 2017 at 06:40:28AM -1000, Chris Worley wrote:
> The documentation doesn't define anything but R, W, and S (and barriers).
> 
> I'm guessing F is a FUA/flush, but why two F's?

Pre-Flush and Fua.

> Is M no-merge?

Metadata.
