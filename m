From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 23 Mar 2020 16:30:14 +0000
Subject: [RFC PATCH 31/39] blktrace: link blk_log_xxx() to trace action
Message-Id: <20200323163022.30688-32-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 07a12582d17d..05894c23f781 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -2355,6 +2355,28 @@ static const struct {
 	[__BLK_TA_REMAP]	= {{  "A", "remap" },	   blk_log_remap },
 };
 
+static const struct {
+	const char *act[2];
+	void	   (*print)(struct trace_seq *s, const struct trace_entry *ent,
+			    bool has_cg);
+} what2act_ext[] = {
+	[__BLK_TA_QUEUE]	= {{  "Q", "queue" },	   blk_log_generic_ext },
+	[__BLK_TA_BACKMERGE]	= {{  "M", "backmerge" },  blk_log_generic_ext },
+	[__BLK_TA_FRONTMERGE]	= {{  "F", "frontmerge" }, blk_log_generic_ext },
+	[__BLK_TA_GETRQ]	= {{  "G", "getrq" },	   blk_log_generic_ext },
+	[__BLK_TA_SLEEPRQ]	= {{  "S", "sleeprq" },	   blk_log_generic_ext },
+	[__BLK_TA_REQUEUE]	= {{  "R", "requeue" },	   blk_log_with_error_ext },
+	[__BLK_TA_ISSUE]	= {{  "D", "issue" },	   blk_log_generic_ext },
+	[__BLK_TA_COMPLETE]	= {{  "C", "complete" },   blk_log_with_error_ext },
+	[__BLK_TA_PLUG]		= {{  "P", "plug" },	   blk_log_plug },
+	[__BLK_TA_UNPLUG_IO]	= {{  "U", "unplug_io" },  blk_log_unplug_ext },
+	[__BLK_TA_UNPLUG_TIMER]	= {{ "UT", "unplug_timer" }, blk_log_unplug_ext},
+	[__BLK_TA_INSERT]	= {{  "I", "insert" },	   blk_log_generic_ext},
+	[__BLK_TA_SPLIT]	= {{  "X", "split" },	   blk_log_split_ext },
+	[__BLK_TA_BOUNCE]	= {{  "B", "bounce" },	   blk_log_generic_ext },
+	[__BLK_TA_REMAP]	= {{  "A", "remap" },	   blk_log_remap_ext },
+};
+
 static enum print_line_t print_one_line(struct trace_iterator *iter,
 					bool classic)
 {
-- 
2.22.0
