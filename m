From: jeffm@suse.com
Date: Thu, 21 Oct 2021 14:16:20 +0000
Subject: [PATCH 2/2] blkparse: fix incorrectly sized memset in check_cpu_map
Message-Id: <20211021141620.2878-3-jeffm@suse.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

The memset call in check_cpu_map always clears sizeof(unsigned long *)
regardless of what size was allocated.  Use calloc instead to allocate
the map so it's zeroed properly regardless of the size requested.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 blkparse.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 498857c..9d2029a 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2236,8 +2236,7 @@ static int check_cpu_map(struct per_dev_info *pdi)
 	/*
 	 * create a map of the cpus we have traces for
 	 */
-	cpu_map = malloc(pdi->cpu_map_max / sizeof(long));
-	memset(cpu_map, 0, sizeof(*cpu_map));
+	cpu_map = calloc(1, pdi->cpu_map_max / sizeof(long));
 	n = rb_first(&rb_sort_root);
 	while (n) {
 		__t = rb_entry(n, struct trace, rb_node);
-- 
2.33.1
