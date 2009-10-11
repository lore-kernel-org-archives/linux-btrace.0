From: Jens Axboe <jens.axboe@oracle.com>
Date: Sun, 11 Oct 2009 18:35:36 +0000
Subject: Re: lots of unplugged by timer normal or abnormal?
Message-Id: <20091011183536.GS9228@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20091006185337.GF26949@hostway.ca>
In-Reply-To: <20091006185337.GF26949@hostway.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Sun, Oct 11 2009, Simon Kirby wrote:
> On Tue, Oct 06, 2009 at 04:20:32PM -0400, Alan D. Brunelle wrote:
> 
> > Coincidentally I was investigating something similar w/ RHEL 5.4 at this
> > very moment - just wanted to know if that was a common denominator.
> > 
> > Could you run the attached SystemTap script and send out the output?
> > [You may have to get `systemtap' though...]
> 
> Thanks for the excuse to try SystemTap. :)  I have some traces, but I
> don't think the UT case is abnormal.  On my desktop at home, I can see
> btraces such as this, which seem to show it happening often:

It depends a lot on the workload. The UT will trigger if the amount of
writes isn't very high - if you go above 4 queued writes, a regular
unplug will trigger. So if you see if for write intensive workloads, it
is almost surely a bug. For background firefox activity on your desktop,
it's not unusual.

If you see if for reads, it's almost always a bug.

-- 
Jens Axboe

