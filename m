From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Fri, 18 Jul 2008 15:28:30 +0000
Subject: Re: [Patch] blkiomon: repost with some fixes and improvements
Message-Id: <4880B69E.3050806@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216377086.8497.4.camel@kitka.ibm.com>
In-Reply-To: <1216377086.8497.4.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


> 
> Thanks for the patch, I'll give it a try today.
> The most  reliable way to reproduce is to run a dd that copies about
> 10-20Gb, and rm the file immediately.
> Then try that find / ^C stuff, it usually occurs right at the end of the
> dd (when the file is probably removed).
> 
> Best regards,
> --Edwin

The system /is/ acting very strange: I'm seeing very, very poor
responsiveness - trying to start anything with very large dd's going on
takes a long time (maybe forever, I'm just trying to log in right now
and it won't budge).

I do have vmstat & iostat running, what's strange is I'm seeing a lot of
I/O from iostat:

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.47    0.00    2.14   90.51    0.00    6.88

Device:            tps   Blk_read/s   Blk_wrtn/s   Blk_read   Blk_wrtn
sda             163.50        20.00    157296.00         40     314592


but /not/ vmstat (I thought I'd see the 'bo' column going):

procs -----------memory---------- ---swap-- -----io---- -system--
----cpu----
 r  b   swpd   free  inact active   si   so    bi    bo   in   cs us sy
id wa
 0  0      0 2795940 3326292 1649612    0    0     0    26  183 2104  8
 0 92  0

Anyways, I'm hoping the Python script helps diagnose some stuff. I'm
looking into how to measure other things that are put off because we are
congested in the request allocation path...

Alan
