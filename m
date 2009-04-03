From: <raksac@yahoo.com>
Date: Fri, 03 Apr 2009 21:01:10 +0000
Subject: how would this happen
Message-Id: <644473.76414.qm@web30205.mail.mud.yahoo.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


Using blktrace with a device having ext2fs I get a
good picture -

issuing pid->block xlation->completion

From above given a block # using debugfs
(icheck/ncheck) we can reverse lookup a file name to
which the IO was performed. This seems to be helpful
when the file is persistent beyond the blktrace
collection session i.e. during blkparse.

For short lived files (temp files which would be
removed from namespace prior to blkparse run) how can
we get the block->file mapping with blktrace.

Thanks,
Rakesh


      
