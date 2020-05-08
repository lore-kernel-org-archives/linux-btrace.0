From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 08 May 2020 12:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20200508120002.62FE61BC0195@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit db4f6340e04716285ea56fe26d76381c3adabe58:

  btt_plot.py: Use `with open() as ...` context manager (2020-03-20 15:53:50 -0600)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to e81829a565162d41e2f551dc5e0f74f22f319554:

  blkparse: Fix up the sector and length of split completions (2020-05-07 12:22:37 -0600)

----------------------------------------------------------------
Andreas Gruenbacher (4):
      blkparse: Fix device in event tracking error messages
      blkparse: Allow request tracking on non md/dm devices
      blkparse: Initialize and test for undefined request tracking timestamps
      blkparse: Fix up the sector and length of split completions

 blkparse.c | 169 +++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 130 insertions(+), 39 deletions(-)

---

Diff of recent changes:

diff --git a/blkparse.c b/blkparse.c
index 28bdf15..796059b 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -25,6 +25,7 @@
 #include <stdio.h>
 #include <fcntl.h>
 #include <stdlib.h>
+#include <stdarg.h>
 #include <string.h>
 #include <getopt.h>
 #include <errno.h>
@@ -261,17 +262,21 @@ static struct trace *t_alloc_list;
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
@@ -326,6 +331,21 @@ static int have_drv_data = 0;
 #define CPU_IDX(cpu)	((cpu) / CPUS_PER_LONG)
 #define CPU_BIT(cpu)	((cpu) & (CPUS_PER_LONG - 1))
 
+static void io_warn_unless(struct blk_io_trace *t, int condition,
+			   const char *fmt, ...)
+{
+	va_list ap;
+
+	if (condition)
+		return;
+	va_start(ap, fmt);
+	printf("(%d,%d) request %llu + %u: ",
+	       MAJOR(t->device), MINOR(t->device),
+	       t->sector, t->bytes);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+}
+
 static void output_binary(void *buf, int len)
 {
 	if (dump_binary) {
@@ -976,6 +996,11 @@ static struct io_track *__find_track(struct per_dev_info *pdi, __u64 sector)
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
@@ -983,10 +1008,19 @@ static struct io_track *find_track(struct per_dev_info *pdi, pid_t pid,
 
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
 		track_rb_insert(pdi, iot);
 	}
@@ -1006,7 +1040,7 @@ static void log_track_frontmerge(struct per_dev_info *pdi,
 	if (!iot) {
 		if (verbose)
 			fprintf(stderr, "merge not found for (%d,%d): %llu\n",
-				MAJOR(pdi->dev), MINOR(pdi->dev),
+				MAJOR(t->device), MINOR(t->device),
 				(unsigned long long) t->sector + t_sec(t));
 		return;
 	}
@@ -1019,19 +1053,16 @@ static void log_track_frontmerge(struct per_dev_info *pdi,
 static void log_track_getrq(struct per_dev_info *pdi, struct blk_io_trace *t)
 {
 	struct io_track *iot;
+	struct io_track_req *req;
 
 	if (!track_ios)
 		return;
 
 	iot = find_track(pdi, t->pid, t->sector);
-	iot->allocation_time = t->time;
-}
-
-static inline int is_remapper(struct per_dev_info *pdi)
-{
-	int major = MAJOR(pdi->dev);
-
-	return (major = 253 || major = 9);
+	req = iot->req;
+	io_warn_unless(t, req->allocation_time = -1ULL,
+		       "confused about %s time", "allocation");
+	req->allocation_time = t->time;
 }
 
 /*
@@ -1041,14 +1072,34 @@ static inline int is_remapper(struct per_dev_info *pdi)
 static void log_track_queue(struct per_dev_info *pdi, struct blk_io_trace *t)
 {
 	struct io_track *iot;
+	struct io_track_req *req;
 
 	if (!track_ios)
 		return;
-	if (!is_remapper(pdi))
-		return;
 
 	iot = find_track(pdi, t->pid, t->sector);
-	iot->dispatch_time = t->time;
+	req = iot->req;
+	io_warn_unless(t, req->dispatch_time = -1ULL,
+		       "confused about %s time", "dispatch");
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
@@ -1059,20 +1110,24 @@ static unsigned long long log_track_insert(struct per_dev_info *pdi,
 {
 	unsigned long long elapsed;
 	struct io_track *iot;
+	struct io_track_req *req;
 
 	if (!track_ios)
 		return -1;
 
 	iot = find_track(pdi, t->pid, t->sector);
-	iot->queue_time = t->time;
+	req = iot->req;
+	io_warn_unless(t, req->queue_time = -1ULL,
+		       "confused about %s time", "queue");
+	req->queue_time = t->time;
 
-	if (!iot->allocation_time)
+	if (req->allocation_time = -1ULL)
 		return -1;
 
-	elapsed = iot->queue_time - iot->allocation_time;
+	elapsed = req->queue_time - req->allocation_time;
 
 	if (per_process_stats) {
-		struct per_process_info *ppi = find_ppi(iot->ppm->pid);
+		struct per_process_info *ppi = find_ppi(req->ppm->pid);
 		int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
 
 		if (ppi && elapsed > ppi->longest_allocation_wait[w])
@@ -1088,8 +1143,9 @@ static unsigned long long log_track_insert(struct per_dev_info *pdi,
 static unsigned long long log_track_issue(struct per_dev_info *pdi,
 					  struct blk_io_trace *t)
 {
-	unsigned long long elapsed;
+	unsigned long long elapsed = -1ULL;
 	struct io_track *iot;
+	struct io_track_req *req;
 
 	if (!track_ios)
 		return -1;
@@ -1100,16 +1156,20 @@ static unsigned long long log_track_issue(struct per_dev_info *pdi,
 	if (!iot) {
 		if (verbose)
 			fprintf(stderr, "issue not found for (%d,%d): %llu\n",
-				MAJOR(pdi->dev), MINOR(pdi->dev),
+				MAJOR(t->device), MINOR(t->device),
 				(unsigned long long) t->sector);
 		return -1;
 	}
 
-	iot->dispatch_time = t->time;
-	elapsed = iot->dispatch_time - iot->queue_time;
+	req = iot->req;
+	io_warn_unless(t, req->dispatch_time = -1ULL,
+		       "confused about %s time", "dispatch");
+	req->dispatch_time = t->time;
+	if (req->queue_time != -1ULL)
+		elapsed = req->dispatch_time - req->queue_time;
 
-	if (per_process_stats) {
-		struct per_process_info *ppi = find_ppi(iot->ppm->pid);
+	if (elapsed != -1ULL && per_process_stats) {
+		struct per_process_info *ppi = find_ppi(req->ppm->pid);
 		int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
 
 		if (ppi && elapsed > ppi->longest_dispatch_wait[w])
@@ -1119,14 +1179,34 @@ static unsigned long long log_track_issue(struct per_dev_info *pdi,
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
 static unsigned long long log_track_complete(struct per_dev_info *pdi,
 					     struct blk_io_trace *t)
 {
-	unsigned long long elapsed;
-	struct io_track *iot;
+	unsigned long long elapsed = -1ULL;
+	struct io_track *iot, *next;
+	struct io_track_req *req;
 
 	if (!track_ios)
 		return -1;
@@ -1135,16 +1215,20 @@ static unsigned long long log_track_complete(struct per_dev_info *pdi,
 	if (!iot) {
 		if (verbose)
 			fprintf(stderr,"complete not found for (%d,%d): %llu\n",
-				MAJOR(pdi->dev), MINOR(pdi->dev),
+				MAJOR(t->device), MINOR(t->device),
 				(unsigned long long) t->sector);
 		return -1;
 	}
 
-	iot->completion_time = t->time;
-	elapsed = iot->completion_time - iot->dispatch_time;
+	req = iot->req;
+	io_warn_unless(t, req->completion_time = -1ULL,
+		       "confused about %s time", "completion");
+	req->completion_time = t->time;
+	if (req->dispatch_time != -1ULL)
+		elapsed = req->completion_time - req->dispatch_time;
 
-	if (per_process_stats) {
-		struct per_process_info *ppi = find_ppi(iot->ppm->pid);
+	if (elapsed != -1ULL && per_process_stats) {
+		struct per_process_info *ppi = find_ppi(req->ppm->pid);
 		int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
 
 		if (ppi && elapsed > ppi->longest_completion_wait[w])
@@ -1154,8 +1238,13 @@ static unsigned long long log_track_complete(struct per_dev_info *pdi,
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
@@ -1606,6 +1695,7 @@ static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
 		case __BLK_TA_COMPLETE:
 			if (pdi->cur_depth[w])
 				pdi->cur_depth[w]--;
+			fixup_complete(pdi, t);
 			account_c(t, pci, w, t->bytes);
 			log_complete(pdi, pci, t, "C");
 			break;
@@ -1621,6 +1711,7 @@ static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
 			log_unplug(pci, t, "UT");
 			break;
 		case __BLK_TA_SPLIT:
+			log_track_split(pdi, t);
 			log_split(pci, t, "X");
 			break;
 		case __BLK_TA_BOUNCE:
