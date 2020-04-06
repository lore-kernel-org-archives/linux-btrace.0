From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 06 Apr 2020 14:09:15 +0000
Subject: [PATCH 3/3] blkparse: Fix up the sector and length of split completions
Message-Id: <20200406140915.109022-4-agruenba@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

When a split io completes, the sector and length of the completion refer to the
last split of the original request.  This makes reading the blkparse output
difficult, so fix up the sector and length to match the original request when
we can (that is, when --track-ios is enabled).

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 blkparse.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/blkparse.c b/blkparse.c
index c31a5c2..f75e724 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -265,6 +265,7 @@ struct io_track {
 	struct rb_node rb_node;
 
 	struct process_pid_map *ppm;
+	__u64 start_sector;
 	__u64 sector;
 	unsigned long long allocation_time;
 	unsigned long long queue_time;
@@ -987,6 +988,7 @@ static struct io_track *find_track(struct per_dev_info *pdi, pid_t pid,
 		iot->ppm = find_ppm(pid);
 		if (!iot->ppm)
 			iot->ppm = add_ppm_hash(pid, "unknown");
+		iot->start_sector = sector;
 		iot->sector = sector;
 		track_rb_insert(pdi, iot);
 	}
@@ -1042,6 +1044,27 @@ static void log_track_queue(struct per_dev_info *pdi, struct blk_io_trace *t)
 	iot->dispatch_time = t->time;
 }
 
+static void log_track_split(struct per_dev_info *pdi, struct blk_io_trace *t)
+{
+	struct io_track *iot;
+
+	if (!track_ios)
+		return;
+
+	/*
+	 * With a split request, the start sector of the associated completion
+	 * will be the start sector of the last split that makes up the
+	 * request.  If we can't find the request here, this probably means
+	 * that we're splitting a request that isn't such a last split.
+	 */
+	iot = __find_track(pdi, t->sector);
+	if (iot) {
+		rb_erase(&iot->rb_node, &pdi->rb_track);
+		iot->sector += t_sec(t);
+		track_rb_insert(pdi, iot);
+	}
+}
+
 /*
  * return time between rq allocation and insertion
  */
@@ -1134,6 +1157,16 @@ static unsigned long long log_track_complete(struct per_dev_info *pdi,
 	iot->completion_time = t->time;
 	elapsed = iot->completion_time - iot->dispatch_time;
 
+	if (track_ios) {
+		/*
+		 * When a split io completes, the sector and length of the
+		 * completion refer to the last split of the original request.
+		 * Fix that up to match the original request if we can.
+		 */
+		t->bytes += (t->sector - iot->start_sector) << 9;
+		t->sector = iot->start_sector;
+	}
+
 	if (per_process_stats) {
 		struct per_process_info *ppi = find_ppi(iot->ppm->pid);
 		int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
@@ -1612,6 +1645,7 @@ static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
 			log_unplug(pci, t, "UT");
 			break;
 		case __BLK_TA_SPLIT:
+			log_track_split(pdi, t);
 			log_split(pci, t, "X");
 			break;
 		case __BLK_TA_BOUNCE:
-- 
2.25.1
