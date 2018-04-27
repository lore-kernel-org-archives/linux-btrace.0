From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:30 +0000
Subject: [PATCH 23/31] blkparse: fix allowed event type specifiers for custom output format
Message-Id: <20180427130738.102806-24-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

'W' was replaced by 'B' in code but 'W' was not removed from valid specs.
Fixes: bd5e71cf069d ("[PATCH] Fix back descriptors")
'W' (and 'X' for split) had been added to valid specs as a side effect of
remap action support ('A') in commit a8f30e64d4d3 ("[PATCH] Add support
for remap actions").

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 blkparse_fmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index c42e6d7b7219..c110dad10b0b 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -11,7 +11,7 @@
 
 #include "blktrace.h"
 
-#define VALID_SPECS	"ABCDFGIMPQRSTUWX"
+#define VALID_SPECS	"ABCDFGIMPQRSTUX"
 
 #define HEADER		"%D %2c %8s %5T.%9t %5p %2a %3d "
 
-- 
2.14.2

