From: "Alan D. Brunelle" <alan.brunelle@hp.com>
Date: Mon, 09 Apr 2007 14:24:32 +0000
Subject: [BTT PATCH] Clean up all memory leaks
Message-Id: <461A4CA0.10808@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090507070403000109020705"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------090507070403000109020705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------090507070403000109020705
Content-Type: text/plain;
 name="release-all-mem"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="release-all-mem"

From Alan D. Brunelle <Alan.Brunelle@hp.com>

Ensure that all allocated memory was released.

Lots of minor clean up to help ensure all allocated memory is freed
prior to exit. (Also closed a few files that were left open.)

# valgrind --leak-check=yes --show-reachable=yes btt -i bp.bin -o btt -v
==21322== Memcheck, a memory error detector.
==21322== Copyright (C) 2002-2006, and GNU GPL'd, by Julian Seward et al.
==21322== Using LibVEX rev 1658, a library for dynamic binary translation.
==21322== Copyright (C) 2004-2006, and GNU GPL'd, by OpenWorks LLP.
==21322== Using valgrind-3.2.1-Debian, a dynamic binary instrumentation framework.
==21322== Copyright (C) 2000-2006, and GNU GPL'd, by Julian Seward et al.
==21322== For more details, rerun with: -v
==21322== 
Sending range data to btt.dat
Sending stats data to btt.avg
   4581291 traces @ 10.7 Ktps in 426.578804 seconds                             	tree = |0|
   ==21322== 
   ==21322== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 8 from 1)
   ==21322== malloc/free: in use at exit: 0 bytes in 0 blocks.
   ==21322== malloc/free: 11,241,958 allocs, 11,241,958 frees, 440,381,362 bytes allocated.
   ==21322== For counts of detected errors, rerun with: -v
   ==21322== All heap blocks were freed -- no leaks are possible.

Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>
---

 btt/Makefile      |    4 +--
 btt/args.c        |   51 ++++++++++++++++++++++++------------
 btt/bno_dump.c    |    8 ++++++
 btt/bt_timeline.c |   48 +++++++++++++++++++++-------------
 btt/devmap.c      |   10 +++++++
 btt/devs.c        |   45 +++++++++++++++++++++++++++++++-
 btt/globals.h     |   14 +++++++---
 btt/inlines.h     |   75 +++++++++++++++++++++++++++++++++--------------------
 btt/misc.c        |   35 ++++++++++++++++++++-----
 btt/output.c      |    9 +++---
 btt/proc.c        |   32 +++++++++++++++++++----
 btt/seek.c        |   22 ++++++++++++++++
 12 files changed, 266 insertions(+), 87 deletions(-)

diff --git a/btt/Makefile b/btt/Makefile
index ba9e86f..fcb09a4 100644
--- a/btt/Makefile
+++ b/btt/Makefile
@@ -3,8 +3,8 @@ CC	= gcc
 ECFLAGS	= 
 # ECFLAGS	= -DCOUNT_IOS
 
-CFLAGS	= -Wall -O2 -W -g $(ECFLAGS)
-# CFLAGS	= -Wall -g -W -UDO_INLINE -DDEBUG $(ECFLAGS)
+# CFLAGS	= -Wall -O2 -W -g $(ECFLAGS)
+CFLAGS	= -Wall -g -W -UDO_INLINE -DDEBUG $(ECFLAGS)
 
 ALL_CFLAGS = $(CFLAGS) -I.. -D_GNU_SOURCE -D_LARGEFILE_SOURCE \
 		-D_FILE_OFFSET_BITS=64
diff --git a/btt/args.c b/btt/args.c
index 4bbcf76..9aa24ae 100644
--- a/btt/args.c
+++ b/btt/args.c
@@ -27,6 +27,8 @@
 #include <fcntl.h>
 #include "globals.h"
 
+#define SETBUFFER_SIZE	(64 * 1024)
+
 #define S_OPTS	"AB:d:D:e:hi:I:l:M:o:p:q:s:S:t:T:Vv"
 static struct option l_opts[] = {
 	{
@@ -169,12 +171,42 @@ static char usage_str[] = \
 	"[ -V               | --version ]\n" \
 	"[ -v               | --verbose ]\n\n";
 
+static struct file_info *arg_files = NULL;
+
 static void usage(char *prog)
 {
 	fprintf(stderr, "Usage: %s %s %s", prog, bt_timeline_version,
 		usage_str);
 }
 
+static FILE *setup_ofile(char *fname)
+{
+	if (fname) {
+		char *buf;
+		FILE *ofp = fopen(fname, "w");
+
+		if (!ofp) {
+			perror(fname);
+			exit(1);
+		}
+
+		buf = malloc(SETBUFFER_SIZE);
+		assert(buf);
+
+		setbuffer(ofp, buf, SETBUFFER_SIZE);
+		add_file(&arg_files, ofp, fname);
+		add_buf(buf);
+		return ofp;
+	}
+
+	return NULL;
+}
+
+void clean_args(void)
+{
+	clean_files(&arg_files);
+}
+
 void handle_args(int argc, char *argv[])
 {
 	int c;
@@ -283,21 +315,6 @@ void handle_args(int argc, char *argv[])
 		free(fname);
 	}
 
-	if (iostat_name != NULL) {
-		iostat_ofp = fopen(iostat_name, "w");
-		if (iostat_ofp == NULL) {
-			perror(iostat_name);
-			exit(1);
-		}
-		setbuffer(iostat_ofp, malloc(64 * 1024), 64 * 1024);
-	}
-
-	if (per_io_name != NULL) {
-		per_io_ofp = fopen(per_io_name, "w");
-		if (per_io_ofp == NULL) {
-			perror(per_io_name);
-			exit(1);
-		}
-		setbuffer(per_io_ofp, malloc(64 * 1024), 64 * 1024);
-	}
+	iostat_ofp = setup_ofile(iostat_name);
+	per_io_ofp = setup_ofile(per_io_name);
 }
diff --git a/btt/bno_dump.c b/btt/bno_dump.c
index c990171..d1bc6ab 100644
--- a/btt/bno_dump.c
+++ b/btt/bno_dump.c
@@ -58,6 +58,14 @@ void *bno_dump_init(__u32 device)
 	return bdp;
 }
 
+void bno_dump_exit(void *param)
+{
+	/*
+	 * Associated files will be auto-cleaned by bno_dump_clean
+	 */
+	free(param);
+}
+
 static inline void bno_dump_write(FILE *fp, struct io *iop)
 {
 	fprintf(fp, "%15.9lf %lld %lld\n",
diff --git a/btt/bt_timeline.c b/btt/bt_timeline.c
index 045c081..32c900e 100644
--- a/btt/bt_timeline.c
+++ b/btt/bt_timeline.c
@@ -50,8 +50,6 @@ __u64 next_retry_check = 0;
 struct region_info all_regions = {
 	.qranges = LIST_HEAD_INIT(all_regions.qranges),
 	.cranges = LIST_HEAD_INIT(all_regions.cranges),
-	.qr_cur = NULL,
-	.cr_cur = NULL
 };
 
 #if defined(DEBUG)
@@ -74,6 +72,30 @@ int main(int argc, char *argv[])
 	if (process() || output_avgs(avgs_ofp) || output_ranges(ranges_ofp))
 		return 1;
 
+	if (iostat_ofp) {
+		fprintf(iostat_ofp, "\n");
+		iostat_dump_stats(iostat_last_stamp, 1);
+	}
+
+	if (ranges_ofp != stdout) 
+		fclose(ranges_ofp);
+	if (avgs_ofp != stdout) 
+		fclose(avgs_ofp);
+
+	seek_clean();
+	latency_clean();
+	bno_dump_clean();
+	dev_map_exit();
+	dip_exit();
+	pip_exit();
+	io_free_all();
+	region_exit(&all_regions);
+
+	free(input_name);
+	if (output_name) free(output_name);
+
+	clean_bufs();
+
 	return 0;
 }
 
@@ -86,7 +108,7 @@ int process(void)
 {
 	int ret = 0;
 	struct io *iop = io_alloc();
-	struct timeval tvs, tvi, tve;
+	struct timeval tvs, tve;
 
 	genesis = last_vtrace = time(NULL);
 	gettimeofday(&tvs, NULL);
@@ -97,27 +119,17 @@ int process(void)
 
 	io_release(iop);
 	do_retries(0);
-
-	gettimeofday(&tvi, NULL);
-
-	if (iostat_ofp) {
-		fprintf(iostat_ofp, "\n");
-		iostat_dump_stats(iostat_last_stamp, 1);
-	}
-
-	seek_clean();
-	latency_clean();
-	bno_dump_clean();
 	gettimeofday(&tve, NULL);
 
 	if (verbose) {
-		double tps, dt_input = tv2dbl(&tvi) - tv2dbl(&tvs);
+		double tps, dt_input = tv2dbl(&tve) - tv2dbl(&tvs);
 		
 		tps = (double)n_traces / dt_input;
-		printf("%10lu traces @ %.1lf Ktps\t%.6lf+%.6lf=%.6lf\n", 
+		printf("\r                                        "
+		       "                                        \r");
+		printf("%10lu traces @ %.1lf Ktps in %.6lf seconds\n",
 			n_traces, tps/1000.0,
-			dt_input, tv2dbl(&tve) - tv2dbl(&tvi),
-			tv2dbl(&tve) - tv2dbl(&tvs));
+			dt_input);
 
 #		if defined(DEBUG)
 			printf("\ttree = |%d|\n", rb_tree_size);
diff --git a/btt/devmap.c b/btt/devmap.c
index 2b6366c..a74f224 100644
--- a/btt/devmap.c
+++ b/btt/devmap.c
@@ -23,6 +23,16 @@
 
 struct devmap *all_devmaps = NULL;
 
+void dev_map_exit(void)
+{
+	struct devmap *dmp;
+
+	while ((dmp = all_devmaps) != NULL) {
+		all_devmaps = dmp->next;
+		free(dmp);
+	}
+}
+
 void dev_map_add(struct devmap *dmp)
 {
 	struct devmap *this = malloc(sizeof(struct devmap));
diff --git a/btt/devs.c b/btt/devs.c
index 21e658d..9eece81 100644
--- a/btt/devs.c
+++ b/btt/devs.c
@@ -25,6 +25,33 @@
 #define DEV_HASH(dev)	((MAJOR(dev) ^ MINOR(dev)) & (N_DEV_HASH - 1))
 struct list_head	dev_heads[N_DEV_HASH];
 
+static inline void *dip_rb_mkhds(void)
+{
+	size_t len = N_IOP_TYPES * sizeof(struct rb_root);
+	return memset(malloc(len), 0, len);
+}
+
+static void __destroy(struct rb_node *n)
+{
+	if (n) {
+		struct io *iop = rb_entry(n, struct io, rb_node);
+
+		__destroy(n->rb_left);
+		__destroy(n->rb_right);
+		io_release(iop);
+	}
+}
+
+static void __destroy_heads(struct rb_root *roots)
+{
+	int i;
+
+	for (i = 0; i < N_IOP_TYPES; i++)
+		__destroy(roots[i].rb_node);
+
+	free(roots);
+}
+
 #if defined(DEBUG)
 void __dump_rb_node(struct rb_node *n)
 {
@@ -95,6 +122,22 @@ struct d_info *__dip_find(__u32 device)
 	return NULL;
 }
 
+void dip_exit(void)
+{
+	struct d_info *dip;
+	struct list_head *p, *q;
+
+	list_for_each_safe(p, q, &all_devs) {
+		dip = list_entry(p, struct d_info, all_head);
+
+		__destroy_heads(dip->heads);
+		region_exit(&dip->regions);
+		seeki_exit(dip->seek_handle);
+		bno_dump_exit(dip->bno_dump_handle);
+		free(dip);
+	}
+}
+
 struct d_info *dip_add(__u32 device, struct io *iop)
 {
 	struct d_info *dip = __dip_find(device);
@@ -103,7 +146,7 @@ struct d_info *dip_add(__u32 device, struct io *iop)
 		dip = malloc(sizeof(struct d_info));
 		memset(dip, 0, sizeof(*dip));
 		dip->heads = dip_rb_mkhds();
-		init_region(&dip->regions);
+		region_init(&dip->regions);
 		dip->device = device;
 		dip->last_q = (__u64)-1;
 		dip->map = dev_map_find(device);
diff --git a/btt/globals.h b/btt/globals.h
index 69c9e9d..1b54cb0 100644
--- a/btt/globals.h
+++ b/btt/globals.h
@@ -84,7 +84,7 @@ enum iop_type {
 struct file_info {
 	struct file_info *next;
 	FILE *ofp;
-	char oname[1];
+	char *oname;
 };
 
 struct mode {
@@ -124,7 +124,6 @@ struct range_info {
 struct region_info {
 	struct list_head qranges;
 	struct list_head cranges;
-	struct range_info *qr_cur, *cr_cur;
 };
 
 struct p_info {
@@ -132,7 +131,7 @@ struct p_info {
 	struct avgs_info avgs;
 	__u64 last_q;
 	__u32 pid;
-	char name[1];
+	char *name;
 };
 
 struct devmap {
@@ -222,9 +221,10 @@ extern struct list_head cios;
 /* args.c */
 void handle_args(int argc, char *argv[]);
 
-/* dev_map.c */
+/* devmap.c */
 int dev_map_read(char *fname);
 struct devmap *dev_map_find(__u32 device);
+void dev_map_exit(void);
 
 /* devs.c */
 #if defined(DEBUG)
@@ -241,6 +241,7 @@ struct io *dip_find_sec(struct d_info *dip, enum iop_type type, __u64 sec);
 void dip_foreach_out(void (*func)(struct d_info *, void *), void *arg);
 void dip_plug(__u32 dev, double cur_time);
 void dip_unplug(__u32 dev, double cur_time, int is_timer);
+void dip_exit(void);
 
 /* dip_rb.c */
 int rb_insert(struct rb_root *root, struct io *iop);
@@ -269,6 +270,8 @@ void latency_q2c(struct d_info *dip, __u64 tstamp, __u64 latency);
 int in_devices(struct blk_io_trace *t);
 void add_file(struct file_info **fipp, FILE *fp, char *oname);
 void clean_files(struct file_info **fipp);
+void add_buf(void *buf);
+void clean_bufs(void);
 void dbg_ping(void);
 
 /* mmap.c */
@@ -286,14 +289,17 @@ void add_process(__u32 pid, char *name);
 struct p_info *find_process(__u32 pid, char *name);
 void pip_update_q(struct io *iop);
 void pip_foreach_out(void (*f)(struct p_info *, void *), void *arg);
+void pip_exit(void);
 
 /* bno_dump.c */
 void *bno_dump_init(__u32 device);
+void bno_dump_exit(void *param);
 void bno_dump_add(void *handle, struct io *iop);
 void bno_dump_clean(void);
 
 /* seek.c */
 void *seeki_init(__u32 device);
+void seeki_exit(void *param);
 void seek_clean(void);
 void seeki_add(void *handle, struct io *iop);
 double seeki_mean(void *handle);
diff --git a/btt/inlines.h b/btt/inlines.h
index 38ac5ef..3c8deac 100644
--- a/btt/inlines.h
+++ b/btt/inlines.h
@@ -19,46 +19,58 @@
  *
  */
 
-static inline struct range_info *new_cur(__u64 time)
+static inline void region_init(struct region_info *reg)
 {
-	struct range_info *cur = malloc(sizeof(struct range_info));
-
-	INIT_LIST_HEAD(&cur->head);
-	cur->start = time;
-	return cur;
+	INIT_LIST_HEAD(&reg->qranges);
+	INIT_LIST_HEAD(&reg->cranges);
 }
 
-static inline void update_range(struct list_head *head_p,
-				struct range_info **cur_p, __u64 time)
+static inline void __region_exit(struct list_head *range_head)
 {
-	if (*cur_p == NULL)
-		*cur_p = new_cur(time);
-	else {
-		__u64 my_delta = (time > (*cur_p)->end) ? time - (*cur_p)->end : 1;
-		if (BIT_TIME(my_delta) >= range_delta) {
-			list_add_tail(&(*cur_p)->head, head_p);
-			*cur_p = new_cur(time);
-		}
+	struct list_head *p, *q;
+	struct range_info *rip;
+
+	list_for_each_safe(p, q, range_head) {
+		rip = list_entry(p, struct range_info, head);
+		free(rip);
 	}
+}
 
-	(*cur_p)->end = time;
+static inline void region_exit(struct region_info *reg)
+{
+	__region_exit(&reg->qranges);
+	__region_exit(&reg->cranges);
 }
 
-static inline void init_region(struct region_info *reg)
+static inline void update_range(struct list_head *head_p, __u64 time)
 {
-	INIT_LIST_HEAD(&reg->qranges);
-	INIT_LIST_HEAD(&reg->cranges);
-	reg->qr_cur = reg->cr_cur = NULL;
+	struct range_info *rip;
+
+	if (!list_empty(head_p)) {
+		rip = list_entry(head_p->prev, struct range_info, head);
+
+		if (time < rip->end)
+			return;
+
+		if ((time - rip->end) < range_delta) {
+			rip->end = time;
+			return;
+		}
+	}
+
+	rip = malloc(sizeof(*rip));
+	rip->start = rip->end = time;
+	list_add_tail(&rip->head, head_p);
 }
 
 static inline void update_qregion(struct region_info *reg, __u64 time)
 {
-	update_range(&reg->qranges, &reg->qr_cur, time);
+	update_range(&reg->qranges, time);
 }
 
 static inline void update_cregion(struct region_info *reg, __u64 time)
 {
-	update_range(&reg->cranges, &reg->cr_cur, time);
+	update_range(&reg->cranges, time);
 }
 
 static inline void avg_update(struct avg_info *ap, __u64 t)
@@ -161,6 +173,17 @@ static inline void io_free(struct io *iop)
 	list_add_tail(&iop->f_head, &free_ios);
 }
 
+static inline void io_free_all(void)
+{
+	struct io *iop;
+	struct list_head *p, *q;
+
+	list_for_each_safe(p, q, &free_ios) {
+		iop = list_entry(p, struct io, f_head);
+		free(iop);
+	}
+}
+
 static inline int io_setup(struct io *iop, enum iop_type type)
 {
 	iop->type = type;
@@ -282,12 +305,6 @@ static inline struct rb_root *__get_root(struct d_info *dip, enum iop_type type)
 	return &roots[type];
 }
 
-static inline void *dip_rb_mkhds(void)
-{
-	size_t len = N_IOP_TYPES * sizeof(struct rb_root);
-	return memset(malloc(len), 0, len);
-}
-
 static inline int dip_rb_ins(struct d_info *dip, struct io *iop)
 {
 	return rb_insert(__get_root(dip, iop->type), iop);
diff --git a/btt/misc.c b/btt/misc.c
index 022cef5..24ade81 100644
--- a/btt/misc.c
+++ b/btt/misc.c
@@ -53,15 +53,12 @@ int in_devices(struct blk_io_trace *t)
 
 void add_file(struct file_info **fipp, FILE *fp, char *oname)
 {
-	struct file_info *fip;
-	
-	fip = malloc(sizeof(struct file_info) + strlen(oname) + 1);
+	struct file_info *fip = malloc(sizeof(*fip));
 
+	fip->ofp = fp;
+	fip->oname = oname;
 	fip->next = *fipp;
 	*fipp = fip;
-
-	fip->ofp = fp;
-	strcpy(fip->oname, oname);
 }
 
 void clean_files(struct file_info **fipp)
@@ -75,8 +72,34 @@ void clean_files(struct file_info **fipp)
 		fclose(fip->ofp);
 		if (!stat(fip->oname, &buf) && (buf.st_size == 0))
 			unlink(fip->oname);
+
+		free(fip->oname);
 		free(fip);
 	}
 }
 
+struct buf_info {
+	struct buf_info *next;
+	void *buf;
+} *all_bufs;
+void add_buf(void *buf)
+{
+	struct buf_info *bip = malloc(sizeof(*bip));
+
+	bip->buf = buf;
+	bip->next = all_bufs;
+	all_bufs = bip;
+}
+
+void clean_bufs(void)
+{
+	struct buf_info *bip;
+
+	while ((bip = all_bufs) != NULL) {
+		all_bufs = bip->next;
+		free(bip->buf);
+		free(bip);
+	}
+}
+	
 void dbg_ping(void) {}
diff --git a/btt/output.c b/btt/output.c
index 6851848..18d1d53 100644
--- a/btt/output.c
+++ b/btt/output.c
@@ -321,6 +321,7 @@ void output_seek_mode_info(FILE *ofp, struct o_seek_info *sip)
 		free(p);
 	}
 }
+
 void add_seek_mode_info(struct o_seek_info *sip, struct mode *mp)
 {
 	int i;
@@ -342,6 +343,8 @@ void add_seek_mode_info(struct o_seek_info *sip, struct mode *mp)
 			sip->head = new;
 			new->mode = lp[i];
 			new->nseeks = mp->most_seeks;
+
+			add_buf(new);
 		}
 	}
 }
@@ -373,6 +376,7 @@ void __output_dip_seek_info(struct d_info *dip, void *arg)
 		seek_info.mean += (nseeks * mean);
 		seek_info.median += (nseeks * median);
 		add_seek_mode_info(&seek_info, &m);
+		free(m.modes);
 	}
 }
 
@@ -598,11 +602,6 @@ void __output_ranges(FILE *ofp, struct list_head *head_p, float base)
 int output_regions(FILE *ofp, char *header, struct region_info *reg, 
 			  float base)
 {
-	if (reg->qr_cur != NULL)
-		list_add_tail(&reg->qr_cur->head, &reg->qranges);
-	if (reg->cr_cur != NULL)
-		list_add_tail(&reg->cr_cur->head, &reg->cranges);
-
 	if (list_len(&reg->qranges) == 0 && list_len(&reg->cranges) == 0)
 		return 0;
 
diff --git a/btt/proc.c b/btt/proc.c
index 8e6c5ff..e24948f 100644
--- a/btt/proc.c
+++ b/btt/proc.c
@@ -33,6 +33,24 @@ struct pn_info {
 
 struct rb_root root_pid, root_name;
 
+static void __destroy(struct rb_node *n, int free_name, int free_pip)
+{
+	if (n) {
+		struct pn_info *pnp = rb_entry(n, struct pn_info, rb_node);
+
+		__destroy(n->rb_left, free_name, free_pip);
+		__destroy(n->rb_right, free_name, free_pip);
+
+		if (free_name) free(pnp->u.name);
+		if (free_pip) {
+			free(pnp->pip->name);
+			region_exit(&pnp->pip->regions);
+			free(pnp->pip);
+		}
+		free(pnp);
+	}
+}
+
 struct p_info * __find_process_pid(__u32 pid)
 {
 	struct pn_info *this;
@@ -151,13 +169,11 @@ void add_process(__u32 pid, char *name)
 	struct p_info *pip = find_process(pid, name);
 
 	if (pip == NULL) {
-		size_t len = sizeof(struct p_info) + strlen(name) + 1;
-
-		pip = memset(malloc(len), 0, len);
+		pip = memset(malloc(sizeof(*pip)), 0, sizeof(*pip));
 		pip->pid = pid;
-		init_region(&pip->regions);
+		region_init(&pip->regions);
 		pip->last_q = (__u64)-1;
-		strcpy(pip->name, name);
+		pip->name = strdup(name);
 
 		insert(pip);
 	}
@@ -204,3 +220,9 @@ void pip_foreach_out(void (*f)(struct p_info *, void *), void *arg)
 		}
 	}
 }
+
+void pip_exit(void)
+{
+	__destroy(root_pid.rb_node, 0, 0);
+	__destroy(root_name.rb_node, 1, 1);
+}
diff --git a/btt/seek.c b/btt/seek.c
index f5f3851..e23f6bb 100644
--- a/btt/seek.c
+++ b/btt/seek.c
@@ -84,6 +84,17 @@ static void __insert(struct rb_root *root, long long sectors)
 	rb_insert_color(&sbp->rb_node, root);
 }
 
+static void __destroy(struct rb_node *n)
+{
+	if (n) {
+		struct seek_bkt *sbp = rb_entry(n, struct seek_bkt, rb_node);
+
+		__destroy(n->rb_left);
+		__destroy(n->rb_right);
+		free(sbp);
+	}
+}
+
 void seek_clean(void)
 {
 	clean_files(&seek_files);
@@ -122,6 +133,17 @@ void *seeki_init(__u32 device)
 	return sip;
 }
 
+void seeki_exit(void *param)
+{
+	struct seeki *sip = param;
+
+	/*
+	 * Associated files are cleaned up by seek_clean
+	 */
+	__destroy(sip->root.rb_node);
+	free(sip);
+}
+
 void seeki_add(void *handle, struct io *iop)
 {
 	struct seeki *sip = handle;

--------------090507070403000109020705--
