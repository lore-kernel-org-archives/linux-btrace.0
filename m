From: Vasily Tarasov <vtaras@sw.ru>
Date: Fri, 11 May 2007 15:50:31 +0000
Subject: Re: [blktrace] unplug queue trace action is missed at some places
Message-Id: <1178898631.3335.23.camel@dhcp0-54.sw.ru>
List-Id: <linux-btrace.vger.kernel.org>
References: <1178897976.3335.20.camel@dhcp0-54.sw.ru>
In-Reply-To: <1178897976.3335.20.camel@dhcp0-54.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hmm, I see now that not only blk_start_queueing() function suffers from,
that there are a lot of other callers of
generic_unplug_device/__generic_unplug_device

On Fri, 2007-05-11 at 19:39 +0400, Vasily Tarasov wrote:
> Hello all,
> 
> The function blk_start_queueing() calls __generic_unplug_device()
> function directly without tracing BLK_TA_UNPLUG_IO action. So I have an
> odd output of blktrace, when requests go through the plugged queue. I
> suppose it's a BUG, or do I miss something?
> 
> Thanks,
> Vasily
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

