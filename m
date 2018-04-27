From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:13 +0000
Subject: [PATCH 06/31] blkrawverify: man: fix input format, reports written unconditionally
Message-Id: <20180427130738.102806-7-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 doc/blkrawverify.1 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/blkrawverify.1 b/doc/blkrawverify.1
index 9d3b4bc92f9a..7d272736e46d 100644
--- a/doc/blkrawverify.1
+++ b/doc/blkrawverify.1
@@ -2,7 +2,7 @@
 
 
 .SH NAME
-blkrawverify \- verifies an output file produced by blkparse
+blkrawverify \- verifies an output file produced by blktrace
 
 
 .SH SYNOPSIS
@@ -17,6 +17,7 @@ The \fIblkrawverify\fR utility can be used to verify data retrieved via
 sequence numbers and time stamps, also does reasonable checks for other
 potential issues within individual events.
 
+For each \fIdev\fR, a report is written to \fIdev\fR.verify.out.
 Errors found will be tracked in <\fIdev\fR>.verify.out.
 
 
-- 
2.14.2

