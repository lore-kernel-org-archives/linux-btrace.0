From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Mon, 20 Apr 2009 14:05:18 +0000
Subject: [Patch] fix include statement in stats.h
Message-Id: <1240236318.4039.2.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Martin Peschke <mpeschke@linux.vnet.ibm.com>

Some endianess conversion macros have been moved and the corresponding
header file is gone. Need to adapt an include statement in stats.h. The
compiler did not complain because blkiomon.c accidently included blktrace.h
prior to stats.h. Introduced by blktrace rewrite which became version 2.

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>

---
 stats.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/stats.h
+++ b/stats.h
@@ -23,7 +23,7 @@
 #define STATS_H
 
 #include <linux/types.h>
-#include "endian.h"
+#include "blktrace.h"
 
 struct minmax {
 	__u64 min;


