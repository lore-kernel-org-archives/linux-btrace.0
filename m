From: Christoph Hellwig <hch@lst.de>
Date: Sun, 14 Apr 2019 11:46:00 +0000
Subject: status of seekwater
Message-Id: <20190414114600.GA12039@lst.de>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Has any tried to use seekwatcher lately?  For one the report on
oss.oracle.com seems to be gone.  I found a git repo that seems
to have the latest codebase from hg and two little fixes here:

https://github.com/trofi/seekwatcher

But even that doesn't seem to work in modern environments.  After
a build with a few warnings actually trying to run it creates doesn't
seem to actually work well:


$ /usr/local/bin/seekwatcher -o sda2.png -t sda2
using tracefile ./sda2
Traceback (most recent call last):
  File "/usr/local/bin/seekwatcher", line 983, in <module>
    run = run_blkparse(x)
  File "/usr/local/bin/seekwatcher", line 614, in run_blkparse
    loaddata(fh, rd)
  File "/usr/local/bin/seekwatcher", line 130, in loaddata
    tags, options)
  File "rundata.pyx", line 234, in seekwatcher.rundata.rundata.load_data (seekwatcher/rundata.c:3936)
ValueError: The truth value of an array with more than one element is ambiguous. Use a.any() or a.all()

With not output produces. 
