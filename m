From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Mon, 24 Nov 2008 13:48:10 +0000
Subject: [Patch] blkiomon: fix min value
Message-Id: <1227534490.9636.21.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Reported-by: Stefan Raspl <raspl@linux.vnet.ibm.com>

A couple of min-counters weren't initialised correctly (thrput_r, thrput_w).
We have got a perfectly working init function for this purpose.
Removing partially duplicated code.

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Signed-off-by: Stefan Raspl <raspl@linux.vnet.ibm.com>
 
---
 blkiomon.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/blkiomon.c
+++ b/blkiomon.c
@@ -168,7 +168,7 @@ static struct dstat *blkiomon_alloc_dsta
 		return NULL;
 	}
 
-	memset(dstat, 0, sizeof(*dstat));
+	blkiomon_stat_init(&dstat->msg.stat);
 	return dstat;
 }
 
@@ -211,10 +211,6 @@ static struct dstat *blkiomon_get_dstat(
 		goto out;
 
 	dstat->msg.stat.device = device;
-	dstat->msg.stat.size_r.min = -1ULL;
-	dstat->msg.stat.size_w.min = -1ULL;
-	dstat->msg.stat.d2c_r.min = -1ULL;
-	dstat->msg.stat.d2c_w.min = -1ULL;
 
 	rb_link_node(&dstat->node, search.parent, search.node_ptr);
 	rb_insert_color(&dstat->node, &dstat_tree[dstat_curr]);


