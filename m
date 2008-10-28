From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Tue, 28 Oct 2008 16:08:12 +0000
Subject: [Patch 6/6] blkiomon: add through-put statistics
Message-Id: <1225210092.1060.34.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Martin Peschke <mpeschke@linux.vnet.ibm.com>

Add accounting of per-request throughput in bytes per millisecond
both for read ad write I/O.

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>

---
 blkiomon.c |    3 +++
 blkiomon.h |   10 ++++++++++
 2 files changed, 13 insertions(+)

--- a/blkiomon.c
+++ b/blkiomon.c
@@ -316,6 +316,7 @@ static int blkiomon_account(struct blk_i
 	struct blkiomon_stat *p;
 	__u64 d2c = (bit_c->time - bit_d->time) / 1000; /* ns -> us */
 	__u32 size = bit_d->bytes;
+	__u64 thrput = size * 1000 / d2c;
 
 	dstat = blkiomon_get_dstat(bit_d->device);
 	if (!dstat)
@@ -323,9 +324,11 @@ static int blkiomon_account(struct blk_i
 	p = &dstat->msg.stat;
 
 	if (BLK_DATADIR(bit_c->action) & BLK_TC_READ) {
+		minmax_account(&p->thrput_r, thrput);
 		minmax_account(&p->size_r, size);
 		minmax_account(&p->d2c_r, d2c);
 	} else if (BLK_DATADIR(bit_c->action) & BLK_TC_WRITE) {
+		minmax_account(&p->thrput_w, thrput);
 		minmax_account(&p->size_w, size);
 		minmax_account(&p->d2c_w, d2c);
 	} else
--- a/blkiomon.h
+++ b/blkiomon.h
@@ -38,6 +38,8 @@ struct blkiomon_stat {
 	struct minmax size_w;
 	struct minmax d2c_r;
 	struct minmax d2c_w;
+	struct minmax thrput_r;
+	struct minmax thrput_w;
 	__u64 bidir;
 	__u32 device;
 } __attribute__ ((packed));
@@ -61,6 +63,8 @@ static inline void blkiomon_stat_init(st
 	minmax_init(&bstat->size_w);
 	minmax_init(&bstat->d2c_r);
 	minmax_init(&bstat->d2c_w);
+	minmax_init(&bstat->thrput_r);
+	minmax_init(&bstat->thrput_w);
 }
 
 static inline void blkiomon_stat_to_be(struct blkiomon_stat *bstat)
@@ -71,6 +75,8 @@ static inline void blkiomon_stat_to_be(s
 	minmax_to_be(&bstat->size_w);
 	minmax_to_be(&bstat->d2c_r);
 	minmax_to_be(&bstat->d2c_w);
+	minmax_to_be(&bstat->thrput_r);
+	minmax_to_be(&bstat->thrput_w);
 	bstat->bidir = cpu_to_be64(bstat->bidir);
 	bstat->time = cpu_to_be64(bstat->time);
 	bstat->device = cpu_to_be32(bstat->device);
@@ -85,6 +91,8 @@ static inline void blkiomon_stat_merge(s
 	minmax_merge(&dst->size_w, &src->size_w);
 	minmax_merge(&dst->d2c_r, &src->d2c_r);
 	minmax_merge(&dst->d2c_w, &src->d2c_w);
+	minmax_merge(&dst->thrput_r, &src->thrput_r);
+	minmax_merge(&dst->thrput_w, &src->thrput_w);
 	dst->bidir += src->bidir;
 }
 
@@ -99,6 +107,8 @@ static inline void blkiomon_stat_print(F
 	minmax_print(fp, "sizes write (bytes)", &p->size_w);
 	minmax_print(fp, "d2c read (usec)", &p->d2c_r);
 	minmax_print(fp, "d2c write (usec)", &p->d2c_w);
+	minmax_print(fp, "throughput read (bytes/msec)", &p->thrput_r);
+	minmax_print(fp, "throughput write (bytes/msec)", &p->thrput_w);
 	histlog2_print(fp, "sizes histogram (bytes)", p->size_hist, &size_hist);
 	histlog2_print(fp, "d2c histogram (usec)", p->d2c_hist, &d2c_hist);
 	fprintf(fp, "bidirectional requests: %ld\n", (unsigned long)p->bidir);


