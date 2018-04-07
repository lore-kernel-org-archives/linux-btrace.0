From: Weiping Zhang <zhangweiping@didichuxing.com>
Date: Sat, 07 Apr 2018 09:12:18 +0000
Subject: [PATCH 2/2] blkparse: add documetation for 'R' requeue request
Message-Id: <40db37bc1b8b836495d699ce0250172f8be97629.1523092071.git.zhangweiping@didichuxing.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Weiping Zhang <zhangweiping@didichuxing.com>
---
 doc/blkparse.1 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/blkparse.1 b/doc/blkparse.1
index b1cb6ef..cb21fea 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -285,6 +285,10 @@ this and will clone lots of i/o.
 For stacked devices, incoming i/o is remapped to device below it in the i/o
 stack. The remap action details what exactly is being remapped to what.
 
+.HP 4
+\fBR -- requeue\fR
+Put a request back on queue.
+
 
 
 
-- 
2.9.4

