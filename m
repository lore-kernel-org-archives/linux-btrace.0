From: Martin Peschke <mp3@de.ibm.com>
Date: Wed, 16 Jul 2008 11:22:37 +0000
Subject: [Patch 0/2] blkiomon: I/O monitor based on blktrace data
Message-Id: <1216207358.26621.75.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

In order to analyse I/O performance problems which could be reported by
customers we want to provide a little monitoring tool. Primarily, we
would like to be able look at a history of request size and request
latency histograms per device.

The D and C traces provided by blktrace are exactly what we need for
that purpose. So, running blktrace with appropriate filters (-a option)
makes this approach feasible.

Patch 1/2 allows users to get binary output from blkparse on stdout.

Patch 2/2 contains blkiomon, an I/O monitoring tool, which reads
blkparse data from stdin and which periodically writes I/O statistics.

I would like to contribute this little tool to the blktrace source tree.
I think it would complement blkparse and btt quite well.

Martin

