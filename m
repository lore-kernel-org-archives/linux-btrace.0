From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 13 Apr 2020 19:01:50 +0000
Subject: [PATCH v2 2/4] blkparse: Allow request tracking on non md/dm devices
Message-Id: <20200413190153.86357-3-agruenba@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Fix queue to completion tracking on devices other than md/dm: without this fix,
enabling tracking with the -t option on a non-md/dm device leads to "complete
not found" errors.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 blkparse.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 0054d4f..c31a5c2 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -1027,13 +1027,6 @@ static void log_track_getrq(struct per_dev_info *pdi, struct blk_io_trace *t)
 	iot->allocation_time = t->time;
 }
 
-static inline int is_remapper(struct per_dev_info *pdi)
-{
-	int major = MAJOR(pdi->dev);
-
-	return (major == 253 || major == 9);
-}
-
 /*
  * for md/dm setups, the interesting cycle is Q -> C. So track queueing
  * time here, as dispatch time
@@ -1044,8 +1037,6 @@ static void log_track_queue(struct per_dev_info *pdi, struct blk_io_trace *t)
 
 	if (!track_ios)
 		return;
-	if (!is_remapper(pdi))
-		return;
 
 	iot = find_track(pdi, t->pid, t->sector);
 	iot->dispatch_time = t->time;
-- 
2.25.2
