From: jeffm@suse.com
Date: Thu, 21 Oct 2021 14:16:19 +0000
Subject: [PATCH 1/2] blkparse: skip check_cpu_map with pipe input
Message-Id: <20211021141620.2878-2-jeffm@suse.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

When we're using pipe input, we don't track online CPUs and don't have a
cpu_map.  When we start to show entries, check_sequence will be invoked.
If the first entry isn't sequence 1 (perhaps it's been dropped?), we'll
proceed to check_cpu_map.  Since we haven't tracked online CPUs,
pdi->cpu_map_max will be 0 and we'll do a malloc(0).  Then we'll start
setting bits corresponding to CPU numbers in memory we don't own.  Since
there's nothing to check here, let's skip it on pipe input.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 blkparse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/blkparse.c b/blkparse.c
index f88204a..498857c 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2229,6 +2229,10 @@ static int check_cpu_map(struct per_dev_info *pdi)
 	unsigned int i;
 	int ret, cpu;
 
+	/* Pipe input doesn't do CPU online tracking. */
+	if (!pdi->cpu_map_max)
+		return 0;
+
 	/*
 	 * create a map of the cpus we have traces for
 	 */
-- 
2.33.1
