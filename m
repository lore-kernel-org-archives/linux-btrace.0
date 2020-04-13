From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 13 Apr 2020 19:01:51 +0000
Subject: [PATCH v2 3/4] blkparse: Initialize and test for undefined request tracking timestamps
Message-Id: <20200413190153.86357-4-agruenba@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Currently, event tracking timestamps aren't initialized at all even though some
places in the code assume that a value of 0 indicates 'undefined'.  However, 0
is the timestamp of the first event, so use -1ULL for 'undefined' instead.

In addition, make sure timestamps are only initialized once, and always check
if timestamps are defined before using them.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 blkparse.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index c31a5c2..fcc0ccd 100644
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
@@ -326,6 +327,21 @@ static int have_drv_data = 0;
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
@@ -988,6 +1004,10 @@ static struct io_track *find_track(struct per_dev_info *pdi, pid_t pid,
 		if (!iot->ppm)
 			iot->ppm = add_ppm_hash(pid, "unknown");
 		iot->sector = sector;
+		iot->allocation_time = -1ULL;
+		iot->queue_time = -1ULL;
+		iot->dispatch_time = -1ULL;
+		iot->completion_time = -1ULL;
 		track_rb_insert(pdi, iot);
 	}
 
@@ -1024,6 +1044,8 @@ static void log_track_getrq(struct per_dev_info *pdi, struct blk_io_trace *t)
 		return;
 
 	iot = find_track(pdi, t->pid, t->sector);
+	io_warn_unless(t, iot->allocation_time == -1ULL,
+		       "confused about %s time", "allocation");
 	iot->allocation_time = t->time;
 }
 
@@ -1039,6 +1061,8 @@ static void log_track_queue(struct per_dev_info *pdi, struct blk_io_trace *t)
 		return;
 
 	iot = find_track(pdi, t->pid, t->sector);
+	io_warn_unless(t, iot->dispatch_time == -1ULL,
+		       "confused about %s time", "dispatch");
 	iot->dispatch_time = t->time;
 }
 
@@ -1055,9 +1079,11 @@ static unsigned long long log_track_insert(struct per_dev_info *pdi,
 		return -1;
 
 	iot = find_track(pdi, t->pid, t->sector);
+	io_warn_unless(t, iot->queue_time == -1ULL,
+		       "confused about %s time", "queue");
 	iot->queue_time = t->time;
 
-	if (!iot->allocation_time)
+	if (iot->allocation_time == -1ULL)
 		return -1;
 
 	elapsed = iot->queue_time - iot->allocation_time;
@@ -1079,7 +1105,7 @@ static unsigned long long log_track_insert(struct per_dev_info *pdi,
 static unsigned long long log_track_issue(struct per_dev_info *pdi,
 					  struct blk_io_trace *t)
 {
-	unsigned long long elapsed;
+	unsigned long long elapsed = -1ULL;
 	struct io_track *iot;
 
 	if (!track_ios)
@@ -1096,10 +1122,13 @@ static unsigned long long log_track_issue(struct per_dev_info *pdi,
 		return -1;
 	}
 
+	io_warn_unless(t, iot->dispatch_time == -1ULL,
+		       "confused about %s time", "dispatch");
 	iot->dispatch_time = t->time;
-	elapsed = iot->dispatch_time - iot->queue_time;
+	if (iot->queue_time != -1ULL)
+		elapsed = iot->dispatch_time - iot->queue_time;
 
-	if (per_process_stats) {
+	if (elapsed != -1ULL && per_process_stats) {
 		struct per_process_info *ppi = find_ppi(iot->ppm->pid);
 		int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
 
@@ -1116,7 +1145,7 @@ static unsigned long long log_track_issue(struct per_dev_info *pdi,
 static unsigned long long log_track_complete(struct per_dev_info *pdi,
 					     struct blk_io_trace *t)
 {
-	unsigned long long elapsed;
+	unsigned long long elapsed = -1ULL;
 	struct io_track *iot;
 
 	if (!track_ios)
@@ -1131,10 +1160,13 @@ static unsigned long long log_track_complete(struct per_dev_info *pdi,
 		return -1;
 	}
 
+	io_warn_unless(t, iot->completion_time == -1ULL,
+		       "confused about %s time", "completion");
 	iot->completion_time = t->time;
-	elapsed = iot->completion_time - iot->dispatch_time;
+	if (iot->dispatch_time != -1ULL)
+		elapsed = iot->completion_time - iot->dispatch_time;
 
-	if (per_process_stats) {
+	if (elapsed != -1ULL && per_process_stats) {
 		struct per_process_info *ppi = find_ppi(iot->ppm->pid);
 		int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
 
-- 
2.25.2
