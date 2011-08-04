From: Jens Axboe <jaxboe@fusionio.com>
Date: Thu, 04 Aug 2011 12:08:48 +0000
Subject: Re: Recent changes
Message-Id: <4E3A8BD0.7070706@fusionio.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 2011-08-04 13:50, Edward Shishkin wrote:
> Hello.
> 
> How about those bits:
> http://marc.info/?l=linux-btrace&m0978262022784&w=2
> http://marc.info/?l=linux-btrace&m0978263222799&w=2
> 
> any chances it will be applied?

-k isn't meant to kill blktrace, it's meant to fixup broken state if
blktrace is already gone yet the device trace state is still running (or
hosed).

-- 
Jens Axboe

