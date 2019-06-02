From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:58:07 +0000
Subject: [blktrace-tools RFC PATCH 2/5] blktrace.h: update tools header for trace extension
Message-Id: <20190602165810.14817-3-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

This patch updates blktrace tools header with various declarations and
definitions to support the blktrace extension. We add iopriority
definitions from the kernel header which are used in the blkparse tool
in order to track the iopriority. We add blktrace-extension version
to uniquely identify the trace along with the trace verification
and endianness helper.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 blktrace.h | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/blktrace.h b/blktrace.h
index 944fc08..c1eecc4 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -6,6 +6,8 @@
 #include <byteswap.h>
 #include <endian.h>
 #include <sys/types.h>
+#include <stdbool.h>
+#include <stdint.h>
 
 #include "blktrace_api.h"
 #include "rbtree.h"
@@ -26,6 +28,37 @@
 #define t_kb(t)		((t)->bytes >> 10)
 #define t_b(t)		((t)->bytes & 1023)
 
+/*
+ * Gives us 8 prio classes with 13-bits of data for each class
+ */
+#define IOPRIO_CLASS_SHIFT      (13)
+#define IOPRIO_PRIO_MASK        ((1UL << IOPRIO_CLASS_SHIFT) - 1)
+
+#define IOPRIO_PRIO_CLASS(mask) ((mask) >> IOPRIO_CLASS_SHIFT)
+#define IOPRIO_PRIO_DATA(mask)  ((mask) & IOPRIO_PRIO_MASK)
+#define IOPRIO_PRIO_VALUE(class, data)  (((class) << IOPRIO_CLASS_SHIFT) | data)
+
+#define ioprio_valid(mask)      (IOPRIO_PRIO_CLASS((mask)) != IOPRIO_CLASS_NONE)
+
+/*
+ * These are the io priority groups as implemented by CFQ. RT is the realtime
+ * class, it always gets premium service. BE is the best-effort scheduling
+ * class, the default for any process. IDLE is the idle scheduling class, it
+ * is only served when no one else is using the disk.
+ */
+enum {
+	IOPRIO_CLASS_NONE,
+	IOPRIO_CLASS_RT,
+	IOPRIO_CLASS_BE,
+	IOPRIO_CLASS_IDLE,
+	IOPRIO_CLASS_LAST,
+};
+
+#define TRACE_ALL_IOPRIO ((1 << IOPRIO_CLASS_NONE) | (1 << IOPRIO_CLASS_RT) | \
+		(1 << IOPRIO_CLASS_BE) | (1 << IOPRIO_CLASS_IDLE))
+
+extern bool blkparse_track_prio;
+extern uint32_t blkparse_prio_mask;
 typedef __u32 u32;
 typedef __u8 u8;
 
@@ -69,6 +102,7 @@ extern struct timespec abs_start_time;
 
 #define CHECK_MAGIC(t)		(((t)->magic & 0xffffff00) = BLK_IO_TRACE_MAGIC)
 #define SUPPORTED_VERSION	(0x07)
+#define SUPPORTED_VERSION_EXT	(0x08)
 
 #if __BYTE_ORDER = __LITTLE_ENDIAN
 #define be16_to_cpu(x)		__bswap_16(x)
@@ -95,6 +129,21 @@ static inline int verify_trace(struct blk_io_trace *t)
 		return 1;
 	}
 	if ((t->magic & 0xff) != SUPPORTED_VERSION) {
+		fprintf(stderr, "unsupported trace version %x\n",
+			t->magic & 0xff);
+		return 1;
+	}
+
+	return 0;
+}
+
+static inline int verify_trace_ext(struct blk_io_trace_ext *t)
+{
+	if (!CHECK_MAGIC(t)) {
+		fprintf(stderr, "bad trace magic %x\n", t->magic);
+		return 1;
+	}
+	if ((t->magic & 0xff) != SUPPORTED_VERSION_EXT) {
 		fprintf(stderr, "unsupported trace version %x\n", 
 			t->magic & 0xff);
 		return 1;
@@ -121,6 +170,25 @@ static inline void trace_to_cpu(struct blk_io_trace *t)
 	t->pdu_len	= be16_to_cpu(t->pdu_len);
 }
 
+static inline void trace_to_cpu_ext(struct blk_io_trace_ext *t)
+{
+	if (data_is_native)
+		return;
+
+	t->magic	= be32_to_cpu(t->magic);
+	t->sequence	= be32_to_cpu(t->sequence);
+	t->time		= be64_to_cpu(t->time);
+	t->sector	= be64_to_cpu(t->sector);
+	t->bytes	= be32_to_cpu(t->bytes);
+	t->action	= be64_to_cpu(t->action);
+	t->ioprio	= be32_to_cpu(t->ioprio);
+	t->pid		= be32_to_cpu(t->pid);
+	t->device	= be32_to_cpu(t->device);
+	t->cpu		= be32_to_cpu(t->cpu);
+	t->error	= be16_to_cpu(t->error);
+	t->pdu_len	= be16_to_cpu(t->pdu_len);
+}
+
 /*
  * check whether data is native or not
  */
@@ -145,7 +213,11 @@ extern int add_format_spec(char *);
 extern void process_fmt(char *, struct per_cpu_info *, struct blk_io_trace *,
 			unsigned long long, int, unsigned char *);
 extern int valid_act_opt(int);
+extern uint64_t valid_act_opt_ext(uint64_t x);
 extern int find_mask_map(char *);
+extern int find_mask_map_ext(char *string);
+extern bool valid_prio_opt(uint32_t x);
+extern int find_prio_mask_map(char *string);
 extern char *find_process_name(pid_t);
 
 #endif
-- 
2.19.1
