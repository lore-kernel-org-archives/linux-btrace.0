From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Mon, 20 Apr 2009 14:07:11 +0000
Subject: [Patch] fix off-by-one issues in blkiomon.h
Message-Id: <1240236431.4039.5.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Martin Peschke <mpeschke@linux.vnet.ibm.com>

Fix two off-by-one issues. Last bucket of histogram was ommitted by mistake
when being converted to big-endian or when being merged with another bucket.

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>

---
 stats.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/stats.h
+++ b/stats.h
@@ -124,7 +124,7 @@ static inline void histlog2_merge(struct
 {
 	int i;
 
-	for (i = 0; i < h->num - 1; i++)
+	for (i = 0; i < h->num; i++)
 		dst[i] += src[i];
 }
 
@@ -132,7 +132,7 @@ static inline void histlog2_to_be(__u32 
 {
 	int i;
 
-	for (i = 0; i < h->num - 1; i++)
+	for (i = 0; i < h->num; i++)
 		a[i] = cpu_to_be32(a[i]);
 }
 


