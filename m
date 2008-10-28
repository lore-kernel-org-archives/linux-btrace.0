From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Tue, 28 Oct 2008 16:08:05 +0000
Subject: [Patch 3/6] blkiomon: fix trace debug output
Message-Id: <1225210085.1060.31.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Martin Peschke <mpeschke@linux.vnet.ibm.com>

Removed leftovers of trace tree and made debug code work by using trace
hash instead of trace tree.

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>

---
 blkiomon.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/blkiomon.c
+++ b/blkiomon.c
@@ -78,7 +78,6 @@ static int interval = -1;
 
 static struct trace *vacant_traces_list = NULL;
 static int vacant_traces = 0;
-static struct rb_root trace_tree = RB_ROOT;
 
 #define TRACE_HASH_SIZE 128
 struct trace *thash[TRACE_HASH_SIZE] = {};
@@ -569,17 +568,18 @@ static int blkiomon_open_msg_q(void)
 
 static void blkiomon_debug(void)
 {
-	struct rb_node *n;
+	int i;
 	struct trace *t;
 
 	if (!debug.fn)
 		return;
 
-	for (n = rb_first(&trace_tree); n; n = rb_next(n)) {
-		t = rb_entry(n, struct trace, node);
-		dump_bit(t, "leftover");
-		leftover++;
-	}
+	for (i = 0; i < TRACE_HASH_SIZE; i++)
+		for (t = thash[i]; t; t = t->next) {
+			dump_bit(t, "leftover");
+			leftover++;
+		}
+
 	fprintf(debug.fp, "%ld leftover, %ld match, %ld mismatch, "
 		"%ld driverdata, %ld overall\n",
 		leftover, match, mismatch, driverdata, sequence);


