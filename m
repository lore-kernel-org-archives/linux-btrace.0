From: Martin Peschke <martin_peschke@gmx.de>
Date: Fri, 18 Jul 2008 10:31:25 +0000
Subject: [Patch] blkiomon: repost with some fixes and improvements
Message-Id: <1216377086.8497.4.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

recent changes:
- added man page
- beautified human-readable output
- fixed an x86 compile error caused by incomplete endianess handling
- fixed some x86 __u64 vs. unsigned long compiler warnings
- fixed checking of a command line argument


blkiomon periodicaly generates per devive request size and request latency
statistics from blktrace data. It provides histograms as well as data that
can be used to calculate min, max, average and variance. For this purpose,
it consumes D and C traces read from stdin.

There are options for binary output and human-readable output to files and
stdout. Output to a message queue is supported as well.

# blktrace /dev/sdw -a issue -a complete -w 20 -o - | blkiomon -I 10 -h -

device: 65,96   interval end: 1216371175009582
requests: read 138, write 96, bidir: 0
sizes: min 4096, max 438272, sum 20770816, squ 3822772551680
d2c: min 262, max 14269, sum 470086, squ 1947918822
sizes histogram (in kB):
          0:     0          1:     0          2:     0          4:    28
          8:     3         16:    38         32:    11         64:    57
        128:    51        256:    34        512:    12       1024:     0
       2048:     0       4096:     0       8192:     0      >8192:     0
d2c histogram (in microsec):
          0:     0          8:     0         16:     0         32:     0
         64:     0        128:     0        256:     0        512:    28
       1024:    55       2048:    78       4096:    46       8192:    22
      16384:     5      32768:     0      65536:     0     131072:     0
     262144:     0     524288:     0    1048576:     0    2097152:     0
    4194304:     0    8388608:     0   16777216:     0   33554432:     0
  >33554432:     0

device: 65,96   interval end: 1216371185009570
requests: read 502, write 8, bidir: 0
sizes: min 0, max 262144, sum 24682496, squ 2009776259072
d2c: min 179, max 5318, sum 662188, squ 1268516980
sizes histogram (in kB):
          0:     1          1:     0          2:     0          4:    12
          8:     0         16:   143         32:   103         64:   179
        128:    65        256:     7        512:     0       1024:     0
       2048:     0       4096:     0       8192:     0      >8192:     0
d2c histogram (in microsec):
          0:     0          8:     0         16:     0         32:     0
         64:     0        128:     0        256:     1        512:    68
       1024:   186       2048:   177       4096:    70       8192:     8
      16384:     0      32768:     0      65536:     0     131072:     0
     262144:     0     524288:     0    1048576:     0    2097152:     0
    4194304:     0    8388608:     0   16777216:     0   33554432:     0


Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---
 Makefile       |    5 
 blkiomon.c     |  822 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 blkiomon.h     |   90 ++++++
 doc/blkiomon.8 |  123 ++++++++
 4 files changed, 1039 insertions(+), 1 deletion(-)

--- /dev/null
+++ b/blkiomon.c
@@ -0,0 +1,822 @@
+/*
+ * I/O monitor based on block queue trace data
+ *
+ * Copyright IBM Corp. 2008
+ *
+ * Author(s): Martin Peschke <mp3@de.ibm.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <getopt.h>
+#include <errno.h>
+#include <locale.h>
+#include <libgen.h>
+#include <sys/msg.h>
+#include <pthread.h>
+#include <time.h>
+
+#include "blktrace.h"
+#include "rbtree.h"
+#include "jhash.h"
+#include "blkiomon.h"
+
+struct trace {
+	struct blk_io_trace bit;
+	struct rb_node node;
+	struct trace *next;
+	long sequence;
+};
+
+struct rb_search {
+	struct rb_node **node_ptr;
+	struct rb_node *parent;
+};
+
+struct dstat_msg {
+	long mtype;
+	struct dstat_payload stat;
+};
+
+struct dstat {
+	struct dstat_msg msg;
+	struct rb_node node;
+	struct dstat *next;
+};
+
+struct output {
+	char *fn;
+	FILE *fp;
+	char *buf;
+	int pipe;
+};
+
+static char blkiomon_version[] = "0.2";
+
+static FILE *ifp;
+static int interval = -1;
+
+static struct trace *vacant_traces_list = NULL;
+static int vacant_traces = 0;
+static struct rb_root trace_tree = RB_ROOT;
+
+static struct dstat *vacant_dstats_list = NULL;
+static struct rb_root dstat_tree[2] = { RB_ROOT, RB_ROOT };
+static struct dstat *dstat_list[2] = {};
+int dstat_curr = 0;
+
+static struct output drvdata, human, binary, debug;
+
+static char *msg_q_name = NULL;
+static int msg_q_id = -1, msg_q = -1;
+static long msg_id = -1;
+
+static pthread_t interval_thread;
+static pthread_mutex_t dstat_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+int data_is_native = -1;
+
+/* debugging */
+static long leftover = 0, driverdata = 0, match = 0, mismatch = 0, sequence = 0;
+
+static void dump_bit(struct trace *t, const char *descr)
+{
+	struct blk_io_trace *bit = &t->bit;
+
+	if (!debug.fn)
+		return;
+
+	fprintf(debug.fp, "--- %s ---\n", descr);
+	fprintf(debug.fp, "magic    %16d\n", bit->magic);
+	fprintf(debug.fp, "sequence %16d\n", bit->sequence);
+	fprintf(debug.fp, "time     %16ld\n", (unsigned long)bit->time);
+	fprintf(debug.fp, "sector   %16ld\n", (unsigned long)bit->sector);
+	fprintf(debug.fp, "bytes    %16d\n", bit->bytes);
+	fprintf(debug.fp, "action   %16x\n", bit->action);
+	fprintf(debug.fp, "pid      %16d\n", bit->pid);
+	fprintf(debug.fp, "device   %16d\n", bit->device);
+	fprintf(debug.fp, "cpu      %16d\n", bit->cpu);
+	fprintf(debug.fp, "error    %16d\n", bit->error);
+	fprintf(debug.fp, "pdu_len  %16d\n", bit->pdu_len);
+
+	fprintf(debug.fp, "order    %16ld\n", t->sequence);
+}
+
+static void dump_bits(struct trace *t1, struct trace *t2, const char *descr)
+{
+	struct blk_io_trace *bit1 = &t1->bit;
+	struct blk_io_trace *bit2 = &t2->bit;
+
+	if (!debug.fn)
+		return;
+
+	fprintf(debug.fp, "--- %s ---\n", descr);
+	fprintf(debug.fp, "magic    %16d %16d\n", bit1->magic, bit2->magic);
+	fprintf(debug.fp, "sequence %16d %16d\n",
+		bit1->sequence, bit2->sequence);
+	fprintf(debug.fp, "time     %16ld %16ld\n",
+		(unsigned long)bit1->time, (unsigned long)bit2->time);
+	fprintf(debug.fp, "sector   %16ld %16ld\n",
+		(unsigned long)bit1->sector, (unsigned long)bit2->sector);
+	fprintf(debug.fp, "bytes    %16d %16d\n", bit1->bytes, bit2->bytes);
+	fprintf(debug.fp, "action   %16x %16x\n", bit1->action, bit2->action);
+	fprintf(debug.fp, "pid      %16d %16d\n", bit1->pid, bit2->pid);
+	fprintf(debug.fp, "device   %16d %16d\n", bit1->device, bit2->device);
+	fprintf(debug.fp, "cpu      %16d %16d\n", bit1->cpu, bit2->cpu);
+	fprintf(debug.fp, "error    %16d %16d\n", bit1->error, bit2->error);
+	fprintf(debug.fp, "pdu_len  %16d %16d\n", bit1->pdu_len, bit2->pdu_len);
+
+	fprintf(debug.fp, "order    %16ld %16ld\n", t1->sequence, t2->sequence);
+}
+
+static void dstat_to_bigendian(struct dstat_payload *d)
+{
+	int i;
+
+	for (i = 0; i < BLKIOMON_SIZE_BUCKETS; i++)
+		d->size_hist[i] = cpu_to_be32(d->size_hist[i]);
+	for (i = 0; i < BLKIOMON_D2C_BUCKETS; i++)
+		d->d2c_hist[i] = cpu_to_be32(d->d2c_hist[i]);
+	d->size_var.min = cpu_to_be64(d->size_var.min);
+	d->size_var.max = cpu_to_be64(d->size_var.max);
+	d->size_var.sum = cpu_to_be64(d->size_var.sum);
+	d->size_var.sos = cpu_to_be64(d->size_var.sos);
+	d->d2c_var.min = cpu_to_be64(d->d2c_var.min);
+	d->d2c_var.max = cpu_to_be64(d->d2c_var.max);
+	d->d2c_var.sum = cpu_to_be64(d->d2c_var.sum);
+	d->d2c_var.sos = cpu_to_be64(d->d2c_var.sos);
+	d->read = cpu_to_be64(d->read);
+	d->write = cpu_to_be64(d->write);
+	d->bidir = cpu_to_be64(d->bidir);
+	d->time = cpu_to_be64(d->time);
+	d->device = cpu_to_be32(d->device);
+}
+
+static struct dstat *blkiomon_alloc_dstat(void)
+{
+	struct dstat *dstat;
+
+	if (vacant_dstats_list) {
+		dstat = vacant_dstats_list;
+		vacant_dstats_list = dstat->next;
+	} else
+		dstat = malloc(sizeof(*dstat));
+	if (!dstat) {
+		perror("device statistic");
+		return NULL;
+	}
+
+	memset(dstat, 0, sizeof(*dstat));
+	return dstat;
+}
+
+static struct dstat *blkiomon_find_dstat(struct rb_search *search, __u32 device)
+{
+	struct rb_node **p = &(dstat_tree[dstat_curr].rb_node);
+	struct rb_node *parent = NULL;
+	struct dstat *dstat;
+
+	while (*p) {
+		parent = *p;
+
+		dstat = rb_entry(parent, struct dstat, node);
+
+		if (dstat->msg.stat.device < device)
+			p = &(*p)->rb_left;
+		else if (dstat->msg.stat.device > device)
+			p = &(*p)->rb_right;
+		else
+			return dstat;
+	}
+	search->node_ptr = p;
+	search->parent = parent;
+	return NULL;
+}
+
+static struct dstat *blkiomon_get_dstat(__u32 device)
+{
+	struct dstat *dstat;
+	struct rb_search search;
+
+	pthread_mutex_lock(&dstat_mutex);
+
+	dstat = blkiomon_find_dstat(&search, device);
+	if (dstat)
+		goto out;
+
+	dstat = blkiomon_alloc_dstat();
+	if (!dstat)
+		goto out;
+
+	dstat->msg.stat.device = device;
+	dstat->msg.stat.size_var.min = -1ULL;
+	dstat->msg.stat.d2c_var.min = -1ULL;
+
+	rb_link_node(&dstat->node, search.parent, search.node_ptr);
+	rb_insert_color(&dstat->node, &dstat_tree[dstat_curr]);
+
+	dstat->next = dstat_list[dstat_curr];
+	dstat_list[dstat_curr] = dstat;
+
+out:
+	pthread_mutex_unlock(&dstat_mutex);
+	return dstat;
+}
+
+static int blkiomon_output_msg_q(struct dstat *dstat)
+{
+	if (!msg_q_name)
+		return 0;
+
+	return msgsnd(msg_q, &dstat->msg, sizeof(struct dstat_payload), 0);
+}
+
+static int blkiomon_output_binary(struct dstat *dstat)
+{
+	struct dstat_payload *p = &dstat->msg.stat;
+
+	if (!binary.fn)
+		return 0;
+
+	if (fwrite(p, sizeof(*p), 1, binary.fp) != 1)
+		goto failed;
+	if (binary.pipe && fflush(binary.fp))
+		goto failed;
+	return 0;
+
+failed:
+	perror(binary.fn);
+	fclose(binary.fp);
+	binary.fn = NULL;
+	return 1;
+}
+
+static int blkiomon_output_human(struct dstat *dstat)
+{
+	struct dstat_payload *p = &dstat->msg.stat;
+	FILE *fp = human.fp;
+	int i;
+
+	if (!human.fn)
+		return 0;
+
+	fprintf(fp, "device: %d,%d\t", MAJOR(p->device), MINOR(p->device));
+	fprintf(fp, "interval end: %ld\n", (unsigned long)p->time);
+
+	fprintf(fp, "requests: read %ld, write %ld, bidir: %ld\n",
+		(unsigned long)p->read, (unsigned long)p->write,
+		(unsigned long)p->bidir);
+
+	fprintf(fp, "sizes: min %ld, max %ld, sum %ld, squ %ld\n",
+		(unsigned long)p->size_var.min, (unsigned long)p->size_var.max,
+		(unsigned long)p->size_var.sum, (unsigned long)p->size_var.sos);
+
+	fprintf(fp, "d2c: min %ld, max %ld, sum %ld, squ %ld\n",
+		(unsigned long)p->d2c_var.min, (unsigned long)p->d2c_var.max,
+		(unsigned long)p->d2c_var.sum, (unsigned long)p->d2c_var.sos);
+
+	fprintf(fp, "sizes histogram (in kB):\n");
+	for (i = 0; i < BLKIOMON_SIZE_BUCKETS - 1; i++) {
+		fprintf(fp, "   %8ld:%6d",
+			(unsigned long)(hist_upper_limit(i, &size_hist) / 1024),
+			p->size_hist[i]);
+		if (!((i + 1) % 4))
+			fprintf(fp, "\n");
+	}
+	fprintf(fp, "      >%4ld:%6d\n",
+		(unsigned long)(hist_upper_limit(i - 1, &size_hist) / 1024),
+		p->size_hist[i]);
+
+	fprintf(fp, "d2c histogram (in microsec):\n");
+	for (i = 0; i < BLKIOMON_D2C_BUCKETS - 1; i++) {
+		fprintf(fp, "   %8ld:%6d",
+			(unsigned long)(hist_upper_limit(i, &d2c_hist)),
+			p->d2c_hist[i]);
+		if (!((i + 1) % 4))
+			fprintf(fp, "\n");
+	}
+	fprintf(fp, "  >%8ld:%6d\n\n",
+		(unsigned long)(hist_upper_limit(i - 1, &d2c_hist)),
+		p->d2c_hist[i]);
+	return 0;
+}
+
+static struct dstat *blkiomon_output(struct dstat *head, struct timespec *ts)
+{
+	struct dstat *dstat, *tail = NULL;
+	__u64 time = ts->tv_sec * 1000000 + ts->tv_nsec / 1000;
+
+	for (dstat = head; dstat; dstat = dstat->next) {
+		dstat->msg.stat.time = time;
+		blkiomon_output_human(dstat);
+		dstat_to_bigendian(&dstat->msg.stat);
+		blkiomon_output_binary(dstat);
+		blkiomon_output_msg_q(dstat);
+		tail = dstat;
+	}
+	return tail;
+}
+
+static void *blkiomon_interval(void *data)
+{
+	struct timespec wake, r, switched;
+	struct dstat *head, *tail;
+	int finished;
+
+	clock_gettime(CLOCK_REALTIME, &wake);
+
+	while (1) {
+		wake.tv_sec += interval;
+		if (clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &wake, &r)) {
+			perror("sleep");
+			continue;
+		}
+
+		/* grab tree and make data gatherer build up another tree */
+		pthread_mutex_lock(&dstat_mutex);
+		clock_gettime(CLOCK_REALTIME, &switched);
+		finished = dstat_curr;
+		dstat_curr = dstat_curr ? 0 : 1;
+		pthread_mutex_unlock(&dstat_mutex);
+
+		head = dstat_list[finished];
+		if (!head)
+			continue;
+		dstat_list[finished] = NULL;
+		dstat_tree[finished] = RB_ROOT;
+		tail = blkiomon_output(head, &switched);
+
+		pthread_mutex_lock(&dstat_mutex);
+		tail->next = vacant_dstats_list;
+		vacant_dstats_list = head;
+		pthread_mutex_unlock(&dstat_mutex);
+	}
+	return data;
+}
+
+#define BLK_DATADIR(a) (((a) >> BLK_TC_SHIFT) & (BLK_TC_READ | BLK_TC_WRITE))
+
+static int blkiomon_account(struct blk_io_trace *bit_d,
+			    struct blk_io_trace *bit_c)
+{
+	struct dstat *dstat;
+	struct dstat_payload *p;
+	__u64 d2c = (bit_c->time - bit_d->time) / 1000; /* ns -> us */
+	__u32 size = bit_d->bytes;
+
+	dstat = blkiomon_get_dstat(bit_d->device);
+	if (!dstat)
+		return 1;
+	p = &dstat->msg.stat;
+
+	if (BLK_DATADIR(bit_c->action) & BLK_TC_READ)
+		p->read++;
+	else if (BLK_DATADIR(bit_c->action) & BLK_TC_WRITE)
+		p->write++;
+	else
+		p->bidir++;
+
+	blkiomon_account_hist_log2(p->size_hist, size, &size_hist);
+	blkiomon_account_hist_log2(p->d2c_hist, d2c, &d2c_hist);
+	blkiomon_account_var(&p->size_var, size);
+	blkiomon_account_var(&p->d2c_var, d2c);
+	return 0;
+}
+
+static struct trace *blkiomon_alloc_trace(void)
+{
+	struct trace *t = vacant_traces_list;
+	if (t) {
+		vacant_traces_list = t->next;
+		vacant_traces--;
+	} else
+		t = malloc(sizeof(*t));
+	memset(t, 0, sizeof(*t));
+	return t;
+}
+
+static void blkiomon_free_trace(struct trace *t)
+{
+	if (vacant_traces < 256) {
+		t->next = vacant_traces_list;
+		vacant_traces_list = t;
+		vacant_traces++;
+	} else
+		free(t);
+}
+
+static int action(int a)
+{
+	int bits = BLK_TC_WRITE | BLK_TC_READ | BLK_TC_FS | BLK_TC_PC;
+	return a & (BLK_TC_ACT(bits));
+}
+
+static struct trace *_blkiomon_find_trace(struct rb_search *search,
+					  struct blk_io_trace *bit)
+{
+	struct rb_node **p = &(trace_tree.rb_node);
+	struct rb_node *parent = NULL;
+	struct trace *t;
+
+	while (*p) {
+		parent = *p;
+
+		t = rb_entry(parent, struct trace, node);
+
+		if (t->bit.device < bit->device)
+			p = &(*p)->rb_left;
+		else if (t->bit.device > bit->device)
+			p = &(*p)->rb_right;
+		else if (t->bit.sector < bit->sector)
+			p = &(*p)->rb_left;
+		else if (t->bit.sector > bit->sector)
+			p = &(*p)->rb_right;
+		else if (action(t->bit.action) < action(bit->action))
+			p = &(*p)->rb_left;
+		else if (action(t->bit.action) > action(bit->action))
+			p = &(*p)->rb_right;
+		else
+			return t;
+	}
+	search->node_ptr = p;
+	search->parent = parent;
+	return NULL;
+}
+
+static void _blkiomon_insert_trace(struct rb_search *pos, struct trace *t)
+{
+	rb_link_node(&t->node, pos->parent, pos->node_ptr);
+	rb_insert_color(&t->node, &trace_tree);
+}
+
+static void blkiomon_remove_trace(struct trace *t)
+{
+	rb_erase(&t->node, &trace_tree);
+}
+
+static struct trace *blkiomon_do_trace(struct trace *t)
+{
+	struct trace *t_stored, *t_old, *t_young;
+	struct rb_search pos;
+
+	/* store trace if there is no match yet */
+	t_stored = _blkiomon_find_trace(&pos, &t->bit);
+	if (!t_stored) {
+		_blkiomon_insert_trace(&pos, t);
+		return blkiomon_alloc_trace();
+	}
+	blkiomon_remove_trace(t_stored);
+
+	/* figure out older trace and younger trace */
+	if (t_stored->bit.time < t->bit.time) {
+		t_old = t_stored;
+		t_young = t;
+	} else {
+		t_old = t;
+		t_young = t_stored;
+	}
+
+	/* we need an older D trace and a younger C trace */
+	if (t_old->bit.action & BLK_TC_ACT(BLK_TC_ISSUE) &&
+	    t_young->bit.action & BLK_TC_ACT(BLK_TC_COMPLETE)) {
+		/* matching D and C traces - update statistics */
+		dump_bits(t_old, t_young, "match");
+		match++;
+		blkiomon_account(&t_old->bit, &t_young->bit);
+		blkiomon_free_trace(t_stored);
+		return t;
+	}
+
+	/* no matching D and C traces - keep more recent trace */
+	dump_bits(t_old, t_young, "mismatch");
+	mismatch++;
+	_blkiomon_insert_trace(&pos, t_young);
+	return t_old;
+}
+
+static int blkiomon_dump_drvdata(struct blk_io_trace *bit, void *pdu_buf)
+{
+	if (!drvdata.fn)
+		return 0;
+
+	if (fwrite(bit, sizeof(*bit), 1, drvdata.fp) != 1)
+		goto failed;
+	if (fwrite(pdu_buf, bit->pdu_len, 1, drvdata.fp) != 1)
+		goto failed;
+	if (drvdata.pipe && fflush(drvdata.fp))
+		goto failed;
+	return 0;
+
+failed:
+	perror(drvdata.fn);
+	fclose(drvdata.fp);
+	drvdata.fn = NULL;
+	return 1;
+}
+
+static int blkiomon_do_fifo(void)
+{
+	struct trace *t;
+	struct blk_io_trace *bit;
+	void *pdu_buf = NULL;
+
+	t = blkiomon_alloc_trace();
+	if (!t)
+		return 1;
+	bit = &t->bit;
+
+	while (fread(bit, sizeof(*bit), 1, ifp) = 1) {
+		if (ferror(ifp)) {
+			clearerr(ifp);
+			perror("fread");
+			break;
+		}
+
+		if (data_is_native = -1 && check_data_endianness(bit->magic))
+			break;
+
+		/* endianess */
+		trace_to_cpu(bit);
+		if (verify_trace(bit)) {
+			perror("bad trace");
+			break;
+		}
+
+		/* read additional trace payload */
+		if (bit->pdu_len) {
+			pdu_buf = realloc(pdu_buf, bit->pdu_len);
+			if (fread(pdu_buf, bit->pdu_len, 1, ifp) != 1) {
+				clearerr(ifp);
+				perror("fread payload");
+				break;
+			}
+		}
+
+		t->sequence = sequence++;
+
+		/* forward low-level device driver trace to other tool */
+		if (bit->action & BLK_TC_ACT(BLK_TC_DRV_DATA)) {
+			driverdata++;
+			if (blkiomon_dump_drvdata(bit, pdu_buf))
+				break;
+			continue;
+		}
+
+		if (!(bit->action & BLK_TC_ACT(BLK_TC_ISSUE | BLK_TC_COMPLETE)))
+			continue;
+
+		/* try to find matching trace and update statistics */
+		t = blkiomon_do_trace(t);
+		if (!t)
+			break;
+		bit = &t->bit;
+		/* t and bit will be recycled for next incoming trace */
+	}
+	blkiomon_free_trace(t);
+	free(pdu_buf);
+	return 0;
+}
+
+static int blkiomon_open_output(struct output *out)
+{
+	int mode, vbuf_size;
+
+	if (!out->fn)
+		return 0;
+
+	if (!strcmp(out->fn, "-")) {
+		out->fp = fdopen(STDOUT_FILENO, "w");
+		mode = _IOLBF;
+		vbuf_size = 4096;
+		out->pipe = 1;
+	} else {
+		out->fp = fopen(out->fn, "w");
+		mode = _IOFBF;
+		vbuf_size = 128 * 1024;
+		out->pipe = 0;
+	}
+	if (!out->fp)
+		goto failed;
+	out->buf = malloc(128 * 1024);
+	if (setvbuf(out->fp, out->buf, mode, vbuf_size))
+		goto failed;
+	return 0;
+
+failed:
+	perror(out->fn);
+	out->fn = NULL;
+	free(out->buf);
+	return 1;
+}
+
+static int blkiomon_open_msg_q(void)
+{
+	key_t key;
+
+	if (!msg_q_name)
+		return 0;
+	if (!msg_q_id || msg_id <= 0)
+		return 1;
+	key = ftok(msg_q_name, msg_q_id);
+	if (key = -1)
+		return 1;
+	msg_q = msgget(key, S_IRWXU);
+	if (msg_q = -1)
+		return 1;
+	return 0;
+}
+
+static void blkiomon_debug(void)
+{
+	struct rb_node *n;
+	struct trace *t;
+
+	if (!debug.fn)
+		return;
+
+	for (n = rb_first(&trace_tree); n; n = rb_next(n)) {
+		t = rb_entry(n, struct trace, node);
+		dump_bit(t, "leftover");
+		leftover++;
+	}
+	fprintf(debug.fp, "%ld leftover, %ld match, %ld mismatch, "
+		"%ld driverdata, %ld overall\n",
+		leftover, match, mismatch, driverdata, sequence);
+}
+
+#define S_OPTS "b:d:D:h:I:Q:q:m:V"
+
+static char usage_str[] = "\n\n" \
+	"-I <interval>       | --interval=<interval>\n" \
+	"[ -h <file>         | --human-readable=<file> ]\n" \
+	"[ -b <file>         | --binary=<file> ]\n" \
+	"[ -d <file>         | --dump-lldd=<file> ]\n" \
+	"[ -D <file>         | --debug=<file> ]\n" \
+	"[ -Q <path name>    | --msg-queue-name=<path name>]\n" \
+	"[ -q <msg queue id> | --msg-queue-id=<msg queue id>]\n" \
+	"[ -m <msg id>       | --msg-id=<msg id>]\n" \
+	"[ -V                | --version ]\n\n" \
+	"\t-I   Sample interval.\n" \
+	"\t-h   Human-readable output file.\n" \
+	"\t-b   Binary output file.\n" \
+	"\t-d   Output file for data emitted by low level device driver.\n" \
+	"\t-D   Output file for debugging data.\n" \
+	"\t-Qqm Output to message queue using given ID for messages.\n" \
+	"\t-V   Print program version.\n\n";
+
+static struct option l_opts[] = {
+	{
+		.name = "human-readable",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'h'
+	},
+	{
+		.name = "binary",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'b'
+	},
+	{
+		.name = "dump-lldd",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'd'
+	},
+	{
+		.name = "debug",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'D'
+	},
+	{
+		.name = "interval",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'I'
+	},
+	{
+		.name = "msg-queue",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'Q'
+	},
+	{
+		.name = "msg-queue-id",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'q'
+	},
+	{
+		.name = "msg-id",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'm'
+	},
+	{
+		.name = "version",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'V'
+	},
+	{
+		.name = NULL,
+	}
+};
+
+static void blkiomon_usage(char *prog)
+{
+	fprintf(stderr, "Usage: %s %s", prog, usage_str);
+}
+
+int main(int argc, char *argv[])
+{
+	int c;
+
+	while ((c = getopt_long(argc, argv, S_OPTS, l_opts, NULL)) != -1) {
+		switch (c) {
+		case 'h':
+			human.fn = optarg;
+			break;
+		case 'b':
+			binary.fn = optarg;
+			break;
+		case 'd':
+			drvdata.fn = optarg;
+			break;
+		case 'D':
+			debug.fn = optarg;
+			break;
+		case 'I':
+			interval = atoi(optarg);
+			break;
+		case 'Q':
+			msg_q_name = optarg;
+			break;
+		case 'q':
+			msg_q_id = atoi(optarg);
+			break;
+		case 'm':
+			msg_id = atoi(optarg);
+			break;
+		case 'V':
+			printf("%s version %s\n", argv[0], blkiomon_version);
+			return 0;
+		default:
+			blkiomon_usage(argv[0]);
+			return 1;
+		}
+	}
+
+	if (interval <= 0) {
+		blkiomon_usage(argv[0]);
+		return 1;
+	}
+
+	ifp = fdopen(STDIN_FILENO, "r");
+	if (!ifp) {
+		perror("open stdin");
+		return 1;
+	}
+
+	if (blkiomon_open_output(&human))
+		return 1;
+	if (blkiomon_open_output(&binary))
+		return 1;
+	if (blkiomon_open_output(&drvdata))
+		return 1;
+	if (blkiomon_open_output(&debug))
+		return 1;
+	if (blkiomon_open_msg_q())
+		return 1;
+
+	if (pthread_create(&interval_thread, NULL, blkiomon_interval, NULL)) {
+		perror("pthread_create");
+		return 1;
+	}
+
+	blkiomon_do_fifo();
+
+	blkiomon_debug();
+	return 0;
+}
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 CC	= gcc
 CFLAGS	= -Wall -O2 -g -W
 ALL_CFLAGS = $(CFLAGS) -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITSd
-PROGS	= blkparse blktrace verify_blkparse blkrawverify
+PROGS	= blkparse blktrace verify_blkparse blkrawverify blkiomon
 LIBS	= -lpthread
 SCRIPTS	= btrace
 
@@ -34,6 +34,9 @@ verify_blkparse: verify_blkparse.o
 blkrawverify: blkrawverify.o
 	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^)
 
+blkiomon: blkiomon.o rbtree.o
+	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS) -lrt
+
 $(PROGS): | depend
 
 docs:
--- /dev/null
+++ b/blkiomon.h
@@ -0,0 +1,90 @@
+/*
+ * I/O monitor based on block queue trace data
+ *
+ * Copyright IBM Corp. 2008
+ *
+ * Author(s): Martin Peschke <mp3@de.ibm.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+struct dstat_variance {
+	__u64 min;
+	__u64 max;
+	__u64 sum;
+	__u64 sos;
+};
+
+#define BLKIOMON_SIZE_BUCKETS 16
+#define BLKIOMON_D2C_BUCKETS 25
+struct dstat_payload {
+	__u32 size_hist[BLKIOMON_SIZE_BUCKETS];
+	__u32 d2c_hist[BLKIOMON_D2C_BUCKETS];
+	struct dstat_variance size_var;
+	struct dstat_variance d2c_var;
+	__u64 read;
+	__u64 write;
+	__u64 bidir;
+	__u64 time;
+	__u32 device;
+};
+
+struct hist_log2 {
+	int first;
+	int delta;
+	int num;
+};
+
+static struct hist_log2 size_hist = {
+	.first = 0,
+	.delta = 1024,
+	.num = BLKIOMON_SIZE_BUCKETS
+};
+
+static struct hist_log2 d2c_hist = {
+	.first = 0,
+	.delta = 8,
+	.num = BLKIOMON_D2C_BUCKETS
+};
+
+static inline void blkiomon_account_var(struct dstat_variance *var, __u64 value)
+{
+	var->sum += value;
+	var->sos += value * value;
+	if (value < var->min)
+		var->min = value;
+	if (value > var->max)
+		var->max = value;
+}
+
+static inline __u64 hist_upper_limit(int index, struct hist_log2 *h)
+{
+	return h->first + (index ? h->delta << (index - 1) : 0);
+}
+
+static inline int hist_index(__u64 val, struct hist_log2 *h)
+{
+	int i;
+
+	for (i = 0; i < (h->num - 1) && val > hist_upper_limit(i, h); i++);
+	return i;
+}
+
+static inline void blkiomon_account_hist_log2(__u32 *bucket, __u32 val,
+					      struct hist_log2 *h)
+{
+	int index = hist_index(val, h);
+	bucket[index]++;
+}
--- /dev/null
+++ b/doc/blkiomon.8
@@ -0,0 +1,123 @@
+.TH BLKIOMON 8 "July 17, 2008" "" ""
+
+
+.SH NAME
+blkiomon \- monitor block device I/O based o blktrace data
+
+
+.SH SYNOPSIS
+.B blkiomon \-I \fIinterval\fR [ \-h \fIfile\fR ] [ \-b \fIfile\fR ]
+[ \-d \fIfile\fR ] [ \-D \fIfile\fR ] [ \-Q \fIpath_name\fR
+\-q \fImsg_queue_id\fR \-m \fImsg_id\fR ] [ \-V ]
+.br
+
+
+.SH DESCRIPTION
+blkiomon is a block device I/O monitor. It periodically generates per device
+request size and request latency statistics from blktrace data. It provides
+histograms as well as data that can be used to calculate min, max, average
+and variance. For this purpose, it consumes D and C traces read from stdin.
+
+There are options for binary output and human-readable output to files and
+stdout. Output to a message queue is supported as well.
+
+There is no need to use blkparse with blkiomon. blkiomon is capable of
+consuming binary output written to stdout by blktrace.
+
+
+.SH OPTIONS
+
+\-I \fIinterval\fR
+.br
+\-\-interval=\fIinterval\fR
+.RS
+Set sample interval
+.RE
+
+\-h \fIfile\fR
+.br
+\-\-human\-readable=\fIfile\fR
+.RS
+Human-readable output file. Use '\-' for stdout.
+.RE
+
+\-b \fIfile\fR
+.br
+\-\-binary=\fIfile\fR
+.RS
+Binary output file. Use '\-' for stdout.
+.RE
+
+\-d \fIfile\fR
+.br
+\-\-dump\-lldd=\fIfile\fR
+.RS
+Output file for data emitted by low level device driver. Use '\-' for stdout.
+.RE
+
+\-D \fIfile\fR
+.br
+\-\-debug=\fIfile\fR
+.RS
+Output file for debugging data. Use '\-' for stdout.
+.RE
+
+\-Q \fIpath_name\fR
+.br
+\-\-msg\-queue\-name=\fIpath_name\fR
+.RS
+Sets \fIpath_name\fR as path name for existing message queue to be used
+for binary output.
+.RE
+
+\-q \fImsg_queue_id\fR
+.br
+\-\-msg\-queue\-id=\fImsg_queue_id\fR
+.RS
+Sets \fImsg_queue_id\fR as ID for an existing message queue to be used
+for binary output.
+.RE
+
+\-m \fImsg_id\fR
+.br
+\-\-msg\-id=\fImsg_id\fR
+.RS
+Sets \fImsg_id\fR as message identifier to be used for binary output
+messages written to an existing message queue.
+.RE
+
+\-V
+.br
+\-\-version
+.RS
+Print program version.
+.RE
+
+
+.SH EXAMPLES
+To get I/O statistics for /dev/sdw every 10 seconds for a period of one hour,
+use the following command:
+
+    % blktrace /dev/sdw -a issue -a complete -w 3600 -o - | blkiomon -I 10 -h -
+
+
+.SH AUTHORS
+blkiomon and this man page were written by Martin Peschke.
+
+
+.SH "REPORTING BUGS"
+Report bugs to <linux\-btrace@vger.kernel.org>
+
+
+.SH COPYRIGHT
+Copyright \(co 2008 IBM Corp.
+.br
+This is free software.  You may redistribute copies of it under the terms of
+the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
+There is NO WARRANTY, to the extent permitted by law.
+
+
+.SH "SEE ALSO"
+btrace (8), blktrace (8), blkparse (1), verify_blkparse (1), blkrawverify (1),
+btt (1)
+


