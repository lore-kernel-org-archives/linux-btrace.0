From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Tue, 28 Oct 2008 16:08:02 +0000
Subject: [Patch 2/6] blkiomon: fix unit in histogram output
Message-Id: <1225210083.1060.30.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Martin Peschke <mpeschke@linux.vnet.ibm.com>

Fix unit of request sizes as printed in histogram (it's bytes not kilobytes).

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>

---
 blkiomon.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/blkiomon.h
+++ b/blkiomon.h
@@ -98,8 +98,8 @@ static inline void blkiomon_stat_print(F
 		(unsigned long)p->bidir);
 	minmax_print(fp, "sizes", &p->size_mm);
 	minmax_print(fp, "d2c", &p->d2c_mm);
-	histlog2_print(fp, "sizes histogram (in kB)", p->size_hist, &size_hist);
-	histlog2_print(fp, "d2c histogram (in usec)", p->d2c_hist, &d2c_hist);
+	histlog2_print(fp, "sizes histogram (bytes)", p->size_hist, &size_hist);
+	histlog2_print(fp, "d2c histogram (usec)", p->d2c_hist, &d2c_hist);
 }
 
 #endif


