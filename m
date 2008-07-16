From: Martin Peschke <mp3@de.ibm.com>
Date: Wed, 16 Jul 2008 14:34:00 +0000
Subject: Re: [Patch 0/2] blkiomon: I/O monitor based on blktrace data
Message-Id: <1216218841.26621.92.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216207358.26621.75.camel@kitka.ibm.com>
In-Reply-To: <1216207358.26621.75.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


On Wed, 2008-07-16 at 09:28 -0400, Alan D. Brunelle wrote:
> Martin Peschke wrote:
> > In order to analyse I/O performance problems which could be reported by
> > customers we want to provide a little monitoring tool. Primarily, we
> > would like to be able look at a history of request size and request
> > latency histograms per device.
> > 
> > The D and C traces provided by blktrace are exactly what we need for
> > that purpose. So, running blktrace with appropriate filters (-a option)
> > makes this approach feasible.
> > 
> > Patch 1/2 allows users to get binary output from blkparse on stdout.
> > 
> > Patch 2/2 contains blkiomon, an I/O monitoring tool, which reads
> > blkparse data from stdin and which periodically writes I/O statistics.
> > 
> > I would like to contribute this little tool to the blktrace source tree.
> > I think it would complement blkparse and btt quite well.
> > 
> > Martin
> 
> Hi Martin -
> 
> Is there some reason why you don't just parse the textual output from
> blkparse itself? [I believe that's what Chris Mason does w/ his
> seekwatcher for example.]

Hi Alan,
we would like to spend as few CPU cycles as possible.

Having a little c-program consuming binary data is less expensive than
having blkparse generate textual output which would be parsed by some
script.

This is a monitoring tool, and there might be millions of requests.

