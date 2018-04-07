From: Weiping Zhang <zhangweiping@didichuxing.com>
Date: Sat, 07 Apr 2018 09:11:41 +0000
Subject: [PATCH 0/2] add docmention for blkparse man page
Message-Id: <cover.1523092071.git.zhangweiping@didichuxing.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi Jens,

misc improvement for blkparse man page:

patch-1: remove a duplicated entry for flag 'M', back or front merge.
patch-2: add documetation for "'R' requeue request" trace actoin.


Weiping Zhang (2):
  blkparse: remove duplicated entry for flag M
  blkparse: add documetation for 'R' requeue request

 doc/blkparse.1 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.9.4

