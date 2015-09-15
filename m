From: Khem Raj <raj.khem@gmail.com>
Date: Tue, 15 Sep 2015 00:05:21 +0000
Subject: [PATCH] include sys/types.h for dev_t definition
Message-Id: <1442275521-130450-1-git-send-email-raj.khem@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Avoids the build failures when sys/types.h does not get included
indirectly through other headers.

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 blktrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/blktrace.h b/blktrace.h
index 380aec7..944fc08 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -5,6 +5,7 @@
 #include <limits.h>
 #include <byteswap.h>
 #include <endian.h>
+#include <sys/types.h>
 
 #include "blktrace_api.h"
 #include "rbtree.h"
-- 
2.5.2

