From: "Alan D. Brunelle" <alan.brunelle@hp.com>
Date: Mon, 26 Mar 2007 16:17:17 +0000
Subject: Re: memory used by btt
Message-Id: <4607F20D.4060605@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1174922598.3667.27.camel@dhcp-119.ibrix.com>
In-Reply-To: <1174922598.3667.27.camel@dhcp-119.ibrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Ming Zhang wrote:
> Hi 
>
> I am now using btt to analyze a 700MB trace data and it always run oom
> in my 2GB ram laptop. it also eat 2GB swap as well. Any idea why btt
> need so many memory?
>   

Well, BTT builds trees based upon outstanding IO traces. That could 
indicate that BTT is having a hard time dealing with your data - I find 
that sometimes the kernel does weird things, causing strange IO trees 
being built that BTT can't put back together. I've got some multi-GB 
sized binary files that I've handled, let me see what the memory 
footprint is for those...


> ps, why we always need double in the code, can float fit the bill as
> well?
>   

Probably could, but I'm not too sure about some of the conversions done 
with LBAs. I can look into that if need be.

Alan

> Ming
>
>   

