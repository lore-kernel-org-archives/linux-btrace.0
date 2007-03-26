From: Ming Zhang <blackmagic02881@gmail.com>
Date: Mon, 26 Mar 2007 13:30:40 +0000
Subject: Re: how to understand the Q2Q in btt result?
Message-Id: <1174915840.3667.4.camel@dhcp-119.ibrix.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1174876819.6887.2.camel@localhost.localdomain>
In-Reply-To: <1174876819.6887.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Sun, 2007-03-25 at 23:51 -0400, Alan D. Brunelle wrote:
> Ming Zhang wrote:
> > from btt user guide
> >
> > "Q2Q which measures the time between queue traces in the system.
> > This provides some idea as to how quickly IOs are being handed to
> > the block IO layer."
> >
> > does this mean the time between queuing N request and N
> > +1 request?
> >   
> 
> Hi Ming -
> 
> This is the average time between the Q traces being logged. We take the 
> difference between each succeeding Q trace, and divide the sum by the total.

so like block layer idle indicator. maybe a similar D2D will be a nice
device indicator as well.


> 
> Alan
> > thanks!
> >
> > Ming
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >   
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

