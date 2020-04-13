From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 13 Apr 2020 19:01:52 +0000
Subject: [PATCH v2 4/4] blkparse: Fix up the sector and length of split completions
Message-Id: <20200413190153.86357-5-agruenba@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

When a split io completes, the sector and length of the completion event refer
to the last part of the original request.  This is in conflict with the
blkparse manual page, makes the blkparse output difficult to read, and leads to
incorrect statistics.  Fix up the sector and length of split completion events
to match the original request.

To achieve that, slightly extend the existing event tracking infrastructure to
track all parts of a split request.  We could almost get by tracking only the
last part of a split, but that wouldn't quite work correctly for splits of
splits.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 blkparse.c | 136 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 102 insertions(+), 34 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index fcc0ccd..796059b 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -262,17 +262,21 @@ static struct trace *t_alloc_list;
 /*
  * for tracking individual ios
  */
-struct io_track {
-	struct rb_node rb_node;
-
+struct io_track_req {
 	struct process_pid_map *ppm;
-	__u64 sector;
 	unsigned long long allocation_time;
 	unsigned long long queue_time;
 	unsigned long long dispatch_time;
 	unsigned long long completion_time;
 };
 
+struct io_track {
+	struct rb_node rb_node;
+	struct io_track_req *req;
+	struct io_track *next;
+	__u64 sector;
+};
+
 static int ndevices;
 static struct per_dev_info *devices;
 static char *get_dev_name(struct per_dev_info *, char *, int);
@@ -992,6 +996,11 @@ static struct io_track *__find_track(struct per_dev_info *pdi, __u64 sector)
 	return NULL;
 }
 
+static inline struct io_track *first_iot(struct io_track_req *req)
+{
+	return (struct io_track *)(req + 1);
+}
+
 static struct io_track *find_track(struct per_dev_info *pdi, pid_t pid,
 				   __u64 sector)
 {
@@ -999,15 +1008,20 @@ static struct io_track *find_track(struct per_dev_info *pdi, pid_t pid,
 
 	iot = __find_track(pdi, sector);
 	if (!iot) {
-		iot = malloc(sizeof(*iot));
-		iot->ppm = find_ppm(pid);
-		if (!iot->ppm)
-			iot->ppm = add_ppm_hash(pid, "unknown");
+		struct io_track_req *req;
+
+		req = malloc(sizeof(*req) + sizeof(*iot));
+		req->ppm = find_ppm(pid);
+		if (!req->ppm)
+			req->ppm = add_ppm_hash(pid, "unknown");
+		req->allocation_time = -1ULL;
+		req->queue_time = -1ULL;
+		req->dispatch_time = -1ULL;
+		req->completion_time = -1ULL;
+		iot = first_iot(req);
+		iot->req = req;
+		iot->next = NULL;
 		iot->sector = sector;
-		iot->allocation_time = -1ULL;
-		iot->queue_time = -1ULL;
-		iot->dispatch_time = -1ULL;
-		iot->completion_time = -1ULL;
 		track_rb_insert(pdi, iot);
 	}
 
@@ -1039,14 +1053,16 @@ static void log_track_frontmerge(struct per_dev_info *pdi,
 static void log_track_getrq(struct per_dev_info *pdi, struct blk_io_trace *t)
 {
 	struct io_track *iot;
+	struct io_track_req *req;
 
 	if (!track_ios)
 		return;
 
 	iot = find_track(pdi, t->pid, t->sector);
-	io_warn_unless(t, iot->allocation_time == -1ULL,
+	req = iot->req;
+	io_warn_unless(t, req->allocation_time == -1ULL,
 		       "confused about %s time", "allocation");
-	iot->allocation_time = t->time;
+	req->allocation_time = t->time;
 }
 
 /*
@@ -1056,14 +1072,34 @@ static void log_track_getrq(struct per_dev_info *pdi, struct blk_io_trace *t)
 static void log_track_queue(struct per_dev_info *pdi, struct blk_io_trace *t)
 {
 	struct io_track *iot;
+	struct io_track_req *req;
 
 	if (!track_ios)
 		return;
 
 	iot = find_track(pdi, t->pid, t->sector);
-	io_warn_unless(t, iot->dispatch_time == -1ULL,
+	req = iot->req;
+	io_warn_unless(t, req->dispatch_time == -1ULL,
 		       "confused about %s time", "dispatch");
-	iot->dispatch_time = t->time;
+	req->dispatch_time = t->time;
+}
+
+static void log_track_split(struct per_dev_info *pdi, struct blk_io_trace *t)
+{
+	struct io_track *iot, *split;
+
+	/*
+	 * With a split request, the completion event will refer to the last
+	 * part of the original request, but other events might refer to other
+	 * parts.
+	 */
+	iot = find_track(pdi, t->pid, t->sector);
+	split = malloc(sizeof(*iot));
+	split->req = iot->req;
+	split->next = iot->next;
+	iot->next = split;
+	split->sector = iot->sector + t_sec(t);
+	track_rb_insert(pdi, split);
 }
 
 /*
@@ -1074,22 +1110,24 @@ static unsigned long long log_track_insert(struct per_dev_info *pdi,
 {
 	unsigned long long elapsed;
 	struct io_track *iot;
+	struct io_track_req *req;
 
 	if (!track_ios)
 		return -1;
 
 	iot = find_track(pdi, t->pid, t->sector);
-	io_warn_unless(t, iot->queue_time == -1ULL,
+	req = iot->req;
+	io_warn_unless(t, req->queue_time == -1ULL,
 		       "confused about %s time", "queue");
-	iot->queue_time = t->time;
+	req->queue_time = t->time;
 
-	if (iot->allocation_time == -1ULL)
+	if (req->allocation_time == -1ULL)
 		return -1;
 
-	elapsed = iot->queue_time - iot->allocation_time;
+	elapsed = req->queue_time - req->allocation_time;
 
 	if (per_process_stats) {
-		struct per_process_info *ppi = find_ppi(iot->ppm->pid);
+		struct per_process_info *ppi = find_ppi(req->ppm->pid);
 		int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
 
 		if (ppi && elapsed > ppi->longest_allocation_wait[w])
@@ -1107,6 +1145,7 @@ static unsigned long long log_track_issue(struct per_dev_info *pdi,
 {
 	unsigned long long elapsed = -1ULL;
 	struct io_track *iot;
+	struct io_track_req *req;
 
 	if (!track_ios)
 		return -1;
@@ -1122,14 +1161,15 @@ static unsigned long long log_track_issue(struct per_dev_info *pdi,
 		return -1;
 	}
 
-	io_warn_unless(t, iot->dispatch_time == -1ULL,
+	req = iot->req;
+	io_warn_unless(t, req->dispatch_time == -1ULL,
 		       "confused about %s time", "dispatch");
-	iot->dispatch_time = t->time;
-	if (iot->queue_time != -1ULL)
-		elapsed = iot->dispatch_time - iot->queue_time;
+	req->dispatch_time = t->time;
+	if (req->queue_time != -1ULL)
+		elapsed = req->dispatch_time - req->queue_time;
 
 	if (elapsed != -1ULL && per_process_stats) {
-		struct per_process_info *ppi = find_ppi(iot->ppm->pid);
+		struct per_process_info *ppi = find_ppi(req->ppm->pid);
 		int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
 
 		if (ppi && elapsed > ppi->longest_dispatch_wait[w])
@@ -1139,6 +1179,25 @@ static unsigned long long log_track_issue(struct per_dev_info *pdi,
 	return elapsed;
 }
 
+static void fixup_complete(struct per_dev_info *pdi, struct blk_io_trace *t)
+{
+	struct io_track *iot;
+	__u64 start_sector;
+
+	iot = __find_track(pdi, t->sector);
+	if (!iot)
+		return;
+
+	/*
+	 * When a split io completes, the sector and length of the completion
+	 * refer to the last part of the original request.  Fix the sector and
+	 * length of the complete event to match the original request.
+	 */
+	start_sector = first_iot(iot->req)->sector;
+	t->bytes += (t->sector - start_sector) << 9;
+	t->sector = start_sector;
+}
+
 /*
  * return time between dispatch and complete
  */
@@ -1146,7 +1205,8 @@ static unsigned long long log_track_complete(struct per_dev_info *pdi,
 					     struct blk_io_trace *t)
 {
 	unsigned long long elapsed = -1ULL;
-	struct io_track *iot;
+	struct io_track *iot, *next;
+	struct io_track_req *req;
 
 	if (!track_ios)
 		return -1;
@@ -1160,14 +1220,15 @@ static unsigned long long log_track_complete(struct per_dev_info *pdi,
 		return -1;
 	}
 
-	io_warn_unless(t, iot->completion_time == -1ULL,
+	req = iot->req;
+	io_warn_unless(t, req->completion_time == -1ULL,
 		       "confused about %s time", "completion");
-	iot->completion_time = t->time;
-	if (iot->dispatch_time != -1ULL)
-		elapsed = iot->completion_time - iot->dispatch_time;
+	req->completion_time = t->time;
+	if (req->dispatch_time != -1ULL)
+		elapsed = req->completion_time - req->dispatch_time;
 
 	if (elapsed != -1ULL && per_process_stats) {
-		struct per_process_info *ppi = find_ppi(iot->ppm->pid);
+		struct per_process_info *ppi = find_ppi(req->ppm->pid);
 		int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
 
 		if (ppi && elapsed > ppi->longest_completion_wait[w])
@@ -1177,8 +1238,13 @@ static unsigned long long log_track_complete(struct per_dev_info *pdi,
 	/*
 	 * kill the trace, we don't need it after completion
 	 */
-	rb_erase(&iot->rb_node, &pdi->rb_track);
-	free(iot);
+	for (iot = first_iot(req); iot; iot = next) {
+		next = iot->next;
+		rb_erase(&iot->rb_node, &pdi->rb_track);
+		if (iot != first_iot(req))
+			free(iot);
+	}
+	free(req);
 
 	return elapsed;
 }
@@ -1629,6 +1695,7 @@ static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
 		case __BLK_TA_COMPLETE:
 			if (pdi->cur_depth[w])
 				pdi->cur_depth[w]--;
+			fixup_complete(pdi, t);
 			account_c(t, pci, w, t->bytes);
 			log_complete(pdi, pci, t, "C");
 			break;
@@ -1644,6 +1711,7 @@ static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
 			log_unplug(pci, t, "UT");
 			break;
 		case __BLK_TA_SPLIT:
+			log_track_split(pdi, t);
 			log_split(pci, t, "X");
 			break;
 		case __BLK_TA_BOUNCE:
-- 
2.25.2
