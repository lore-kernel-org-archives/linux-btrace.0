From: Andrew Price <anprice@redhat.com>
Date: Thu, 25 Sep 2014 21:04:13 +0000
Subject: [PATCH 1/4] iowatcher: Add iowatcher to .gitignore
Message-Id: <1411679056-32596-2-git-send-email-anprice@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Andrew Price <anprice@redhat.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 2436e34..87a5d2d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -11,3 +11,4 @@ verify_blkparse
 btt/btt
 btt/doc/btt.pdf
 doc/blktrace.pdf
+iowatcher/iowatcher
-- 
1.9.3

