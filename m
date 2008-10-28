From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Tue, 28 Oct 2008 16:07:57 +0000
Subject: [Patch 1/6] blkiomon: fix cross-arch data analysis issue
Message-Id: <1225210077.1060.29.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Martin Peschke <mpeschke@linux.vnet.ibm.com>

This fixes cross-arch issues. Binary data gathered on System z could not
be read on x86.

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>

---
 blkiomon.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/blkiomon.h
+++ b/blkiomon.h
@@ -40,7 +40,7 @@ struct blkiomon_stat {
 	__u64 write;
 	__u64 bidir;
 	__u32 device;
-};
+} __attribute__ ((packed));
 
 static struct histlog2 size_hist = {
 	.first = 0,


