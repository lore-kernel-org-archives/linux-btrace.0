From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Wed, 21 Jan 2009 13:58:30 +0000
Subject: [Patch] blkiomon: fix min value
Message-Id: <1232546310.466.24.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi Jens,
here is one of two fixes, which have not made it into blktrace yet.
I posted them end of last year
http://marc.info/?l=linux-btrace&m2753449808364&w=2

Please apply. Thanks,
Martin



From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Reported-by: Stefan Raspl <raspl@linux.vnet.ibm.com>

A couple of min-counters weren't initialised correctly (thrput_r,
thrput_w).
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




