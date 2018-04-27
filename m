From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:12 +0000
Subject: [PATCH 05/31] btrace: man: improve by pointing to blkparse for option -r (debugfs)
Message-Id: <20180427130738.102806-6-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

With that, the user can see which btrace option is passed to and
backed by which internally called tool (blktrace or blkparse).

Fixes: bc93336f08a3 ("fix up btrace options & manpage")
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 doc/btrace.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/btrace.8 b/doc/btrace.8
index 146462ced50c..dc08e3608f1d 100644
--- a/doc/btrace.8
+++ b/doc/btrace.8
@@ -50,7 +50,7 @@ Specifies buffer size for event extraction (scaled by 1024) (see
 
 .HP 4
 .B \-r \fI<dbg mnt>\fR
-Specifies the debugfs mountpoint.
+Specifies the debugfs mountpoint (see \fIblktrace\fR (8)).
 
 .HP 4
 .B \-a <\fItrace\fR>...
-- 
2.14.2

