From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Wed, 18 Apr 2007 12:23:37 +0000
Subject: [BTT PATCH] Fix unplug histogram assignments
Message-Id: <46260DC9.6010802@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010608090108090600010305"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------010608090108090600010305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------010608090108090600010305
Content-Type: text/plain;
 name="fix-up-hist"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-up-hist"

From: Alan D. Brunelle <Alan.Brunelle@hp.com>

Fix unplug histogram placement.

Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>
---

 btt/unplug_hist.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/btt/unplug_hist.c b/btt/unplug_hist.c
index 03b009b..4971f31 100644
--- a/btt/unplug_hist.c
+++ b/btt/unplug_hist.c
@@ -30,8 +30,6 @@ struct hist_bkt {
 	int hist[NBKTS * sizeof(int)];
 };
 
-static struct file_info *unplug_hist_files = NULL;
-
 void *unplug_hist_init(__u32 device)
 {
 	struct hist_bkt *hbp;
@@ -54,9 +52,12 @@ void unplug_hist_add(struct io *u_iop)
 	dip = __dip_find(u_iop->t.device);
 	if (dip && dip->unplug_hist_handle) {
 		__u64 *val = u_iop->pdu;
-		int n_unplugs = be64_to_cpu(*val);
-		struct hist_bkt * hbp = dip->unplug_hist_handle;
-		int idx = (n_unplugs / BKT_WIDTH) <= MAX_BKT ?: EXCESS_BKT;
+		int idx, n_unplugs = be64_to_cpu(*val);
+		struct hist_bkt *hbp = dip->unplug_hist_handle;
+
+		idx = (n_unplugs / BKT_WIDTH);
+		if (idx > MAX_BKT)
+			idx = EXCESS_BKT;
 
 		assert((0 <= idx) && (idx <= EXCESS_BKT));
 		hbp->hist[idx]++;

--------------010608090108090600010305--
