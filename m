From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 12 Jun 2007 16:23:06 +0000
Subject: Re: blktrace crashing with 2.6.22-rc3
Message-Id: <20070612162306.GN18832@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <466E7226.7060609@lichota.net>
In-Reply-To: <466E7226.7060609@lichota.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, Jun 12 2007, Krzysztof Lichota wrote:
> Jens Axboe napisa??(a):
> >> Should I investigate it further or is it a known issue?
> >
> > I think it's a known issue. Don't run blktrace -k unless the trace is
> > really stuck - does it work correctly if you just ctrl-c out of
> > blktrace?
> 
> Yes, it works. I just got the impression that blktrace -k is the
> preferred way of terminating the trace.

oh no, -k is for KILL, extremely unpolite :-)

> Thanks for help :)

It sounds like you have found a way to reliably cause that bug, so I'll
see if I can reproduce and get it fixed.


-- 
Jens Axboe

