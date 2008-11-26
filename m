From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Wed, 26 Nov 2008 09:33:46 +0000
Subject: Re: bad trace magic
Message-Id: <1227692026.6947.3.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1227094718.10046.29.camel@kitka.ibm.com>
In-Reply-To: <1227094718.10046.29.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


On Wed, 2008-11-19 at 16:07 +0100, Jens Axboe wrote:
> So you don't happen to have a stream of data we can inspect _after_ the
> bad magic occured?

Hi Jens,
any suggestions, a commmand line, for capturing that stream of data?

I have been looking into the kernel side of it, and blktrace/relay
appear to continue writing data when a bad trace has been detected in
user space.

Thanks,
Martin

