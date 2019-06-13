From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Thu, 13 Jun 2019 14:59:55 +0000
Subject: [PATCH 8/8] blktrace: use helper in blk_trace_setup_lba()
Message-Id: <20190613145955.4813-9-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190613145955.4813-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190613145955.4813-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-scsi@vger.kernel.org, linux-btrace@vger.kernel.org, kent.overstreet@gmail.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This patch updates the blk_trace_setup_lba() with newly introduced helper
function to read the nr_sects from block device's hd_parts with the
help if part_nr_sects_read() protected by appropriate locking.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index e1c6d79fb4cc..35ff49503b85 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -461,7 +461,7 @@ static void blk_trace_setup_lba(struct blk_trace *bt,
 
 	if (part) {
 		bt->start_lba = part->start_sect;
-		bt->end_lba = part->start_sect + part->nr_sects;
+		bt->end_lba = part->start_sect + bdev_nr_sects(bdev);
 	} else {
 		bt->start_lba = 0;
 		bt->end_lba = -1ULL;
-- 
2.19.1
