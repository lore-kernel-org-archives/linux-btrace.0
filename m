From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Thu, 31 Jan 2008 18:23:12 +0000
Subject: Updated btt portion of the tree
Message-Id: <47A21210.3070007@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


[PATCH] Fixed excess bucket information for unplug histograms.

(Jens: the push worked OK...)

---
 btt/unplug_hist.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/btt/unplug_hist.c b/btt/unplug_hist.c
index 4971f31..aaa4c39 100644
--- a/btt/unplug_hist.c
+++ b/btt/unplug_hist.c
@@ -23,7 +23,7 @@
 #define BKT_WIDTH	5
 #define MAX_BKT		19
 #define EXCESS_BKT	20
-#define NBKTS		EXCESS_BKT
+#define NBKTS		(EXCESS_BKT + 1)
 
 struct hist_bkt {
 	__u32 dev;
@@ -56,7 +56,7 @@ void unplug_hist_add(struct io *u_iop)
 		struct hist_bkt *hbp = dip->unplug_hist_handle;
 
 		idx = (n_unplugs / BKT_WIDTH);
-		if (idx > MAX_BKT)
+		if (idx > EXCESS_BKT)
 			idx = EXCESS_BKT;
 
 		assert((0 <= idx) && (idx <= EXCESS_BKT));
-- 
1.5.2.5

