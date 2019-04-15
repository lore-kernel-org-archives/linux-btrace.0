From: Christoph Hellwig <hch@lst.de>
Date: Mon, 15 Apr 2019 05:24:56 +0000
Subject: Re: status of seekwater
Message-Id: <20190415052456.GA15902@lst.de>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190414114600.GA12039@lst.de>
In-Reply-To: <20190414114600.GA12039@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Sun, Apr 14, 2019 at 07:43:17PM +0000, Chris Mason wrote:
> I replaced seekwatcher with iowatcher a while ago, and convinced Jens to 
> stuff it into blktrace git.  It's dramatically faster (C instead of 
> python), and the command line is slightly different.  But, all the 
> features should be there.

Ok.  Can we add a note to the blktrace repo that this replaces seekwatcher
in a way that can be easily found?  Do we still have friends at Oracle
that could add such a note to the old seekwatcher page at:

    https://oss.oracle.com/~mason/seekwatcher/
