From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Mon, 21 Jul 2008 18:38:18 +0000
Subject: [Patch kernel] Allow one to filter on specific trace actions
Message-Id: <4884D79A.5030001@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060506090905060607050604"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------060506090905060607050604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This kernel patch allows one to specify one or more trace actions to
filter on. This is different from trace categories - you can drill down
to getrq, sleeprq, ...

The associated application patch is next...

--------------060506090905060607050604
Content-Type: text/x-diff;
 name="0002-Allow-one-to-filter-on-specific-trace-actions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-Allow-one-to-filter-on-specific-trace-actions.patch"

From e82d1d848b1587c5a472ec5af503457d5e1353a1 Mon Sep 17 00:00:00 2001
From: Alan D. Brunelle <alan.brunelle@hp.com>
Date: Mon, 21 Jul 2008 14:22:34 -0400
Subject: [PATCH] Allow one to filter on specific trace actions


Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 block/blktrace.c             |    6 ++++++
 block/compat_ioctl.c         |    2 ++
 include/linux/blktrace_api.h |    4 ++++
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/block/blktrace.c b/block/blktrace.c
index 91c7f2b..05d08c9 100644
--- a/block/blktrace.c
+++ b/block/blktrace.c
@@ -98,6 +98,8 @@ static int act_log_check(struct blk_trace *bt, u32 what, sector_t sector,
 {
 	if (((bt->cat_mask << BLK_TC_SHIFT) & what) == 0)
 		return 1;
+	if ((bt->trace_mask & (1 << (what & BLK_TA_MASK))) == 0)
+		return 1;
 	if (sector < bt->start_lba || sector > bt->end_lba)
 		return 1;
 	if (bt->pid && pid != bt->pid)
@@ -389,6 +391,10 @@ int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!bt->cat_mask)
 		bt->cat_mask = (u16) -1;
 
+	bt->trace_mask = buts->trace_mask;
+	if (!bt->trace_mask)
+		bt->trace_mask = (u32) -1;
+
 	bt->start_lba = buts->start_lba;
 	bt->end_lba = buts->end_lba;
 	if (!bt->end_lba)
diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index ef0cc68..3002475 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -532,6 +532,7 @@ out:
 struct compat_blk_user_trace_setup {
 	char name[32];
 	u16 cat_mask;
+	u32 trace_mask;
 	u32 buf_size;
 	u32 buf_nr;
 	compat_u64 start_lba;
@@ -559,6 +560,7 @@ static int compat_blk_trace_setup(struct block_device *bdev, char __user *arg)
 
 	buts = (struct blk_user_trace_setup) {
 		.cat_mask = cbuts.cat_mask,
+		.trace_mask = cbuts.trace_mask,
 		.buf_size = cbuts.buf_size,
 		.buf_nr = cbuts.buf_nr,
 		.start_lba = cbuts.start_lba,
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 2abbcc0..e55ae37 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -49,6 +49,8 @@ enum blktrace_act {
 	__BLK_TA_REMAP,			/* bio was remapped */
 };
 
+#define BLK_TA_MASK            ((1 << BLK_TC_SHIFT) - 1)
+
 /*
  * Notify events.
  */
@@ -123,6 +125,7 @@ struct blk_trace {
 	unsigned long *sequence;
 	unsigned char *msg_data;
 	u16 cat_mask;
+	u32 trace_mask;
 	u64 start_lba;
 	u64 end_lba;
 	u32 pid;
@@ -138,6 +141,7 @@ struct blk_trace {
 struct blk_user_trace_setup {
 	char name[BDEVNAME_SIZE];	/* output */
 	u16 cat_mask;			/* input */
+	u32 trace_mask;			/* input */
 	u32 buf_size;			/* input */
 	u32 buf_nr;			/* input */
 	u64 start_lba;
-- 
1.5.4.3


--------------060506090905060607050604--
