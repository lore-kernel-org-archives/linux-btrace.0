From: Eric Sandeen <sandeen@redhat.com>
Date: Fri, 16 Dec 2011 19:25:16 +0000
Subject: [PATCH 9/10] blkparse: initialize cpu_map
Message-Id: <4EEB9B1C.8040509@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

We malloc'd cpu_map, and then did:

	cpu_map[CPU_IDX(cpu)] |= (1UL << CPU_BIT(cpu));

... not sure how that ever worked if cpu_map was not initialized!

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/blkparse.c b/blkparse.c
index 169d491..96ad666 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -1962,6 +1962,7 @@ static int check_cpu_map(struct per_dev_info *pdi)
 	 * create a map of the cpus we have traces for
 	 */
 	cpu_map = malloc(pdi->cpu_map_max / sizeof(long));
+	memset(cpu_map, 0, sizeof(*cpu_map));
 	n = rb_first(&rb_sort_root);
 	while (n) {
 		__t = rb_entry(n, struct trace, rb_node);


