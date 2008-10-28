From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Tue, 28 Oct 2008 16:08:10 +0000
Subject: [Patch 5/6] blkiomon: separate statistics for read and write
Message-Id: <1225210090.1060.33.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Martin Peschke <mpeschke@linux.vnet.ibm.com>

Split min/max/avg statistics for request sizes and dispatch-to-completion
latencies into separate statistics for read and write requests.

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>

---
 blkiomon.c |   20 +++++++++++---------
 blkiomon.h |   40 +++++++++++++++++++++-------------------
 2 files changed, 32 insertions(+), 28 deletions(-)

--- a/blkiomon.h
+++ b/blkiomon.h
@@ -34,10 +34,10 @@ struct blkiomon_stat {
 	__u64 time;
 	__u32 size_hist[BLKIOMON_SIZE_BUCKETS];
 	__u32 d2c_hist[BLKIOMON_D2C_BUCKETS];
-	struct minmax size_mm;
-	struct minmax d2c_mm;
-	__u64 read;
-	__u64 write;
+	struct minmax size_r;
+	struct minmax size_w;
+	struct minmax d2c_r;
+	struct minmax d2c_w;
 	__u64 bidir;
 	__u32 device;
 } __attribute__ ((packed));
@@ -57,18 +57,20 @@ static struct histlog2 d2c_hist = {
 static inline void blkiomon_stat_init(struct blkiomon_stat *bstat)
 {
 	memset(bstat, 0, sizeof(*bstat));
-	minmax_init(&bstat->size_mm);
-	minmax_init(&bstat->d2c_mm);
+	minmax_init(&bstat->size_r);
+	minmax_init(&bstat->size_w);
+	minmax_init(&bstat->d2c_r);
+	minmax_init(&bstat->d2c_w);
 }
 
 static inline void blkiomon_stat_to_be(struct blkiomon_stat *bstat)
 {
 	histlog2_to_be(bstat->size_hist, &size_hist);
 	histlog2_to_be(bstat->d2c_hist, &d2c_hist);
-	minmax_to_be(&bstat->size_mm);
-	minmax_to_be(&bstat->d2c_mm);
-	bstat->read = cpu_to_be64(bstat->read);
-	bstat->write = cpu_to_be64(bstat->write);
+	minmax_to_be(&bstat->size_r);
+	minmax_to_be(&bstat->size_w);
+	minmax_to_be(&bstat->d2c_r);
+	minmax_to_be(&bstat->d2c_w);
 	bstat->bidir = cpu_to_be64(bstat->bidir);
 	bstat->time = cpu_to_be64(bstat->time);
 	bstat->device = cpu_to_be32(bstat->device);
@@ -79,10 +81,10 @@ static inline void blkiomon_stat_merge(s
 {
 	histlog2_merge(&size_hist, dst->size_hist, src->size_hist);
 	histlog2_merge(&d2c_hist, dst->d2c_hist, src->d2c_hist);
-	minmax_merge(&dst->size_mm, &src->size_mm);
-	minmax_merge(&dst->d2c_mm, &src->d2c_mm);
-	dst->read += src->read;
-	dst->write += src->write;
+	minmax_merge(&dst->size_r, &src->size_r);
+	minmax_merge(&dst->size_w, &src->size_w);
+	minmax_merge(&dst->d2c_r, &src->d2c_r);
+	minmax_merge(&dst->d2c_w, &src->d2c_w);
 	dst->bidir += src->bidir;
 }
 
@@ -93,13 +95,13 @@ static inline void blkiomon_stat_print(F
 
 	fprintf(fp, "\ntime: %s", ctime((void *)&p->time));
 	fprintf(fp, "device: %d,%d\n", MAJOR(p->device), MINOR(p->device));
-	fprintf(fp, "requests: read %ld, write %ld, bidir: %ld\n",
-		(unsigned long)p->read, (unsigned long)p->write,
-		(unsigned long)p->bidir);
-	minmax_print(fp, "sizes", &p->size_mm);
-	minmax_print(fp, "d2c", &p->d2c_mm);
+	minmax_print(fp, "sizes read (bytes)", &p->size_r);
+	minmax_print(fp, "sizes write (bytes)", &p->size_w);
+	minmax_print(fp, "d2c read (usec)", &p->d2c_r);
+	minmax_print(fp, "d2c write (usec)", &p->d2c_w);
 	histlog2_print(fp, "sizes histogram (bytes)", p->size_hist, &size_hist);
 	histlog2_print(fp, "d2c histogram (usec)", p->d2c_hist, &d2c_hist);
+	fprintf(fp, "bidirectional requests: %ld\n", (unsigned long)p->bidir);
 }
 
 #endif
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -211,8 +211,10 @@ static struct dstat *blkiomon_get_dstat(
 		goto out;
 
 	dstat->msg.stat.device = device;
-	dstat->msg.stat.size_mm.min = -1ULL;
-	dstat->msg.stat.d2c_mm.min = -1ULL;
+	dstat->msg.stat.size_r.min = -1ULL;
+	dstat->msg.stat.size_w.min = -1ULL;
+	dstat->msg.stat.d2c_r.min = -1ULL;
+	dstat->msg.stat.d2c_w.min = -1ULL;
 
 	rb_link_node(&dstat->node, search.parent, search.node_ptr);
 	rb_insert_color(&dstat->node, &dstat_tree[dstat_curr]);
@@ -320,17 +322,17 @@ static int blkiomon_account(struct blk_i
 		return 1;
 	p = &dstat->msg.stat;
 
-	if (BLK_DATADIR(bit_c->action) & BLK_TC_READ)
-		p->read++;
-	else if (BLK_DATADIR(bit_c->action) & BLK_TC_WRITE)
-		p->write++;
-	else
+	if (BLK_DATADIR(bit_c->action) & BLK_TC_READ) {
+		minmax_account(&p->size_r, size);
+		minmax_account(&p->d2c_r, d2c);
+	} else if (BLK_DATADIR(bit_c->action) & BLK_TC_WRITE) {
+		minmax_account(&p->size_w, size);
+		minmax_account(&p->d2c_w, d2c);
+	} else
 		p->bidir++;
 
 	histlog2_account(p->size_hist, size, &size_hist);
 	histlog2_account(p->d2c_hist, d2c, &d2c_hist);
-	minmax_account(&p->size_mm, size);
-	minmax_account(&p->d2c_mm, d2c);
 	return 0;
 }
 


