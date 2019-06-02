From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:10 +0000
Subject: [RFC PATCH 01/46] blktrace_api: add new trace definitions
Message-Id: <20190602165055.14424-2-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

This patch adds a new trace categories, trace actions adds a new
version number for the trace extentions, adds new trace extension
structure to hold actual trace along with structure nedded to
execute various IOCTLs to configure trace from user space.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 105 ++++++++++++++++++++++++------
 1 file changed, 84 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 690621b610e5..76e943083da9 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -8,30 +8,36 @@
  * Trace categories
  */
 enum blktrace_cat {
-	BLK_TC_READ	= 1 << 0,	/* reads */
-	BLK_TC_WRITE	= 1 << 1,	/* writes */
-	BLK_TC_FLUSH	= 1 << 2,	/* flush */
-	BLK_TC_SYNC	= 1 << 3,	/* sync IO */
-	BLK_TC_SYNCIO	= BLK_TC_SYNC,
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
-	BLK_TC_DRV_DATA	= 1 << 14,	/* binary per-driver data */
-	BLK_TC_FUA	= 1 << 15,	/* fua requests */
-
-	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
+	BLK_TC_READ		= 1 << 0,	/* reads */
+	BLK_TC_WRITE		= 1 << 1,	/* writes */
+	BLK_TC_FLUSH		= 1 << 2,	/* flush */
+	BLK_TC_SYNC		= 1 << 3,	/* sync IO */
+	BLK_TC_SYNCIO		= BLK_TC_SYNC,
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
+	BLK_TC_DRV_DATA		= 1 << 14,	/* binary per-driver data */
+	BLK_TC_FUA		= 1 << 15,	/* fua requests */
+	BLK_TC_WRITE_ZEROES	= 1 << 16,	/* write-zeores */
+	BLK_TC_ZONE_RESET	= 1 << 17,	/* zone-reset */
+
+	BLK_TC_END		= 1 << 15,	/* we've run out of bits! */
+	BLK_TC_END_EXT		= 1 << 31,	/* we've run out of bits! */
 };
 
 #define BLK_TC_SHIFT		(16)
 #define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)
 
+#define BLK_TC_SHIFT_EXT   	(32)
+#define BLK_TC_ACT_EXT(act)		(((u64)act) << BLK_TC_SHIFT_EXT)
+
 /*
  * Basic trace actions
  */
@@ -88,12 +94,38 @@ enum blktrace_notify {
 #define BLK_TA_ABORT		(__BLK_TA_ABORT | BLK_TC_ACT(BLK_TC_QUEUE))
 #define BLK_TA_DRV_DATA	(__BLK_TA_DRV_DATA | BLK_TC_ACT(BLK_TC_DRV_DATA))
 
+#define BLK_TA_QUEUE_EXT       (__BLK_TA_QUEUE | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_BACKMERGE_EXT   (__BLK_TA_BACKMERGE | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_FRONTMERGE_EXT  (__BLK_TA_FRONTMERGE | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_GETRQ_EXT       (__BLK_TA_GETRQ | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_SLEEPRQ_EXT     (__BLK_TA_SLEEPRQ | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_REQUEUE_EXT     (__BLK_TA_REQUEUE | BLK_TC_ACT_EXT(BLK_TC_REQUEUE))
+#define BLK_TA_ISSUE_EXT       (__BLK_TA_ISSUE | BLK_TC_ACT_EXT(BLK_TC_ISSUE))
+#define BLK_TA_COMPLETE_EXT    (__BLK_TA_COMPLETE| BLK_TC_ACT_EXT(BLK_TC_COMPLETE))
+#define BLK_TA_PLUG_EXT                (__BLK_TA_PLUG | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_UNPLUG_IO_EXT   (__BLK_TA_UNPLUG_IO | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_UNPLUG_TIMER_EXT        \
+       (__BLK_TA_UNPLUG_TIMER | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_INSERT_EXT      (__BLK_TA_INSERT | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_SPLIT_EXT       (__BLK_TA_SPLIT)
+#define BLK_TA_BOUNCE_EXT      (__BLK_TA_BOUNCE)
+#define BLK_TA_REMAP_EXT       (__BLK_TA_REMAP | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_ABORT_EXT       (__BLK_TA_ABORT | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_DRV_DATA_EXT    \
+       (__BLK_TA_DRV_DATA | BLK_TC_ACT_EXT(BLK_TC_DRV_DATA))
+
 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))
 
-#define BLK_IO_TRACE_MAGIC	0x65617400
-#define BLK_IO_TRACE_VERSION	0x07
+#define BLK_TN_PROCESS_EXT     (__BLK_TN_PROCESS | BLK_TC_ACT_EXT(BLK_TC_NOTIFY))
+#define BLK_TN_TIMESTAMP_EXT   (__BLK_TN_TIMESTAMP | BLK_TC_ACT_EXT(BLK_TC_NOTIFY))
+#define BLK_TN_MESSAGE_EXT     (__BLK_TN_MESSAGE | BLK_TC_ACT_EXT(BLK_TC_NOTIFY))
+
+#define BLK_IO_TRACE_MAGIC             0x65617400
+#define BLK_IO_TRACE_VERSION           0x07
+#define BLK_IO_TRACE_VERSION_EXT       0x08
+
 
 /*
  * The trace itself
@@ -113,6 +145,23 @@ struct blk_io_trace {
 	/* cgroup id will be stored here if exists */
 };
 
+struct blk_io_trace_ext {
+	__u32 magic;            /* MAGIC << 8 | version */
+	__u32 sequence;         /* event number */
+	__u64 time;             /* in nanoseconds */
+	__u64 sector;           /* disk offset */
+	__u32 bytes;            /* transfer length */
+	__u64 action;           /* what happened */
+	__u32 ioprio;           /* I/O priority */
+	__u32 pid;              /* who did it */
+	__u32 device;           /* device number */
+	__u32 cpu;              /* on what cpu did it happen */
+	__u16 error;            /* completion error */
+	__u16 pdu_len;          /* length of data after this trace */
+	/* cgroup id will be stored here if exists */
+};
+
+
 /*
  * The remap event
  */
@@ -143,4 +192,18 @@ struct blk_user_trace_setup {
 	__u32 pid;
 };
 
+/*
+ * User setup structure passed with BLKTRACESETUP_EXT
+ */
+struct blk_user_trace_setup_ext {
+	char name[BLKTRACE_BDEV_SIZE];  /* output */
+	__u64 act_mask;                 /* input */
+	__u32 prio_mask;                /* input */
+	__u32 buf_size;                 /* input */
+	__u32 buf_nr;                   /* input */
+	__u64 start_lba;
+	__u64 end_lba;
+	__u32 pid;
+};
+
 #endif /* _UAPIBLKTRACE_H */
-- 
2.19.1
