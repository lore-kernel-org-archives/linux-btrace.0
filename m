From: weiping zhang <zhangweiping@didichuxing.com>
Date: Thu, 07 Dec 2017 16:23:10 +0000
Subject: [PATCH] doc: trace action M only for back merge
Message-Id: <20171207162306.GA25143@localhost.didichuxing.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

F -- front merge
M -- back merge, exclude front merge

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 doc/blkparse.1 | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/doc/blkparse.1 b/doc/blkparse.1
index be9b34b..70c85cf 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -243,14 +243,6 @@ Same as the back merge, except this i/o ends where a previously inserted
 requests starts.
 
 .HP 4
-\fBM --front or back merge\fR
-One of the above
-
-.HP 4
-\fBM -- front or back merge\fR
-One of the above.
-
-.HP 4
 \fBG -- get request\fR
 To send any type of request to a block device, a \fIstruct request\fR
 container must be allocated first.
-- 
2.9.4

