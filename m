From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:58:06 +0000
Subject: [blktrace-tools RFC PATCH 1/5] blktrace_api.h: add trace extension definitions
Message-Id: <20190602165810.14817-2-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

This patch adds trace extension definitions to the header blktrace
tools headers. We add new trace categories, trace actions, a new
structure to handle trace with new actions and categories with
an ability to handle priority along with new IOCTLs.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 blktrace_api.h | 107 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 19 deletions(-)

diff --git a/blktrace_api.h b/blktrace_api.h
index b222218..05fb6d2 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -3,33 +3,40 @@
 
 #include <asm/types.h>
 
+#define BLKTRACE_BDEV_SIZE	32
 /*
  * Trace categories
  */
 enum {
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
+	BLK_TC_READ		= 1 << 0,	/* reads */
+	BLK_TC_WRITE		= 1 << 1,	/* writes */
+	BLK_TC_FLUSH		= 1 << 2,	/* flush */
+	BLK_TC_SYNC		= 1 << 3,	/* sync */
+	BLK_TC_QUEUE		= 1 << 4,	/* queueing/merging */
+	BLK_TC_REQUEUE		= 1 << 5,	/* requeueing */
+	BLK_TC_ISSUE		= 1 << 6,	/* issue */
+	BLK_TC_COMPLETE		= 1 << 7,	/* completions */
+	BLK_TC_FS		= 1 << 8,	/* fs requests */
+	BLK_TC_PC		= 1 << 9,	/* pc requests */
+	BLK_TC_NOTIFY		= 1 << 10,	/* special message */
+	BLK_TC_AHEAD		= 1 << 11,	/* readahead */
+	BLK_TC_META		= 1 << 12,	/* metadata */
+	BLK_TC_DISCARD		= 1 << 13,	/* discard requests */
+	BLK_TC_DRV_DATA		= 1 << 14,	/* binary driver data */
+	BLK_TC_FUA		= 1 << 15,	/* fua requests */
+
+	BLK_TC_WRITE_ZEROES	= 1 << 16,	/* write-zeores */
+	BLK_TC_ZONE_RESET	= 1 << 17,	/* zone-reset */
+
+	BLK_TC_END		= 1 << 15,	/* we've run out of bits! */
+	BLK_TC_END_EXT		= 1 << 31,	/* we've run out of bits! */
 };
 
 #define BLK_TC_SHIFT		(16)
 #define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)
 
+#define BLK_TC_SHIFT_EXT   	(32)
+#define BLK_TC_ACT_EXT(act)		(((__u64)act) << BLK_TC_SHIFT_EXT)
 /*
  * Basic trace actions
  */
@@ -83,12 +90,37 @@ enum blktrace_notify {
 #define BLK_TA_ABORT		(__BLK_TA_ABORT | BLK_TC_ACT(BLK_TC_QUEUE))
 #define BLK_TA_DRV_DATA		(__BLK_TA_DRV_DATA | BLK_TC_ACT(BLK_TC_DRV_DATA))
 
+#define BLK_TA_QUEUE_EXT	(__BLK_TA_QUEUE | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_BACKMERGE_EXT	(__BLK_TA_BACKMERGE | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_FRONTMERGE_EXT	(__BLK_TA_FRONTMERGE | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_GETRQ_EXT	(__BLK_TA_GETRQ | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_SLEEPRQ_EXT	(__BLK_TA_SLEEPRQ | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_REQUEUE_EXT	(__BLK_TA_REQUEUE | BLK_TC_ACT_EXT(BLK_TC_REQUEUE))
+#define BLK_TA_ISSUE_EXT	(__BLK_TA_ISSUE | BLK_TC_ACT_EXT(BLK_TC_ISSUE))
+#define BLK_TA_COMPLETE_EXT	(__BLK_TA_COMPLETE| BLK_TC_ACT_EXT(BLK_TC_COMPLETE))
+#define BLK_TA_PLUG_EXT		(__BLK_TA_PLUG | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_UNPLUG_IO_EXT	(__BLK_TA_UNPLUG_IO | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_UNPLUG_TIMER_EXT	\
+	(__BLK_TA_UNPLUG_TIMER | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_INSERT_EXT	(__BLK_TA_INSERT | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_SPLIT_EXT	(__BLK_TA_SPLIT)
+#define BLK_TA_BOUNCE_EXT	(__BLK_TA_BOUNCE)
+#define BLK_TA_REMAP_EXT	(__BLK_TA_REMAP | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_ABORT_EXT	(__BLK_TA_ABORT | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_DRV_DATA_EXT	\
+	(__BLK_TA_DRV_DATA | BLK_TC_ACT_EXT(BLK_TC_DRV_DATA))
+
 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))
 
+#define BLK_TN_PROCESS_EXT	(__BLK_TN_PROCESS | BLK_TC_ACT_EXT(BLK_TC_NOTIFY))
+#define BLK_TN_TIMESTAMP_EXT	(__BLK_TN_TIMESTAMP | BLK_TC_ACT_EXT(BLK_TC_NOTIFY))
+#define BLK_TN_MESSAGE_EXT	(__BLK_TN_MESSAGE | BLK_TC_ACT_EXT(BLK_TC_NOTIFY))
+
 #define BLK_IO_TRACE_MAGIC	0x65617400
 #define BLK_IO_TRACE_VERSION	0x07
+#define BLK_IO_TRACE_VERSION_EXT	0x08
 
 /*
  * The trace itself
@@ -107,6 +139,25 @@ struct blk_io_trace {
 	__u16 pdu_len;		/* length of data after this trace */
 };
 
+/*
+ * The trace itself with extention
+ */
+struct blk_io_trace_ext {
+	__u32 magic;		/* MAGIC << 8 | version */
+	__u32 sequence;		/* event number */
+	__u64 time;		/* in nanoseconds */
+	__u64 sector;		/* disk offset */
+	__u32 bytes;		/* transfer length */
+	__u64 action;		/* what happened */
+	__u32 ioprio;		/* I/O priority */
+	__u32 pid;		/* who did it */
+	__u32 device;		/* device number */
+	__u32 cpu;		/* on what cpu did it happen */
+	__u16 error;		/* completion error */
+	__u16 pdu_len;		/* length of data after this trace */
+	/* cgroup id will be stored here if exists */
+};
+
 /*
  * The remap event
  */
@@ -120,7 +171,7 @@ struct blk_io_trace_remap {
  * User setup structure passed with BLKSTARTTRACE
  */
 struct blk_user_trace_setup {
-	char name[32];			/* output */
+	char name[BLKTRACE_BDEV_SIZE];	/* output */
 	__u16 act_mask;			/* input */
 	__u32 buf_size;			/* input */
 	__u32 buf_nr;			/* input */
@@ -129,9 +180,27 @@ struct blk_user_trace_setup {
 	__u32 pid;
 };
 
+/*
+ * User setup structure passed with BLKTRACESETUP_EXT
+ */
+struct blk_user_trace_setup_ext {
+	char name[BLKTRACE_BDEV_SIZE];	/* output */
+	__u64 act_mask;			/* input */
+	__u32 prio_mask;		/* input */
+	__u32 buf_size;			/* input */
+	__u32 buf_nr;			/* input */
+	__u64 start_lba;
+	__u64 end_lba;
+	__u32 pid;
+};
+
 #define BLKTRACESETUP _IOWR(0x12,115,struct blk_user_trace_setup)
 #define BLKTRACESTART _IO(0x12,116)
 #define BLKTRACESTOP _IO(0x12,117)
 #define BLKTRACETEARDOWN _IO(0x12,118)
+#define BLKTRACESETUP_EXT _IOWR(0x12,128,struct blk_user_trace_setup_ext)
+#define BLKTRACESTART_EXT _IO(0x12,129)
+#define BLKTRACESTOP_EXT _IO(0x12,130)
+#define BLKTRACETEARDOWN_EXT _IO(0x12,131)
 
 #endif
-- 
2.19.1
