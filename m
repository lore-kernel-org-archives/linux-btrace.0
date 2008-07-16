From: Martin Peschke <mp3@de.ibm.com>
Date: Wed, 16 Jul 2008 14:53:49 +0000
Subject: Re: [Patch 2/2] blkiomon: I/O monitor
Message-Id: <1216220030.26621.112.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <487DF98B.9020708@hp.com>
In-Reply-To: <487DF98B.9020708@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-s390@vger.kernel.org, linux-btrace@vger.kernel.org


On Wed, 2008-07-16 at 09:37 -0400, Alan D. Brunelle wrote:
> Martin Peschke wrote:
> > blkiomon periodically generates per device request size and request latency
> > statistics from blktrace data. It provides histograms as well as data that
> > can be used to calculate min, max, average and variance. For this purpose,
> > it consumes D and C traces read from stdin.
> > 
> > There are options for binary output and human-readable output to files and
> > stdout. Output to a message queue is supported as well.
> > 
> > # blktrace /dev/sdw -a issue -a complete -w 3000 -o - \
> >   | blkparse -i - -O -d - | blkiomon -I 10 -h -
> > 
> > device: 65,96   interval end: 1216044286134293
> 
> 
> What units are 'interval end' displayed in?

microseconds

Might make sense to refine the textual output.

For our purpose, we are more interested in binary output.

> > requests: read 521, write 34, bidir: 0
> > sizes: min 4096, max 520192, sum 32059392, squ 4300285673472
> > d2c: min 238, max 19274, sum 726186, squ 2428562090
> 
> 
> Why not show the average? What is 'squ'?

We want to be able to calculate min/max/avg/variance later on, for
periods of time that are multiples of the interval monitoring data is
written for.

> 
> > sizes histogram (in kB):
> >        0       1       2       4       8      16      32      64
> >      128     256     512    1024    2048    4096    8192   16384
> >        0       0       0      64      17     144      71     117
> >       97      42       3       0       0       0       0       0
> 
> These outputs are a bit hard to read - are they wrapped (from very, very
> long lines), or is this how they are displayed? If the latter, why not
> have some sort of MxN chart like:
> 
>    0:  0      1:  0      2:  0      4: 64
>    8: 17     16:144     32: 71     64:117
>  128: 97    256: 42    512:  3   1024:  0
> 2048:  0   4096:  0   8192:  0  16384:  0

Looks good to me. I can do that.

Thanks,
Martin

