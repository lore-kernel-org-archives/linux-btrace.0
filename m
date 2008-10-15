From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Wed, 15 Oct 2008 11:39:56 +0000
Subject: Re: [Patch] blkiomon: I/O monitor
Message-Id: <1224070796.27114.14.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1222803445.24609.2.camel@kitka.ibm.com>
In-Reply-To: <1222803445.24609.2.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi Jens,
here has been another patch I would like to recommend warmly to you :-)
Your feedback is appreciated.

Thanks,
Martin


On Tue, 2008-09-30 at 21:37 +0200, Martin Peschke wrote:
> Jens,
> I'd like to ask you whether this is something you are interested in for
> inclusion in the blktrace tree.
> 
> We use it as part of a small I/O monitoring solution. But blkiomon
> itself is pretty much generic and implements just another way of looking
> at raw blktrace data, like btt or some statistics implemented in
> blkparse. So I would be happy to contribute it to blktrace.
> 
> I posted it way back in July and made some changes suggested by Alan.
> 
> Thanks,
> Martin
> 
> 
> 
> 
> blkiomon periodicaly generates per devive request size and request latency
> statistics from blktrace data. It provides histograms as well as data that
> can be used to calculate min, max, average and variance. For this purpose,
> it consumes D and C traces read from stdin.
> 
> There are options for binary output and human-readable output to files and
> stdout. Output to a message queue is supported as well.
> 
> #blktrace /dev/sdw -a issue -a complete -w 200 -o - | blkiomon -I 8 -h -
> 
> time: Tue Sep 30 17:39:25 2008
> device: 65,96
> requests: read 62, write 40, bidir: 0
> sizes: num 102, min 4096, max 430080, sum 13312000, squ 3102442782720,
>  avg 130509.8, var 13383296793.3
> d2c: num 102, min 393, max 14261, sum 359441, squ 2830211755, avg 3523.9,
>  var 15329081.8
> sizes histogram (in kB):
>             0:     0         1024:     0         2048:     0         4096:     6
>          8192:     0        16384:    15        32768:     4        65536:    24
>        131072:    11       262144:    30       524288:    12      1048576:     0
>       2097152:     0      4194304:     0      8388608:     0    > 8388608:     0
> d2c histogram (in usec):
>             0:     0            8:     0           16:     0           32:     0
>            64:     0          128:     0          256:     0          512:    13
>          1024:    21         2048:    27         4096:    14         8192:     8
>         16384:    19        32768:     0        65536:     0       131072:     0
>        262144:     0       524288:     0      1048576:     0      2097152:     0
>       4194304:     0      8388608:     0     16777216:     0     33554432:     0
>     >33554432:     0
> 
> time: Tue Sep 30 17:39:33 2008
> device: 65,96
> requests: read 312, write 47, bidir: 0
> sizes: num 359, min 4096, max 430080, sum 13197312, squ 1575816790016,
>  avg 36761.3, var 3038067547.5
> d2c: num 359, min 294, max 9211, sum 387134, squ 1262489694, avg 1078.4,
>  var 2353807.5
> sizes histogram (in kB):
>             0:     0         1024:     0         2048:     0         4096:    32
>          8192:    17        16384:   133        32768:    87        65536:    59
>        131072:     9       262144:    18       524288:     4      1048576:     0
>       2097152:     0      4194304:     0      8388608:     0    > 8388608:     0
> d2c histogram (in usec):
>             0:     0            8:     0           16:     0           32:     0
>            64:     0          128:     0          256:     0          512:   129
>          1024:   164         2048:    33         4096:    15         8192:    13
>         16384:     5        32768:     0        65536:     0       131072:     0
>        262144:     0       524288:     0      1048576:     0      2097152:     0
>       4194304:     0      8388608:     0     16777216:     0     33554432:     0
>     >33554432:     0
> 
> Signed-off-by: Martin Peschke <mp3@de.ibm.com>
> ---
>  Makefile       |    5 
>  blkiomon.c     |  716 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  blkiomon.h     |  105 ++++++++
>  doc/blkiomon.8 |  123 +++++++++
>  stats.h        |  155 ++++++++++++
>  5 files changed, 1103 insertions(+), 1 deletion(-)
> 
> Index: blktrace/blkiomon.c
> =================================> --- /dev/null
> +++ blktrace/blkiomon.c
> @@ -0,0 +1,708 @@
> +/*
> + * I/O monitor based on block queue trace data
> + *
> + * Copyright IBM Corp. 2008
> + *
> + * Author(s): Martin Peschke <mp3@de.ibm.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <getopt.h>
> +#include <errno.h>
> +#include <locale.h>
> +#include <libgen.h>
> +#include <sys/msg.h>
> +#include <pthread.h>
> +#include <time.h>
> +
> +#include "blktrace.h"
> +#include "rbtree.h"
> +#include "jhash.h"
> +#include "blkiomon.h"
> +
> +struct trace {
> +	struct blk_io_trace bit;
> +	struct rb_node node;
> +	struct trace *next;
> +	long sequence;
> +};
> +
> +struct rb_search {
> +	struct rb_node **node_ptr;
> +	struct rb_node *parent;
> +};
> +
> +struct dstat_msg {
> +	long mtype;
> +	struct blkiomon_stat stat;
> +};
> +
> +struct dstat {
> +	struct dstat_msg msg;
> +	struct rb_node node;
> +	struct dstat *next;
> +};
> +
> +struct output {
> +	char *fn;
> +	FILE *fp;
> +	char *buf;
> +	int pipe;
> +};
> +
> +static char blkiomon_version[] = "0.2";
> +
> +static FILE *ifp;
> +static int interval = -1;
> +
> +static struct trace *vacant_traces_list = NULL;
> +static int vacant_traces = 0;
> +static struct rb_root trace_tree = RB_ROOT;
> +
> +#define TRACE_HASH_SIZE 128
> +struct trace *thash[TRACE_HASH_SIZE] = {};
> +
> +static struct dstat *vacant_dstats_list = NULL;
> +static struct rb_root dstat_tree[2] = { RB_ROOT, RB_ROOT };
> +static struct dstat *dstat_list[2] = {};
> +static int dstat_curr = 0;
> +
> +static struct output human, binary, debug;
> +
> +static char *msg_q_name = NULL;
> +static int msg_q_id = -1, msg_q = -1;
> +static long msg_id = -1;
> +
> +static pthread_t interval_thread;
> +static pthread_mutex_t dstat_mutex = PTHREAD_MUTEX_INITIALIZER;
> +
> +int data_is_native = -1;
> +
> +static int up = 1;
> +
> +/* debugging */
> +static long leftover = 0, driverdata = 0, match = 0, mismatch = 0, sequence = 0;
> +
> +static void dump_bit(struct trace *t, const char *descr)
> +{
> +	struct blk_io_trace *bit = &t->bit;
> +
> +	if (!debug.fn)
> +		return;
> +
> +	fprintf(debug.fp, "--- %s ---\n", descr);
> +	fprintf(debug.fp, "magic    %16d\n", bit->magic);
> +	fprintf(debug.fp, "sequence %16d\n", bit->sequence);
> +	fprintf(debug.fp, "time     %16ld\n", (unsigned long)bit->time);
> +	fprintf(debug.fp, "sector   %16ld\n", (unsigned long)bit->sector);
> +	fprintf(debug.fp, "bytes    %16d\n", bit->bytes);
> +	fprintf(debug.fp, "action   %16x\n", bit->action);
> +	fprintf(debug.fp, "pid      %16d\n", bit->pid);
> +	fprintf(debug.fp, "device   %16d\n", bit->device);
> +	fprintf(debug.fp, "cpu      %16d\n", bit->cpu);
> +	fprintf(debug.fp, "error    %16d\n", bit->error);
> +	fprintf(debug.fp, "pdu_len  %16d\n", bit->pdu_len);
> +
> +	fprintf(debug.fp, "order    %16ld\n", t->sequence);
> +}
> +
> +static void dump_bits(struct trace *t1, struct trace *t2, const char *descr)
> +{
> +	struct blk_io_trace *bit1 = &t1->bit;
> +	struct blk_io_trace *bit2 = &t2->bit;
> +
> +	if (!debug.fn)
> +		return;
> +
> +	fprintf(debug.fp, "--- %s ---\n", descr);
> +	fprintf(debug.fp, "magic    %16d %16d\n", bit1->magic, bit2->magic);
> +	fprintf(debug.fp, "sequence %16d %16d\n",
> +		bit1->sequence, bit2->sequence);
> +	fprintf(debug.fp, "time     %16ld %16ld\n",
> +		(unsigned long)bit1->time, (unsigned long)bit2->time);
> +	fprintf(debug.fp, "sector   %16ld %16ld\n",
> +		(unsigned long)bit1->sector, (unsigned long)bit2->sector);
> +	fprintf(debug.fp, "bytes    %16d %16d\n", bit1->bytes, bit2->bytes);
> +	fprintf(debug.fp, "action   %16x %16x\n", bit1->action, bit2->action);
> +	fprintf(debug.fp, "pid      %16d %16d\n", bit1->pid, bit2->pid);
> +	fprintf(debug.fp, "device   %16d %16d\n", bit1->device, bit2->device);
> +	fprintf(debug.fp, "cpu      %16d %16d\n", bit1->cpu, bit2->cpu);
> +	fprintf(debug.fp, "error    %16d %16d\n", bit1->error, bit2->error);
> +	fprintf(debug.fp, "pdu_len  %16d %16d\n", bit1->pdu_len, bit2->pdu_len);
> +
> +	fprintf(debug.fp, "order    %16ld %16ld\n", t1->sequence, t2->sequence);
> +}
> +
> +static struct dstat *blkiomon_alloc_dstat(void)
> +{
> +	struct dstat *dstat;
> +
> +	if (vacant_dstats_list) {
> +		dstat = vacant_dstats_list;
> +		vacant_dstats_list = dstat->next;
> +	} else
> +		dstat = malloc(sizeof(*dstat));
> +	if (!dstat) {
> +		perror("blkiomon: could not allocate device statistic");
> +		return NULL;
> +	}
> +
> +	memset(dstat, 0, sizeof(*dstat));
> +	return dstat;
> +}
> +
> +static struct dstat *blkiomon_find_dstat(struct rb_search *search, __u32 device)
> +{
> +	struct rb_node **p = &(dstat_tree[dstat_curr].rb_node);
> +	struct rb_node *parent = NULL;
> +	struct dstat *dstat;
> +
> +	while (*p) {
> +		parent = *p;
> +
> +		dstat = rb_entry(parent, struct dstat, node);
> +
> +		if (dstat->msg.stat.device < device)
> +			p = &(*p)->rb_left;
> +		else if (dstat->msg.stat.device > device)
> +			p = &(*p)->rb_right;
> +		else
> +			return dstat;
> +	}
> +	search->node_ptr = p;
> +	search->parent = parent;
> +	return NULL;
> +}
> +
> +static struct dstat *blkiomon_get_dstat(__u32 device)
> +{
> +	struct dstat *dstat;
> +	struct rb_search search;
> +
> +	pthread_mutex_lock(&dstat_mutex);
> +
> +	dstat = blkiomon_find_dstat(&search, device);
> +	if (dstat)
> +		goto out;
> +
> +	dstat = blkiomon_alloc_dstat();
> +	if (!dstat)
> +		goto out;
> +
> +	dstat->msg.stat.device = device;
> +	dstat->msg.stat.size_mm.min = -1ULL;
> +	dstat->msg.stat.d2c_mm.min = -1ULL;
> +
> +	rb_link_node(&dstat->node, search.parent, search.node_ptr);
> +	rb_insert_color(&dstat->node, &dstat_tree[dstat_curr]);
> +
> +	dstat->next = dstat_list[dstat_curr];
> +	dstat_list[dstat_curr] = dstat;
> +
> +out:
> +	pthread_mutex_unlock(&dstat_mutex);
> +	return dstat;
> +}
> +
> +static int blkiomon_output_msg_q(struct dstat *dstat)
> +{
> +	if (!msg_q_name)
> +		return 0;
> +
> +	dstat->msg.mtype = msg_id;
> +	return msgsnd(msg_q, &dstat->msg, sizeof(struct blkiomon_stat), 0);
> +}
> +
> +static int blkiomon_output_binary(struct dstat *dstat)
> +{
> +	struct blkiomon_stat *p = &dstat->msg.stat;
> +
> +	if (!binary.fn)
> +		return 0;
> +
> +	if (fwrite(p, sizeof(*p), 1, binary.fp) != 1)
> +		goto failed;
> +	if (binary.pipe && fflush(binary.fp))
> +		goto failed;
> +	return 0;
> +
> +failed:
> +	fprintf(stderr, "blkiomon: could not write to %s\n", binary.fn);
> +	fclose(binary.fp);
> +	binary.fn = NULL;
> +	return 1;
> +}
> +
> +static struct dstat *blkiomon_output(struct dstat *head, struct timespec *ts)
> +{
> +	struct dstat *dstat, *tail = NULL;
> +
> +	for (dstat = head; dstat; dstat = dstat->next) {
> +		dstat->msg.stat.time = ts->tv_sec;
> +		blkiomon_stat_print(human.fp, &dstat->msg.stat);
> +		blkiomon_stat_to_be(&dstat->msg.stat);
> +		blkiomon_output_binary(dstat);
> +		blkiomon_output_msg_q(dstat);
> +		tail = dstat;
> +	}
> +	return tail;
> +}
> +
> +static void *blkiomon_interval(void *data)
> +{
> +	struct timespec wake, r;
> +	struct dstat *head, *tail;
> +	int finished;
> +
> +	clock_gettime(CLOCK_REALTIME, &wake);
> +
> +	while (1) {
> +		wake.tv_sec += interval;
> +		if (clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &wake, &r)) {
> +			perror("blkiomon: interrupted sleep");
> +			continue;
> +		}
> +
> +		/* grab tree and make data gatherer build up another tree */
> +		pthread_mutex_lock(&dstat_mutex);
> +		finished = dstat_curr;
> +		dstat_curr = dstat_curr ? 0 : 1;
> +		pthread_mutex_unlock(&dstat_mutex);
> +
> +		head = dstat_list[finished];
> +		if (!head)
> +			continue;
> +		dstat_list[finished] = NULL;
> +		dstat_tree[finished] = RB_ROOT;
> +		tail = blkiomon_output(head, &wake);
> +
> +		pthread_mutex_lock(&dstat_mutex);
> +		tail->next = vacant_dstats_list;
> +		vacant_dstats_list = head;
> +		pthread_mutex_unlock(&dstat_mutex);
> +	}
> +	return data;
> +}
> +
> +#define BLK_DATADIR(a) (((a) >> BLK_TC_SHIFT) & (BLK_TC_READ | BLK_TC_WRITE))
> +
> +static int blkiomon_account(struct blk_io_trace *bit_d,
> +			    struct blk_io_trace *bit_c)
> +{
> +	struct dstat *dstat;
> +	struct blkiomon_stat *p;
> +	__u64 d2c = (bit_c->time - bit_d->time) / 1000; /* ns -> us */
> +	__u32 size = bit_d->bytes;
> +
> +	dstat = blkiomon_get_dstat(bit_d->device);
> +	if (!dstat)
> +		return 1;
> +	p = &dstat->msg.stat;
> +
> +	if (BLK_DATADIR(bit_c->action) & BLK_TC_READ)
> +		p->read++;
> +	else if (BLK_DATADIR(bit_c->action) & BLK_TC_WRITE)
> +		p->write++;
> +	else
> +		p->bidir++;
> +
> +	histlog2_account(p->size_hist, size, &size_hist);
> +	histlog2_account(p->d2c_hist, d2c, &d2c_hist);
> +	minmax_account(&p->size_mm, size);
> +	minmax_account(&p->d2c_mm, d2c);
> +	return 0;
> +}
> +
> +static struct trace *blkiomon_alloc_trace(void)
> +{
> +	struct trace *t = vacant_traces_list;
> +	if (t) {
> +		vacant_traces_list = t->next;
> +		vacant_traces--;
> +	} else
> +		t = malloc(sizeof(*t));
> +	memset(t, 0, sizeof(*t));
> +	return t;
> +}
> +
> +static void blkiomon_free_trace(struct trace *t)
> +{
> +	if (vacant_traces < 256) {
> +		t->next = vacant_traces_list;
> +		vacant_traces_list = t;
> +		vacant_traces++;
> +	} else
> +		free(t);
> +}
> +
> +static int action(int a)
> +{
> +	int bits = BLK_TC_WRITE | BLK_TC_READ | BLK_TC_FS | BLK_TC_PC;
> +	return a & (BLK_TC_ACT(bits));
> +}
> +
> +static void blkiomon_store_trace(struct trace *t)
> +{
> +	int i = t->bit.sector % TRACE_HASH_SIZE;
> +
> +	t->next = thash[i];
> +	thash[i] = t;
> +}
> +
> +static struct trace *blkiomon_fetch_trace(struct blk_io_trace *bit)
> +{
> +	int i = bit->sector % TRACE_HASH_SIZE;
> +	struct trace *t, *prev = NULL;
> +
> +	for (t = thash[i]; t; t = t->next) {
> +		if (t->bit.device = bit->device &&
> +		    t->bit.sector = bit->sector &&
> +		    action(t->bit.action) = action(bit->action)) {
> +			if (prev)
> +				prev->next = t->next;
> +			else
> +				thash[i] = t->next;
> +			return t;
> +		}
> +		prev = t;
> +	}
> +	return NULL;
> +}
> +
> +static struct trace *blkiomon_do_trace(struct trace *t)
> +{
> +	struct trace *t_stored, *t_old, *t_young;
> +
> +	/* store trace if there is no match yet */
> +	t_stored = blkiomon_fetch_trace(&t->bit);
> +	if (!t_stored) {
> +		blkiomon_store_trace(t);
> +		return blkiomon_alloc_trace();
> +	}
> +
> +	/* figure out older trace and younger trace */
> +	if (t_stored->bit.time < t->bit.time) {
> +		t_old = t_stored;
> +		t_young = t;
> +	} else {
> +		t_old = t;
> +		t_young = t_stored;
> +	}
> +
> +	/* we need an older D trace and a younger C trace */
> +	if (t_old->bit.action & BLK_TC_ACT(BLK_TC_ISSUE) &&
> +	    t_young->bit.action & BLK_TC_ACT(BLK_TC_COMPLETE)) {
> +		/* matching D and C traces - update statistics */
> +		match++;
> +		blkiomon_account(&t_old->bit, &t_young->bit);
> +		blkiomon_free_trace(t_stored);
> +		return t;
> +	}
> +
> +	/* no matching D and C traces - keep more recent trace */
> +	dump_bits(t_old, t_young, "mismatch");
> +	mismatch++;
> +	blkiomon_store_trace(t_young);
> +	return t_old;
> +}
> +
> +static int blkiomon_do_fifo(void)
> +{
> +	struct trace *t;
> +	struct blk_io_trace *bit;
> +	void *pdu_buf = NULL;
> +
> +	t = blkiomon_alloc_trace();
> +	if (!t)
> +		return 1;
> +	bit = &t->bit;
> +
> +	while (up) {
> +		if (fread(bit, sizeof(*bit), 1, ifp) != 1) {
> +			if (!feof(ifp))
> +				fprintf(stderr,
> +					"blkiomon: could not read trace");
> +			break;
> +		}
> +		if (ferror(ifp)) {
> +			clearerr(ifp);
> +			perror("blkiomon: error while reading trace");
> +			break;
> +		}
> +
> +		if (data_is_native = -1 && check_data_endianness(bit->magic))
> +			break;
> +
> +		/* endianess */
> +		trace_to_cpu(bit);
> +		if (verify_trace(bit)) {
> +			perror("blkiomon: bad trace");
> +			break;
> +		}
> +
> +		/* read additional trace payload */
> +		if (bit->pdu_len) {
> +			pdu_buf = realloc(pdu_buf, bit->pdu_len);
> +			if (fread(pdu_buf, bit->pdu_len, 1, ifp) != 1) {
> +				clearerr(ifp);
> +				perror("blkiomon: could not read payload");
> +				break;
> +			}
> +		}
> +
> +		t->sequence = sequence++;
> +
> +		if (!(bit->action & BLK_TC_ACT(BLK_TC_ISSUE | BLK_TC_COMPLETE)))
> +			continue;
> +
> +		/* try to find matching trace and update statistics */
> +		t = blkiomon_do_trace(t);
> +		if (!t)
> +			break;
> +		bit = &t->bit;
> +		/* t and bit will be recycled for next incoming trace */
> +	}
> +	blkiomon_free_trace(t);
> +	free(pdu_buf);
> +	return 0;
> +}
> +
> +static int blkiomon_open_output(struct output *out)
> +{
> +	int mode, vbuf_size;
> +
> +	if (!out->fn)
> +		return 0;
> +
> +	if (!strcmp(out->fn, "-")) {
> +		out->fp = fdopen(STDOUT_FILENO, "w");
> +		mode = _IOLBF;
> +		vbuf_size = 4096;
> +		out->pipe = 1;
> +	} else {
> +		out->fp = fopen(out->fn, "w");
> +		mode = _IOFBF;
> +		vbuf_size = 128 * 1024;
> +		out->pipe = 0;
> +	}
> +	if (!out->fp)
> +		goto failed;
> +	out->buf = malloc(128 * 1024);
> +	if (setvbuf(out->fp, out->buf, mode, vbuf_size))
> +		goto failed;
> +	return 0;
> +
> +failed:
> +	fprintf(stderr, "blkiomon: could not write to %s\n", out->fn);
> +	out->fn = NULL;
> +	free(out->buf);
> +	return 1;
> +}
> +
> +static int blkiomon_open_msg_q(void)
> +{
> +	key_t key;
> +
> +	if (!msg_q_name)
> +		return 0;
> +	if (!msg_q_id || msg_id <= 0)
> +		return 1;
> +	key = ftok(msg_q_name, msg_q_id);
> +	if (key = -1)
> +		return 1;
> +	while (up) {
> +		msg_q = msgget(key, S_IRWXU);
> +		if (msg_q >= 0)
> +			break;
> +	}
> +	return (msg_q >= 0 ? 0 : -1);
> +}
> +
> +static void blkiomon_debug(void)
> +{
> +	struct rb_node *n;
> +	struct trace *t;
> +
> +	if (!debug.fn)
> +		return;
> +
> +	for (n = rb_first(&trace_tree); n; n = rb_next(n)) {
> +		t = rb_entry(n, struct trace, node);
> +		dump_bit(t, "leftover");
> +		leftover++;
> +	}
> +	fprintf(debug.fp, "%ld leftover, %ld match, %ld mismatch, "
> +		"%ld driverdata, %ld overall\n",
> +		leftover, match, mismatch, driverdata, sequence);
> +}
> +
> +#define S_OPTS "b:D:h:I:Q:q:m:V"
> +
> +static char usage_str[] = "\n\nblkiomon " \
> +	"-I <interval>       | --interval=<interval>\n" \
> +	"[ -h <file>         | --human-readable=<file> ]\n" \
> +	"[ -b <file>         | --binary=<file> ]\n" \
> +	"[ -D <file>         | --debug=<file> ]\n" \
> +	"[ -Q <path name>    | --msg-queue-name=<path name>]\n" \
> +	"[ -q <msg queue id> | --msg-queue-id=<msg queue id>]\n" \
> +	"[ -m <msg id>       | --msg-id=<msg id>]\n" \
> +	"[ -V                | --version ]\n\n" \
> +	"\t-I   Sample interval.\n" \
> +	"\t-h   Human-readable output file.\n" \
> +	"\t-b   Binary output file.\n" \
> +	"\t-D   Output file for debugging data.\n" \
> +	"\t-Qqm Output to message queue using given ID for messages.\n" \
> +	"\t-V   Print program version.\n\n";
> +
> +static struct option l_opts[] = {
> +	{
> +		.name = "human-readable",
> +		.has_arg = required_argument,
> +		.flag = NULL,
> +		.val = 'h'
> +	},
> +	{
> +		.name = "binary",
> +		.has_arg = required_argument,
> +		.flag = NULL,
> +		.val = 'b'
> +	},
> +	{
> +		.name = "debug",
> +		.has_arg = required_argument,
> +		.flag = NULL,
> +		.val = 'D'
> +	},
> +	{
> +		.name = "interval",
> +		.has_arg = required_argument,
> +		.flag = NULL,
> +		.val = 'I'
> +	},
> +	{
> +		.name = "msg-queue",
> +		.has_arg = required_argument,
> +		.flag = NULL,
> +		.val = 'Q'
> +	},
> +	{
> +		.name = "msg-queue-id",
> +		.has_arg = required_argument,
> +		.flag = NULL,
> +		.val = 'q'
> +	},
> +	{
> +		.name = "msg-id",
> +		.has_arg = required_argument,
> +		.flag = NULL,
> +		.val = 'm'
> +	},
> +	{
> +		.name = "version",
> +		.has_arg = no_argument,
> +		.flag = NULL,
> +		.val = 'V'
> +	},
> +	{
> +		.name = NULL,
> +	}
> +};
> +
> +static void blkiomon_signal(int signal)
> +{
> +	fprintf(stderr, "blkiomon: terminated by signal\n");
> +	up = signal & 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int c;
> +
> +	signal(SIGALRM, blkiomon_signal);
> +	signal(SIGINT, blkiomon_signal);
> +	signal(SIGTERM, blkiomon_signal);
> +	signal(SIGQUIT, blkiomon_signal);
> +
> +	while ((c = getopt_long(argc, argv, S_OPTS, l_opts, NULL)) != -1) {
> +		switch (c) {
> +		case 'h':
> +			human.fn = optarg;
> +			break;
> +		case 'b':
> +			binary.fn = optarg;
> +			break;
> +		case 'D':
> +			debug.fn = optarg;
> +			break;
> +		case 'I':
> +			interval = atoi(optarg);
> +			break;
> +		case 'Q':
> +			msg_q_name = optarg;
> +			break;
> +		case 'q':
> +			msg_q_id = atoi(optarg);
> +			break;
> +		case 'm':
> +			msg_id = atoi(optarg);
> +			break;
> +		case 'V':
> +			printf("%s version %s\n", argv[0], blkiomon_version);
> +			return 0;
> +		default:
> +			fprintf(stderr, "Usage: %s", usage_str);
> +			return 1;
> +		}
> +	}
> +
> +	if (interval <= 0) {
> +		fprintf(stderr, "Usage: %s", usage_str);
> +		return 1;
> +	}
> +
> +	ifp = fdopen(STDIN_FILENO, "r");
> +	if (!ifp) {
> +		perror("blkiomon: could not open stdin for reading");
> +		return 1;
> +	}
> +
> +	if (blkiomon_open_output(&human))
> +		return 1;
> +	if (blkiomon_open_output(&binary))
> +		return 1;
> +	if (blkiomon_open_output(&debug))
> +		return 1;
> +	if (blkiomon_open_msg_q())
> +		return 1;
> +
> +	if (pthread_create(&interval_thread, NULL, blkiomon_interval, NULL)) {
> +		perror("blkiomon: could not create thread");
> +		return 1;
> +	}
> +
> +	blkiomon_do_fifo();
> +
> +	blkiomon_debug();
> +	return 0;
> +}
> Index: blktrace/Makefile
> =================================> --- blktrace.orig/Makefile
> +++ blktrace/Makefile
> @@ -1,7 +1,7 @@
>  CC	= gcc
>  CFLAGS	= -Wall -O2 -g -W
>  ALL_CFLAGS = $(CFLAGS) -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITSd
> -PROGS	= blkparse blktrace verify_blkparse blkrawverify
> +PROGS	= blkparse blktrace verify_blkparse blkrawverify blkiomon
>  LIBS	= -lpthread
>  SCRIPTS	= btrace
> 
> @@ -34,6 +34,9 @@ verify_blkparse: verify_blkparse.o
>  blkrawverify: blkrawverify.o
>  	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^)
> 
> +blkiomon: blkiomon.o rbtree.o
> +	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS) -lrt
> +
>  $(PROGS): | depend
> 
>  docs:
> Index: blktrace/blkiomon.h
> =================================> --- /dev/null
> +++ blktrace/blkiomon.h
> @@ -0,0 +1,105 @@
> +/*
> + * I/O monitor based on block queue trace data
> + *
> + * Copyright IBM Corp. 2008
> + *
> + * Author(s): Martin Peschke <mp3@de.ibm.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef BLKIOMON_H
> +#define BLKIOMON_H
> +
> +#include <string.h>
> +
> +#include "stats.h"
> +#include "blktrace.h"
> +
> +#define BLKIOMON_SIZE_BUCKETS 16
> +#define BLKIOMON_D2C_BUCKETS 25
> +struct blkiomon_stat {
> +	__u64 time;
> +	__u32 size_hist[BLKIOMON_SIZE_BUCKETS];
> +	__u32 d2c_hist[BLKIOMON_D2C_BUCKETS];
> +	struct minmax size_mm;
> +	struct minmax d2c_mm;
> +	__u64 read;
> +	__u64 write;
> +	__u64 bidir;
> +	__u32 device;
> +};
> +
> +static struct histlog2 size_hist = {
> +	.first = 0,
> +	.delta = 1024,
> +	.num = BLKIOMON_SIZE_BUCKETS
> +};
> +
> +static struct histlog2 d2c_hist = {
> +	.first = 0,
> +	.delta = 8,
> +	.num = BLKIOMON_D2C_BUCKETS
> +};
> +
> +static inline void blkiomon_stat_init(struct blkiomon_stat *bstat)
> +{
> +	memset(bstat, 0, sizeof(*bstat));
> +	minmax_init(&bstat->size_mm);
> +	minmax_init(&bstat->d2c_mm);
> +}
> +
> +static inline void blkiomon_stat_to_be(struct blkiomon_stat *bstat)
> +{
> +	histlog2_to_be(bstat->size_hist, &size_hist);
> +	histlog2_to_be(bstat->d2c_hist, &d2c_hist);
> +	minmax_to_be(&bstat->size_mm);
> +	minmax_to_be(&bstat->d2c_mm);
> +	bstat->read = cpu_to_be64(bstat->read);
> +	bstat->write = cpu_to_be64(bstat->write);
> +	bstat->bidir = cpu_to_be64(bstat->bidir);
> +	bstat->time = cpu_to_be64(bstat->time);
> +	bstat->device = cpu_to_be32(bstat->device);
> +}
> +
> +static inline void blkiomon_stat_merge(struct blkiomon_stat *dst,
> +				       struct blkiomon_stat *src)
> +{
> +	histlog2_merge(&size_hist, dst->size_hist, src->size_hist);
> +	histlog2_merge(&d2c_hist, dst->d2c_hist, src->d2c_hist);
> +	minmax_merge(&dst->size_mm, &src->size_mm);
> +	minmax_merge(&dst->d2c_mm, &src->d2c_mm);
> +	dst->read += src->read;
> +	dst->write += src->write;
> +	dst->bidir += src->bidir;
> +}
> +
> +static inline void blkiomon_stat_print(FILE *fp, struct blkiomon_stat *p)
> +{
> +	if (!fp)
> +		return;
> +
> +	fprintf(fp, "\ntime: %s", ctime((void *)&p->time));
> +	fprintf(fp, "device: %d,%d\n", MAJOR(p->device), MINOR(p->device));
> +	fprintf(fp, "requests: read %ld, write %ld, bidir: %ld\n",
> +		(unsigned long)p->read, (unsigned long)p->write,
> +		(unsigned long)p->bidir);
> +	minmax_print(fp, "sizes", &p->size_mm);
> +	minmax_print(fp, "d2c", &p->d2c_mm);
> +	histlog2_print(fp, "sizes histogram (in kB)", p->size_hist, &size_hist);
> +	histlog2_print(fp, "d2c histogram (in usec)", p->d2c_hist, &d2c_hist);
> +}
> +
> +#endif
> Index: blktrace/doc/blkiomon.8
> =================================> --- /dev/null
> +++ blktrace/doc/blkiomon.8
> @@ -0,0 +1,116 @@
> +.TH BLKIOMON 8 "July 17, 2008" "" ""
> +
> +
> +.SH NAME
> +blkiomon \- monitor block device I/O based o blktrace data
> +
> +
> +.SH SYNOPSIS
> +.B blkiomon \-I \fIinterval\fR [ \-h \fIfile\fR ] [ \-b \fIfile\fR ]
> +[ \-D \fIfile\fR ] [ \-Q \fIpath_name\fR
> +\-q \fImsg_queue_id\fR \-m \fImsg_id\fR ] [ \-V ]
> +.br
> +
> +
> +.SH DESCRIPTION
> +blkiomon is a block device I/O monitor. It periodically generates per device
> +request size and request latency statistics from blktrace data. It provides
> +histograms as well as data that can be used to calculate min, max, average
> +and variance. For this purpose, it consumes D and C traces read from stdin.
> +
> +There are options for binary output and human-readable output to files and
> +stdout. Output to a message queue is supported as well.
> +
> +There is no need to use blkparse with blkiomon. blkiomon is capable of
> +consuming binary output written to stdout by blktrace.
> +
> +
> +.SH OPTIONS
> +
> +\-I \fIinterval\fR
> +.br
> +\-\-interval=\fIinterval\fR
> +.RS
> +Set sample interval
> +.RE
> +
> +\-h \fIfile\fR
> +.br
> +\-\-human\-readable=\fIfile\fR
> +.RS
> +Human-readable output file. Use '\-' for stdout.
> +.RE
> +
> +\-b \fIfile\fR
> +.br
> +\-\-binary=\fIfile\fR
> +.RS
> +Binary output file. Use '\-' for stdout.
> +.RE
> +
> +\-D \fIfile\fR
> +.br
> +\-\-debug=\fIfile\fR
> +.RS
> +Output file for debugging data. Use '\-' for stdout.
> +.RE
> +
> +\-Q \fIpath_name\fR
> +.br
> +\-\-msg\-queue\-name=\fIpath_name\fR
> +.RS
> +Sets \fIpath_name\fR as path name for existing message queue to be used
> +for binary output.
> +.RE
> +
> +\-q \fImsg_queue_id\fR
> +.br
> +\-\-msg\-queue\-id=\fImsg_queue_id\fR
> +.RS
> +Sets \fImsg_queue_id\fR as ID for an existing message queue to be used
> +for binary output.
> +.RE
> +
> +\-m \fImsg_id\fR
> +.br
> +\-\-msg\-id=\fImsg_id\fR
> +.RS
> +Sets \fImsg_id\fR as message identifier to be used for binary output
> +messages written to an existing message queue.
> +.RE
> +
> +\-V
> +.br
> +\-\-version
> +.RS
> +Print program version.
> +.RE
> +
> +
> +.SH EXAMPLES
> +To get I/O statistics for /dev/sdw every 10 seconds for a period of one hour,
> +use the following command:
> +
> +    % blktrace /dev/sdw -a issue -a complete -w 3600 -o - | blkiomon -I 10 -h -
> +
> +
> +.SH AUTHORS
> +blkiomon and this man page were written by Martin Peschke.
> +
> +
> +.SH "REPORTING BUGS"
> +Report bugs to <linux\-btrace@vger.kernel.org>
> +
> +
> +.SH COPYRIGHT
> +Copyright \(co 2008 IBM Corp.
> +.br
> +This is free software.  You may redistribute copies of it under the terms of
> +the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
> +There is NO WARRANTY, to the extent permitted by law.
> +
> +
> +.SH "SEE ALSO"
> +btrace (8), blktrace (8), blkparse (1), verify_blkparse (1), blkrawverify (1),
> +btt (1)
> +
> Index: blktrace/stats.h
> =================================> --- /dev/null
> +++ blktrace/stats.h
> @@ -0,0 +1,155 @@
> +/*
> + * Copyright IBM Corp. 2008
> + *
> + * Author(s): Martin Peschke <mp3@de.ibm.com>
> + *            Stefan Raspl <stefan.raspl@de.ibm.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef STATS_H
> +#define STATS_H
> +
> +#include <linux/types.h>
> +#include "endian.h"
> +
> +struct minmax {
> +	__u64 min;
> +	__u64 max;
> +	__u64 sum;
> +	__u64 sos;
> +	__u64 num;
> +};
> +
> +static inline void minmax_init(struct minmax *mm)
> +{
> +	mm->min = -1ULL;
> +	mm->max = 0;
> +	mm->sum = 0;
> +	mm->sos = 0;
> +	mm->num = 0;
> +}
> +
> +static inline void minmax_account(struct minmax *mm, __u64 value)
> +{
> +	mm->sum += value;
> +	mm->sos += value * value;
> +	if (value < mm->min)
> +		mm->min = value;
> +	if (value > mm->max)
> +		mm->max = value;
> +	mm->num++;
> +}
> +
> +static inline void minmax_merge(struct minmax *dst, struct minmax *src)
> +{
> +	dst->sum += src->sum;
> +	dst->sos += src->sos;
> +	if (src->min < dst->min)
> +		dst->min = src->min;
> +	if (src->max > dst->max)
> +		dst->max = src->max;
> +	dst->num += src->num;
> +}
> +
> +static inline void minmax_to_be(struct minmax *mm)
> +{
> +	mm->sum = cpu_to_be64(mm->sum);
> +	mm->sos = cpu_to_be64(mm->sos);
> +	mm->min = cpu_to_be64(mm->min);
> +	mm->max = cpu_to_be64(mm->max);
> +	mm->num = cpu_to_be64(mm->num);
> +}
> +
> +static inline double minmax_avg(struct minmax *mm)
> +{
> +	return (mm->sum / (double)mm->num);
> +}
> +
> +static inline double minmax_var(struct minmax *mm)
> +{
> +	double num = (double)mm->num;
> +
> +	return ((mm->sos - ((mm->sum * mm->sum) / num)) / num);
> +}
> +
> +static inline int minmax_print(FILE *fp, const char *s, struct minmax *mm)
> +{
> +	return fprintf(fp, "%s: num %Ld, min %Ld, max %Ld, sum %Ld, squ %Ld, "
> +		       "avg %.1f, var %.1f\n", s, (unsigned long long)mm->num,
> +		       (unsigned long long)mm->min, (unsigned long long)mm->max,
> +		       (unsigned long long)mm->sum, (unsigned long long)mm->sos,
> +		       minmax_avg(mm), minmax_var(mm));
> +}
> +
> +struct histlog2 {
> +	int first;
> +	int delta;
> +	int num;
> +};
> +
> +static inline __u64 histlog2_upper_limit(int index, struct histlog2 *h)
> +{
> +	return h->first + (index ? h->delta << (index - 1) : 0);
> +}
> +
> +static inline int histlog2_index(__u64 val, struct histlog2 *h)
> +{
> +	int i;
> +
> +	for (i = 0; i < (h->num - 1) && val > histlog2_upper_limit(i, h); i++);
> +	return i;
> +}
> +
> +static inline void histlog2_account(__u32 *bucket, __u32 val,
> +				    struct histlog2 *h)
> +{
> +	int index = histlog2_index(val, h);
> +	bucket[index]++;
> +}
> +
> +static inline void histlog2_merge(struct histlog2 *h, __u32 *dst, __u32 *src)
> +{
> +	int i;
> +
> +	for (i = 0; i < h->num - 1; i++)
> +		dst[i] += src[i];
> +}
> +
> +static inline void histlog2_to_be(__u32 a[], struct histlog2 *h)
> +{
> +	int i;
> +
> +	for (i = 0; i < h->num - 1; i++)
> +		a[i] = cpu_to_be32(a[i]);
> +}
> +
> +static inline void histlog2_print(FILE *fp, const char *s, __u32 a[],
> +				  struct histlog2 *h)
> +{
> +	int i;
> +
> +	fprintf(fp, "%s:\n", s);
> +	for (i = 0; i < h->num - 1; i++) {
> +		fprintf(fp, "   %10ld:%6d",
> +			(unsigned long)(histlog2_upper_limit(i, h)), a[i]);
> +		if (!((i + 1) % 4))
> +			fprintf(fp, "\n");
> +	}
> +	fprintf(fp, "    >%8ld:%6d\n",
> +		(unsigned long)(histlog2_upper_limit(i - 1, h)), a[i]);
> +}
> +
> +#endif
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

