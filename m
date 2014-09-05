From: Christoph Hellwig <hch@infradead.org>
Date: Fri, 05 Sep 2014 18:48:06 +0000
Subject: [RFC] merge seekwatcher into the blktrace repository?
Message-Id: <20140905184806.GA32325@infradead.org>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi Chris, hi Jens,

I worked with a customer last week who had to manually install
seekwatcher because their distro didn't provide it, and it turns
out that the hg repository for it seems fairly dead, and recent fixes
are instead carried in various distro packages.

Given that seekwatcher is based on blktrace, and given that other
simple blktrace consumers are in the blktrace repository maybe it's time
to simple add seekwatcher to the blktrace repository so that we have
a canonical place for any sort of fixes for it?
