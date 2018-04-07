From: Weiping Zhang <zhangweiping@didichuxing.com>
Date: Sat, 07 Apr 2018 09:12:00 +0000
Subject: [PATCH 1/2] blkparse: remove duplicated entry for flag M
Message-Id: <3b4a1adbd6869ab90dd2818e0248b4a8c425c188.1523092071.git.zhangweiping@didichuxing.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

remove dupliated entry 'M' for man page of blkparse.

Signed-off-by: Weiping Zhang <zhangweiping@didichuxing.com>
---
 doc/blkparse.1 | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/doc/blkparse.1 b/doc/blkparse.1
index be9b34b..b1cb6ef 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -243,10 +243,6 @@ Same as the back merge, except this i/o ends where a previously inserted
 requests starts.
 
 .HP 4
-\fBM --front or back merge\fR
-One of the above
-
-.HP 4
 \fBM -- front or back merge\fR
 One of the above.
 
-- 
2.9.4

