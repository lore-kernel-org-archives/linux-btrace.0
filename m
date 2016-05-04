From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 04 May 2016 12:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20160504120002.2E4312C00AB@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit cbd4bc0a3f6386cd000cb842b9f1f6325e301623:

  btreplay: remove timestamps (2016-04-25 08:54:34 -0600)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to d1422556dbff03e982aeb2faf5893b4363621bee:

  btt/unplug_hist: fix bad memset (2016-05-03 08:34:50 -0600)

----------------------------------------------------------------
Jens Axboe (1):
      btt/unplug_hist: fix bad memset

 btt/unplug_hist.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

---

Diff of recent changes:

diff --git a/btt/unplug_hist.c b/btt/unplug_hist.c
index 89995de..be16b69 100644
--- a/btt/unplug_hist.c
+++ b/btt/unplug_hist.c
@@ -34,11 +34,11 @@ void *unplug_hist_alloc(struct d_info *dip)
 {
 	struct hist_bkt *hbp;
 
-	if (unplug_hist_name = NULL) return NULL;
+	if (unplug_hist_name = NULL)
+		return NULL;
 
-	hbp = malloc(sizeof(*hbp));
+	hbp = calloc(1, sizeof(*hbp));
 	hbp->dip = dip;
-	memset(hbp->hist, 0, NBKTS * sizeof(int));
 
 	return hbp;
 }
