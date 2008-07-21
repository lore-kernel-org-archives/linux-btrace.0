From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Mon, 21 Jul 2008 14:13:11 +0000
Subject: Re: [PATCH kernel] Change 'act_mask' to 'cat_mask'
Message-Id: <48849977.9050702@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080402000808010501060304"
List-Id: <linux-btrace.vger.kernel.org>
References: <488493DA.8010701@hp.com>
In-Reply-To: <488493DA.8010701@hp.com>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------080402000808010501060304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<sigh> patch missed compat_ioctl structure fix...

--------------080402000808010501060304
Content-Type: text/x-diff;
 name="0001-Changed-act_mask-to-cat_mask-Categories-not-actio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Changed-act_mask-to-cat_mask-Categories-not-actio.patch"

From bbc85dabee6ed5e7af53bacdf2d5e7910d1e512a Mon Sep 17 00:00:00 2001
From: Alan D. Brunelle <alan.brunelle@hp.com>
Date: Mon, 21 Jul 2008 10:11:34 -0400
Subject: [PATCH] Changed act_mask to cat_mask - Categories, not actions

The mask actually pertains to /categories/ of actions - multiple actions
are encompassed w/in one category. This leads to confusion at the user
application level: one would /like/ to discriminate based upon individual
actions, we only support categories (for the moment).

This is preparatory to building a true action mask.

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 block/blktrace.c             |    8 ++++----
 block/compat_ioctl.c         |    4 ++--
 include/linux/blktrace_api.h |    4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/blktrace.c b/block/blktrace.c
index eb9651c..d2d639a 100644
--- a/block/blktrace.c
+++ b/block/blktrace.c
@@ -96,7 +96,7 @@ EXPORT_SYMBOL_GPL(__trace_note_message);
 static int act_log_check(struct blk_trace *bt, u32 what, sector_t sector,
 			 pid_t pid)
 {
-	if (((bt->act_mask << BLK_TC_SHIFT) & what) == 0)
+	if (((bt->cat_mask << BLK_TC_SHIFT) & what) == 0)
 		return 1;
 	if (sector < bt->start_lba || sector > bt->end_lba)
 		return 1;
@@ -428,9 +428,9 @@ int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!bt->rchan)
 		goto err;
 
-	bt->act_mask = buts->act_mask;
-	if (!bt->act_mask)
-		bt->act_mask = (u16) -1;
+	bt->cat_mask = buts->cat_mask;
+	if (!bt->cat_mask)
+		bt->cat_mask = (u16) -1;
 
 	bt->start_lba = buts->start_lba;
 	bt->end_lba = buts->end_lba;
diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index c23177e..ef0cc68 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -531,7 +531,7 @@ out:
 
 struct compat_blk_user_trace_setup {
 	char name[32];
-	u16 act_mask;
+	u16 cat_mask;
 	u32 buf_size;
 	u32 buf_nr;
 	compat_u64 start_lba;
@@ -558,7 +558,7 @@ static int compat_blk_trace_setup(struct block_device *bdev, char __user *arg)
 	bdevname(bdev, b);
 
 	buts = (struct blk_user_trace_setup) {
-		.act_mask = cbuts.act_mask,
+		.cat_mask = cbuts.cat_mask,
 		.buf_size = cbuts.buf_size,
 		.buf_nr = cbuts.buf_nr,
 		.start_lba = cbuts.start_lba,
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index d084b8d..f4c2e12 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -122,7 +122,7 @@ struct blk_trace {
 	struct rchan *rchan;
 	unsigned long *sequence;
 	unsigned char *msg_data;
-	u16 act_mask;
+	u16 cat_mask;
 	u64 start_lba;
 	u64 end_lba;
 	u32 pid;
@@ -138,7 +138,7 @@ struct blk_trace {
  */
 struct blk_user_trace_setup {
 	char name[BDEVNAME_SIZE];	/* output */
-	u16 act_mask;			/* input */
+	u16 cat_mask;			/* input */
 	u32 buf_size;			/* input */
 	u32 buf_nr;			/* input */
 	u64 start_lba;
-- 
1.5.4.3


--------------080402000808010501060304--
