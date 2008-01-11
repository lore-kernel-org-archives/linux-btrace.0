From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 11 Jan 2008 09:07:23 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <20080111090723.GI6258@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov> <1199996752.9159.46.camel@lap75545.ornl.gov> <20080110234438.4826f658@inria.fr> <1200020661.5099.3.camel@obelisk.thedillows.org>
In-Reply-To: <1200020661.5099.3.camel@obelisk.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Dillow <dillowda@ornl.gov>
Cc: Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de

On Thu, Jan 10 2008, David Dillow wrote:
> 
> On Thu, 2008-01-10 at 23:44 +0100, Guillaume Chazarain wrote:
> > David Dillow <dillowda@ornl.gov> wrote:
> > 
> > > At the moment, I'm not sure how to track this farther, or how to fix it
> > > properly. Any advice would be appreciated.
> > 
> > Just out of curiosity, could you try the appended cumulative patch and
> > report .clock_warps, .clock_overflows and .clock_underflows as you did.
> 
> With those patches, CONFIG_NO_HZ works just fine.
> 
> Patched kernel, nohz=off:
> now at 214257.820809 msecs
>   .clock                         : 214212.727559
>   .idle_clock                    : 0.000000
>   .prev_clock_raw                : 244569.402345
>   .clock_warps                   : 0
>   .clock_overflows               : 577
>   .clock_underflows              : 213887
>   .clock_deep_idle_events        : 4
>   .clock_max_delta               : 0.999830
> 
> Patched kernel, nohz=on:
> now at 248931.524381 msecs
>   .clock                         : 248745.808465
>   .idle_clock                    : 0.000000
>   .prev_clock_raw                : 270911.098507
>   .clock_warps                   : 0
>   .clock_overflows               : 69
>   .clock_underflows              : 784
>   .clock_deep_idle_events        : 4
>   .clock_max_delta               : 100.639397
> 
> Running my disk test, blktrace is getting the proper timestamps now with
> CONFIG_NO_HZ.

Thanks for reporting this. Guillaume, did you write this patch? We need
to get it into 2.6.24-rc7 asap. Let me know if I should take care of
that, or if it's already queued up elsewhere.

-- 
Jens Axboe

