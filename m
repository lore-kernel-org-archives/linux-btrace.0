From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:58:10 +0000
Subject: [blktrace-tools RFC PATCH 5/5] blkparse: add support for trace extension
Message-Id: <20190602165810.14817-6-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

This patch isolates the struct trace into separate header file.
We also add helper functions which are used in the following patch.
Since other tools like blkiomon can also share this structure make
this code available in the header file to avoid different copies.

Update blktrace tool to support the trace extensions. The new option
'-E' will allow blktrace to configure trace with newly introduced
IOCTLs for trace extensions. '-Y' and '-y' options are similar to
'-a' and '-A' but can now use the mask for additional operations
which are supported for trace-extension. For tracking the priority we
add '-P' along with the '-X' and '-x' to specify priority value and
mask.

Update blkparse format with the trace extension support so blkparse
now can now identify and dump the trace extension. The new function
fill_rwbs_ext() formats the trace string with newly added trace
categories. We encapsulate existing blk_trace and newly added
blk_trace_ext structure under struct trace and use the t_bit_xxx()
helpers to read the appropriate value based on whether extensions
are enabled or not. We also add the support for priority tracking
when trace extension is enabled.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 Makefile       |    2 +-
 blkparse.c     | 1072 +++++++++++++++++++++++++++++++++++-------------
 blkparse.h     |   78 ++++
 blkparse_fmt.c |  204 ++++++---
 blktrace.h     |    6 +-
 5 files changed, 1017 insertions(+), 345 deletions(-)
 create mode 100644 blkparse.h

diff --git a/Makefile b/Makefile
index 5917814..af90a45 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 CC	= gcc
 CFLAGS	= -Wall -O2 -g -W
 ALL_CFLAGS = $(CFLAGS) -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITSd
-PROGS	= blkparse blktrace verify_blkparse blkrawverify blkiomon
+PROGS	= blkparse blktrace #verify_blkparse blkrawverify blkiomon
 LIBS	= -lpthread
 SCRIPTS	= btrace
 SUBDIRS = btreplay btt iowatcher
diff --git a/blkparse.c b/blkparse.c
index 227cc44..36fe568 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -201,6 +201,42 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 'w'
 	},
+	{
+		.name = "act-mask-ext",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'y'
+	},
+	{
+		.name = "set-mask-ext",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'Y'
+	},
+	{
+		.name = "use-extensions",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'E'
+	},
+	{
+		.name = "track-priority",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'P'
+	},
+	{
+		.name = "prio-mask",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'x'
+	},
+	{
+		.name = "prio-set-mask",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'X'
+	},
 	{
 		.name = "verbose",
 		.has_arg = no_argument,
@@ -218,16 +254,6 @@ static struct option l_opts[] = {
 	}
 };
 
-/*
- * for sorting the displayed output
- */
-struct trace {
-	struct blk_io_trace *bit;
-	struct rb_node rb_node;
-	struct trace *next;
-	unsigned long read_sequence;
-};
-
 static struct rb_root rb_sort_root;
 static unsigned long rb_sort_entries;
 
@@ -237,6 +263,7 @@ static struct trace *trace_list;
  * allocation cache
  */
 static struct blk_io_trace *bit_alloc_list;
+static struct blk_io_trace_ext *bit_alloc_list_ext;
 static struct trace *t_alloc_list;
 
 /*
@@ -268,12 +295,16 @@ static unsigned long long stopwatch_start;	/* start from zero by default */
 static unsigned long long stopwatch_end = -1ULL;	/* "infinity" */
 static unsigned long read_sequence;
 
+static bool use_ext = false;
 static int per_process_stats;
 static int per_device_and_cpu_stats = 1;
 static int track_ios;
 static int ppi_hash_by_pid = 1;
 static int verbose;
 static unsigned int act_mask = -1U;
+static uint64_t act_mask_ext = -1ULL;
+uint32_t blkparse_prio_mask = 0;
+bool blkparse_track_prio = false;
 static int stats_printed;
 static int bin_output_msgs = 1;
 int data_is_native = -1;
@@ -306,6 +337,14 @@ static int have_drv_data = 0;
 #define CPU_IDX(cpu)	((cpu) / CPUS_PER_LONG)
 #define CPU_BIT(cpu)	((cpu) & (CPUS_PER_LONG - 1))
 
+static inline bool is_write_trace(struct trace *t)
+{
+	if (t->use_ext)
+		return ((t->bit->action) & BLK_TC_ACT_EXT(BLK_TC_WRITE)) != 0;
+
+	return ((t->bit->action) & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
+}
+
 static void output_binary(void *buf, int len)
 {
 	if (dump_binary) {
@@ -572,53 +611,82 @@ static struct process_pid_map *add_ppm_hash(pid_t pid, const char *name)
 	return ppm;
 }
 
-static void handle_notify(struct blk_io_trace *bit)
+static void handle_notify(struct trace *t)
 {
-	void	*payload = (caddr_t) bit + sizeof(*bit);
+	void	*payload;
 	__u32	two32[2];
 
-	switch (bit->action) {
-	case BLK_TN_PROCESS:
-		add_ppm_hash(bit->pid, payload);
-		break;
-
-	case BLK_TN_TIMESTAMP:
-		if (bit->pdu_len != sizeof(two32))
-			return;
-		memcpy(two32, payload, sizeof(two32));
-		if (!data_is_native) {
-			two32[0] = be32_to_cpu(two32[0]);
-			two32[1] = be32_to_cpu(two32[1]);
-		}
-		start_timestamp = bit->time;
-		abs_start_time.tv_sec  = two32[0];
-		abs_start_time.tv_nsec = two32[1];
-		if (abs_start_time.tv_nsec < 0) {
-			abs_start_time.tv_sec--;
-			abs_start_time.tv_nsec += 1000000000;
+	if (t->use_ext)
+		payload = (caddr_t) t->bit_ext + sizeof(*(t->bit_ext));
+	else
+		payload = (caddr_t) t->bit + sizeof(*(t->bit));
+
+	if (use_ext) {
+		if (t_bit_act(t) = BLK_TN_PROCESS_EXT) {
+			add_ppm_hash(t_bit_pid(t), payload);
+		} else if (t_bit_act(t) = BLK_TN_TIMESTAMP_EXT) {
+			if (t_bit_pdu_len(t) != sizeof(two32))
+				return;
+			memcpy(two32, payload, sizeof(two32));
+			if (!data_is_native) {
+				two32[0] = be32_to_cpu(two32[0]);
+				two32[1] = be32_to_cpu(two32[1]);
+			}
+			start_timestamp = t_bit_time(t);
+			abs_start_time.tv_sec  = two32[0];
+			abs_start_time.tv_nsec = two32[1];
+			if (abs_start_time.tv_nsec < 0) {
+				abs_start_time.tv_sec--;
+				abs_start_time.tv_nsec += 1000000000;
+			}
+		} else if (t_bit_act(t) = BLK_TN_MESSAGE_EXT) {
+			if (t_bit_pdu_len(t) > 0) {
+				char msg[t_bit_pdu_len(t)+1];
+
+				memcpy(msg, (char *)payload, t_bit_pdu_len(t));
+				msg[t_bit_pdu_len(t)] = '\0';
+
+				fprintf(ofp,
+					"%3d,%-3d %2d %8s %5d.%09lu %5u %2s %3s %s\n",
+					MAJOR(t_bit_dev(t)), MINOR(t_bit_dev(t)),
+					t_bit_cpu(t), "0", (int) SECONDS(t_bit_time(t)),
+					(unsigned long) NANO_SECONDS(t_bit_time(t)),
+					0, "m", "N", msg);
+			}
 		}
-
-		break;
-
-	case BLK_TN_MESSAGE:
-		if (bit->pdu_len > 0) {
-			char msg[bit->pdu_len+1];
-
-			memcpy(msg, (char *)payload, bit->pdu_len);
-			msg[bit->pdu_len] = '\0';
-
-			fprintf(ofp,
-				"%3d,%-3d %2d %8s %5d.%09lu %5u %2s %3s %s\n",
-				MAJOR(bit->device), MINOR(bit->device),
-				bit->cpu, "0", (int) SECONDS(bit->time),
-				(unsigned long) NANO_SECONDS(bit->time),
-				0, "m", "N", msg);
+	} else {
+		if (t_bit_act(t) = BLK_TN_PROCESS) {
+			add_ppm_hash(t_bit_pid(t), payload);
+		} else if (t_bit_act(t) = BLK_TN_TIMESTAMP) {
+			if (t_bit_pdu_len(t) != sizeof(two32))
+				return;
+			memcpy(two32, payload, sizeof(two32));
+			if (!data_is_native) {
+				two32[0] = be32_to_cpu(two32[0]);
+				two32[1] = be32_to_cpu(two32[1]);
+			}
+			start_timestamp = t_bit_time(t);
+			abs_start_time.tv_sec  = two32[0];
+			abs_start_time.tv_nsec = two32[1];
+			if (abs_start_time.tv_nsec < 0) {
+				abs_start_time.tv_sec--;
+				abs_start_time.tv_nsec += 1000000000;
+			}
+		} else if (t_bit_act(t) = BLK_TN_MESSAGE) {
+			if (t_bit_pdu_len(t) > 0) {
+				char msg[t_bit_pdu_len(t)+1];
+
+				memcpy(msg, (char *)payload, t_bit_pdu_len(t));
+				msg[t_bit_pdu_len(t)] = '\0';
+
+				fprintf(ofp,
+					"%3d,%-3d %2d %8s %5d.%09lu %5u %2s %3s %s\n",
+					MAJOR(t_bit_dev(t)), MINOR(t_bit_dev(t)),
+					t_bit_cpu(t), "0", (int) SECONDS(t_bit_time(t)),
+					(unsigned long) NANO_SECONDS(t_bit_time(t)),
+					0, "m", "N", msg);
+			}
 		}
-		break;
-
-	default:
-		/* Ignore unknown notify events */
-		;
 	}
 }
 
@@ -763,6 +831,20 @@ static inline void bit_free(struct blk_io_trace *bit)
 		free(bit);
 }
 
+static inline void bit_free_ext(struct blk_io_trace_ext *bit)
+{
+	/* just use existing bit_alloc_cache for blk_io_trace_ext */
+	if (bit_alloc_cache < 1024 && !bit->pdu_len) {
+		/*
+		 * abuse a 64-bit field for a next pointer for the free item
+		 */
+		bit->time = (__u64) (unsigned long) bit_alloc_list_ext;
+		bit_alloc_list_ext = (struct blk_io_trace_ext *) bit;
+		bit_alloc_cache++;
+	} else
+		free(bit);
+}
+
 static inline struct blk_io_trace *bit_alloc(void)
 {
 	struct blk_io_trace *bit = bit_alloc_list;
@@ -777,20 +859,36 @@ static inline struct blk_io_trace *bit_alloc(void)
 	return malloc(sizeof(*bit));
 }
 
+static inline struct blk_io_trace_ext *bit_alloc_ext(void)
+{
+	struct blk_io_trace_ext *bit = bit_alloc_list_ext;
+
+	/* just use existing bit_alloc_cache for blk_io_trace_ext */
+	if (bit) {
+		bit_alloc_list_ext = (struct blk_io_trace_ext *) (unsigned long) \
+				 bit->time;
+		bit_alloc_cache--;
+		return bit;
+	}
+
+	return malloc(sizeof(*bit));
+}
+
 static inline void __put_trace_last(struct per_dev_info *pdi, struct trace *t)
 {
-	struct per_cpu_info *pci = get_cpu_info(pdi, t->bit->cpu);
+	struct per_cpu_info *pci = get_cpu_info(pdi, t_bit_cpu(t));
 
 	rb_erase(&t->rb_node, &pci->rb_last);
 	pci->rb_last_entries--;
 
-	bit_free(t->bit);
+	t->use_ext ? bit_free_ext(t->bit_ext) : bit_free(t->bit);
 	t_free(t);
 }
 
 static void put_trace(struct per_dev_info *pdi, struct trace *t)
 {
 	rb_erase(&t->rb_node, &rb_sort_root);
+
 	rb_sort_entries--;
 
 	trace_rb_insert_last(pdi, t);
@@ -806,19 +904,19 @@ static inline int trace_rb_insert(struct trace *t, struct rb_root *root)
 		parent = *p;
 
 		__t = rb_entry(parent, struct trace, rb_node);
-
-		if (t->bit->time < __t->bit->time)
+		if (t_bit_time(t) < t_bit_time(__t))
 			p = &(*p)->rb_left;
-		else if (t->bit->time > __t->bit->time)
+		else if (t_bit_time(t) > t_bit_time(__t))
 			p = &(*p)->rb_right;
-		else if (t->bit->device < __t->bit->device)
+		else if (t_bit_dev(t) < t_bit_dev(__t))
 			p = &(*p)->rb_left;
-		else if (t->bit->device > __t->bit->device)
+		else if (t_bit_dev(t) > t_bit_dev(__t))
 			p = &(*p)->rb_right;
-		else if (t->bit->sequence < __t->bit->sequence)
+		else if (t_bit_seq(t) < t_bit_seq(__t))
 			p = &(*p)->rb_left;
 		else	/* >= sequence */
 			p = &(*p)->rb_right;
+
 	}
 
 	rb_link_node(&t->rb_node, parent, p);
@@ -838,7 +936,7 @@ static inline int trace_rb_insert_sort(struct trace *t)
 
 static int trace_rb_insert_last(struct per_dev_info *pdi, struct trace *t)
 {
-	struct per_cpu_info *pci = get_cpu_info(pdi, t->bit->cpu);
+	struct per_cpu_info *pci = get_cpu_info(pdi, t_bit_cpu(t));
 
 	if (trace_rb_insert(t, &pci->rb_last))
 		return 1;
@@ -866,13 +964,13 @@ static struct trace *trace_rb_find(dev_t device, unsigned long sequence,
 		__t = rb_entry(n, struct trace, rb_node);
 		prev = n;
 
-		if (device < __t->bit->device)
+		if (device < t_bit_dev(__t))
 			n = n->rb_left;
-		else if (device > __t->bit->device)
+		else if (device > t_bit_dev(__t))
 			n = n->rb_right;
-		else if (sequence < __t->bit->sequence)
+		else if (sequence < t_bit_seq(__t))
 			n = n->rb_left;
-		else if (sequence > __t->bit->sequence)
+		else if (sequence > t_bit_seq(__t))
 			n = n->rb_right;
 		else
 			return __t;
@@ -891,8 +989,8 @@ static struct trace *trace_rb_find(dev_t device, unsigned long sequence,
 		while (((n = rb_next(prev)) != NULL) && max--) {
 			__t = rb_entry(n, struct trace, rb_node);
 
-			if (__t->bit->device = device &&
-			    __t->bit->sequence = sequence)
+			if (t_bit_dev(__t) = device &&
+			    t_bit_seq(__t) = sequence)
 				return __t;
 
 			prev = n;
@@ -974,37 +1072,37 @@ static struct io_track *find_track(struct per_dev_info *pdi, pid_t pid,
 	return iot;
 }
 
-static void log_track_frontmerge(struct per_dev_info *pdi,
-				 struct blk_io_trace *t)
+static void log_track_frontmerge(struct per_dev_info *pdi, struct trace *t)
 {
 	struct io_track *iot;
 
 	if (!track_ios)
 		return;
 
-	iot = __find_track(pdi, t->sector + t_sec(t));
+	iot = __find_track(pdi, t_bit_sec(t) + (t_bit_bytes(t) >> 9));
 	if (!iot) {
 		if (verbose)
 			fprintf(stderr, "merge not found for (%d,%d): %llu\n",
 				MAJOR(pdi->dev), MINOR(pdi->dev),
-				(unsigned long long) t->sector + t_sec(t));
+				(unsigned long long) t_bit_sec(t) +
+				(t_bit_bytes(t) >> 9));
 		return;
 	}
 
 	rb_erase(&iot->rb_node, &pdi->rb_track);
-	iot->sector -= t_sec(t);
+	iot->sector -= (t_bit_bytes(t) >> 9);
 	track_rb_insert(pdi, iot);
 }
 
-static void log_track_getrq(struct per_dev_info *pdi, struct blk_io_trace *t)
+static void log_track_getrq(struct per_dev_info *pdi, struct trace *t)
 {
 	struct io_track *iot;
 
 	if (!track_ios)
 		return;
 
-	iot = find_track(pdi, t->pid, t->sector);
-	iot->allocation_time = t->time;
+	iot = find_track(pdi, t_bit_pid(t), t_bit_sec(t));
+	iot->allocation_time = t_bit_time(t);
 }
 
 static inline int is_remapper(struct per_dev_info *pdi)
@@ -1018,7 +1116,7 @@ static inline int is_remapper(struct per_dev_info *pdi)
  * for md/dm setups, the interesting cycle is Q -> C. So track queueing
  * time here, as dispatch time
  */
-static void log_track_queue(struct per_dev_info *pdi, struct blk_io_trace *t)
+static void log_track_queue(struct per_dev_info *pdi, struct trace *t)
 {
 	struct io_track *iot;
 
@@ -1027,15 +1125,15 @@ static void log_track_queue(struct per_dev_info *pdi, struct blk_io_trace *t)
 	if (!is_remapper(pdi))
 		return;
 
-	iot = find_track(pdi, t->pid, t->sector);
-	iot->dispatch_time = t->time;
+	iot = find_track(pdi, t_bit_pid(t), t_bit_sec(t));
+	iot->dispatch_time = t_bit_time(t);
 }
 
 /*
  * return time between rq allocation and insertion
  */
 static unsigned long long log_track_insert(struct per_dev_info *pdi,
-					   struct blk_io_trace *t)
+					   struct trace *t)
 {
 	unsigned long long elapsed;
 	struct io_track *iot;
@@ -1043,8 +1141,8 @@ static unsigned long long log_track_insert(struct per_dev_info *pdi,
 	if (!track_ios)
 		return -1;
 
-	iot = find_track(pdi, t->pid, t->sector);
-	iot->queue_time = t->time;
+	iot = find_track(pdi, t_bit_pid(t), t_bit_sec(t));
+	iot->queue_time = t_bit_time(t);
 
 	if (!iot->allocation_time)
 		return -1;
@@ -1053,7 +1151,7 @@ static unsigned long long log_track_insert(struct per_dev_info *pdi,
 
 	if (per_process_stats) {
 		struct per_process_info *ppi = find_ppi(iot->ppm->pid);
-		int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
+		int w = is_write_trace(t);
 
 		if (ppi && elapsed > ppi->longest_allocation_wait[w])
 			ppi->longest_allocation_wait[w] = elapsed;
@@ -1066,31 +1164,37 @@ static unsigned long long log_track_insert(struct per_dev_info *pdi,
  * return time between queue and issue
  */
 static unsigned long long log_track_issue(struct per_dev_info *pdi,
-					  struct blk_io_trace *t)
+					  struct trace *t)
 {
 	unsigned long long elapsed;
 	struct io_track *iot;
 
 	if (!track_ios)
 		return -1;
-	if ((t->action & BLK_TC_ACT(BLK_TC_FS)) = 0)
-		return -1;
 
-	iot = __find_track(pdi, t->sector);
+	if (t->use_ext) {
+		if ((t->bit_ext->action & BLK_TC_ACT_EXT(BLK_TC_FS)) = 0)
+			return -1;
+	} else {
+		if ((t->bit->action & BLK_TC_ACT(BLK_TC_FS)) = 0)
+			return -1;
+	}
+
+	iot = __find_track(pdi, t_bit_sec(t));
 	if (!iot) {
 		if (verbose)
 			fprintf(stderr, "issue not found for (%d,%d): %llu\n",
 				MAJOR(pdi->dev), MINOR(pdi->dev),
-				(unsigned long long) t->sector);
+				(unsigned long long) t_bit_sec(t));
 		return -1;
 	}
 
-	iot->dispatch_time = t->time;
+	iot->dispatch_time = t_bit_time(t);
 	elapsed = iot->dispatch_time - iot->queue_time;
 
 	if (per_process_stats) {
 		struct per_process_info *ppi = find_ppi(iot->ppm->pid);
-		int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
+		int w = is_write_trace(t);
 
 		if (ppi && elapsed > ppi->longest_dispatch_wait[w])
 			ppi->longest_dispatch_wait[w] = elapsed;
@@ -1103,7 +1207,7 @@ static unsigned long long log_track_issue(struct per_dev_info *pdi,
  * return time between dispatch and complete
  */
 static unsigned long long log_track_complete(struct per_dev_info *pdi,
-					     struct blk_io_trace *t)
+					     struct trace *t)
 {
 	unsigned long long elapsed;
 	struct io_track *iot;
@@ -1111,21 +1215,21 @@ static unsigned long long log_track_complete(struct per_dev_info *pdi,
 	if (!track_ios)
 		return -1;
 
-	iot = __find_track(pdi, t->sector);
+	iot = __find_track(pdi, t_bit_sec(t));
 	if (!iot) {
 		if (verbose)
 			fprintf(stderr,"complete not found for (%d,%d): %llu\n",
 				MAJOR(pdi->dev), MINOR(pdi->dev),
-				(unsigned long long) t->sector);
+				(unsigned long long) t_bit_sec(t));
 		return -1;
 	}
 
-	iot->completion_time = t->time;
+	iot->completion_time = t_bit_time(t);
 	elapsed = iot->completion_time - iot->dispatch_time;
 
 	if (per_process_stats) {
 		struct per_process_info *ppi = find_ppi(iot->ppm->pid);
-		int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
+		int w = is_write_trace(t);
 
 		if (ppi && elapsed > ppi->longest_completion_wait[w])
 			ppi->longest_completion_wait[w] = elapsed;
@@ -1140,7 +1244,6 @@ static unsigned long long log_track_complete(struct per_dev_info *pdi,
 	return elapsed;
 }
 
-
 static struct io_stats *find_process_io_stats(pid_t pid)
 {
 	struct per_process_info *ppi = find_ppi(pid);
@@ -1167,62 +1270,61 @@ static char *get_dev_name(struct per_dev_info *pdi, char *buffer, int size)
 	return buffer;
 }
 
-static void check_time(struct per_dev_info *pdi, struct blk_io_trace *bit)
+static void check_time(struct per_dev_info *pdi, struct trace *t)
 {
-	unsigned long long this = bit->time;
+	unsigned long long this = t_bit_time(t);
 	unsigned long long last = pdi->last_reported_time;
 
 	pdi->backwards = (this < last) ? 'B' : ' ';
 	pdi->last_reported_time = this;
 }
 
-static inline void __account_m(struct io_stats *ios, struct blk_io_trace *t,
-			       int rw)
+static inline void __account_m(struct io_stats *ios, struct trace *t, int rw)
 {
 	if (rw) {
 		ios->mwrites++;
-		ios->mwrite_kb += t_kb(t);
-		ios->mwrite_b += t_b(t);
+		ios->mwrite_kb += (t_bit_bytes(t) >> 10);
+		ios->mwrite_b += (t_bit_bytes(t) & 1023);
 	} else {
 		ios->mreads++;
-		ios->mread_kb += t_kb(t);
-		ios->mread_b += t_b(t);
+		ios->mread_kb += (t_bit_bytes(t) >> 10);
+		ios->mread_b += (t_bit_bytes(t) & 1023);
 	}
 }
 
-static inline void account_m(struct blk_io_trace *t, struct per_cpu_info *pci,
+static inline void account_m(struct trace *t, struct per_cpu_info *pci,
 			     int rw)
 {
 	__account_m(&pci->io_stats, t, rw);
 
 	if (per_process_stats) {
-		struct io_stats *ios = find_process_io_stats(t->pid);
+		struct io_stats *ios = find_process_io_stats(t_bit_pid(t));
 
 		__account_m(ios, t, rw);
 	}
 }
 
-static inline void __account_pc_queue(struct io_stats *ios,
-				      struct blk_io_trace *t, int rw)
+static inline void __account_pc_queue(struct io_stats *ios, struct trace *t,
+				      int rw)
 {
 	if (rw) {
 		ios->qwrites_pc++;
-		ios->qwrite_kb_pc += t_kb(t);
-		ios->qwrite_b_pc += t_b(t);
+		ios->qwrite_kb_pc += (t_bit_bytes(t) >> 10);
+		ios->qwrite_b_pc += (t_bit_bytes(t) & 1023);
 	} else {
 		ios->qreads_pc++;
-		ios->qread_kb += t_kb(t);
-		ios->qread_b_pc += t_b(t);
+		ios->qread_kb += (t_bit_bytes(t) >> 10);
+		ios->qread_b_pc += (t_bit_bytes(t) & 1023);
 	}
 }
 
-static inline void account_pc_queue(struct blk_io_trace *t,
+static inline void account_pc_queue(struct trace *t,
 				    struct per_cpu_info *pci, int rw)
 {
 	__account_pc_queue(&pci->io_stats, t, rw);
 
 	if (per_process_stats) {
-		struct io_stats *ios = find_process_io_stats(t->pid);
+		struct io_stats *ios = find_process_io_stats(t_bit_pid(t));
 
 		__account_pc_queue(ios, t, rw);
 	}
@@ -1242,39 +1344,40 @@ static inline void __account_pc_issue(struct io_stats *ios, int rw,
 	}
 }
 
-static inline void account_pc_issue(struct blk_io_trace *t,
+static inline void account_pc_issue(struct trace *t,
 				    struct per_cpu_info *pci, int rw)
 {
-	__account_pc_issue(&pci->io_stats, rw, t->bytes);
+	__account_pc_issue(&pci->io_stats, rw, t_bit_bytes(t));
 
 	if (per_process_stats) {
-		struct io_stats *ios = find_process_io_stats(t->pid);
+		struct io_stats *ios = find_process_io_stats(t_bit_pid(t));
 
-		__account_pc_issue(ios, rw, t->bytes);
+		__account_pc_issue(ios, rw, t_bit_bytes(t));
 	}
 }
 
-static inline void __account_pc_requeue(struct io_stats *ios,
-					struct blk_io_trace *t, int rw)
+static inline void __account_pc_requeue(struct io_stats *ios, struct trace *t,
+				      int rw)
 {
 	if (rw) {
 		ios->wrqueue_pc++;
-		ios->iwrite_kb_pc -= t_kb(t);
-		ios->iwrite_b_pc -= t_b(t);
+		ios->iwrite_kb_pc -= (t_bit_bytes(t) >> 10);
+		ios->iwrite_b_pc -= (t_bit_bytes(t) & 1023);
 	} else {
 		ios->rrqueue_pc++;
-		ios->iread_kb_pc -= t_kb(t);
-		ios->iread_b_pc -= t_b(t);
+		ios->iread_kb_pc -= (t_bit_bytes(t) >> 10);
+		ios->iread_b_pc -= (t_bit_bytes(t) & 1023);
 	}
 }
 
-static inline void account_pc_requeue(struct blk_io_trace *t,
+
+static inline void account_pc_requeue(struct trace *t,
 				      struct per_cpu_info *pci, int rw)
 {
 	__account_pc_requeue(&pci->io_stats, t, rw);
 
 	if (per_process_stats) {
-		struct io_stats *ios = find_process_io_stats(t->pid);
+		struct io_stats *ios = find_process_io_stats(t_bit_pid(t));
 
 		__account_pc_requeue(ios, t, rw);
 	}
@@ -1288,41 +1391,41 @@ static inline void __account_pc_c(struct io_stats *ios, int rw)
 		ios->creads_pc++;
 }
 
-static inline void account_pc_c(struct blk_io_trace *t,
+static inline void account_pc_c(struct trace *t,
 				struct per_cpu_info *pci, int rw)
 {
 	__account_pc_c(&pci->io_stats, rw);
 
 	if (per_process_stats) {
-		struct io_stats *ios = find_process_io_stats(t->pid);
+		struct io_stats *ios = find_process_io_stats(t_bit_pid(t));
 
 		__account_pc_c(ios, rw);
 	}
 }
 
-static inline void __account_queue(struct io_stats *ios, struct blk_io_trace *t,
-				   int rw)
+static inline void __account_queue(struct io_stats *ios, struct trace *t,
+				      int rw)
 {
 	if (rw) {
 		ios->qwrites++;
-		ios->qwrite_kb += t_kb(t);
-		ios->qwrite_b += t_b(t);
+		ios->qwrite_kb += (t_bit_bytes(t) >> 10);
+		ios->qwrite_b += (t_bit_bytes(t) & 1023);
 	} else {
 		ios->qreads++;
-		ios->qread_kb += t_kb(t);
-		ios->qread_b += t_b(t);
+		ios->qread_kb += (t_bit_bytes(t) >> 10);
+		ios->qread_b += (t_bit_bytes(t) & 1023);
 	}
 }
 
-static inline void account_queue(struct blk_io_trace *t,
+static inline void account_queue(struct trace *t,
 				 struct per_cpu_info *pci, int rw)
 {
 	__account_queue(&pci->io_stats, t, rw);
 
 	if (per_process_stats) {
-		struct io_stats *ios = find_process_io_stats(t->pid);
+		struct io_stats *ios = find_process_io_stats(t_bit_pid(t));
 
-		__account_queue(ios, t, rw);
+		__account_pc_queue(ios, t, rw);
 	}
 }
 
@@ -1339,13 +1442,13 @@ static inline void __account_c(struct io_stats *ios, int rw, int bytes)
 	}
 }
 
-static inline void account_c(struct blk_io_trace *t, struct per_cpu_info *pci,
+static inline void account_c(struct trace *t, struct per_cpu_info *pci,
 			     int rw, int bytes)
 {
 	__account_c(&pci->io_stats, rw, bytes);
 
 	if (per_process_stats) {
-		struct io_stats *ios = find_process_io_stats(t->pid);
+		struct io_stats *ios = find_process_io_stats(t_bit_pid(t));
 
 		__account_c(ios, rw, bytes);
 	}
@@ -1365,15 +1468,15 @@ static inline void __account_issue(struct io_stats *ios, int rw,
 	}
 }
 
-static inline void account_issue(struct blk_io_trace *t,
+static inline void account_issue(struct trace *t,
 				 struct per_cpu_info *pci, int rw)
 {
-	__account_issue(&pci->io_stats, rw, t->bytes);
+	__account_issue(&pci->io_stats, rw, t_bit_bytes(t));
 
 	if (per_process_stats) {
-		struct io_stats *ios = find_process_io_stats(t->pid);
+		struct io_stats *ios = find_process_io_stats(t_bit_pid(t));
 
-		__account_issue(ios, rw, t->bytes);
+		__account_issue(ios, rw, t_bit_bytes(t));
 	}
 }
 
@@ -1385,70 +1488,70 @@ static inline void __account_unplug(struct io_stats *ios, int timer)
 		ios->io_unplugs++;
 }
 
-static inline void account_unplug(struct blk_io_trace *t,
+static inline void account_unplug(struct trace *t,
 				  struct per_cpu_info *pci, int timer)
 {
 	__account_unplug(&pci->io_stats, timer);
 
 	if (per_process_stats) {
-		struct io_stats *ios = find_process_io_stats(t->pid);
+		struct io_stats *ios = find_process_io_stats(t_bit_pid(t));
 
 		__account_unplug(ios, timer);
 	}
 }
 
-static inline void __account_requeue(struct io_stats *ios,
-				     struct blk_io_trace *t, int rw)
+static inline void __account_requeue(struct io_stats *ios, struct trace *t,
+				     int rw)
 {
 	if (rw) {
 		ios->wrqueue++;
-		ios->iwrite_kb -= t_kb(t);
-		ios->iwrite_b -= t_b(t);
+		ios->iwrite_kb -= (t_bit_bytes(t) >> 10);
+		ios->iwrite_b -= (t_bit_bytes(t) & 1023);
 	} else {
 		ios->rrqueue++;
-		ios->iread_kb -= t_kb(t);
-		ios->iread_b -= t_b(t);
+		ios->iread_kb -= (t_bit_bytes(t) >> 10);
+		ios->iread_b -= (t_bit_bytes(t) & 1023);
 	}
 }
 
-static inline void account_requeue(struct blk_io_trace *t,
+static inline void account_requeue(struct trace *t,
 				   struct per_cpu_info *pci, int rw)
 {
 	__account_requeue(&pci->io_stats, t, rw);
 
 	if (per_process_stats) {
-		struct io_stats *ios = find_process_io_stats(t->pid);
+		struct io_stats *ios = find_process_io_stats(t_bit_pid(t));
 
 		__account_requeue(ios, t, rw);
 	}
 }
 
 static void log_complete(struct per_dev_info *pdi, struct per_cpu_info *pci,
-			 struct blk_io_trace *t, char *act)
+			 struct trace *t, char *act)
 {
 	process_fmt(act, pci, t, log_track_complete(pdi, t), 0, NULL);
 }
 
 static void log_insert(struct per_dev_info *pdi, struct per_cpu_info *pci,
-		       struct blk_io_trace *t, char *act)
+		       struct trace *t, char *act)
 {
 	process_fmt(act, pci, t, log_track_insert(pdi, t), 0, NULL);
 }
 
-static void log_queue(struct per_cpu_info *pci, struct blk_io_trace *t,
+static void log_queue(struct per_cpu_info *pci, struct trace *t,
 		      char *act)
 {
 	process_fmt(act, pci, t, -1, 0, NULL);
 }
 
 static void log_issue(struct per_dev_info *pdi, struct per_cpu_info *pci,
-		      struct blk_io_trace *t, char *act)
+		      struct trace *t, char *act)
 {
 	process_fmt(act, pci, t, log_track_issue(pdi, t), 0, NULL);
 }
 
 static void log_merge(struct per_dev_info *pdi, struct per_cpu_info *pci,
-		      struct blk_io_trace *t, char *act)
+		      struct trace *t, char *act)
 {
 	if (act[0] = 'F')
 		log_track_frontmerge(pdi, t);
@@ -1456,42 +1559,43 @@ static void log_merge(struct per_dev_info *pdi, struct per_cpu_info *pci,
 	process_fmt(act, pci, t, -1ULL, 0, NULL);
 }
 
-static void log_action(struct per_cpu_info *pci, struct blk_io_trace *t,
-			char *act)
+static void log_action(struct per_cpu_info *pci, struct trace *t, char *act)
 {
 	process_fmt(act, pci, t, -1ULL, 0, NULL);
 }
 
-static void log_generic(struct per_cpu_info *pci, struct blk_io_trace *t,
-			char *act)
+static void log_generic(struct per_cpu_info *pci, struct trace *t, char *act)
 {
 	process_fmt(act, pci, t, -1ULL, 0, NULL);
 }
 
-static void log_unplug(struct per_cpu_info *pci, struct blk_io_trace *t,
-		      char *act)
+static void log_unplug(struct per_cpu_info *pci, struct trace *t, char *act)
 {
 	process_fmt(act, pci, t, -1ULL, 0, NULL);
 }
 
-static void log_split(struct per_cpu_info *pci, struct blk_io_trace *t,
-		      char *act)
+static void log_split(struct per_cpu_info *pci, struct trace *t, char *act)
 {
 	process_fmt(act, pci, t, -1ULL, 0, NULL);
 }
 
-static void log_pc(struct per_cpu_info *pci, struct blk_io_trace *t, char *act)
+static void log_pc(struct per_cpu_info *pci, struct trace *t, char *act)
 {
-	unsigned char *buf = (unsigned char *) t + sizeof(*t);
+	unsigned char *buf;
+
+	if (t->use_ext)
+		buf  = (unsigned char *) t->bit_ext + sizeof(*(t->bit_ext));
+	else
+		buf  = (unsigned char *) t->bit + sizeof(*(t->bit));
 
-	process_fmt(act, pci, t, -1ULL, t->pdu_len, buf);
+	process_fmt(act, pci, t, -1ULL, t_bit_pdu_len(t), buf);
 }
 
-static void dump_trace_pc(struct blk_io_trace *t, struct per_dev_info *pdi,
+static void dump_trace_pc(struct trace *t, struct per_dev_info *pdi,
 			  struct per_cpu_info *pci)
 {
-	int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
-	int act = t->action & 0xffff;
+	int w = is_write_trace(t);
+	__u64 act = t_bit_act(t) & 0xffff;
 
 	switch (act) {
 		case __BLK_TA_QUEUE:
@@ -1531,16 +1635,16 @@ static void dump_trace_pc(struct blk_io_trace *t, struct per_dev_info *pdi,
 			log_pc(pci, t, "I");
 			break;
 		default:
-			fprintf(stderr, "Bad pc action %x\n", act);
+			fprintf(stderr, "Bad pc action %llx\n", act);
 			break;
 	}
 }
 
-static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
+static void dump_trace_fs(struct trace *t, struct per_dev_info *pdi,
 			  struct per_cpu_info *pci)
 {
-	int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
-	int act = t->action & 0xffff;
+	int w = is_write_trace(t);
+	__u64 act = t_bit_act(t) & 0xffff;
 
 	switch (act) {
 		case __BLK_TA_QUEUE:
@@ -1586,7 +1690,7 @@ static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
 		case __BLK_TA_COMPLETE:
 			if (pdi->cur_depth[w])
 				pdi->cur_depth[w]--;
-			account_c(t, pci, w, t->bytes);
+			account_c(t, pci, w, t_bit_bytes(t));
 			log_complete(pdi, pci, t, "C");
 			break;
 		case __BLK_TA_PLUG:
@@ -1614,32 +1718,52 @@ static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
 			/* dump to binary file only */
 			break;
 		default:
-			fprintf(stderr, "Bad fs action %x\n", t->action);
+			fprintf(stderr, "Bad fs action %llx\n", t_bit_act(t));
 			break;
 	}
 }
 
-static void dump_trace(struct blk_io_trace *t, struct per_cpu_info *pci,
+static void dump_trace(struct trace *t, struct per_cpu_info *pci,
 		       struct per_dev_info *pdi)
 {
 	if (text_output) {
-		if (t->action = BLK_TN_MESSAGE)
-			handle_notify(t);
-		else if (t->action & BLK_TC_ACT(BLK_TC_PC))
-			dump_trace_pc(t, pdi, pci);
-		else
-			dump_trace_fs(t, pdi, pci);
+		if (use_ext)
+			if (t->bit_ext->action = BLK_TN_MESSAGE_EXT)
+				handle_notify(t);
+			else if (t->bit_ext->action & BLK_TC_ACT_EXT(BLK_TC_PC))
+				dump_trace_pc(t, pdi, pci);
+			else
+				dump_trace_fs(t, pdi, pci);
+		else {
+			if (t->bit->action = BLK_TN_MESSAGE)
+				handle_notify(t);
+			else if (t->bit->action & BLK_TC_ACT(BLK_TC_PC))
+				dump_trace_pc(t, pdi, pci);
+			else
+				dump_trace_fs(t, pdi, pci);
+		}
 	}
 
 	if (!pdi->events)
-		pdi->first_reported_time = t->time;
+		pdi->first_reported_time = t_bit_time(t);
 
 	pdi->events++;
 
-	if (bin_output_msgs ||
-			    !(t->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
-			      t->action = BLK_TN_MESSAGE))
-		output_binary(t, sizeof(*t) + t->pdu_len);
+	if (use_ext) {
+		struct blk_io_trace_ext *bit_ext = t->bit_ext;
+
+		if (bin_output_msgs ||
+				!(bit_ext->action & BLK_TC_ACT_EXT(BLK_TC_NOTIFY) &&
+					bit_ext->action = BLK_TN_MESSAGE_EXT))
+			output_binary(bit_ext, sizeof(*bit_ext) + bit_ext->pdu_len);
+	} else {
+		struct blk_io_trace *bit = t->bit;
+
+		if (bin_output_msgs ||
+				!(bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+					bit->action = BLK_TN_MESSAGE))
+			output_binary(bit, sizeof(*bit) + bit->pdu_len);
+	}
 }
 
 /*
@@ -1926,15 +2050,17 @@ static void find_genesis(void)
 
 	genesis_time = -1ULL;
 	while (t != NULL) {
-		if (t->bit->time < genesis_time)
-			genesis_time = t->bit->time;
+		if (t_bit_time(t) < genesis_time)
+			genesis_time = t_bit_time(t);
 
 		t = t->next;
 	}
 
+
 	/* The time stamp record will usually be the first
 	 * record in the trace, but not always.
 	 */
+
 	if (start_timestamp
 	 && start_timestamp != genesis_time) {
 		long delta = genesis_time - start_timestamp;
@@ -1952,10 +2078,10 @@ static void find_genesis(void)
 	}
 }
 
-static inline int check_stopwatch(struct blk_io_trace *bit)
+static inline int check_stopwatch(struct trace *t)
 {
-	if (bit->time < stopwatch_end &&
-	    bit->time >= stopwatch_start)
+	if (t_bit_time(t) < stopwatch_end &&
+	    t_bit_time(t) >= stopwatch_start)
 		return 0;
 
 	return 1;
@@ -1973,30 +2099,32 @@ static int sort_entries(unsigned long long *youngest)
 	if (!genesis_time)
 		find_genesis();
 
+
 	*youngest = 0;
 	while ((t = trace_list) != NULL) {
-		struct blk_io_trace *bit = t->bit;
-
 		trace_list = t->next;
 
-		bit->time -= genesis_time;
+		if (use_ext)
+			t->bit_ext->time -= genesis_time;
+		else
+			t->bit->time -= genesis_time;
 
-		if (bit->time < *youngest || !*youngest)
-			*youngest = bit->time;
+		if (t_bit_time(t) < *youngest || !*youngest)
+			*youngest = t_bit_time(t);
 
-		if (!pdi || pdi->dev != bit->device) {
-			pdi = get_dev_info(bit->device);
+		if (!pdi || pdi->dev != t_bit_dev(t)) {
+			pdi = get_dev_info(t_bit_dev(t));
 			pci = NULL;
 		}
 
-		if (!pci || pci->cpu != bit->cpu)
-			pci = get_cpu_info(pdi, bit->cpu);
+		if (!pci || pci->cpu != t_bit_cpu(t))
+			pci = get_cpu_info(pdi, t_bit_cpu(t));
 
-		if (bit->sequence < pci->smallest_seq_read)
-			pci->smallest_seq_read = bit->sequence;
+		if (t_bit_seq(t) < pci->smallest_seq_read)
+			pci->smallest_seq_read = t_bit_seq(t);
 
-		if (check_stopwatch(bit)) {
-			bit_free(bit);
+		if (check_stopwatch(t)) {
+			use_ext ? bit_free_ext(t->bit_ext) : bit_free(t->bit);
 			t_free(t);
 			continue;
 		}
@@ -2027,7 +2155,7 @@ static int check_cpu_map(struct per_dev_info *pdi)
 	n = rb_first(&rb_sort_root);
 	while (n) {
 		__t = rb_entry(n, struct trace, rb_node);
-		cpu = __t->bit->cpu;
+		cpu = t_bit_cpu(__t);
 
 		cpu_map[CPU_IDX(cpu)] |= (1UL << CPU_BIT(cpu));
 		n = rb_next(n);
@@ -2051,27 +2179,26 @@ static int check_cpu_map(struct per_dev_info *pdi)
 
 static int check_sequence(struct per_dev_info *pdi, struct trace *t, int force)
 {
-	struct blk_io_trace *bit = t->bit;
 	unsigned long expected_sequence;
 	struct per_cpu_info *pci;
 	struct trace *__t;
 
-	pci = get_cpu_info(pdi, bit->cpu);
+	pci = get_cpu_info(pdi, t_bit_cpu(t));
 	expected_sequence = pci->last_sequence + 1;
 
 	if (!expected_sequence) {
 		/*
 		 * 1 should be the first entry, just allow it
 		 */
-		if (bit->sequence = 1)
+		if (t_bit_seq(t) = 1)
 			return 0;
-		if (bit->sequence = pci->smallest_seq_read)
+		if (t_bit_seq(t) = pci->smallest_seq_read)
 			return 0;
 
 		return check_cpu_map(pdi);
 	}
 
-	if (bit->sequence = expected_sequence)
+	if (t_bit_seq(t) = expected_sequence)
 		return 0;
 
 	/*
@@ -2089,11 +2216,11 @@ static int check_sequence(struct per_dev_info *pdi, struct trace *t, int force)
 		return 1;
 	} else {
 skip:
-		if (check_current_skips(pci, bit->sequence))
+		if (check_current_skips(pci, t_bit_seq(t)))
 			return 0;
 
-		if (expected_sequence < bit->sequence)
-			insert_skip(pci, expected_sequence, bit->sequence - 1);
+		if (expected_sequence < t_bit_seq(t))
+			insert_skip(pci, expected_sequence, t_bit_seq(t) - 1);
 		return 0;
 	}
 }
@@ -2102,7 +2229,6 @@ static void show_entries_rb(int force)
 {
 	struct per_dev_info *pdi = NULL;
 	struct per_cpu_info *pci = NULL;
-	struct blk_io_trace *bit;
 	struct rb_node *n;
 	struct trace *t;
 
@@ -2111,41 +2237,57 @@ static void show_entries_rb(int force)
 			break;
 
 		t = rb_entry(n, struct trace, rb_node);
-		bit = t->bit;
 
 		if (read_sequence - t->read_sequence < 1 && !force)
 			break;
 
-		if (!pdi || pdi->dev != bit->device) {
-			pdi = get_dev_info(bit->device);
+		if (!pdi || pdi->dev != t_bit_dev(t)) {
+			pdi = get_dev_info(t_bit_dev(t));
 			pci = NULL;
 		}
 
 		if (!pdi) {
 			fprintf(stderr, "Unknown device ID? (%d,%d)\n",
-				MAJOR(bit->device), MINOR(bit->device));
+				MAJOR(t_bit_dev(t)), MINOR(t_bit_dev(t)));
 			break;
 		}
 
-		if (!(bit->action = BLK_TN_MESSAGE) &&
-		    check_sequence(pdi, t, force))
-			break;
+		if (use_ext) {
+			if (!(t->bit_ext->action = BLK_TN_MESSAGE_EXT) &&
+					check_sequence(pdi, t, force))
+				break;
+		} else {
+			if (!(t->bit->action = BLK_TN_MESSAGE) &&
+					check_sequence(pdi, t, force))
+				break;
+		}
 
-		if (!force && bit->time > last_allowed_time)
+		if (!force && t_bit_time(t) > last_allowed_time)
 			break;
 
-		check_time(pdi, bit);
+		check_time(pdi, t);
 
-		if (!pci || pci->cpu != bit->cpu)
-			pci = get_cpu_info(pdi, bit->cpu);
+		if (!pci || pci->cpu != t_bit_cpu(t))
+			pci = get_cpu_info(pdi, t_bit_cpu(t));
 
-		if (!(bit->action = BLK_TN_MESSAGE))
-			pci->last_sequence = bit->sequence;
+		if (use_ext) {
+			if (!(t->bit_ext->action = BLK_TN_MESSAGE_EXT))
+				pci->last_sequence = t->bit_ext->sequence;
+		} else {
+			if (!(t->bit->action = BLK_TN_MESSAGE))
+				pci->last_sequence = t->bit->sequence;
+		}
 
 		pci->nelems++;
 
-		if (bit->action & (act_mask << BLK_TC_SHIFT))
-			dump_trace(bit, pci, pdi);
+		if (use_ext) {
+			if (t->bit_ext->action &
+					(act_mask_ext << BLK_TC_SHIFT_EXT))
+				dump_trace(t, pci, pdi);
+		} else {
+			if (t->bit->action & (act_mask << BLK_TC_SHIFT))
+				dump_trace(t, pci, pdi);
+		}
 
 		put_trace(pdi, t);
 	}
@@ -2207,6 +2349,14 @@ static inline __u16 get_pdulen(struct blk_io_trace *bit)
 	return __bswap_16(bit->pdu_len);
 }
 
+static inline __u16 get_pdulen_ext(struct blk_io_trace_ext *bit)
+{
+	if (data_is_native)
+		return bit->pdu_len;
+
+	return __bswap_16(bit->pdu_len);
+}
+
 static inline __u32 get_magic(struct blk_io_trace *bit)
 {
 	if (data_is_native)
@@ -2215,6 +2365,54 @@ static inline __u32 get_magic(struct blk_io_trace *bit)
 	return __bswap_32(bit->magic);
 }
 
+static inline __u32 get_magic_ext(struct blk_io_trace_ext *bit)
+{
+	if (data_is_native)
+		return bit->magic;
+
+	return __bswap_32(bit->magic);
+}
+
+static inline bool is_notify_act(struct blk_io_trace *bit)
+{
+	if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+			bit->action != BLK_TN_MESSAGE)
+		return true;
+	return false;
+}
+
+static inline bool is_notify_act_ext(struct blk_io_trace *bit)
+{
+	if (bit->action & BLK_TC_ACT_EXT(BLK_TC_NOTIFY) &&
+			bit->action != BLK_TN_MESSAGE)
+		return true;
+	return false;
+}
+
+static bool check_magic(__u32 magic)
+{
+	if ((magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
+		fprintf(stderr, " %s Bad magic %x\n", __func__, magic);
+		return false;
+	}
+
+	if (use_ext) {
+		if ((magic & 0x000000ff) != BLK_IO_TRACE_VERSION_EXT) {
+			fprintf(stderr, " %s Bad version %x\n", __func__,
+					magic & 0x000000ff);
+			return false;
+		}
+	} else {
+
+		if ((magic & 0x000000ff) != BLK_IO_TRACE_VERSION) {
+			fprintf(stderr, " %s Bad version %x\n", __func__,
+					magic & 0x000000ff);
+			return false;
+		}
+	}
+	return true;
+}
+
 static int read_events(int fd, int always_block, int *fdblock)
 {
 	struct per_dev_info *pdi = NULL;
@@ -2246,10 +2444,8 @@ static int read_events(int fd, int always_block, int *fdblock)
 			break;
 
 		magic = get_magic(bit);
-		if ((magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
-			fprintf(stderr, "Bad magic %x\n", magic);
+		if (!check_magic(magic))
 			break;
-		}
 
 		pdu_len = get_pdulen(bit);
 		if (pdu_len) {
@@ -2270,20 +2466,110 @@ static int read_events(int fd, int always_block, int *fdblock)
 			continue;
 		}
 
+		t = t_alloc();
+		memset(t, 0, sizeof(*t));
+		t->bit = bit;
+		t->use_ext = false;
+		t->read_sequence = read_sequence;
+
 		/*
 		 * not a real trace, so grab and handle it here
 		 */
 		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && bit->action != BLK_TN_MESSAGE) {
-			handle_notify(bit);
+			handle_notify(t);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
+			t_free(t);
+			bit_free(bit);
+
+			continue;
+		}
+
+		t->next = trace_list;
+		trace_list = t;
+
+		if (!pdi || pdi->dev != bit->device)
+			pdi = get_dev_info(bit->device);
+
+		if (bit->time > pdi->last_read_time)
+			pdi->last_read_time = bit->time;
+
+		events++;
+	}
+
+	return events;
+}
+
+static int read_events_ext(int fd, int always_block, int *fdblock)
+{
+	struct per_dev_info *pdi = NULL;
+	unsigned int events = 0;
+
+	while (!is_done() && events < rb_batch) {
+		struct blk_io_trace_ext *bit;
+		struct trace *t;
+		int pdu_len, should_block, ret;
+		__u32 magic;
+
+		bit = bit_alloc_ext();
+
+		should_block = !events || always_block;
+
+		ret = read_data(fd, bit, sizeof(*bit), should_block, fdblock);
+		if (ret) {
+			bit_free_ext(bit);
+			if (!events && ret < 0)
+				events = ret;
+			break;
+		}
+
+		/*
+		 * look at first trace to check whether we need to convert
+		 * data in the future
+		 */
+		if (data_is_native = -1 && check_data_endianness(bit->magic))
+			break;
+
+		magic = get_magic_ext(bit);
+		if (!check_magic(magic))
+			break;
+		pdu_len = get_pdulen_ext(bit);
+		if (pdu_len) {
+			void *ptr = realloc(bit, sizeof(*bit) + pdu_len);
+
+			if (read_data(fd, ptr + sizeof(*bit), pdu_len, 1, fdblock)) {
+				bit_free_ext(ptr);
+				break;
+			}
+
+			bit = ptr;
+		}
+
+		trace_to_cpu_ext(bit);
+
+		if (verify_trace_ext(bit)) {
+			bit_free_ext(bit);
 			continue;
 		}
 
 		t = t_alloc();
 		memset(t, 0, sizeof(*t));
-		t->bit = bit;
+		t->bit_ext = bit;
+		t->use_ext = true;
 		t->read_sequence = read_sequence;
 
+		/*
+		 * not a real trace, so grab and handle it here
+		 */
+		if (bit->action & BLK_TC_ACT_EXT(BLK_TC_NOTIFY) &&
+				bit->action != BLK_TN_MESSAGE_EXT) {
+			handle_notify(t);
+			output_binary(bit, sizeof(*bit) + bit->pdu_len);
+			t_free(t);
+			bit_free_ext(bit);
+
+			continue;
+		}
+
 		t->next = trace_list;
 		trace_list = t;
 
@@ -2317,6 +2603,7 @@ struct ms_stream *ms_hash[256];
 
 static void ms_sort(struct ms_stream *msp);
 static int ms_prime(struct ms_stream *msp);
+static int ms_prime_ext(struct ms_stream *msp);
 
 static inline struct trace *ms_peek(struct ms_stream *msp)
 {
@@ -2342,10 +2629,18 @@ static inline void ms_deq(struct ms_stream *msp)
 	msp->first = msp->first->next;
 	if (!msp->first) {
 		msp->last = NULL;
-		if (!ms_prime(msp)) {
-			ms_head = msp->next;
-			msp->next = NULL;
-			return;
+		if (use_ext) {
+			if (!ms_prime_ext(msp)) {
+				ms_head = msp->next;
+				msp->next = NULL;
+				return;
+			}
+		} else {
+			if (!ms_prime(msp)) {
+				ms_head = msp->next;
+				msp->next = NULL;
+				return;
+			}
 		}
 	}
 
@@ -2392,12 +2687,9 @@ static int ms_prime(struct ms_stream *msp)
 			goto err;
 
 		magic = get_magic(bit);
-		if ((magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
-			fprintf(stderr, "Bad magic %x\n", magic);
+		if (!check_magic(magic))
 			goto err;
 
-		}
-
 		pdu_len = get_pdulen(bit);
 		if (pdu_len) {
 			void *ptr = realloc(bit, sizeof(*bit) + pdu_len);
@@ -2422,10 +2714,16 @@ static int ms_prime(struct ms_stream *msp)
 			continue;
 		}
 
+		t = t_alloc();
+		memset(t, 0, sizeof(*t));
+		t->bit = bit;
+		t->use_ext = false;
+
 		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && bit->action != BLK_TN_MESSAGE) {
-			handle_notify(bit);
+			handle_notify(t);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
 			bit_free(bit);
+			t_free(t);
 
 			i -= 1;
 			continue;
@@ -2433,10 +2731,91 @@ static int ms_prime(struct ms_stream *msp)
 
 		if (bit->time > pdi->last_read_time)
 			pdi->last_read_time = bit->time;
+		if (msp->first = NULL)
+			msp->first = msp->last = t;
+		else {
+			msp->last->next = t;
+			msp->last = t;
+		}
+
+		ndone++;
+	}
+
+	return ndone;
+
+err:
+	if (bit) bit_free(bit);
+
+	cpu_mark_offline(pdi, pci->cpu);
+	close(pci->fd);
+	pci->fd = -1;
+
+	return ndone;
+}
+
+static int ms_prime_ext(struct ms_stream *msp)
+{
+	__u32 magic;
+	unsigned int i;
+	struct trace *t;
+	struct per_dev_info *pdi = msp->pdi;
+	struct per_cpu_info *pci = get_cpu_info(pdi, msp->cpu);
+	struct blk_io_trace_ext *bit = NULL;
+	int ret, pdu_len, ndone = 0;
+
+	for (i = 0; !is_done() && pci->fd >= 0 && i < rb_batch; i++) {
+		bit = bit_alloc_ext();
+		ret = read_data(pci->fd, bit, sizeof(*bit), 1, &pci->fdblock);
+		if (ret)
+			goto err;
+
+		if (data_is_native = -1 && check_data_endianness(bit->magic))
+			goto err;
+
+		magic = get_magic_ext(bit);
+		if (!check_magic(magic))
+			goto err;
+		pdu_len = get_pdulen_ext(bit);
+		if (pdu_len) {
+			void *ptr = realloc(bit, sizeof(*bit) + pdu_len);
+			ret = read_data(pci->fd, ptr + sizeof(*bit), pdu_len,
+							     1, &pci->fdblock);
+			if (ret) {
+				free(ptr);
+				bit = NULL;
+				goto err;
+			}
+
+			bit = ptr;
+		}
+
+		trace_to_cpu_ext(bit);
+		if (verify_trace_ext(bit))
+			goto err;
+
+		if (bit->cpu != pci->cpu) {
+			fprintf(stderr, "cpu %d trace info has error cpu %d\n",
+				pci->cpu, bit->cpu);
+			continue;
+		}
 
 		t = t_alloc();
 		memset(t, 0, sizeof(*t));
-		t->bit = bit;
+		t->bit_ext = bit;
+
+		if ((bit->action & BLK_TC_ACT_EXT(BLK_TC_NOTIFY)) &&
+				(bit->action != BLK_TN_MESSAGE)) {
+			handle_notify(t);
+			output_binary(bit, sizeof(*bit) + bit->pdu_len);
+			bit_free_ext(bit);
+			t_free(t);
+
+			i -= 1;
+			continue;
+		}
+
+		if (bit->time > pdi->last_read_time)
+			pdi->last_read_time = bit->time;
 
 		if (msp->first = NULL)
 			msp->first = msp->last = t;
@@ -2451,7 +2830,7 @@ static int ms_prime(struct ms_stream *msp)
 	return ndone;
 
 err:
-	if (bit) bit_free(bit);
+	if (bit) bit_free_ext(bit);
 
 	cpu_mark_offline(pdi, pci->cpu);
 	close(pci->fd);
@@ -2469,8 +2848,13 @@ static struct ms_stream *ms_alloc(struct per_dev_info *pdi, int cpu)
 	msp->pdi = pdi;
 	msp->cpu = cpu;
 
-	if (ms_prime(msp))
-		ms_sort(msp);
+	if (use_ext)  {
+		if (ms_prime_ext(msp))
+			ms_sort(msp);
+	} else {
+		if (ms_prime(msp))
+			ms_sort(msp);
+	}
 
 	return msp;
 }
@@ -2524,23 +2908,21 @@ static int handle(struct ms_stream *msp)
 	struct trace *t;
 	struct per_dev_info *pdi;
 	struct per_cpu_info *pci;
-	struct blk_io_trace *bit;
 
 	t = ms_peek(msp);
 
-	bit = t->bit;
 	pdi = msp->pdi;
 	pci = get_cpu_info(pdi, msp->cpu);
 	pci->nelems++;
-	bit->time -= genesis_time;
+	t->bit->time -= genesis_time;
 
 	if (t->bit->time > stopwatch_end)
 		return 0;
 
-	pdi->last_reported_time = bit->time;
-	if ((bit->action & (act_mask << BLK_TC_SHIFT))&&
+	pdi->last_reported_time = t->bit->time;
+	if ((t->bit->action & (act_mask << BLK_TC_SHIFT))&&
 	    t->bit->time >= stopwatch_start)
-		dump_trace(bit, pci, pdi);
+		dump_trace(t, pci, pdi);
 
 	ms_deq(msp);
 
@@ -2554,6 +2936,39 @@ static int handle(struct ms_stream *msp)
 	return 1;
 }
 
+static int handle_ext(struct ms_stream *msp)
+{
+	struct trace *t;
+	struct per_dev_info *pdi;
+	struct per_cpu_info *pci;
+
+	t = ms_peek(msp);
+
+	pdi = msp->pdi;
+	pci = get_cpu_info(pdi, msp->cpu);
+	pci->nelems++;
+	t->bit_ext->time -= genesis_time;
+
+	if (t->bit_ext->time > stopwatch_end)
+		return 0;
+
+	pdi->last_reported_time = t->bit_ext->time;
+	if ((t->bit_ext->action & (act_mask_ext << BLK_TC_SHIFT_EXT)) &&
+	    t->bit_ext->time >= stopwatch_start)
+		dump_trace(t, pci, pdi);
+
+	ms_deq(msp);
+
+	if (text_output)
+		trace_rb_insert_last(pdi, t);
+	else {
+		bit_free_ext(t->bit_ext);
+		t_free(t);
+	}
+
+	return 1;
+}
+
 /*
  * Check if we need to sanitize the name. We allow 'foo', or if foo.blktrace.X
  * is given, then strip back down to 'foo' to avoid missing files.
@@ -2605,8 +3020,13 @@ static int do_file(void)
 	/*
 	 * Keep processing traces while any are left
 	 */
-	while (!is_done() && ms_head && handle(ms_head))
-		;
+	if (use_ext)
+		while (!is_done() && ms_head && handle_ext(ms_head))
+			;
+	else {
+		while (!is_done() && ms_head && handle(ms_head))
+			;
+	}
 
 	return 0;
 }
@@ -2618,19 +3038,23 @@ static void do_pipe(int fd)
 
 	last_allowed_time = -1ULL;
 	fdblock = -1;
-	while ((events = read_events(fd, 0, &fdblock)) > 0) {
+	while (1) {
+
+		if (use_ext)
+			events = read_events_ext(fd, 0, &fdblock);
+		else
+			events = read_events(fd, 0, &fdblock);
+		if (events <= 0)
+			break;
+
 		read_sequence++;
-	
 #if 0
 		smallest_seq_read = -1U;
 #endif
-
 		if (sort_entries(&youngest))
 			break;
-
 		if (youngest > stopwatch_end)
 			break;
-
 		show_entries_rb(0);
 	}
 
@@ -2730,26 +3154,32 @@ static int is_pipe(const char *str)
 	return 0;
 }
 
-#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vVM"
+#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vVMPx:X:y:Y:E"
 static char usage_str[] =    "\n\n" \
-	"-i <file>           | --input=<file>\n" \
-	"[ -a <action field> | --act-mask=<action field> ]\n" \
-	"[ -A <action mask>  | --set-mask=<action mask> ]\n" \
-	"[ -b <traces>       | --batch=<traces> ]\n" \
-	"[ -d <file>         | --dump-binary=<file> ]\n" \
-	"[ -D <dir>          | --input-directory=<dir> ]\n" \
-	"[ -f <format>       | --format=<format> ]\n" \
-	"[ -F <spec>         | --format-spec=<spec> ]\n" \
-	"[ -h                | --hash-by-name ]\n" \
-	"[ -o <file>         | --output=<file> ]\n" \
-	"[ -O                | --no-text-output ]\n" \
-	"[ -q                | --quiet ]\n" \
-	"[ -s                | --per-program-stats ]\n" \
-	"[ -t                | --track-ios ]\n" \
-	"[ -w <time>         | --stopwatch=<time> ]\n" \
-	"[ -M                | --no-msgs\n" \
-	"[ -v                | --verbose ]\n" \
-	"[ -V                | --version ]\n\n" \
+	"-i <file>               | --input=<file>\n" \
+	"[ -a <action field>     | --act-mask=<action field> ]\n" \
+	"[ -A <action mask>      | --set-mask=<action mask> ]\n" \
+	"[ -b <traces>           | --batch=<traces> ]\n" \
+	"[ -d <file>             | --dump-binary=<file> ]\n" \
+	"[ -D <dir>              | --input-directory=<dir> ]\n" \
+	"[ -f <format>           | --format=<format> ]\n" \
+	"[ -F <spec>             | --format-spec=<spec> ]\n" \
+	"[ -h                    | --hash-by-name ]\n" \
+	"[ -o <file>             | --output=<file> ]\n" \
+	"[ -O                    | --no-text-output ]\n" \
+	"[ -q                    | --quiet ]\n" \
+	"[ -s                    | --per-program-stats ]\n" \
+	"[ -t                    | --track-ios ]\n" \
+	"[ -w <time>             | --stopwatch=<time> ]\n" \
+	"[ -M                    | --no-msgs\n" \
+	"[ -E                    | --use-extensions ]\n" \
+	"[ -y <action field ext> | --act-mask-ext=<action field ext>]\n" \
+	"[ -Y <action mask ext>  | --set-mask=<action mask>]\n" \
+	"[ -P                    | --track-priority ]\n" \
+	"[ -x <ioprio field>     | --prio-mask=<ioprio field> ]\n" \
+	"[ -X <ioprio mask>      | --set-mask=<ioprio mask> ]\n" \
+	"[ -v                    | --verbose ]\n" \
+	"[ -V                    | --version ]\n\n" \
 	"\t-a Only trace specified actions. See documentation\n" \
 	"\t-A Give trace mask as a single value. See documentation\n" \
 	"\t-b stdin read batching\n" \
@@ -2769,6 +3199,12 @@ static char usage_str[] =    "\n\n" \
 	"\t-w Only parse data between the given time interval in seconds.\n" \
 	"\t   If 'start' isn't given, blkparse defaults the start time to 0\n" \
 	"\t-M Do not output messages to binary file\n" \
+	"\t-E Use Blocktrace Extensions\n" \
+	"\t-P Enable tracking priorites.\n" \
+	"\t-y Only trace specified actions ext.\n" \
+	"\t-Y Give trace mask as a single value ext.\n" \
+	"\t-x Only priority specified actions.\n" \
+	"\t-X Give priority mask as a single value.\n" \
 	"\t-v More verbose for marginal errors\n" \
 	"\t-V Print program version info\n\n";
 
@@ -2781,6 +3217,7 @@ int main(int argc, char *argv[])
 {
 	int i, c, ret, mode;
 	int act_mask_tmp = 0;
+	uint64_t act_mask_tmp_ext = 0;
 	char *ofp_buffer = NULL;
 	char *bin_ofp_buffer = NULL;
 
@@ -2797,7 +3234,7 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'A':
-			if ((sscanf(optarg, "%x", &i) != 1) || 
+			if ((sscanf(optarg, "%x", &i) != 1) ||
 							!valid_act_opt(i)) {
 				fprintf(stderr,
 					"Invalid set action mask %s/0x%x\n",
@@ -2862,6 +3299,52 @@ int main(int argc, char *argv[])
 		case 'M':
 			bin_output_msgs = 0;
 			break;
+
+		case 'E': /* use blktrace extensions */
+			use_ext = true;
+			break;
+		case 'y':
+			i = find_mask_map_ext(optarg);
+			if (i < 0) {
+				fprintf(stderr, "Invalid action mask %s\n",
+					optarg);
+				return 1;
+			}
+			act_mask_tmp_ext |= i;
+			break;
+
+		case 'Y':
+			if ((sscanf(optarg, "%x", &i) != 1) ||
+							!valid_act_opt_ext(i)) {
+				fprintf(stderr,
+					"Invalid set action mask %s/0x%x\n",
+					optarg, i);
+				return 1;
+			}
+			act_mask_tmp_ext = i;
+			break;
+
+		case 'P': /* enable priority tracking */
+			blkparse_track_prio = true;
+			break;
+		case 'x': /* priority mask values in string */
+			i = find_prio_mask_map(optarg);
+			if (i < 0) {
+				fprintf(stderr,"Invalid prio mask %s\n",
+						optarg);
+				return 1;
+			}
+			blkparse_prio_mask |= i;
+			break;
+		case 'X': /* priority mask values in hex */
+			if ((sscanf(optarg, "%x", &i) != 1) ||
+					!valid_prio_opt(i)) {
+				fprintf(stderr, "Invalid prio mask %s/0x%x\n",
+						optarg, i);
+				return 1;
+			}
+			blkparse_prio_mask = i;
+			break;
 		default:
 			usage(argv[0]);
 			return 1;
@@ -2882,8 +3365,27 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
-	if (act_mask_tmp != 0)
-		act_mask = act_mask_tmp;
+	if (use_ext) {
+		if (act_mask_tmp) {
+			fprintf(stderr, "please use y or Y with -E\n");
+			return 1;
+		}
+		if (act_mask_tmp_ext != 0)
+			act_mask_ext = act_mask_tmp_ext;
+
+		/*
+		 * When track-priority is on and user didn't specify prio_mask then
+		 * trace all the classes.
+		 */
+		if (blkparse_track_prio && !blkparse_prio_mask)
+			blkparse_prio_mask = TRACE_ALL_IOPRIO;
+	} else {
+		if (act_mask_tmp != 0)
+			act_mask = act_mask_tmp;
+	}
+
+	if (!use_ext && (blkparse_track_prio || blkparse_prio_mask))
+		fprintf(stderr,"please specify -E with -P or -X or -x\n");
 
 	memset(&rb_sort_root, 0, sizeof(rb_sort_root));
 
diff --git a/blkparse.h b/blkparse.h
new file mode 100644
index 0000000..1a079e6
--- /dev/null
+++ b/blkparse.h
@@ -0,0 +1,78 @@
+#ifndef BLKPARSE_H
+#define BLKPARSE_H
+
+struct trace {
+	/* use anon-union for bit and bit_ext ? */
+	bool use_ext;
+	struct blk_io_trace *bit;
+	struct blk_io_trace_ext *bit_ext;
+	struct rb_node rb_node;
+	struct trace *next;
+	unsigned long read_sequence;
+};
+
+/*
+ * struct trace based blk_io_trace and blk_io_trace_ext helpers.
+ */
+
+static inline __u32 t_bit_magic(struct trace *t)
+{
+	return t->use_ext ? t->bit_ext->magic : t->bit->magic;
+}
+
+static inline __u32 t_bit_seq(struct trace *t)
+{
+	return t->use_ext ? t->bit_ext->sequence : t->bit->sequence;
+}
+
+static inline __u64 t_bit_time(struct trace *t)
+{
+	return t->use_ext ? t->bit_ext->time : t->bit->time;
+}
+
+static inline __u64 t_bit_sec(struct trace *t)
+{
+	return t->use_ext ? t->bit_ext->sector : t->bit->sector;
+}
+
+static inline __u32 t_bit_bytes(struct trace *t)
+{
+	return t->use_ext ? t->bit_ext->bytes : t->bit->bytes;
+}
+
+static inline __u64 t_bit_act(struct trace *t)
+{
+	return t->use_ext ? t->bit_ext->action : t->bit->action;
+}
+
+static inline __u32 t_bit_ioprio(struct trace *t)
+{
+	return t->use_ext ? t->bit_ext->ioprio : 0;
+}
+
+static inline __u32 t_bit_pid(struct trace *t)
+{
+	return t->use_ext ? t->bit_ext->pid : t->bit->pid;
+}
+
+static inline __u32 t_bit_dev(struct trace *t)
+{
+	return t->use_ext ? t->bit_ext->device : t->bit->device;
+}
+
+static inline __u32 t_bit_cpu(struct trace *t)
+{
+	return t->use_ext ? t->bit_ext->cpu: t->bit->cpu;
+}
+
+static inline __u16 t_bit_err(struct trace *t)
+{
+	return t->use_ext ? t->bit_ext->error: t->bit->error;
+}
+
+static inline __u16 t_bit_pdu_len(struct trace *t)
+{
+	return t->use_ext ? t->bit_ext->pdu_len: t->bit->pdu_len;
+}
+
+#endif /* BLKPARSE_H*/
diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index c42e6d7..15c5f44 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -5,11 +5,13 @@
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
+#include <stdint.h>
 #include <unistd.h>
 #include <ctype.h>
 #include <time.h>
 
 #include "blktrace.h"
+#include "blkparse.h"
 
 #define VALID_SPECS	"ABCDFGIMPQRSTUWX"
 
@@ -50,6 +52,49 @@ int add_format_spec(char *option)
 	return 0;
 }
 
+static inline void fill_rwbs_ext(char *rwbs, struct blk_io_trace_ext *t)
+{
+	uint64_t w = t->action & BLK_TC_ACT_EXT(BLK_TC_WRITE);
+	uint64_t a = t->action & BLK_TC_ACT_EXT(BLK_TC_AHEAD);
+	uint64_t s = t->action & BLK_TC_ACT_EXT(BLK_TC_SYNC);
+	uint64_t m = t->action & BLK_TC_ACT_EXT(BLK_TC_META);
+	uint64_t d = t->action & BLK_TC_ACT_EXT(BLK_TC_DISCARD);
+	uint64_t f = t->action & BLK_TC_ACT_EXT(BLK_TC_FLUSH);
+	uint64_t u = t->action & BLK_TC_ACT_EXT(BLK_TC_FUA);
+	uint64_t z = t->action & BLK_TC_ACT_EXT(BLK_TC_WRITE_ZEROES);
+	uint64_t r = t->action & BLK_TC_ACT_EXT(BLK_TC_ZONE_RESET);
+	int i = 0;
+
+	if (f)
+		rwbs[i++] = 'F'; /* flush */
+
+	if (d)
+		rwbs[i++] = 'D';
+	else if (z) {
+		rwbs[i++] = 'W'; /* write-zeroes */
+		rwbs[i++] = 'Z';
+	} else if (r) {
+		rwbs[i++] = 'Z'; /* zone-reset */
+		rwbs[i++] = 'R';
+	} else if (w)
+		rwbs[i++] = 'W';
+	else if (t->bytes)
+		rwbs[i++] = 'R';
+	else
+		rwbs[i++] = 'N';
+
+	if (u)
+		rwbs[i++] = 'F'; /* fua */
+	if (a)
+		rwbs[i++] = 'A';
+	if (s)
+		rwbs[i++] = 'S';
+	if (m)
+		rwbs[i++] = 'M';
+
+	rwbs[i] = '\0';
+}
+
 static inline void fill_rwbs(char *rwbs, struct blk_io_trace *t)
 {
 	int w = t->action & BLK_TC_ACT(BLK_TC_WRITE);
@@ -145,16 +190,23 @@ static char *dump_pdu(unsigned char *pdu_buf, int pdu_len)
 	return p;
 }
 
-#define pdu_start(t)	(((void *) (t) + sizeof(struct blk_io_trace)))
+static inline void *pdu_start(struct trace *t)
+{
+	if (t->use_ext)
+		return (((void *) (t->bit_ext) +
+					sizeof(struct blk_io_trace_ext)));
+
+	return (((void *) (t->bit) + sizeof(struct blk_io_trace)));
+}
 
-static unsigned int get_pdu_int(struct blk_io_trace *t)
+static unsigned int get_pdu_int(struct trace *t)
 {
 	__u64 *val = pdu_start(t);
 
 	return be64_to_cpu(*val);
 }
 
-static void get_pdu_remap(struct blk_io_trace *t, struct blk_io_trace_remap *r)
+static void get_pdu_remap(struct trace *t, struct blk_io_trace_remap *r)
 {
 	struct blk_io_trace_remap *__r = pdu_start(t);
 	__u64 sector_from = __r->sector_from;
@@ -165,7 +217,7 @@ static void get_pdu_remap(struct blk_io_trace *t, struct blk_io_trace_remap *r)
 }
 
 static void print_field(char *act, struct per_cpu_info *pci,
-			struct blk_io_trace *t, unsigned long long elapsed,
+			struct trace *t, unsigned long long elapsed,
 			int pdu_len, unsigned char *pdu_buf, char field,
 			int minus, int has_w, int width)
 {
@@ -187,7 +239,7 @@ static void print_field(char *act, struct per_cpu_info *pci,
 		fprintf(ofp, strcat(format, "d"), pci->cpu);
 		break;
 	case 'C': {
-		char *name = find_process_name(t->pid);
+		char *name = find_process_name(t_bit_pid(t));
 
 		fprintf(ofp, strcat(format, "s"), name);
 		break;
@@ -195,30 +247,32 @@ static void print_field(char *act, struct per_cpu_info *pci,
 	case 'd': {
 		char rwbs[8];
 
-		fill_rwbs(rwbs, t);
+		t->use_ext ? fill_rwbs_ext(rwbs, t->bit_ext) :
+			fill_rwbs(rwbs, t->bit);
 		fprintf(ofp, strcat(format, "s"), rwbs);
 		break;
 	}
 	case 'D':	/* format width ignored */
-		fprintf(ofp,"%3d,%-3d", MAJOR(t->device), MINOR(t->device));
+		fprintf(ofp,"%3d,%-3d", MAJOR(t_bit_dev(t)),
+				MINOR(t_bit_dev(t)));
 		break;
 	case 'e':
-		fprintf(ofp, strcat(format, "d"), t->error);
+		fprintf(ofp, strcat(format, "d"), t_bit_err(t));
 		break;
 	case 'M':
-		fprintf(ofp, strcat(format, "d"), MAJOR(t->device));
+		fprintf(ofp, strcat(format, "d"), MAJOR(t_bit_dev(t)));
 		break;
 	case 'm':
-		fprintf(ofp, strcat(format, "d"), MINOR(t->device));
+		fprintf(ofp, strcat(format, "d"), MINOR(t_bit_dev(t)));
 		break;
 	case 'n':
-		fprintf(ofp, strcat(format, "u"), t_sec(t));
+		fprintf(ofp, strcat(format, "u"), (t_bit_bytes(t) >> 9));
 		break;
 	case 'N':
-		fprintf(ofp, strcat(format, "u"), t->bytes);
+		fprintf(ofp, strcat(format, "u"), t_bit_bytes(t));
 		break;
 	case 'p':
-		fprintf(ofp, strcat(format, "u"), t->pid);
+		fprintf(ofp, strcat(format, "u"), t_bit_pid(t));
 		break;
 	case 'P': { /* format width ignored */
 		char *p = dump_pdu(pdu_buf, pdu_len);
@@ -227,17 +281,17 @@ static void print_field(char *act, struct per_cpu_info *pci,
 		break;
 	}
 	case 's':
-		fprintf(ofp, strcat(format, "ld"), t->sequence);
+		fprintf(ofp, strcat(format, "ld"), t_bit_seq(t));
 		break;
 	case 'S':
-		fprintf(ofp, strcat(format, "lu"), t->sector);
+		fprintf(ofp, strcat(format, "lu"), t_bit_sec(t));
 		break;
 	case 't':
 		sprintf(format, "%%0%dlu", has_w ? width : 9);
-		fprintf(ofp, format, NANO_SECONDS(t->time));
+		fprintf(ofp, format, NANO_SECONDS(t_bit_time(t)));
 		break;
 	case 'T':
-		fprintf(ofp, strcat(format, "d"), SECONDS(t->time));
+		fprintf(ofp, strcat(format, "d"), SECONDS(t_bit_time(t)));
 		break;
 	case 'u':
 		if (elapsed = -1ULL) {
@@ -250,7 +304,7 @@ static void print_field(char *act, struct per_cpu_info *pci,
 		fprintf(ofp, strcat(format, "u"), get_pdu_int(t));
 		break;
 	case 'z':
-		fprintf(ofp, strcat(format, "s"), print_time(t->time));
+		fprintf(ofp, strcat(format, "s"), print_time(t_bit_time(t)));
 		break;
 	default:
 		fprintf(ofp,strcat(format, "c"), field);
@@ -258,8 +312,9 @@ static void print_field(char *act, struct per_cpu_info *pci,
 	}
 }
 
+
 static char *parse_field(char *act, struct per_cpu_info *pci,
-			 struct blk_io_trace *t, unsigned long long elapsed,
+			 struct trace *t, unsigned long long elapsed,
 			 int pdu_len, unsigned char *pdu_buf,
 			 char *master_format)
 {
@@ -285,62 +340,97 @@ static char *parse_field(char *act, struct per_cpu_info *pci,
 	return p;
 }
 
+static inline bool t_zone_reset(struct trace *t)
+{
+	if (!t->use_ext)
+		return false;
+
+	return t_bit_act(t) & BLK_TC_ACT_EXT(BLK_TC_ZONE_RESET) ? true : false;
+}
 static void process_default(char *act, struct per_cpu_info *pci,
-			    struct blk_io_trace *t, unsigned long long elapsed,
+			    struct trace *t, unsigned long long elapsed,
 			    int pdu_len, unsigned char *pdu_buf)
 {
 	struct blk_io_trace_remap r = { .device_from = 0, };
 	char rwbs[8];
 	char *name;
 
-	fill_rwbs(rwbs, t);
-
+	t->use_ext ? fill_rwbs_ext(rwbs, t->bit_ext) : fill_rwbs(rwbs, t->bit);
 	 /*
 	  * For remaps we have to modify the device using the remap structure
 	  * passed up.
 	  */
-	 if (act[0] = 'A') {
-		 get_pdu_remap(t, &r);
-		 t->device = r.device_to;
-	 }
+	if (act[0] = 'A') {
+		get_pdu_remap(t, &r);
+		if (t->use_ext)
+			t->bit_ext->device = r.device_to;
+		else
+			t->bit->device = r.device_to;
+	}
 
 	/*
 	 * The header is always the same
 	 */
 	fprintf(ofp, "%3d,%-3d %2d %8d %5d.%09lu %5u %2s %3s ",
-		MAJOR(t->device), MINOR(t->device), pci->cpu, t->sequence,
-		(int) SECONDS(t->time), (unsigned long) NANO_SECONDS(t->time),
-		t->pid, act, rwbs);
+		MAJOR(t_bit_dev(t)), MINOR(t_bit_dev(t)), pci->cpu,
+		t_bit_seq(t), (int) SECONDS(t_bit_time(t)),
+		(unsigned long) NANO_SECONDS(t_bit_time(t)), t_bit_pid(t), act,
+		rwbs);
+
+	if (t->use_ext && blkparse_track_prio) {
+		switch (IOPRIO_PRIO_CLASS(t->bit_ext->ioprio)) {
+		case IOPRIO_CLASS_NONE:
+			if (blkparse_prio_mask & 0x1)
+				fprintf(ofp, "N ");
+			break;
+		case IOPRIO_CLASS_RT:
+			if (blkparse_prio_mask & 0x2)
+				fprintf(ofp, "R ");
+			break;
+		case IOPRIO_CLASS_BE:
+			if (blkparse_prio_mask & 0x4)
+				fprintf(ofp, "B ");
+			break;
+		case IOPRIO_CLASS_IDLE:
+			if (blkparse_prio_mask & 0x8)
+				fprintf(ofp, "I ");
+			break;
+		default:
+			fprintf(ofp, "E ");
+		}
+	}
 
-	name = find_process_name(t->pid);
+	name = find_process_name(t_bit_pid(t));
 
 	switch (act[0]) {
 	case 'R':	/* Requeue */
 	case 'C': 	/* Complete */
-		if (t->action & BLK_TC_ACT(BLK_TC_PC)) {
+		if (((u32)t_bit_act(t)) & BLK_TC_ACT(BLK_TC_PC)) {
 			char *p = dump_pdu(pdu_buf, pdu_len);
 			if (p)
 				fprintf(ofp, "(%s) ", p);
-			fprintf(ofp, "[%d]\n", t->error);
+			fprintf(ofp, "[%d]\n", t_bit_err(t));
 		} else {
 			if (elapsed != -1ULL) {
-				if (t_sec(t))
+				if ((t_bit_bytes(t) >> 9) || t_zone_reset(t))
 					fprintf(ofp, "%llu + %u (%8llu) [%d]\n",
-						(unsigned long long) t->sector,
-						t_sec(t), elapsed, t->error);
+						(unsigned long long) t_bit_sec(t),
+						t_bit_bytes(t) >> 9, elapsed,
+						t_bit_err(t));
 				else
 					fprintf(ofp, "%llu (%8llu) [%d]\n",
-						(unsigned long long) t->sector,
-						elapsed, t->error);
+						(unsigned long long) t_bit_sec(t),
+						elapsed, t_bit_err(t));
 			} else {
-				if (t_sec(t))
+				if ((t_bit_bytes(t) >> 9) || t_zone_reset(t))
 					fprintf(ofp, "%llu + %u [%d]\n",
-						(unsigned long long) t->sector,
-						t_sec(t), t->error);
+						(unsigned long long) t_bit_sec(t),
+						t_bit_bytes(t) >> 9,
+						t_bit_err(t));
 				else
 					fprintf(ofp, "%llu [%d]\n",
-						(unsigned long long) t->sector,
-						t->error);
+						(unsigned long long) t_bit_sec(t),
+						t_bit_err(t));
 			}
 		}
 		break;
@@ -349,27 +439,28 @@ static void process_default(char *act, struct per_cpu_info *pci,
 	case 'I': 	/* Insert */
 	case 'Q': 	/* Queue */
 	case 'B':	/* Bounce */
-		if (t->action & BLK_TC_ACT(BLK_TC_PC)) {
+		if (((u32)t_bit_act(t)) & BLK_TC_ACT(BLK_TC_PC)) {
 			char *p;
-			fprintf(ofp, "%u ", t->bytes);
+			fprintf(ofp, "%u ", t_bit_bytes(t));
 			p = dump_pdu(pdu_buf, pdu_len);
 			if (p)
 				fprintf(ofp, "(%s) ", p);
 			fprintf(ofp, "[%s]\n", name);
 		} else {
 			if (elapsed != -1ULL) {
-				if (t_sec(t))
+				if ((t_bit_bytes(t) >> 9) || t_zone_reset(t))
 					fprintf(ofp, "%llu + %u (%8llu) [%s]\n",
-						(unsigned long long) t->sector,
-						t_sec(t), elapsed, name);
+						(unsigned long long) t_bit_sec(t),
+						t_bit_bytes(t) >> 9, elapsed,
+						name);
 				else
 					fprintf(ofp, "(%8llu) [%s]\n", elapsed,
 						name);
 			} else {
-				if (t_sec(t))
+				if ((t_bit_bytes(t) >> 9) || t_zone_reset(t))
 					fprintf(ofp, "%llu + %u [%s]\n",
-						(unsigned long long) t->sector,
-						t_sec(t), name);
+						(unsigned long long) t_bit_sec(t),
+						t_bit_bytes(t) >> 9, name);
 				else
 					fprintf(ofp, "[%s]\n", name);
 			}
@@ -380,9 +471,10 @@ static void process_default(char *act, struct per_cpu_info *pci,
 	case 'F':	/* Front merge */
 	case 'G':	/* Get request */
 	case 'S':	/* Sleep request */
-		if (t_sec(t))
+		if ((t_bit_bytes(t) >> 9) || t_zone_reset(t))
 			fprintf(ofp, "%llu + %u [%s]\n",
-				(unsigned long long) t->sector, t_sec(t), name);
+				(unsigned long long) t_bit_sec(t),
+				t_bit_bytes(t) >> 9, name);
 		else
 			fprintf(ofp, "[%s]\n", name);
 		break;
@@ -399,13 +491,13 @@ static void process_default(char *act, struct per_cpu_info *pci,
 	case 'A': 	/* remap */
 		get_pdu_remap(t, &r);
 		fprintf(ofp, "%llu + %u <- (%d,%d) %llu\n",
-			(unsigned long long) t->sector, t_sec(t),
+			(unsigned long long) t_bit_sec(t), t_bit_bytes(t) >> 9,
 			MAJOR(r.device_from), MINOR(r.device_from),
 			(unsigned long long) r.sector_from);
 		break;
 
 	case 'X': 	/* Split */
-		fprintf(ofp, "%llu / %u [%s]\n", (unsigned long long) t->sector,
+		fprintf(ofp, "%llu / %u [%s]\n", (unsigned long long) t_bit_sec(t),
 			get_pdu_int(t), name);
 		break;
 
@@ -420,7 +512,7 @@ static void process_default(char *act, struct per_cpu_info *pci,
 
 }
 
-void process_fmt(char *act, struct per_cpu_info *pci, struct blk_io_trace *t,
+void process_fmt(char *act, struct per_cpu_info *pci, struct trace *t,
 		 unsigned long long elapsed, int pdu_len,
 		 unsigned char *pdu_buf)
 {
@@ -465,5 +557,3 @@ void process_fmt(char *act, struct per_cpu_info *pci, struct blk_io_trace *t,
 		}
 	}
 }
-
-
diff --git a/blktrace.h b/blktrace.h
index c1eecc4..3c61ea5 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -11,6 +11,7 @@
 
 #include "blktrace_api.h"
 #include "rbtree.h"
+#include "blkparse.h"
 
 #define MINORBITS	20
 #define MINORMASK	((1U << MINORBITS) - 1)
@@ -210,8 +211,9 @@ static inline int check_data_endianness(u32 magic)
 
 extern void set_all_format_specs(char *);
 extern int add_format_spec(char *);
-extern void process_fmt(char *, struct per_cpu_info *, struct blk_io_trace *,
-			unsigned long long, int, unsigned char *);
+void process_fmt(char *act, struct per_cpu_info *pci, struct trace *t,
+		 unsigned long long elapsed, int pdu_len,
+		 unsigned char *pdu_buf);
 extern int valid_act_opt(int);
 extern uint64_t valid_act_opt_ext(uint64_t x);
 extern int find_mask_map(char *);
-- 
2.19.1
