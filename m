From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 13 Apr 2007 18:14:49 +0000
Subject: Re: [BTT PATCH] Fix memory leak
Message-Id: <20070413181449.GJ19066@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <4617D567.500@pobox.com>
In-Reply-To: <4617D567.500@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Sat, Apr 07 2007, Alan D. Brunelle wrote:
> [[Note: I do not have access to my work mail right now, so I'm doing 
> this quite blind - please excuse me if I've got the name wrong below...]]
> 
> Hi Jens -
> 
> A couple of weeks ago Ming Zhang had noted that btt was using tremendous 
> amounts of memory to accomplish a run. After looking at the code, and 
> doing some testing, I determined the cause - please find a patch to the 
> latest tree that seems to fix the problem for me...

Alan,

I applied this one and tried to apply the rest of your posted patches,
but some of them fail. So I stopped after this one, can you resend the
series against the current HEAD? Thanks!

-- 
Jens Axboe

