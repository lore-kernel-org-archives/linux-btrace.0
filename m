From: Jan Blunck <jblunck@suse.de>
Date: Mon, 08 Dec 2008 21:50:32 +0000
Subject: Re: [PATCH] blkparse: Globally track smallest sequence read
Message-Id: <20081208215032.GR14520@bolzano.suse.de>
List-Id: <linux-btrace.vger.kernel.org>
References: <20081208153727.GN14520@bolzano.suse.de>
In-Reply-To: <20081208153727.GN14520@bolzano.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Mon, Dec 08, Jens Axboe wrote:

> > 
> > Here is a patch to fix this. It uses a global variable to keep track of the
> > smallest sequence read yet on any cpu.
> 
> Shouldn't this be stored in the per-device info - IOW, the smallest
> sequence read yet on this device on any CPU?

Yeah, you are right. I'll send a better patch.

Thanks,
Jan
