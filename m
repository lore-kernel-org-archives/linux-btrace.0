Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53C3AEF5A
	for <linux-btrace@vger.kernel.org>; Sat,  3 Oct 2026 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791028813; cv=none; b=YN12Nep7o7/1VCOuXkQmQk0h4Fa/1hzNTl8NZBh/oufRhM/LuFn9X7VAV3LGrotwW40nV4Vf7XXxIMns2chaoSb0u3YkwG9Ntau5SSGZ0JYofABhoQYwaXxaecFXRiWllwxmo9TG1odS/4MKZbAtA8KvLFRI3Ho1mhANaPD4k80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791028813; c=relaxed/simple;
	bh=IvwwLFA/YxoHYhcNqHsqnWvrYLAMS+P069SFvOQcxVQ=;
	h=Subject:From:To:Date:Message-Id; b=R/W4tgGQRyAPpmHbwh0KDGHpkjBJUMOR51fVOYscFw1IRUAsoXk2mYlg1X+TdPTsoWJiTQdQ9Vr5WhI6iSlpCLA6V95zLO3PyI9WM8BteszdnvheRVmqMSSMsBLRMZ+SrKhl7YtDQGCVTRMP+amgZrC+PPEEIZf9KtGA3Jis19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=fail smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oDLE5fb/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oDLE5fb/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Message-Id:Date:To:From:Subject:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=W+Hb7cFedpIViBsQ1I6FrPz+4e/JZilGbyLYcPuhuqs=; b=oDLE5fb/qRKmAg21LRVtOwstb2
	iTWPeJw+9mzxHw5CTHMfwk4JwMjmVsH9joNeZnHgvKFPm2KYSBLjF8mW9PcJ936Qp96Kj9uvAckp0
	B14IBrlvu/5eOs1RejmpD21j6+qOypGA5uL5Cbu+OrITj6tj1T0GJDZpIQth0QQF6QrKnNPpZ1Fd0
	m/6xfN/ydjzCGmTOlg6dLHVIEYQRGQA3c4isSZZmc3xo+ppUWnzhWfuwPZc0H1YVIM1PtWIau+xgk
	wEjV0wmEv+wWEIBUTbr97D++dzFFXiCm5/oV3YHYLP4EiINZ3iid885VRv3AVm2Wed3ccmrSVFTNC
	aod8EI+Q==;
Received: from [96.43.243.2] (helo=kernel.dk)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCyPN-00000006RRH-2A20
	for linux-btrace@vger.kernel.org;
	Sat, 03 Oct 2026 12:00:06 +0000
Received: by kernel.dk (Postfix, from userid 1000)
	id F07661BC0178; Sat,  3 Oct 2026 06:00:01 -0600 (MDT)
Subject: Recent changes (master)
From: Jens Axboe <axboe@kernel.dk>
To: <linux-btrace@vger.kernel.org>
User-Agent: mail (GNU Mailutils 3.17)
Date: Sat,  3 Oct 2026 06:00:01 -0600
Message-Id: <20261003120001.F07661BC0178@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>

The following changes since commit 9b24b42ef59d2e8015957db3dd70ffedb7ebcfe8:

  Update git tree references (2025-12-10 23:53:45 -0700)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to b3015a35bd6332dfead81aa29fed5b8a6567036f:

  iowatcher/main: remove written only variable (2026-10-02 08:24:58 -0600)

----------------------------------------------------------------
Jens Axboe (1):
      iowatcher/main: remove written only variable

Johannes Thumshirn (11):
      btt: use blk_io_trace2 internally
      btt: natively parse blk_io_trace2
      blktrace: add option to request a specific trace protocol version
      blkrawverify: use blk_io_trace2 internally
      blkrawverify: natively parse blk_io_trace2
      blkiomon: use blk_io_trace2 internally
      blkiomon: natively parse blk_io_trace2
      iowatcher: use blk_io_trace2 internally
      iowatcher: natively parse blk_io_trace2
      btreplay: support blk_io_trace2 in btrecord
      blkparse: add option to emit a specific trace protocol version

 blkiomon.c           |  93 +++++++++++++++++++++++---------
 blkparse.c           |  64 +++++++++++++++++++---
 blkrawverify.c       |  69 ++++++++++++++++++------
 blktrace.c           |  24 ++++++++-
 blktrace.h           |  20 +++++++
 btreplay/btrecord.c  |  83 ++++++++++++++++++++++------
 btt/globals.h        |   4 +-
 btt/mmap.c           | 134 ++++++++++++++++++++++++++++++++++++++++++---
 doc/blkparse.1       |   7 +++
 doc/blktrace.8       |   7 +++
 iowatcher/blkparse.c | 150 ++++++++++++++++++++++++++++++++++++++-------------
 iowatcher/blkparse.h |   3 +-
 iowatcher/main.c     |   2 -
 13 files changed, 543 insertions(+), 117 deletions(-)

---

Diff of recent changes:

diff --git a/blkiomon.c b/blkiomon.c
index 9defa2c..081d1a8 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -42,7 +42,7 @@
 #include "blkiomon.h"
 
 struct trace {
-	struct blk_io_trace bit;
+	struct blk_io_trace2 bit;
 	struct rb_node node;
 	struct trace *next;
 	long sequence;
@@ -105,7 +105,7 @@ static long leftover = 0, driverdata = 0, match = 0, mismatch = 0, sequence = 0;
 
 static void dump_bit(struct trace *t, const char *descr)
 {
-	struct blk_io_trace *bit = &t->bit;
+	struct blk_io_trace2 *bit = &t->bit;
 
 	if (!debug.fn)
 		return;
@@ -116,7 +116,7 @@ static void dump_bit(struct trace *t, const char *descr)
 	fprintf(debug.fp, "time     %16ld\n", (unsigned long)bit->time);
 	fprintf(debug.fp, "sector   %16ld\n", (unsigned long)bit->sector);
 	fprintf(debug.fp, "bytes    %16d\n", bit->bytes);
-	fprintf(debug.fp, "action   %16x\n", bit->action);
+	fprintf(debug.fp, "action   %16llx\n", (unsigned long long)bit->action);
 	fprintf(debug.fp, "pid      %16d\n", bit->pid);
 	fprintf(debug.fp, "device   %16d\n", bit->device);
 	fprintf(debug.fp, "cpu      %16d\n", bit->cpu);
@@ -128,8 +128,8 @@ static void dump_bit(struct trace *t, const char *descr)
 
 static void dump_bits(struct trace *t1, struct trace *t2, const char *descr)
 {
-	struct blk_io_trace *bit1 = &t1->bit;
-	struct blk_io_trace *bit2 = &t2->bit;
+	struct blk_io_trace2 *bit1 = &t1->bit;
+	struct blk_io_trace2 *bit2 = &t2->bit;
 
 	if (!debug.fn)
 		return;
@@ -143,7 +143,9 @@ static void dump_bits(struct trace *t1, struct trace *t2, const char *descr)
 	fprintf(debug.fp, "sector   %16ld %16ld\n",
 		(unsigned long)bit1->sector, (unsigned long)bit2->sector);
 	fprintf(debug.fp, "bytes    %16d %16d\n", bit1->bytes, bit2->bytes);
-	fprintf(debug.fp, "action   %16x %16x\n", bit1->action, bit2->action);
+	fprintf(debug.fp, "action   %16llx %16llx\n",
+		(unsigned long long)bit1->action,
+		(unsigned long long)bit2->action);
 	fprintf(debug.fp, "pid      %16d %16d\n", bit1->pid, bit2->pid);
 	fprintf(debug.fp, "device   %16d %16d\n", bit1->device, bit2->device);
 	fprintf(debug.fp, "cpu      %16d %16d\n", bit1->cpu, bit2->cpu);
@@ -305,8 +307,8 @@ static void *blkiomon_interval(void *data)
 
 #define BLK_DATADIR(a) (((a) >> BLK_TC_SHIFT) & (BLK_TC_READ | BLK_TC_WRITE))
 
-static int blkiomon_account(struct blk_io_trace *bit_d,
-			    struct blk_io_trace *bit_c)
+static int blkiomon_account(struct blk_io_trace2 *bit_d,
+			    struct blk_io_trace2 *bit_c)
 {
 	struct dstat *dstat;
 	struct blkiomon_stat *p;
@@ -371,7 +373,7 @@ static void blkiomon_store_trace(struct trace *t)
 	thash[i] = t;
 }
 
-static struct trace *blkiomon_fetch_trace(struct blk_io_trace *bit)
+static struct trace *blkiomon_fetch_trace(struct blk_io_trace2 *bit)
 {
 	int i = bit->sector % TRACE_HASH_SIZE;
 	struct trace *t, *prev = NULL;
@@ -428,7 +430,7 @@ static struct trace *blkiomon_do_trace(struct trace *t)
 	return t_old;
 }
 
-static int blkiomon_dump_drvdata(struct blk_io_trace *bit, void *pdu_buf)
+static int blkiomon_dump_drvdata(struct blk_io_trace2 *bit, void *pdu_buf)
 {
 	if (!drvdata.fn)
 		return 0;
@@ -451,8 +453,10 @@ failed:
 static int blkiomon_do_fifo(void)
 {
 	struct trace *t;
-	struct blk_io_trace *bit;
+	struct blk_io_trace2 *bit;
+	struct blk_io_trace bit1;
 	void *pdu_buf = NULL;
+	void *p;
 
 	t = blkiomon_alloc_trace();
 	if (!t)
@@ -461,6 +465,7 @@ static int blkiomon_do_fifo(void)
 
 	while (up) {
 		__u32 magic;
+		int version;
 
 		if (fread(&magic, sizeof(magic), 1, ifp) != 1) {
 			if (!feof(ifp))
@@ -468,26 +473,64 @@ static int blkiomon_do_fifo(void)
 					"blkiomon: could not read trace");
 			break;
 		}
-		if (fread(bit, sizeof(*bit), 1, ifp) != 1) {
-			if (!feof(ifp))
-				fprintf(stderr,
-					"blkiomon: could not read trace");
-			break;
-		}
-		bit->magic = magic;
-		if (ferror(ifp)) {
-			clearerr(ifp);
-			fprintf(stderr, "blkiomon: error while reading trace");
-			break;
-		}
 
 		if (data_is_native == -1 && check_data_endianness(magic)) {
 			fprintf(stderr, "blkiomon: endianess problem\n");
 			break;
 		}
 
-		/* endianess */
-		bit_trace_to_cpu(bit);
+		version = (data_is_native ? magic : be32_to_cpu(magic)) & 0xff;
+
+		if (version == SUPPORTED_VERSION2) {
+			bit->magic = magic;
+			p = (void *) ((u8 *)bit + sizeof(__u32));
+			if (fread(p, sizeof(*bit) - sizeof(__u32), 1, ifp) != 1) {
+				if (!feof(ifp))
+					fprintf(stderr,
+						"blkiomon: could not read trace");
+				break;
+			}
+			if (ferror(ifp)) {
+				clearerr(ifp);
+				fprintf(stderr,
+					"blkiomon: error while reading trace");
+				break;
+			}
+
+			/* endianess */
+			bit2_trace_to_cpu(bit);
+		} else {
+			bit1.magic = magic;
+			p = (void *) ((u8 *)&bit1 + sizeof(__u32));
+			if (fread(p, sizeof(bit1) - sizeof(__u32), 1, ifp) != 1) {
+				if (!feof(ifp))
+					fprintf(stderr,
+						"blkiomon: could not read trace");
+				break;
+			}
+			if (ferror(ifp)) {
+				clearerr(ifp);
+				fprintf(stderr,
+					"blkiomon: error while reading trace");
+				break;
+			}
+
+			/* endianess */
+			bit_trace_to_cpu(&bit1);
+
+			bit->magic	= bit1.magic;
+			bit->sequence	= bit1.sequence;
+			bit->time	= bit1.time;
+			bit->sector	= bit1.sector;
+			bit->bytes	= bit1.bytes;
+			bit->action	= bit1.action;
+			bit->pid	= bit1.pid;
+			bit->device	= bit1.device;
+			bit->cpu	= bit1.cpu;
+			bit->error	= bit1.error;
+			bit->pdu_len	= bit1.pdu_len;
+		}
+
 		if (verify_trace(bit->magic)) {
 			fprintf(stderr, "blkiomon: bad trace\n");
 			break;
diff --git a/blkparse.c b/blkparse.c
index 76c775b..88ef019 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -119,6 +119,10 @@ static struct per_process_info *ppi_hash_table[PPI_HASH_SIZE];
 static struct per_process_info *ppi_list;
 static int ppi_list_entries;
 
+enum {
+	OPT_TRACE_VERSION = 256,
+};
+
 static struct option l_opts[] = {
  	{
 		.name = "act-mask",
@@ -234,6 +238,12 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 'V'
 	},
+	{
+		.name = "trace-version",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = OPT_TRACE_VERSION
+	},
 	{
 		.name = NULL,
 	}
@@ -306,6 +316,7 @@ int data_is_native = -1;
 
 static FILE *dump_fp;
 static char *dump_binary;
+static int dump_trace_version = 2;
 
 static unsigned int t_alloc_cache;
 static unsigned int bit_alloc_cache;
@@ -349,14 +360,40 @@ static void io_warn_unless(struct blk_io_trace2 *t, int condition,
 
 static void output_binary(void *buf, int len)
 {
-	if (dump_binary) {
-		size_t n = fwrite(buf, len, 1, dump_fp);
-		if (n != 1) {
-			perror(dump_binary);
-			fclose(dump_fp);
-			dump_binary = NULL;
+	if (!dump_binary)
+		return;
+
+	/*
+	 * The traces are kept as 'struct blk_io_trace2' internally. When a
+	 * version 1 dump is requested, convert them back into the legacy
+	 * 'struct blk_io_trace' before writing them out.
+	 */
+	if (dump_trace_version == 1) {
+		struct blk_io_trace2 *bit2 = buf;
+		struct blk_io_trace *bit;
+
+		len = sizeof(*bit) + bit2->pdu_len;
+		bit = malloc(len);
+		if (!bit)
+			goto err;
+
+		bit2_to_bit(bit2, bit);
+
+		if (fwrite(bit, len, 1, dump_fp) != 1) {
+			free(bit);
+			goto err;
 		}
+		free(bit);
+		return;
 	}
+
+	if (fwrite(buf, len, 1, dump_fp) != 1)
+		goto err;
+	return;
+err:
+	perror(dump_binary);
+	fclose(dump_fp);
+	dump_binary = NULL;
 }
 
 static void resize_cpu_info(struct per_dev_info *pdi, int cpu)
@@ -3175,7 +3212,8 @@ static char usage_str[] =    "\n\n" \
 	"[ -w <time>         | --stopwatch=<time> ]\n" \
 	"[ -M                | --no-msgs\n" \
 	"[ -v                | --verbose ]\n" \
-	"[ -V                | --version ]\n\n" \
+	"[ -V                | --version ]\n" \
+	"[ --trace-version=<1|2> ]\n\n" \
 	"\t-a Only trace specified actions. See documentation\n" \
 	"\t-A Give trace mask as a single value. See documentation\n" \
 	"\t-b stdin read batching\n" \
@@ -3201,7 +3239,8 @@ static char usage_str[] =    "\n\n" \
 	"\t   If 'start' isn't given, blkparse defaults the start time to 0\n" \
 	"\t-M Do not output messages to binary file\n" \
 	"\t-v More verbose for marginal errors\n" \
-	"\t-V Print program version info\n\n";
+	"\t-V Print program version info\n" \
+	"\t--trace-version Emit a version 1 or 2 (default) binary trace\n\n";
 
 static void usage(char *prog)
 {
@@ -3298,6 +3337,15 @@ int main(int argc, char *argv[])
 		case 'M':
 			bin_output_msgs = 0;
 			break;
+		case OPT_TRACE_VERSION:
+			dump_trace_version = atoi(optarg);
+
+			if (dump_trace_version != 1 &&
+			    dump_trace_version != 2) {
+				usage(argv[0]);
+				return 1;
+			}
+			break;
 		default:
 			usage(argv[0]);
 			return 1;
diff --git a/blkrawverify.c b/blkrawverify.c
index 8e863cb..7ef3c07 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -102,7 +102,7 @@ static char *act_to_str(__u64 action)
 	return buf;
 }
 
-static void dump_trace(FILE *ofp, char *prefix, struct blk_io_trace *bit)
+static void dump_trace(FILE *ofp, char *prefix, struct blk_io_trace2 *bit)
 {
 	fprintf(ofp, "    Dump %s\n", prefix);
 	fprintf(ofp, "        %8s: %08x\n", "magic", bit->magic);
@@ -119,17 +119,63 @@ static void dump_trace(FILE *ofp, char *prefix, struct blk_io_trace *bit)
 						           MINOR(bit->device));
 }
 
+static int read_trace(FILE *ifp, struct blk_io_trace2 *bit)
+{
+	struct blk_io_trace bit1;
+	struct blk_io_trace2 bit2;
+	__u32 magic;
+	int version;
+	void *p;
+
+	if (fread(&magic, sizeof(magic), 1, ifp) != 1)
+		return 0;
+
+	if (data_is_native == -1)
+		check_data_endianness(magic);
+
+	version = (data_is_native ? magic : be32_to_cpu(magic)) & 0xff;
+
+	if (version == SUPPORTED_VERSION2) {
+		bit2.magic = magic;
+		p = (void *) ((u8 *)&bit2 + sizeof(__u32));
+		if (fread(p, sizeof(bit2) - sizeof(__u32), 1, ifp) != 1)
+			return 0;
+		bit2_trace_to_cpu(&bit2);
+		*bit = bit2;
+	} else {
+		bit1.magic = magic;
+		p = (void *) ((u8 *)&bit1 + sizeof(__u32));
+		if (fread(p, sizeof(bit1) - sizeof(__u32), 1, ifp) != 1)
+			return 0;
+		bit_trace_to_cpu(&bit1);
+
+		bit->magic	= bit1.magic;
+		bit->sequence	= bit1.sequence;
+		bit->time	= bit1.time;
+		bit->sector	= bit1.sector;
+		bit->bytes	= bit1.bytes;
+		bit->action	= bit1.action;
+		bit->pid	= bit1.pid;
+		bit->device	= bit1.device;
+		bit->cpu	= bit1.cpu;
+		bit->error	= bit1.error;
+		bit->pdu_len	= bit1.pdu_len;
+	}
+
+	return 1;
+}
+
 static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 {
 #	define SWAP_BITS() do {						\
 		if (bit_save) {						\
-			struct blk_io_trace *tmp = bit_save;		\
+			struct blk_io_trace2 *tmp = bit_save;		\
 			bit_save = bit;					\
 			bit = tmp;					\
 		}							\
 		else {							\
 			bit_save = bit;					\
-			bit = malloc(sizeof(struct blk_io_trace));	\
+			bit = malloc(sizeof(struct blk_io_trace2));	\
 		}							\
 	} while (0)
 
@@ -145,8 +191,8 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 	FILE *ifp, *ofp;
 	__u32 save_device = 0, save_sequence = 0;
 	__u64 save_time = 0;
-	struct blk_io_trace *bit_save = NULL;
-	struct blk_io_trace *bit = malloc(sizeof(struct blk_io_trace));
+	struct blk_io_trace2 *bit_save = NULL;
+	struct blk_io_trace2 *bit = malloc(sizeof(struct blk_io_trace2));
 	unsigned int ngood = 0;
 	unsigned int nbad = 0;
 	unsigned int nbad_trace = 0, nbad_pdu = 0, nbad_cpu = 0;
@@ -172,27 +218,18 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 	}
 
 	ofp = *fp;
-	while ((n = fread(bit, sizeof(struct blk_io_trace), 1, ifp)) == 1) {
+	while (read_trace(ifp, bit)) {
 		if (ferror(ifp)) {
 			clearerr(ifp);
 			perror("fread");
 			break;
 		}
-		if (data_is_native == -1)
-			check_data_endianness(bit->magic);
-
-		bit_trace_to_cpu(bit);
 
 		if (!CHECK_MAGIC(bit->magic)) {
 			INC_BAD("bad trace");
 			continue;
 		}
 
-		if ((bit->magic & 0xff) != SUPPORTED_VERSION) {
-			fprintf(stderr, "unsupported trace version\n");
-			break;
-		}
-
 		if (bit->pdu_len) {
 			char *pdu_buf;
 
@@ -245,7 +282,7 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 		SWAP_BITS();
 	}
 
-	if (n == 0 && !feof(ifp))
+	if (!feof(ifp))
 		fprintf(stderr,"%s: fread failed %d/%s\n",
 		        file, errno, strerror(errno));
 	fclose(ifp);
diff --git a/blktrace.c b/blktrace.c
index 72562fd..89a8f8a 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -283,6 +283,7 @@ static unsigned long long act_mask = ~0U;
 static int kill_running_trace;
 static int stop_watch;
 static int piped_output;
+static int trace_ver;
 
 static char *debugfs_path = "/sys/kernel/debug";
 static char *output_name;
@@ -329,6 +330,10 @@ static int *cl_fds;
 static int (*handle_pfds)(struct tracer *, int, int);
 static int (*handle_list)(struct tracer_devpath_head *, struct list_head *);
 
+enum {
+	OPT_TRACE_VERSION = 256,
+};
+
 #define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:"
 static struct option l_opts[] = {
 	{
@@ -433,6 +438,12 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 's'
 	},
+	{
+		.name = "trace-version",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = OPT_TRACE_VERSION
+	},
 	{
 		.name = NULL,
 	}
@@ -455,6 +466,7 @@ static char usage_str[] = "\n\n" \
         "[ -I <devs file>     | --input-devs=<devs file>]\n" \
         "[ -v <version>       | --version]\n" \
         "[ -V <version>       | --version]\n" \
+        "[ --trace-version=<1|2> ]\n" \
 
 	"\t-d Use specified device. May also be given last after options\n" \
 	"\t-r Path to mounted debugfs, defaults to /sys/kernel/debug\n" \
@@ -471,7 +483,8 @@ static char usage_str[] = "\n\n" \
 	"\t-s Make the network client NOT use sendfile() to transfer data\n" \
 	"\t-I Add devices found in <devs file>\n" \
 	"\t-v Print program version info\n" \
-	"\t-V Print program version info\n\n";
+	"\t-V Print program version info\n" \
+	"\t--trace-version Request trace protocol version 1 or 2 from the kernel\n\n";
 
 static void clear_events(struct pollfd *pfd)
 {
@@ -2244,6 +2257,13 @@ static int handle_args(int argc, char *argv[])
 		case 's':
 			net_use_sendfile = 0;
 			break;
+		case OPT_TRACE_VERSION:
+			trace_ver = atoi(optarg);
+			if (trace_ver != 1 && trace_ver != 2) {
+				show_usage(argv[0]);
+				exit(1);
+			}
+			break;
 		default:
 			show_usage(argv[0]);
 			exit(1);
@@ -2714,7 +2734,7 @@ static int run_tracers(void)
 	if (net_mode == Net_client)
 		printf("blktrace: connecting to %s\n", hostname);
 
-	if (setup_buts2()) {
+	if (trace_ver == 1 || setup_buts2()) {
 		if (setup_buts()) {
 			done = 1;
 			return 1;
diff --git a/blktrace.h b/blktrace.h
index ba06237..370e921 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -129,6 +129,26 @@ static inline void bit_to_bit2(struct blk_io_trace *old,
 		       old->pdu_len);
 }
 
+static inline void bit2_to_bit(struct blk_io_trace2 *new,
+			       struct blk_io_trace *old)
+{
+	old->magic	= BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
+	old->sequence	= new->sequence;
+	old->time	= new->time;
+	old->sector	= new->sector;
+	old->bytes	= new->bytes;
+	old->action	= new->action;
+	old->pid	= new->pid;
+	old->device	= new->device;
+	old->cpu	= new->cpu;
+	old->error	= new->error;
+	old->pdu_len	= new->pdu_len;
+
+	if (old->pdu_len)
+		memcpy(((u8 *) old + sizeof(*old)), ((u8 *)new + sizeof(*new)),
+		       new->pdu_len);
+}
+
 static inline void bit2_trace_to_cpu(struct blk_io_trace2 *t)
 {
 	if (data_is_native)
diff --git a/btreplay/btrecord.c b/btreplay/btrecord.c
index a07ca07..c1c9456 100644
--- a/btreplay/btrecord.c
+++ b/btreplay/btrecord.c
@@ -200,7 +200,7 @@ static inline void fatal(const char *errstring, const int exitval,
  * match - Return true if this trace is a proper QUEUE transaction
  * @action: Action field from trace
  */
-static inline int match(__u32 action)
+static inline int match(__u64 action)
 {
 	return ((action & 0xffff) == __BLK_TA_QUEUE) &&
 				       (action & BLK_TC_ACT(BLK_TC_QUEUE));
@@ -483,41 +483,92 @@ void handle_args(int argc, char *argv[])
 static int next_io(struct ifile_info *iip, struct io_spec *spec)
 {
 	ssize_t ret;
-	__u32 action;
+	__u64 action;
 	__u16 pdu_len;
+	__u32 magic;
+	int version;
 	struct blk_io_trace t;
+	struct blk_io_trace2 t2;
+	void *p;
 
 again:
-	ret = read(iip->ifd, &t, sizeof(t));
+	ret = read(iip->ifd, &magic, sizeof(magic));
 	if (ret < 0) {
 		fatal(iip->file_name, ERR_SYSCALL, "Read failed\n");
 		/*NOTREACHED*/
 	}
 	else if (ret == 0)
 		return 0;
-	else if (ret < (ssize_t)sizeof(t)) {
+	else if (ret < (ssize_t)sizeof(magic)) {
 		fprintf(stderr, "WARNING: Short read on %s (%d)\n", 
 			iip->file_name, (int)ret);
 		return 0;
 	}
 
 	if (data_is_native == -1)
-		check_data_endianness(t.magic);
+		check_data_endianness(magic);
 
 	assert(data_is_native >= 0);
-	if (data_is_native) {
-		spec->time = t.time;
-		spec->sector = t.sector;
-		spec->bytes = t.bytes;
-		action = t.action;
-		pdu_len = t.pdu_len;
+
+	version = (data_is_native ? magic : be32_to_cpu(magic)) & 0xff;
+
+	if (version == SUPPORTED_VERSION2) {
+		t2.magic = magic;
+		p = (void *) ((u8 *)&t2 + sizeof(__u32));
+		ret = read(iip->ifd, p, sizeof(t2) - sizeof(__u32));
+		if (ret < 0) {
+			fatal(iip->file_name, ERR_SYSCALL, "Read failed\n");
+			/*NOTREACHED*/
+		}
+		else if (ret < (ssize_t)(sizeof(t2) - sizeof(__u32))) {
+			fprintf(stderr, "WARNING: Short read on %s (%d)\n",
+				iip->file_name, (int)ret);
+			return 0;
+		}
+
+		if (data_is_native) {
+			spec->time = t2.time;
+			spec->sector = t2.sector;
+			spec->bytes = t2.bytes;
+			action = t2.action;
+			pdu_len = t2.pdu_len;
+		}
+		else {
+			spec->time = be64_to_cpu(t2.time);
+			spec->sector = be64_to_cpu(t2.sector);
+			spec->bytes = be32_to_cpu(t2.bytes);
+			action = be64_to_cpu(t2.action);
+			pdu_len = be16_to_cpu(t2.pdu_len);
+		}
 	}
 	else {
-		spec->time = be64_to_cpu(t.time);
-		spec->sector = be64_to_cpu(t.sector);
-		spec->bytes = be32_to_cpu(t.bytes);
-		action = be32_to_cpu(t.action);
-		pdu_len = be16_to_cpu(t.pdu_len);
+		t.magic = magic;
+		p = (void *) ((u8 *)&t + sizeof(__u32));
+		ret = read(iip->ifd, p, sizeof(t) - sizeof(__u32));
+		if (ret < 0) {
+			fatal(iip->file_name, ERR_SYSCALL, "Read failed\n");
+			/*NOTREACHED*/
+		}
+		else if (ret < (ssize_t)(sizeof(t) - sizeof(__u32))) {
+			fprintf(stderr, "WARNING: Short read on %s (%d)\n",
+				iip->file_name, (int)ret);
+			return 0;
+		}
+
+		if (data_is_native) {
+			spec->time = t.time;
+			spec->sector = t.sector;
+			spec->bytes = t.bytes;
+			action = t.action;
+			pdu_len = t.pdu_len;
+		}
+		else {
+			spec->time = be64_to_cpu(t.time);
+			spec->sector = be64_to_cpu(t.sector);
+			spec->bytes = be32_to_cpu(t.bytes);
+			action = be32_to_cpu(t.action);
+			pdu_len = be16_to_cpu(t.pdu_len);
+		}
 	}
 
 
diff --git a/btt/globals.h b/btt/globals.h
index 22a1cb0..f37b3cb 100644
--- a/btt/globals.h
+++ b/btt/globals.h
@@ -158,7 +158,7 @@ struct io {
 	__u64 s_time;
 	__u32 d_nsec, c_nsec;
 
-	struct blk_io_trace t;
+	struct blk_io_trace2 t;
 
 	int linked;
 	enum iop_type type;
@@ -260,7 +260,7 @@ void clean_allocs(void);
 /* mmap.c */
 void setup_ifile(char *fname);
 void cleanup_ifile(void);
-int next_trace(struct blk_io_trace *t, void **pdu);
+int next_trace(struct blk_io_trace2 *t, void **pdu);
 double pct_done(void);
 
 /* output.c */
diff --git a/btt/mmap.c b/btt/mmap.c
index 9d4eb3d..b0a80f4 100644
--- a/btt/mmap.c
+++ b/btt/mmap.c
@@ -36,8 +36,9 @@ static int fd;
 static void *cur_map = MAP_FAILED;
 static off_t cur_min, cur, cur_max, total_size;
 static size_t len;
-static struct blk_io_trace *next_t;
+static struct blk_io_trace2 *next_t;
 static long pgsz;
+static int trace_version;
 
 int data_is_native = -1;
 
@@ -47,12 +48,54 @@ static inline size_t min_len(size_t a, size_t b)
 }
 
 static inline size_t convert_to_cpu(struct blk_io_trace *t,
-                                    struct blk_io_trace *tp,
+                                    struct blk_io_trace2 *tp,
 				    void **pdu)
 {
 	if (data_is_native == -1)
 		check_data_endianness(t->magic);
 
+	if (data_is_native) {
+		tp->magic	= t->magic;
+		tp->sequence	= t->sequence;
+		tp->time	= t->time;
+		tp->sector	= t->sector;
+		tp->bytes	= t->bytes;
+		tp->action	= t->action;
+		tp->pid		= t->pid;
+		tp->device	= t->device;
+		tp->cpu		= t->cpu;
+		tp->error	= t->error;
+		tp->pdu_len	= t->pdu_len;
+	} else {
+		tp->magic	= be32_to_cpu(t->magic);
+		tp->sequence	= be32_to_cpu(t->sequence);
+		tp->time	= be64_to_cpu(t->time);
+		tp->sector	= be64_to_cpu(t->sector);
+		tp->bytes	= be32_to_cpu(t->bytes);
+		tp->action	= be32_to_cpu(t->action);
+		tp->pid		= be32_to_cpu(t->pid);
+		tp->device	= be32_to_cpu(t->device);
+		tp->cpu		= be16_to_cpu(t->cpu);
+		tp->error	= be16_to_cpu(t->error);
+		tp->pdu_len	= be16_to_cpu(t->pdu_len);
+	}
+
+	if (tp->pdu_len) {
+		*pdu = malloc(tp->pdu_len);
+		memcpy(*pdu, t+1, tp->pdu_len);
+	} else
+		*pdu = NULL;
+
+	return sizeof(*t) + tp->pdu_len;
+}
+
+static inline size_t convert_to_cpu2(struct blk_io_trace2 *t,
+                                     struct blk_io_trace2 *tp,
+				     void **pdu)
+{
+	if (data_is_native == -1)
+		check_data_endianness(t->magic);
+
 	if (data_is_native)
 		memcpy(tp, t, sizeof(*tp));
 	else {
@@ -61,10 +104,10 @@ static inline size_t convert_to_cpu(struct blk_io_trace *t,
 		tp->time	= be64_to_cpu(t->time);
 		tp->sector	= be64_to_cpu(t->sector);
 		tp->bytes	= be32_to_cpu(t->bytes);
-		tp->action	= be32_to_cpu(t->action);
+		tp->action	= be64_to_cpu(t->action);
 		tp->pid		= be32_to_cpu(t->pid);
 		tp->device	= be32_to_cpu(t->device);
-		tp->cpu		= be16_to_cpu(t->cpu);
+		tp->cpu		= be32_to_cpu(t->cpu);
 		tp->error	= be16_to_cpu(t->error);
 		tp->pdu_len	= be16_to_cpu(t->pdu_len);
 	}
@@ -75,7 +118,7 @@ static inline size_t convert_to_cpu(struct blk_io_trace *t,
 	} else
 		*pdu = NULL;
 
-	return sizeof(*tp) + tp->pdu_len;
+	return sizeof(*t) + tp->pdu_len;
 }
 
 static int move_map(void)
@@ -127,7 +170,73 @@ void cleanup_ifile(void)
 	close(fd);
 }
 
-int next_trace(struct blk_io_trace *t, void **pdu)
+static inline int magic_ok(__u32 magic)
+{
+	if (!data_is_native)
+		magic = be32_to_cpu(magic);
+
+	return CHECK_MAGIC(magic);
+}
+
+static int count_traces(int version)
+{
+	size_t hdr = (version == SUPPORTED_VERSION2) ?
+			sizeof(struct blk_io_trace2) : sizeof(struct blk_io_trace);
+	off_t pos = cur;
+	int n = 0;
+
+	while (n < 16) {
+		void *p;
+		__u16 pdu_len;
+
+		if (pos == total_size)
+			break;
+		if ((pos + (off_t)hdr) > cur_max)
+			break;
+
+		p = cur_map + (pos - cur_min);
+		if (!magic_ok(((struct blk_io_trace *)p)->magic))
+			break;
+
+		if (version == SUPPORTED_VERSION2)
+			pdu_len = ((struct blk_io_trace2 *)p)->pdu_len;
+		else
+			pdu_len = ((struct blk_io_trace *)p)->pdu_len;
+		if (!data_is_native)
+			pdu_len = be16_to_cpu(pdu_len);
+
+		pos += hdr + pdu_len;
+		n++;
+	}
+
+	return n;
+}
+
+/*
+ * New blkparse always emits 'struct blk_io_trace2', while an old blkparse
+ * emits 'struct blk_io_trace'. As both share the same magic for version 1
+ * traces, the on-disk layout cannot be told apart by the version alone. Pick
+ * the layout that parses the input cleanly.
+ */
+static int detect_trace_version(void)
+{
+	__u32 magic;
+
+	if (data_is_native)
+		magic = next_t->magic;
+	else
+		magic = be32_to_cpu(next_t->magic);
+
+	if ((magic & 0xff) == SUPPORTED_VERSION2)
+		return SUPPORTED_VERSION2;
+
+	if (count_traces(SUPPORTED_VERSION2) >= count_traces(SUPPORTED_VERSION))
+		return SUPPORTED_VERSION2;
+
+	return SUPPORTED_VERSION;
+}
+
+int next_trace(struct blk_io_trace2 *t, void **pdu)
 {
 	size_t this_len;
 
@@ -138,7 +247,18 @@ int next_trace(struct blk_io_trace *t, void **pdu)
 		}
 
 	next_t = cur_map + (cur - cur_min);
-	this_len = convert_to_cpu(next_t, t, pdu);
+
+	if (data_is_native == -1)
+		check_data_endianness(next_t->magic);
+
+	if (!trace_version)
+		trace_version = detect_trace_version();
+
+	if (trace_version == SUPPORTED_VERSION2)
+		this_len = convert_to_cpu2(next_t, t, pdu);
+	else
+		this_len = convert_to_cpu((struct blk_io_trace *) next_t,
+					  t, pdu);
 	cur += this_len;
 
 	return 1;
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index 93aa449..80e7019 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -151,6 +151,13 @@ Do \fInot\fR produce text output, used for binary (\fB\-d\fR) only
 Binary output file
 .RE
 
+\-\-trace\-version=\fI1|2\fR
+.RS
+Selects the trace protocol version of the binary output file (\fB\-d\fR).
+Version 1 emits the legacy \fBstruct blk_io_trace\fR, while version 2 (the
+default) emits \fBstruct blk_io_trace2\fR.
+.RE
+
 \-q
 .br
 \-\-quiet
diff --git a/doc/blktrace.8 b/doc/blktrace.8
index 820b03a..c502adc 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -191,6 +191,13 @@ Outputs version
 Sets run time to the number of seconds specified  
 .RE
 
+\-\-trace\-version=\fI1|2\fR
+.RS
+Selects the trace protocol version requested from the kernel. Requesting
+version 1 forces blktrace to use the old \fBBLKTRACESETUP\fR ioctl, while
+version 2 (the default) uses \fBBLKTRACESETUP2\fR.
+.RE
+
 
 .SH FILTER MASKS
 The following masks may be passed with the \fI\-a\fR command line
diff --git a/iowatcher/blkparse.c b/iowatcher/blkparse.c
index 0518083..92ee1cc 100644
--- a/iowatcher/blkparse.c
+++ b/iowatcher/blkparse.c
@@ -146,7 +146,7 @@ static struct pending_io *io_hash_table_search(u64 sector, u32 dev)
 	return NULL;
 }
 
-static struct pending_io *hash_queued_io(struct blk_io_trace *io)
+static struct pending_io *hash_queued_io(struct blk_io_trace2 *io)
 {
 	struct pending_io *pio;
 	int ret;
@@ -165,7 +165,7 @@ static struct pending_io *hash_queued_io(struct blk_io_trace *io)
 	return pio;
 }
 
-static struct pending_io *hash_dispatched_io(struct blk_io_trace *io)
+static struct pending_io *hash_dispatched_io(struct blk_io_trace2 *io)
 {
 	struct pending_io *pio;
 
@@ -179,7 +179,7 @@ static struct pending_io *hash_dispatched_io(struct blk_io_trace *io)
 	return pio;
 }
 
-static struct pending_io *hash_completed_io(struct blk_io_trace *io)
+static struct pending_io *hash_completed_io(struct blk_io_trace2 *io)
 {
 	struct pending_io *pio;
 
@@ -257,7 +257,7 @@ static struct pid_map *process_hash_insert(u32 pid, char *name)
 
 static void handle_notify(struct trace *trace)
 {
-	struct blk_io_trace *io = trace->io;
+	struct blk_io_trace2 *io = trace->io;
 	void *payload = (char *)io + sizeof(*io);
 	int pdu_len = io->pdu_len;
 	u32 two32[2];
@@ -288,27 +288,119 @@ static void handle_notify(struct trace *trace)
 	}
 }
 
+/*
+ * Count how many consecutive well-formed traces the input holds when parsed
+ * with the given trace version.
+ */
+static int count_traces(struct trace *trace, int version)
+{
+	size_t hdr = (version == BLK_IO_TRACE2_VERSION) ?
+			sizeof(struct blk_io_trace2) : sizeof(struct blk_io_trace);
+	char *p = trace->start;
+	char *end = trace->start + trace->len;
+	int n = 0;
+
+	while (n < 16) {
+		struct blk_io_trace *io = (struct blk_io_trace *)p;
+		int pdu_len;
+
+		if (p == end)			/* traces tile up to the end */
+			break;
+		if (p + hdr > end)
+			break;
+		if (!CHECK_MAGIC(io))
+			break;
+
+		if (version == BLK_IO_TRACE2_VERSION)
+			pdu_len = ((struct blk_io_trace2 *)p)->pdu_len;
+		else
+			pdu_len = io->pdu_len;
+
+		p += hdr + pdu_len;
+		n++;
+	}
+
+	return n;
+}
+
+/*
+ * A recent blkparse always emits 'struct blk_io_trace2', while an old blkparse
+ * emits 'struct blk_io_trace'. As both share the same magic for version 1
+ * traces, the on-disk layout cannot be told apart by the version alone. Pick
+ * the layout that parses the input cleanly.
+ */
+static int detect_trace_version(struct trace *trace)
+{
+	struct blk_io_trace *io = (struct blk_io_trace *)trace->start;
+
+	if ((io->magic & 0xff) == BLK_IO_TRACE2_VERSION)
+		return BLK_IO_TRACE2_VERSION;
+
+	if (count_traces(trace, BLK_IO_TRACE2_VERSION) >=
+	    count_traces(trace, BLK_IO_TRACE_VERSION))
+		return BLK_IO_TRACE2_VERSION;
+
+	return BLK_IO_TRACE_VERSION;
+}
+
+static void trace_convert_io(struct trace *trace)
+{
+	struct blk_io_trace *old = (struct blk_io_trace *)trace->cur;
+	struct blk_io_trace2 *io;
+
+	if (trace->version == BLK_IO_TRACE2_VERSION) {
+		struct blk_io_trace2 *new = (struct blk_io_trace2 *)trace->cur;
+
+		io = realloc(trace->io, sizeof(*new) + new->pdu_len);
+		memcpy(io, new, sizeof(*new) + new->pdu_len);
+		trace->io = io;
+		return;
+	}
+
+	io = realloc(trace->io, sizeof(struct blk_io_trace2) + old->pdu_len);
+
+	io->magic	= old->magic;
+	io->sequence	= old->sequence;
+	io->time	= old->time;
+	io->sector	= old->sector;
+	io->bytes	= old->bytes;
+	io->action	= old->action;
+	io->pid		= old->pid;
+	io->device	= old->device;
+	io->cpu		= old->cpu;
+	io->error	= old->error;
+	io->pdu_len	= old->pdu_len;
+
+	if (io->pdu_len)
+		memcpy((char *)io + sizeof(*io),
+		       (char *)old + sizeof(*old), old->pdu_len);
+
+	trace->io = io;
+}
+
 int next_record(struct trace *trace)
 {
+	int hdr = (trace->version == BLK_IO_TRACE2_VERSION) ?
+		  sizeof(struct blk_io_trace2) : sizeof(struct blk_io_trace);
 	int skip = trace->io->pdu_len;
 	u64 offset;
 
-	trace->cur += sizeof(*trace->io) + skip;
+	trace->cur += hdr + skip;
 	offset = trace->cur - trace->start;
 	if (offset >= trace->len)
 		return 1;
 
-	trace->io = (struct blk_io_trace *)trace->cur;
+	trace_convert_io(trace);
 	return 0;
 }
 
 void first_record(struct trace *trace)
 {
 	trace->cur = trace->start;
-	trace->io = (struct blk_io_trace *)trace->cur;
+	trace_convert_io(trace);
 }
 
-static int is_io_event(struct blk_io_trace *test)
+static int is_io_event(struct blk_io_trace2 *test)
 {
 	char *message;
 	if (!(test->action & BLK_TC_ACT(BLK_TC_NOTIFY)))
@@ -332,30 +424,11 @@ static int is_io_event(struct blk_io_trace *test)
 
 u64 find_last_time(struct trace *trace)
 {
-	char *p = trace->start + trace->len;
-	struct blk_io_trace *test;
-	int search_len = 0;
 	u64 found = 0;
 
-	if (trace->len < sizeof(*trace->io))
+	if (trace->len < sizeof(struct blk_io_trace))
 		return 0;
-	p -= sizeof(*trace->io);
-	while (p >= trace->start) {
-		test = (struct blk_io_trace *)p;
-		if (CHECK_MAGIC(test) && is_io_event(test)) {
-			u64 offset = p - trace->start;
-			if (offset + sizeof(*test) + test->pdu_len == trace->len) {
-				return test->time;
-			}
-		}
-		p--;
-		search_len++;
-		if (search_len > 8192) {
-			break;
-		}
-	}
 
-	/* searching backwards didn't work out, we'll have to scan the file */
 	first_record(trace);
 	while (1) {
 		if (is_io_event(trace->io))
@@ -373,7 +446,7 @@ static int parse_fio_bank_message(struct trace *trace, u64 *bank_ret, u64 *offse
 	char *s;
 	char *next;
 	char *message;
-	struct blk_io_trace *test = trace->io;
+	struct blk_io_trace2 *test = trace->io;
 	int len = test->pdu_len;
 	u64 bank;
 	u64 offset;
@@ -428,7 +501,7 @@ out:
 	return -1;
 }
 
-static struct dev_info *lookup_dev(struct trace *trace, struct blk_io_trace *io)
+static struct dev_info *lookup_dev(struct trace *trace, struct blk_io_trace2 *io)
 {
 	u32 dev = io->device;
 	int i;
@@ -481,7 +554,7 @@ static void map_devices(struct trace *trace)
 	}
 }
 
-static u64 map_io(struct trace *trace, struct blk_io_trace *io)
+static u64 map_io(struct trace *trace, struct blk_io_trace2 *io)
 {
 	struct dev_info *di = lookup_dev(trace, io);
 	u64 val = trace->io->sector << 9;
@@ -532,7 +605,7 @@ void find_extreme_offsets(struct trace *trace, u64 *min_ret, u64 *max_ret, u64 *
 
 static void check_io_types(struct trace *trace)
 {
-	struct blk_io_trace *io = trace->io;
+	struct blk_io_trace2 *io = trace->io;
 	int action = io->action & BLK_TA_MASK;
 
 	if (!(io->action & BLK_TC_ACT(BLK_TC_NOTIFY))) {
@@ -850,7 +923,8 @@ struct trace *open_trace(char *filename)
 	trace->len = st.st_size;
 	trace->start = p;
 	trace->cur = p;
-	trace->io = (struct blk_io_trace *)p;
+	trace->version = detect_trace_version(trace);
+	trace_convert_io(trace);
 	return trace;
 
 fail_fd:
@@ -901,7 +975,7 @@ static inline int io_event(struct trace *trace)
 void add_tput(struct trace *trace, struct graph_line_data *writes_gld,
 	      struct graph_line_data *reads_gld)
 {
-	struct blk_io_trace *io = trace->io;
+	struct blk_io_trace2 *io = trace->io;
 	struct graph_line_data *gld;
 	int action = io->action & BLK_TA_MASK;
 	int seconds;
@@ -962,7 +1036,7 @@ static struct pid_map *get_pid_map(struct trace_file *tf, u32 pid)
 
 void add_io(struct trace *trace, struct trace_file *tf)
 {
-	struct blk_io_trace *io = trace->io;
+	struct blk_io_trace2 *io = trace->io;
 	int action = io->action & BLK_TA_MASK;
 	u64 offset;
 	int index;
@@ -999,7 +1073,7 @@ void add_io(struct trace *trace, struct trace_file *tf)
 void add_pending_io(struct trace *trace, struct graph_line_data *gld)
 {
 	unsigned int seconds;
-	struct blk_io_trace *io = trace->io;
+	struct blk_io_trace2 *io = trace->io;
 	int action = io->action & BLK_TA_MASK;
 	double avg;
 	struct pending_io *pio;
@@ -1068,7 +1142,7 @@ account_io:
 void add_completed_io(struct trace *trace,
 		      struct graph_line_data *latency_gld)
 {
-	struct blk_io_trace *io = trace->io;
+	struct blk_io_trace2 *io = trace->io;
 	int seconds;
 	int action = io->action & BLK_TA_MASK;
 	struct pending_io *pio;
@@ -1107,7 +1181,7 @@ void add_completed_io(struct trace *trace,
 
 void add_iop(struct trace *trace, struct graph_line_data *gld)
 {
-	struct blk_io_trace *io = trace->io;
+	struct blk_io_trace2 *io = trace->io;
 	int action = io->action & BLK_TA_MASK;
 	int seconds;
 
diff --git a/iowatcher/blkparse.h b/iowatcher/blkparse.h
index f828763..c59bcf7 100644
--- a/iowatcher/blkparse.h
+++ b/iowatcher/blkparse.h
@@ -39,7 +39,8 @@ struct trace {
 	u64 len;
 	char *start;
 	char *cur;
-	struct blk_io_trace *io;
+	int version;
+	struct blk_io_trace2 *io;
 	u64 start_timestamp;
 	struct timespec abs_start_time;
 
diff --git a/iowatcher/main.c b/iowatcher/main.c
index 4b97013..e80c228 100644
--- a/iowatcher/main.c
+++ b/iowatcher/main.c
@@ -897,7 +897,6 @@ static void plot_cpu(struct plot *plot, unsigned int max_seconds, char *label,
 	char *color;
 	double avg = 0;
 	int ymax;
-	int plotted = 0;
 
 	if (active_graphs[active_index] == 0)
 		return;
@@ -971,7 +970,6 @@ static void plot_cpu(struct plot *plot, unsigned int max_seconds, char *label,
 					svg_line_graph(plot, gld, color, avg + 30, 95);
 					snprintf(line, line_len, " CPU %d\n", i - 1);
 					svg_add_legend(plot, tf->label, line, color);
-					plotted++;
 					break;
 				}
 
