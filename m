From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 06 Apr 2020 14:09:13 +0000
Subject: [PATCH 1/3] blkparse: Fix device in event tracking error messages
Message-Id: <20200406140915.109022-2-agruenba@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

For some reason, dev in struct per_dev_info isn't set in the log_track_
functions, and so the error messages report (0,0) as the device.  Fix by using
device in struct blk_io_trace instead.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 blkparse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 28bdf15..0054d4f 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -1006,7 +1006,7 @@ static void log_track_frontmerge(struct per_dev_info *pdi,
 	if (!iot) {
 		if (verbose)
 			fprintf(stderr, "merge not found for (%d,%d): %llu\n",
-				MAJOR(pdi->dev), MINOR(pdi->dev),
+				MAJOR(t->device), MINOR(t->device),
 				(unsigned long long) t->sector + t_sec(t));
 		return;
 	}
@@ -1100,7 +1100,7 @@ static unsigned long long log_track_issue(struct per_dev_info *pdi,
 	if (!iot) {
 		if (verbose)
 			fprintf(stderr, "issue not found for (%d,%d): %llu\n",
-				MAJOR(pdi->dev), MINOR(pdi->dev),
+				MAJOR(t->device), MINOR(t->device),
 				(unsigned long long) t->sector);
 		return -1;
 	}
@@ -1135,7 +1135,7 @@ static unsigned long long log_track_complete(struct per_dev_info *pdi,
 	if (!iot) {
 		if (verbose)
 			fprintf(stderr,"complete not found for (%d,%d): %llu\n",
-				MAJOR(pdi->dev), MINOR(pdi->dev),
+				MAJOR(t->device), MINOR(t->device),
 				(unsigned long long) t->sector);
 		return -1;
 	}
-- 
2.25.1
