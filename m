From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:55 +0000
Subject: [RFC PATCH 46/46] mm: set bio iopriority field
Message-Id: <20190602165055.14424-47-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 mm/page_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_io.c b/mm/page_io.c
index 2e8019d0e048..aee83476e0f4 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -38,6 +38,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
 
 		bio->bi_iter.bi_sector = map_swap_page(page, &bdev);
 		bio_set_dev(bio, bdev);
+		bio_set_prio(bio, get_current_ioprio());
 		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
 		bio->bi_end_io = end_io;
 
-- 
2.19.1
