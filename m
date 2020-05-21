From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 21 May 2020 12:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20200521120002.313B91BC0167@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit e81829a565162d41e2f551dc5e0f74f22f319554:

  blkparse: Fix up the sector and length of split completions (2020-05-07 12:22:37 -0600)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to a021a33b405b5101eec6c389e1dacd7934fdd35e:

  blkparse: Print PID information for TN_MESSAGE events (2020-05-20 07:38:26 -0600)

----------------------------------------------------------------
Jan Kara (4):
      blkparse: Handle cgroup information
      iowatcher: Use blktrace_api.h
      iowatcher: Handle cgroup information
      blkparse: Print PID information for TN_MESSAGE events

 blkparse.c           |  41 ++++++++++------
 blkparse_fmt.c       |  15 ++++++
 blktrace_api.h       |  10 ++++
 doc/blkparse.1       |   4 ++
 doc/blktrace.tex     |   3 ++
 iowatcher/blkparse.c | 134 +++++++++------------------------------------------
 6 files changed, 81 insertions(+), 126 deletions(-)

---

Diff of recent changes:

diff --git a/blkparse.c b/blkparse.c
index 796059b..33dd023 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -617,7 +617,7 @@ static void handle_notify(struct blk_io_trace *bit)
 	void	*payload = (caddr_t) bit + sizeof(*bit);
 	__u32	two32[2];
 
-	switch (bit->action) {
+	switch (bit->action & ~__BLK_TN_CGROUP) {
 	case BLK_TN_PROCESS:
 		add_ppm_hash(bit->pid, payload);
 		break;
@@ -643,16 +643,27 @@ static void handle_notify(struct blk_io_trace *bit)
 	case BLK_TN_MESSAGE:
 		if (bit->pdu_len > 0) {
 			char msg[bit->pdu_len+1];
+			int len = bit->pdu_len;
+			char cgidstr[24];
 
-			memcpy(msg, (char *)payload, bit->pdu_len);
-			msg[bit->pdu_len] = '\0';
+			cgidstr[0] = 0;
+			if (bit->action & __BLK_TN_CGROUP) {
+				struct blk_io_cgroup_payload *cgid = payload;
+
+				sprintf(cgidstr, "%x,%x ", cgid->ino,
+					cgid->gen);
+				payload += sizeof(struct blk_io_cgroup_payload);
+				len -= sizeof(struct blk_io_cgroup_payload);
+			}
+			memcpy(msg, (char *)payload, len);
+			msg[len] = '\0';
 
 			fprintf(ofp,
-				"%3d,%-3d %2d %8s %5d.%09lu %5u %2s %3s %s\n",
+				"%3d,%-3d %2d %8s %5d.%09lu %5u %s%2s %3s %s\n",
 				MAJOR(bit->device), MINOR(bit->device),
-				bit->cpu, "0", (int) SECONDS(bit->time),
-				(unsigned long) NANO_SECONDS(bit->time),
-				0, "m", "N", msg);
+				bit->cpu, "0", (int)SECONDS(bit->time),
+				(unsigned long)NANO_SECONDS(bit->time),
+				bit->pid, cgidstr, "m", "N", msg);
 		}
 		break;
 
@@ -1600,7 +1611,7 @@ static void dump_trace_pc(struct blk_io_trace *t, struct per_dev_info *pdi,
 			  struct per_cpu_info *pci)
 {
 	int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
-	int act = t->action & 0xffff;
+	int act = (t->action & 0xffff) & ~__BLK_TA_CGROUP;
 
 	switch (act) {
 		case __BLK_TA_QUEUE:
@@ -1649,7 +1660,7 @@ static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
 			  struct per_cpu_info *pci)
 {
 	int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
-	int act = t->action & 0xffff;
+	int act = (t->action & 0xffff) & ~__BLK_TA_CGROUP;
 
 	switch (act) {
 		case __BLK_TA_QUEUE:
@@ -1734,7 +1745,7 @@ static void dump_trace(struct blk_io_trace *t, struct per_cpu_info *pci,
 		       struct per_dev_info *pdi)
 {
 	if (text_output) {
-		if (t->action = BLK_TN_MESSAGE)
+		if ((t->action & ~__BLK_TN_CGROUP) = BLK_TN_MESSAGE)
 			handle_notify(t);
 		else if (t->action & BLK_TC_ACT(BLK_TC_PC))
 			dump_trace_pc(t, pdi, pci);
@@ -1749,7 +1760,7 @@ static void dump_trace(struct blk_io_trace *t, struct per_cpu_info *pci,
 
 	if (bin_output_msgs ||
 			    !(t->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
-			      t->action = BLK_TN_MESSAGE))
+			      (t->action & ~__BLK_TN_CGROUP) = BLK_TN_MESSAGE))
 		output_binary(t, sizeof(*t) + t->pdu_len);
 }
 
@@ -2325,7 +2336,7 @@ static void show_entries_rb(int force)
 			break;
 		}
 
-		if (!(bit->action = BLK_TN_MESSAGE) &&
+		if (!((bit->action & ~__BLK_TN_CGROUP) = BLK_TN_MESSAGE) &&
 		    check_sequence(pdi, t, force))
 			break;
 
@@ -2337,7 +2348,7 @@ static void show_entries_rb(int force)
 		if (!pci || pci->cpu != bit->cpu)
 			pci = get_cpu_info(pdi, bit->cpu);
 
-		if (!(bit->action = BLK_TN_MESSAGE))
+		if (!((bit->action & ~__BLK_TN_CGROUP) = BLK_TN_MESSAGE))
 			pci->last_sequence = bit->sequence;
 
 		pci->nelems++;
@@ -2471,7 +2482,7 @@ static int read_events(int fd, int always_block, int *fdblock)
 		/*
 		 * not a real trace, so grab and handle it here
 		 */
-		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && bit->action != BLK_TN_MESSAGE) {
+		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
 			handle_notify(bit);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
 			continue;
@@ -2620,7 +2631,7 @@ static int ms_prime(struct ms_stream *msp)
 			continue;
 		}
 
-		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && bit->action != BLK_TN_MESSAGE) {
+		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
 			handle_notify(bit);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
 			bit_free(bit);
diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index c42e6d7..df2f6ce 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -205,6 +205,21 @@ static void print_field(char *act, struct per_cpu_info *pci,
 	case 'e':
 		fprintf(ofp, strcat(format, "d"), t->error);
 		break;
+	case 'g': {
+		char cgidstr[24];
+		u32 ino = 0, gen = 0;
+
+		if (t->action & __BLK_TA_CGROUP) {
+			struct blk_io_cgroup_payload *cgid +				(struct blk_io_cgroup_payload *)pdu_buf;
+
+			ino = cgid->ino;
+			gen = cgid->gen;
+		}
+		sprintf(cgidstr, "%x,%x", ino, gen);
+		fprintf(ofp, strcat(format, "s"), cgidstr);
+		break;
+	}
 	case 'M':
 		fprintf(ofp, strcat(format, "d"), MAJOR(t->device));
 		break;
diff --git a/blktrace_api.h b/blktrace_api.h
index b222218..8c760b8 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -51,6 +51,7 @@ enum {
 	__BLK_TA_REMAP,			/* bio was remapped */
 	__BLK_TA_ABORT,			/* request aborted */
 	__BLK_TA_DRV_DATA,		/* binary driver data */
+	__BLK_TA_CGROUP = 1 << 8,
 };
 
 /*
@@ -60,6 +61,7 @@ enum blktrace_notify {
 	__BLK_TN_PROCESS = 0,		/* establish pid/name mapping */
 	__BLK_TN_TIMESTAMP,		/* include system clock */
 	__BLK_TN_MESSAGE,               /* Character string message */
+	__BLK_TN_CGROUP = __BLK_TA_CGROUP,
 };
 
 /*
@@ -116,6 +118,14 @@ struct blk_io_trace_remap {
 	__u64 sector_from;
 };
 
+/*
+ * Payload with originating cgroup info
+ */
+struct blk_io_cgroup_payload {
+	__u32 ino;
+	__u32 gen;
+};
+
 /*
  * User setup structure passed with BLKSTARTTRACE
  */
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index e494b6e..4c26baf 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -332,6 +332,10 @@ the event's device (separated by a comma).
 .IP \fBe\fR 4
 Error value
 
+.IP \fBg\fR 4
+Cgroup identifier of the cgroup that generated the IO. Note that this requires
+appropriate kernel support (kernel version at least 4.14).
+
 .IP \fBm\fR 4
 Minor number of event's device.
 
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 3647c75..836ac4a 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -601,6 +601,9 @@ Specifier & \\ \hline\hline
 the event's device \\
          & (separated by a comma). \\ \hline
 \emph{e} & Error value \\ \hline
+\emph{g} & Cgroup identifier of the cgroup that generated the IO. Note that this requires
+appropriate \\
+         & kernel support (kernel version at least 4.14). \\ \hline
 \emph{m} & Minor number of event's device. \\ \hline
 \emph{M} & Major number of event's device. \\ \hline
 \emph{n} & Number of blocks \\ \hline
diff --git a/iowatcher/blkparse.c b/iowatcher/blkparse.c
index 41e20f0..6203854 100644
--- a/iowatcher/blkparse.c
+++ b/iowatcher/blkparse.c
@@ -36,6 +36,7 @@
 #include "blkparse.h"
 #include "list.h"
 #include "tracers.h"
+#include "../blktrace_api.h"
 
 #define IO_HASH_TABLE_BITS  11
 #define IO_HASH_TABLE_SIZE (1 << IO_HASH_TABLE_BITS)
@@ -49,111 +50,8 @@ static struct list_head process_hash_table[PROCESS_HASH_TABLE_SIZE];
 extern int plot_io_action;
 extern int io_per_process;
 
-/*
- * Trace categories
- */
-enum {
-	BLK_TC_READ	= 1 << 0,	/* reads */
-	BLK_TC_WRITE	= 1 << 1,	/* writes */
-	BLK_TC_FLUSH	= 1 << 2,	/* flush */
-	BLK_TC_SYNC	= 1 << 3,	/* sync */
-	BLK_TC_QUEUE	= 1 << 4,	/* queueing/merging */
-	BLK_TC_REQUEUE	= 1 << 5,	/* requeueing */
-	BLK_TC_ISSUE	= 1 << 6,	/* issue */
-	BLK_TC_COMPLETE	= 1 << 7,	/* completions */
-	BLK_TC_FS	= 1 << 8,	/* fs requests */
-	BLK_TC_PC	= 1 << 9,	/* pc requests */
-	BLK_TC_NOTIFY	= 1 << 10,	/* special message */
-	BLK_TC_AHEAD	= 1 << 11,	/* readahead */
-	BLK_TC_META	= 1 << 12,	/* metadata */
-	BLK_TC_DISCARD	= 1 << 13,	/* discard requests */
-	BLK_TC_DRV_DATA	= 1 << 14,	/* binary driver data */
-	BLK_TC_FUA	= 1 << 15,	/* fua requests */
-
-	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
-};
-
-#define BLK_TC_SHIFT		(16)
-#define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)
 #define BLK_DATADIR(a) (((a) >> BLK_TC_SHIFT) & (BLK_TC_READ | BLK_TC_WRITE))
-
-/*
- * Basic trace actions
- */
-enum {
-	__BLK_TA_QUEUE = 1,		/* queued */
-	__BLK_TA_BACKMERGE,		/* back merged to existing rq */
-	__BLK_TA_FRONTMERGE,		/* front merge to existing rq */
-	__BLK_TA_GETRQ,			/* allocated new request */
-	__BLK_TA_SLEEPRQ,		/* sleeping on rq allocation */
-	__BLK_TA_REQUEUE,		/* request requeued */
-	__BLK_TA_ISSUE,			/* sent to driver */
-	__BLK_TA_COMPLETE,		/* completed by driver */
-	__BLK_TA_PLUG,			/* queue was plugged */
-	__BLK_TA_UNPLUG_IO,		/* queue was unplugged by io */
-	__BLK_TA_UNPLUG_TIMER,		/* queue was unplugged by timer */
-	__BLK_TA_INSERT,		/* insert request */
-	__BLK_TA_SPLIT,			/* bio was split */
-	__BLK_TA_BOUNCE,		/* bio was bounced */
-	__BLK_TA_REMAP,			/* bio was remapped */
-	__BLK_TA_ABORT,			/* request aborted */
-	__BLK_TA_DRV_DATA,		/* binary driver data */
-};
-
-#define BLK_TA_MASK ((1 << BLK_TC_SHIFT) - 1)
-
-/*
- * Notify events.
- */
-enum blktrace_notify {
-	__BLK_TN_PROCESS = 0,		/* establish pid/name mapping */
-	__BLK_TN_TIMESTAMP,		/* include system clock */
-	__BLK_TN_MESSAGE,               /* Character string message */
-};
-
-/*
- * Trace actions in full. Additionally, read or write is masked
- */
-#define BLK_TA_QUEUE		(__BLK_TA_QUEUE | BLK_TC_ACT(BLK_TC_QUEUE))
-#define BLK_TA_BACKMERGE	(__BLK_TA_BACKMERGE | BLK_TC_ACT(BLK_TC_QUEUE))
-#define BLK_TA_FRONTMERGE	(__BLK_TA_FRONTMERGE | BLK_TC_ACT(BLK_TC_QUEUE))
-#define	BLK_TA_GETRQ		(__BLK_TA_GETRQ | BLK_TC_ACT(BLK_TC_QUEUE))
-#define	BLK_TA_SLEEPRQ		(__BLK_TA_SLEEPRQ | BLK_TC_ACT(BLK_TC_QUEUE))
-#define	BLK_TA_REQUEUE		(__BLK_TA_REQUEUE | BLK_TC_ACT(BLK_TC_REQUEUE))
-#define BLK_TA_ISSUE		(__BLK_TA_ISSUE | BLK_TC_ACT(BLK_TC_ISSUE))
-#define BLK_TA_COMPLETE		(__BLK_TA_COMPLETE| BLK_TC_ACT(BLK_TC_COMPLETE))
-#define BLK_TA_PLUG		(__BLK_TA_PLUG | BLK_TC_ACT(BLK_TC_QUEUE))
-#define BLK_TA_UNPLUG_IO	(__BLK_TA_UNPLUG_IO | BLK_TC_ACT(BLK_TC_QUEUE))
-#define BLK_TA_UNPLUG_TIMER	(__BLK_TA_UNPLUG_TIMER | BLK_TC_ACT(BLK_TC_QUEUE))
-#define BLK_TA_INSERT		(__BLK_TA_INSERT | BLK_TC_ACT(BLK_TC_QUEUE))
-#define BLK_TA_SPLIT		(__BLK_TA_SPLIT)
-#define BLK_TA_BOUNCE		(__BLK_TA_BOUNCE)
-#define BLK_TA_REMAP		(__BLK_TA_REMAP | BLK_TC_ACT(BLK_TC_QUEUE))
-#define BLK_TA_ABORT		(__BLK_TA_ABORT | BLK_TC_ACT(BLK_TC_QUEUE))
-#define BLK_TA_DRV_DATA		(__BLK_TA_DRV_DATA | BLK_TC_ACT(BLK_TC_DRV_DATA))
-
-#define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
-#define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
-#define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))
-
-#define BLK_IO_TRACE_MAGIC	0x65617400
-#define BLK_IO_TRACE_VERSION	0x07
-/*
- * The trace itself
- */
-struct blk_io_trace {
-	__u32 magic;		/* MAGIC << 8 | version */
-	__u32 sequence;		/* event number */
-	__u64 time;		/* in nanoseconds */
-	__u64 sector;		/* disk offset */
-	__u32 bytes;		/* transfer length */
-	__u32 action;		/* what happened */
-	__u32 pid;		/* who did it */
-	__u32 device;		/* device identifier (dev_t) */
-	__u32 cpu;		/* on what cpu did it happen */
-	__u16 error;		/* completion error */
-	__u16 pdu_len;		/* length of data after this trace */
-};
+#define BLK_TA_MASK (((1 << BLK_TC_SHIFT) - 1) & ~__BLK_TA_CGROUP)
 
 struct pending_io {
 	/* sector offset of this IO */
@@ -362,18 +260,23 @@ static void handle_notify(struct trace *trace)
 {
 	struct blk_io_trace *io = trace->io;
 	void *payload = (char *)io + sizeof(*io);
+	int pdu_len = io->pdu_len;
 	u32 two32[2];
 
-	if (io->action = BLK_TN_PROCESS) {
+	if (io->action & __BLK_TN_CGROUP) {
+		payload += sizeof(struct blk_io_cgroup_payload);
+		pdu_len -= sizeof(struct blk_io_cgroup_payload);
+	}
+	if ((io->action & ~__BLK_TN_CGROUP) = BLK_TN_PROCESS) {
 		if (io_per_process)
 			process_hash_insert(io->pid, payload);
 		return;
 	}
 
-	if (io->action != BLK_TN_TIMESTAMP)
+	if ((io->action & ~__BLK_TN_CGROUP) != BLK_TN_TIMESTAMP)
 		return;
 
-	if (io->pdu_len != sizeof(two32))
+	if (pdu_len != sizeof(two32))
 		return;
 
 	memcpy(two32, payload, sizeof(two32));
@@ -411,11 +314,16 @@ static int is_io_event(struct blk_io_trace *test)
 	char *message;
 	if (!(test->action & BLK_TC_ACT(BLK_TC_NOTIFY)))
 		return 1;
-	if (test->action = BLK_TN_MESSAGE) {
+	if ((test->action & ~__BLK_TN_CGROUP) = BLK_TN_MESSAGE) {
 		int len = test->pdu_len;
+
+		message = (char *)(test + 1);
+		if (test->action & __BLK_TN_CGROUP) {
+			len -= sizeof(struct blk_io_cgroup_payload);
+			message += sizeof(struct blk_io_cgroup_payload);
+		}
 		if (len < 3)
 			return 0;
-		message = (char *)(test + 1);
 		if (strncmp(message, "fio ", 4) = 0) {
 			return 1;
 		}
@@ -474,13 +382,17 @@ static int parse_fio_bank_message(struct trace *trace, u64 *bank_ret, u64 *offse
 
 	if (!(test->action & BLK_TC_ACT(BLK_TC_NOTIFY)))
 		return -1;
-	if (test->action != BLK_TN_MESSAGE)
+	if ((test->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE)
 		return -1;
 
+	message = (char *)(test + 1);
+	if (test->action & __BLK_TN_CGROUP) {
+		len -= sizeof(struct blk_io_cgroup_payload);
+		message += sizeof(struct blk_io_cgroup_payload);
+	}
 	/* the message is fio rw bank offset num_banks */
 	if (len < 3)
 		return -1;
-	message = (char *)(test + 1);
 	if (strncmp(message, "fio r ", 6) != 0)
 		return -1;
 
