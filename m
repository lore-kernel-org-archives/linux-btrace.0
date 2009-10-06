From: Simon Kirby <sim@hostway.ca>
Date: Tue, 06 Oct 2009 20:08:03 +0000
Subject: Re: lots of unplugged by timer normal or abnormal?
Message-Id: <20091006200803.GA22261@hostway.ca>
List-Id: <linux-btrace.vger.kernel.org>
References: <20091006185337.GF26949@hostway.ca>
In-Reply-To: <20091006185337.GF26949@hostway.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, Oct 06, 2009 at 03:50:45PM -0400, Alan D. Brunelle wrote:

> This looks pretty bad - could you tell me what distro you are running on
> as a base? And did this happen before 2.6.30.5 (the poor performance)?
> And could you provide a more complete snippet of blktrace output
> (showing a handful of complete ops)?

Hi, Alan!

The poor performance has been ongoing for some time (these boxes were
built circa 2.6.26, and we hit a number of issues along the way -- 2.6.30
was the first stable kernel for serving files via nfsd, even with EXT3).

I'm figuring the majority of the performance issue are actually with the
AOE driver or the Coraid queue scheduling or RAID implementation, but I
figured that unplugging by timer maybe shouldn't happen even regardless
of how slow the underlying "device" is, hence my email.

It's amd64 Debian lenny (not sure why that matters), 16 GB of RAM, about
and a whole bunch of AOE storage, chopped up via DM, mostly using XFS as
a file system, served via knfsd.  "iostat -x -k 1" shows 100% utilization
fairly often for this particular device.

It's possible that this is just aggravated by memory allocator latency or
something, causing the unplug timer to trigger.  I was just wondering if
this is normal behaviour.

blktrace snippets seem pretty massive:

[sroot@nas04:/root/trace]# blktrace -w 10 /dev/etherd/e7.0
Device: /dev/etherd/e7.0
  CPU  0:                    0 events,      843 KiB data
  CPU  1:                    0 events,      709 KiB data
  CPU  2:                    0 events,      712 KiB data
  CPU  3:                    0 events,      752 KiB data
  CPU  4:                    0 events,      714 KiB data
  CPU  5:                    0 events,      713 KiB data
  CPU  6:                    0 events,      619 KiB data
  CPU  7:                    0 events,      732 KiB data
  Total:                     0 events (dropped 0),     5791 KiB data

I've saved that here:

http://0x.ca/sim/ref/2.6.30.5-hw-fixedxfs/nas04_blktrace_snippet.tgz

...which can be extracted and read with "blkparse etherd_e7.0".

Cheers,

Simon-
