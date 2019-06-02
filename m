From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:54 +0000
Subject: [RFC PATCH 45/46] power/swap: set bio iopriority field
Message-Id: <20190602165055.14424-46-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/power/swap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index d7f6c1a288d3..2ad770126719 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -273,6 +273,7 @@ static int hib_submit_io(int op, int op_flags, pgoff_t page_off, void *addr,
 	bio->bi_iter.bi_sector = page_off * (PAGE_SIZE >> 9);
 	bio_set_dev(bio, hib_resume_bdev);
 	bio_set_op_attrs(bio, op, op_flags);
+	bio_set_prio(bio, get_current_ioprio());
 
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
 		pr_err("Adding page to bio failed at %llu\n",
-- 
2.19.1
