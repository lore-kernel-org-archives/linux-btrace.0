From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 06 Oct 2009 20:20:32 +0000
Subject: Re: lots of unplugged by timer normal or abnormal?
Message-Id: <1254860432.4852.91.camel@cail>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-hiQIHg+vDFNjozQxUT78"
List-Id: <linux-btrace.vger.kernel.org>
References: <20091006185337.GF26949@hostway.ca>
In-Reply-To: <20091006185337.GF26949@hostway.ca>
To: linux-btrace@vger.kernel.org


--=-hiQIHg+vDFNjozQxUT78
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2009-10-06 at 13:08 -0700, Simon Kirby wrote:
> On Tue, Oct 06, 2009 at 03:50:45PM -0400, Alan D. Brunelle wrote:
> 
> > This looks pretty bad - could you tell me what distro you are running on
> > as a base? And did this happen before 2.6.30.5 (the poor performance)?
> > And could you provide a more complete snippet of blktrace output
> > (showing a handful of complete ops)?
> 
> Hi, Alan!
> 
> The poor performance has been ongoing for some time (these boxes were
> built circa 2.6.26, and we hit a number of issues along the way -- 2.6.30
> was the first stable kernel for serving files via nfsd, even with EXT3).
> 
> I'm figuring the majority of the performance issue are actually with the
> AOE driver or the Coraid queue scheduling or RAID implementation, but I
> figured that unplugging by timer maybe shouldn't happen even regardless
> of how slow the underlying "device" is, hence my email.
> 
> It's amd64 Debian lenny (not sure why that matters), 16 GB of RAM, about
> and a whole bunch of AOE storage, chopped up via DM, mostly using XFS as
> a file system, served via knfsd.  "iostat -x -k 1" shows 100% utilization
> fairly often for this particular device.


Coincidentally I was investigating something similar w/ RHEL 5.4 at this
very moment - just wanted to know if that was a common denominator.

Could you run the attached SystemTap script and send out the output?
[You may have to get `systemtap' though...]

I'll try to get some time to look at your traces - might not be until
tomorrow though...

Thanks,
Alan

--=-hiQIHg+vDFNjozQxUT78
Content-Disposition: attachment; filename="bpd.stp"
Content-Type: text/plain; name="bpd.stp"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

#! /usr/bin/env stap

global n, plug_stacks

probe kernel.function("blk_plug_device") {
        if ((n ++ % 0xff) == 0) {
                plug_stacks[backtrace()] ++
        }
}

probe begin {
        printf("Collecting traces\n")
}

probe timer.sec(20) {
        foreach (stack in plug_stacks- limit 5) {
                printf("%d:\n", plug_stacks[stack])
                print_stack(stack)
        }
        exit()
}

--=-hiQIHg+vDFNjozQxUT78--

