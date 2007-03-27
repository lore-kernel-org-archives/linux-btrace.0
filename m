From: Ming Zhang <blackmagic02881@gmail.com>
Date: Tue, 27 Mar 2007 01:20:25 +0000
Subject: Re: memory used by btt
Message-Id: <1174958425.5930.12.camel@localhost.localdomain>
List-Id: <linux-btrace.vger.kernel.org>
References: <1174922598.3667.27.camel@dhcp-119.ibrix.com>
In-Reply-To: <1174922598.3667.27.camel@dhcp-119.ibrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Mon, 2007-03-26 at 12:17 -0400, Alan D. Brunelle wrote:
> Ming Zhang wrote:
> > Hi 
> >
> > I am now using btt to analyze a 700MB trace data and it always run oom
> > in my 2GB ram laptop. it also eat 2GB swap as well. Any idea why btt
> > need so many memory?
> >   
> 
> Well, BTT builds trees based upon outstanding IO traces. That could 
> indicate that BTT is having a hard time dealing with your data - I find 
> that sometimes the kernel does weird things, causing strange IO trees 
> being built that BTT can't put back together. I've got some multi-GB 
> sized binary files that I've handled, let me see what the memory 
> footprint is for those...
> 
> 
> > ps, why we always need double in the code, can float fit the bill as
> > well?
> >   
> 
> Probably could, but I'm not too sure about some of the conversions done 
> with LBAs. I can look into that if need be.

i did a quick check, changing to float will not have much help on that
footprint. double is not used in some key data structures.

> 
> Alan
> 
> > Ming
> >
> >   
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

