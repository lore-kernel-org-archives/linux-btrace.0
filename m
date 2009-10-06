From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 06 Oct 2009 19:50:45 +0000
Subject: Re: lots of unplugged by timer normal or abnormal?
Message-Id: <1254858645.4852.87.camel@cail>
List-Id: <linux-btrace.vger.kernel.org>
References: <20091006185337.GF26949@hostway.ca>
In-Reply-To: <20091006185337.GF26949@hostway.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, 2009-10-06 at 11:53 -0700, Simon Kirby wrote:
> Hello,
> 
> I was just testing out blktrace/blkparse/btrace on a box that is hitting
> some performance walls, and noticed that there are a fair amonut of "UT"
> events (unplug by timer).  Is this normal/expected?  For example:
> 
> [sroot@nas04:/root]# btrace /dev/etherd/e7.0 | grep T
> 152,32   4     1379     3.582513494     0 UT   N [swapper] 8
> 152,32   1     1289     4.329760067     0 UT   N [swapper] 1
> 152,32   3     1132     4.362257911     0 UT   N [swapper] 3
> 152,32   7     1070     4.375258374     0 UT   N [swapper] 1
> 152,32   3     1146     4.382260172     0 UT   N [swapper] 5
> 152,32   1     1318     4.417759727  2830 UT   N [nfsd] 3
> 152,32   5     1003     4.498757105     0 UT   N [swapper] 1
> 152,32   1     1368     4.517761127     0 UT   N [swapper] 1
> 152,32   0     1133     4.585522116     0 UT   N [swapper] 5
> 
> This is on 2.6.30.5 with the 2.6.30.6 XFS patches.
> 
> Cheers,
> 
> Simon-

Hello Simon- 

This looks pretty bad - could you tell me what distro you are running on
as a base? And did this happen before 2.6.30.5 (the poor performance)?
And could you provide a more complete snippet of blktrace output
(showing a handful of complete ops)?

Thanks,
Alan D. Brunelle
Hewlett-Packard

