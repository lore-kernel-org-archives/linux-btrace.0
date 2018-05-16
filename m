From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 16 May 2018 19:10:14 +0000
Subject: Re: [PATCH] make btt scripts python3-ready
Message-Id: <d522625a-96b5-cbb5-b3f8-13f0f26cd448@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 3/28/18 2:26 PM, Eric Sandeen wrote:
> Many distributions are moving to python3 by default.  Here's
> an attempt to make the python scripts in blktrace python3-ready.
> 
> Most of this was done with automated tools.  I hand fixed some
> space-vs tab issues, and cast an array index to integer.  It
> passes rudimentary testing when run under python2.7 as well
> as python3.
> 
> This doesn't do anything with the shebangs, it leaves them both
> invoking whatever "env python" coughs up on the system.

Applied, thanks.

-- 
Jens Axboe

