Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AED3126C0
	for <linux-btrace@vger.kernel.org>; Thu, 11 Dec 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765458015; cv=none; b=X0NqgK5DCfIq5XobVRpvPYTUTpcOKoukZNDwx7Gh4BM3+t0RTsVbo6nIcas9+UIpuMHZ7P8gHG9oHtrWt97kTlXAkViR/bpO0W8jItip0AWKlf/jM1Fjfv9K2Dtahp7gj5Rhg5K4imVeGofAd09TOdJwcfyJOxZFzRXW3VkNjik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765458015; c=relaxed/simple;
	bh=RYwlB66VXMnxAubeHdEHhcHFCM0KA1d7V+Ba4O1Jq9Y=;
	h=Subject:From:To:Date:Message-Id; b=hAPZiPth+dMOwIVYe8DFqKkOR1ltvX7pP+ATCNqixvBFlt1D7VUOovY6i00lcG/YxOv7coQ4B7Kt8ol4cFZNyLIFzpIWqJkmASY/ej+ZiozkUTXR6CxRsAoovtytDb7khHCnwoA5wgEfMuTQZB+0VKVev+qZ6G+8gYko3wWpA8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=fail smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZJkX48bT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZJkX48bT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Message-Id:Date:To:From:Subject:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=qfl5hjNzKWJBo20lIUSxtwcJFcN/HnI60t30MOF+x2Y=; b=ZJkX48bTzhPjl6of0KDhfBWRFY
	r4wNENy3QQOyIT3OaBW28cgsimN48cn2nhv9baztnGeELL0c50QSLqkbVz/X10OHzf74NoQodym3E
	tVWigkoSKLgPA0J0FCaVUOrnUIeVZ1+UNKXtrYQ/A9KvptpK4I55MbJFJpttMXeC1v2wCJ+qJgtEF
	vmAjV/vC1vZxczY9aTzelIa/h5nom43pcW5G2LTRN5DRzKiJofQRS6XCjbAvbjUA0zSA3FkaDjMz1
	zaL7RYeLOI3xJlpKG7862PBz0DwAqhJVESb4A37DqdvxYbwwwGevbdAKg5CAj2MOhFjcu6TqzuktW
	wLKKGByg==;
Received: from [96.43.243.2] (helo=kernel.dk)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTgH7-0000000EGFX-3SQ0
	for linux-btrace@vger.kernel.org;
	Thu, 11 Dec 2025 13:00:06 +0000
Received: by kernel.dk (Postfix, from userid 1000)
	id 721F51BC014F; Thu, 11 Dec 2025 06:00:01 -0700 (MST)
Subject: Recent changes (master)
From: Jens Axboe <axboe@kernel.dk>
To: <linux-btrace@vger.kernel.org>
User-Agent: mail (GNU Mailutils 3.17)
Date: Thu, 11 Dec 2025 06:00:01 -0700
Message-Id: <20251211130001.721F51BC014F@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>

The following changes since commit f9bd00dfbd67ce62ca6df6f55d6275b523cd0b39:

  blkparse: Fix a potential coredump issue (2025-03-20 05:06:40 -0600)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 9b24b42ef59d2e8015957db3dd70ffedb7ebcfe8:

  Update git tree references (2025-12-10 23:53:45 -0700)

----------------------------------------------------------------
Jens Axboe (1):
      Update git tree references

Johannes Thumshirn (20):
      blktrace: fix comment for struct blk_trace_setup:
      blkparse: fix compiler warning
      blktrace: add definitions for BLKTRACESETUP2
      blktrace: change size of action to 64 bits
      blktrace: add definitions for blk_io_trace2
      blkparse: pass magic to get_magic
      blkparse: read 'magic' first
      blkparse: factor out reading of a singe blk_io_trace event
      blkparse: skip unsupported protocol versions
      blkparse: make get_pdulen() take the pdu_len
      blkiomon: read 'magic' first
      blktrace: pass magic to CHECK_MAGIC macro
      blktrace: pass magic to verify_trace
      blktrace: rename trace_to_cpu to bit_trace_to_cpu
      blkparse: use blk_io_trace2 internally
      blkparse: natively parse blk_io_trace2
      blkparse: parse zone (un)plug actions
      blkparse: add zoned commands to fill_rwbs()
      blktrace: call BLKTRACESETUP2 ioctl per default to setup a trace
      blktrace: support protocol version 8

 README                    |   6 +-
 act_mask.c                |   4 +-
 blkiomon.c                |  15 +-
 blkparse.c                | 446 +++++++++++++++++++++++++++++++---------------
 blkparse_fmt.c            |  83 +++++++--
 blkrawverify.c            |  14 +-
 blktrace.c                |  40 ++++-
 blktrace.h                |  64 +++++--
 blktrace_api.h            |  58 +++++-
 btreplay/doc/btreplay.tex |   2 +-
 10 files changed, 539 insertions(+), 193 deletions(-)

---

Diff of recent changes:

diff --git a/README b/README
index d7d1fbf..7999d21 100644
--- a/README
+++ b/README
@@ -14,7 +14,7 @@ Requirements
 blktrace was integrated into the mainline kernel between 2.6.16 and 2.6.17-rc1.
 The target trace needs to run on a kernel at least that new.
 
-git://git.kernel.dk/blktrace.git
+git://git.kernel.org/pub/scm/linux/kernel/git/axboe/blktrace.git
 
 If you don't have git, you can get hourly snapshots from:
 
@@ -24,12 +24,12 @@ The snapshots include the full git object database as well. kernel.org has
 excessively long mirror times, so if you have git installed, you can pull
 the master tree from:
 
-git://git.kernel.dk/blktrace.git
+git://git.kernel.org/pub/scm/linux/kernel/git/axboe/blktrace.git
 
 For browsing the repo over http and viewing history etc, you can direct
 your browser to:
 
-http://git.kernel.dk/
+https://git.kernel.org/pub/scm/linux/kernel/git/axboe/blktrace.git
 
 A blktrace visualization tool, iowatcher, was added to blktrace in version
 1.1.0. It requires librsvg and either png2theora or ffmpeg to generate movies.
diff --git a/act_mask.c b/act_mask.c
index 8f1b8d7..510c7e0 100644
--- a/act_mask.c
+++ b/act_mask.c
@@ -42,7 +42,7 @@ int find_mask_map(char *string)
 	return -1;
 }
 
-int valid_act_opt(int x)
+unsigned long long valid_act_opt(unsigned long long x)
 {
-	return (1 <= x) && (x < (1 << BLK_TC_SHIFT));
+	return (1ull <= x) && (x < (1ull << BLK_TC_SHIFT));
 }
diff --git a/blkiomon.c b/blkiomon.c
index f8b0c9d..9defa2c 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -460,26 +460,35 @@ static int blkiomon_do_fifo(void)
 	bit = &t->bit;
 
 	while (up) {
+		__u32 magic;
+
+		if (fread(&magic, sizeof(magic), 1, ifp) != 1) {
+			if (!feof(ifp))
+				fprintf(stderr,
+					"blkiomon: could not read trace");
+			break;
+		}
 		if (fread(bit, sizeof(*bit), 1, ifp) != 1) {
 			if (!feof(ifp))
 				fprintf(stderr,
 					"blkiomon: could not read trace");
 			break;
 		}
+		bit->magic = magic;
 		if (ferror(ifp)) {
 			clearerr(ifp);
 			fprintf(stderr, "blkiomon: error while reading trace");
 			break;
 		}
 
-		if (data_is_native == -1 && check_data_endianness(bit->magic)) {
+		if (data_is_native == -1 && check_data_endianness(magic)) {
 			fprintf(stderr, "blkiomon: endianess problem\n");
 			break;
 		}
 
 		/* endianess */
-		trace_to_cpu(bit);
-		if (verify_trace(bit)) {
+		bit_trace_to_cpu(bit);
+		if (verify_trace(bit->magic)) {
 			fprintf(stderr, "blkiomon: bad trace\n");
 			break;
 		}
diff --git a/blkparse.c b/blkparse.c
index d6aaa8b..76c775b 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -243,7 +243,7 @@ static struct option l_opts[] = {
  * for sorting the displayed output
  */
 struct trace {
-	struct blk_io_trace *bit;
+	struct blk_io_trace2 *bit;
 	struct rb_node rb_node;
 	struct trace *next;
 	unsigned long read_sequence;
@@ -257,7 +257,7 @@ static struct trace *trace_list;
 /*
  * allocation cache
  */
-static struct blk_io_trace *bit_alloc_list;
+static struct blk_io_trace2 *bit_alloc_list;
 static struct trace *t_alloc_list;
 
 /*
@@ -299,7 +299,7 @@ static int per_device_and_cpu_stats = 1;
 static int track_ios;
 static int ppi_hash_by_pid = 1;
 static int verbose;
-static unsigned int act_mask = -1U;
+static unsigned long long act_mask = -1U;
 static int stats_printed;
 static int bin_output_msgs = 1;
 int data_is_native = -1;
@@ -332,7 +332,7 @@ static int have_drv_data = 0;
 #define CPU_IDX(cpu)	((cpu) / CPUS_PER_LONG)
 #define CPU_BIT(cpu)	((cpu) & (CPUS_PER_LONG - 1))
 
-static void io_warn_unless(struct blk_io_trace *t, int condition,
+static void io_warn_unless(struct blk_io_trace2 *t, int condition,
 			   const char *fmt, ...)
 {
 	va_list ap;
@@ -613,7 +613,7 @@ static struct process_pid_map *add_ppm_hash(pid_t pid, const char *name)
 	return ppm;
 }
 
-static void handle_notify(struct blk_io_trace *bit)
+static void handle_notify(struct blk_io_trace2 *bit)
 {
 	void	*payload = (caddr_t) bit + sizeof(*bit);
 	__u32	two32[2];
@@ -802,25 +802,25 @@ static inline struct trace *t_alloc(void)
 	return malloc(sizeof(*t));
 }
 
-static inline void bit_free(struct blk_io_trace *bit)
+static inline void bit_free(struct blk_io_trace2 *bit)
 {
 	if (bit_alloc_cache < 1024 && !bit->pdu_len) {
 		/*
 		 * abuse a 64-bit field for a next pointer for the free item
 		 */
 		bit->time = (__u64) (unsigned long) bit_alloc_list;
-		bit_alloc_list = (struct blk_io_trace *) bit;
+		bit_alloc_list = (struct blk_io_trace2 *) bit;
 		bit_alloc_cache++;
 	} else
 		free(bit);
 }
 
-static inline struct blk_io_trace *bit_alloc(void)
+static inline struct blk_io_trace2 *bit_alloc(void)
 {
-	struct blk_io_trace *bit = bit_alloc_list;
+	struct blk_io_trace2 *bit = bit_alloc_list;
 
 	if (bit) {
-		bit_alloc_list = (struct blk_io_trace *) (unsigned long) \
+		bit_alloc_list = (struct blk_io_trace2 *) (unsigned long) \
 				 bit->time;
 		bit_alloc_cache--;
 		return bit;
@@ -1041,7 +1041,7 @@ static struct io_track *find_track(struct per_dev_info *pdi, pid_t pid,
 }
 
 static void log_track_frontmerge(struct per_dev_info *pdi,
-				 struct blk_io_trace *t)
+				 struct blk_io_trace2 *t)
 {
 	struct io_track *iot;
 
@@ -1062,7 +1062,7 @@ static void log_track_frontmerge(struct per_dev_info *pdi,
 	track_rb_insert(pdi, iot);
 }
 
-static void log_track_getrq(struct per_dev_info *pdi, struct blk_io_trace *t)
+static void log_track_getrq(struct per_dev_info *pdi, struct blk_io_trace2 *t)
 {
 	struct io_track *iot;
 	struct io_track_req *req;
@@ -1081,7 +1081,7 @@ static void log_track_getrq(struct per_dev_info *pdi, struct blk_io_trace *t)
  * for md/dm setups, the interesting cycle is Q -> C. So track queueing
  * time here, as dispatch time
  */
-static void log_track_queue(struct per_dev_info *pdi, struct blk_io_trace *t)
+static void log_track_queue(struct per_dev_info *pdi, struct blk_io_trace2 *t)
 {
 	struct io_track *iot;
 	struct io_track_req *req;
@@ -1096,7 +1096,7 @@ static void log_track_queue(struct per_dev_info *pdi, struct blk_io_trace *t)
 	req->dispatch_time = t->time;
 }
 
-static void log_track_split(struct per_dev_info *pdi, struct blk_io_trace *t)
+static void log_track_split(struct per_dev_info *pdi, struct blk_io_trace2 *t)
 {
 	struct io_track *iot, *split;
 
@@ -1118,7 +1118,7 @@ static void log_track_split(struct per_dev_info *pdi, struct blk_io_trace *t)
  * return time between rq allocation and insertion
  */
 static unsigned long long log_track_insert(struct per_dev_info *pdi,
-					   struct blk_io_trace *t)
+					   struct blk_io_trace2 *t)
 {
 	unsigned long long elapsed;
 	struct io_track *iot;
@@ -1153,7 +1153,7 @@ static unsigned long long log_track_insert(struct per_dev_info *pdi,
  * return time between queue and issue
  */
 static unsigned long long log_track_issue(struct per_dev_info *pdi,
-					  struct blk_io_trace *t)
+					  struct blk_io_trace2 *t)
 {
 	unsigned long long elapsed = -1ULL;
 	struct io_track *iot;
@@ -1191,7 +1191,7 @@ static unsigned long long log_track_issue(struct per_dev_info *pdi,
 	return elapsed;
 }
 
-static void fixup_complete(struct per_dev_info *pdi, struct blk_io_trace *t)
+static void fixup_complete(struct per_dev_info *pdi, struct blk_io_trace2 *t)
 {
 	struct io_track *iot;
 	__u64 start_sector;
@@ -1214,7 +1214,7 @@ static void fixup_complete(struct per_dev_info *pdi, struct blk_io_trace *t)
  * return time between dispatch and complete
  */
 static unsigned long long log_track_complete(struct per_dev_info *pdi,
-					     struct blk_io_trace *t)
+					     struct blk_io_trace2 *t)
 {
 	unsigned long long elapsed = -1ULL;
 	struct io_track *iot, *next;
@@ -1288,7 +1288,7 @@ static char *get_dev_name(struct per_dev_info *pdi, char *buffer, int size)
 	return buffer;
 }
 
-static void check_time(struct per_dev_info *pdi, struct blk_io_trace *bit)
+static void check_time(struct per_dev_info *pdi, struct blk_io_trace2 *bit)
 {
 	unsigned long long this = bit->time;
 	unsigned long long last = pdi->last_reported_time;
@@ -1297,7 +1297,7 @@ static void check_time(struct per_dev_info *pdi, struct blk_io_trace *bit)
 	pdi->last_reported_time = this;
 }
 
-static inline void __account_m(struct io_stats *ios, struct blk_io_trace *t,
+static inline void __account_m(struct io_stats *ios, struct blk_io_trace2 *t,
 			       int rw)
 {
 	if (rw) {
@@ -1311,7 +1311,7 @@ static inline void __account_m(struct io_stats *ios, struct blk_io_trace *t,
 	}
 }
 
-static inline void account_m(struct blk_io_trace *t, struct per_cpu_info *pci,
+static inline void account_m(struct blk_io_trace2 *t, struct per_cpu_info *pci,
 			     int rw)
 {
 	__account_m(&pci->io_stats, t, rw);
@@ -1324,7 +1324,7 @@ static inline void account_m(struct blk_io_trace *t, struct per_cpu_info *pci,
 }
 
 static inline void __account_pc_queue(struct io_stats *ios,
-				      struct blk_io_trace *t, int rw)
+				      struct blk_io_trace2 *t, int rw)
 {
 	if (rw) {
 		ios->qwrites_pc++;
@@ -1337,7 +1337,7 @@ static inline void __account_pc_queue(struct io_stats *ios,
 	}
 }
 
-static inline void account_pc_queue(struct blk_io_trace *t,
+static inline void account_pc_queue(struct blk_io_trace2 *t,
 				    struct per_cpu_info *pci, int rw)
 {
 	__account_pc_queue(&pci->io_stats, t, rw);
@@ -1363,7 +1363,7 @@ static inline void __account_pc_issue(struct io_stats *ios, int rw,
 	}
 }
 
-static inline void account_pc_issue(struct blk_io_trace *t,
+static inline void account_pc_issue(struct blk_io_trace2 *t,
 				    struct per_cpu_info *pci, int rw)
 {
 	__account_pc_issue(&pci->io_stats, rw, t->bytes);
@@ -1376,7 +1376,7 @@ static inline void account_pc_issue(struct blk_io_trace *t,
 }
 
 static inline void __account_pc_requeue(struct io_stats *ios,
-					struct blk_io_trace *t, int rw)
+					struct blk_io_trace2 *t, int rw)
 {
 	if (rw) {
 		ios->wrqueue_pc++;
@@ -1389,7 +1389,7 @@ static inline void __account_pc_requeue(struct io_stats *ios,
 	}
 }
 
-static inline void account_pc_requeue(struct blk_io_trace *t,
+static inline void account_pc_requeue(struct blk_io_trace2 *t,
 				      struct per_cpu_info *pci, int rw)
 {
 	__account_pc_requeue(&pci->io_stats, t, rw);
@@ -1409,7 +1409,7 @@ static inline void __account_pc_c(struct io_stats *ios, int rw)
 		ios->creads_pc++;
 }
 
-static inline void account_pc_c(struct blk_io_trace *t,
+static inline void account_pc_c(struct blk_io_trace2 *t,
 				struct per_cpu_info *pci, int rw)
 {
 	__account_pc_c(&pci->io_stats, rw);
@@ -1421,7 +1421,7 @@ static inline void account_pc_c(struct blk_io_trace *t,
 	}
 }
 
-static inline void __account_queue(struct io_stats *ios, struct blk_io_trace *t,
+static inline void __account_queue(struct io_stats *ios, struct blk_io_trace2 *t,
 				   int rw)
 {
 	if (rw) {
@@ -1435,7 +1435,7 @@ static inline void __account_queue(struct io_stats *ios, struct blk_io_trace *t,
 	}
 }
 
-static inline void account_queue(struct blk_io_trace *t,
+static inline void account_queue(struct blk_io_trace2 *t,
 				 struct per_cpu_info *pci, int rw)
 {
 	__account_queue(&pci->io_stats, t, rw);
@@ -1460,7 +1460,7 @@ static inline void __account_c(struct io_stats *ios, int rw, int bytes)
 	}
 }
 
-static inline void account_c(struct blk_io_trace *t, struct per_cpu_info *pci,
+static inline void account_c(struct blk_io_trace2 *t, struct per_cpu_info *pci,
 			     int rw, int bytes)
 {
 	__account_c(&pci->io_stats, rw, bytes);
@@ -1486,7 +1486,7 @@ static inline void __account_issue(struct io_stats *ios, int rw,
 	}
 }
 
-static inline void account_issue(struct blk_io_trace *t,
+static inline void account_issue(struct blk_io_trace2 *t,
 				 struct per_cpu_info *pci, int rw)
 {
 	__account_issue(&pci->io_stats, rw, t->bytes);
@@ -1506,7 +1506,7 @@ static inline void __account_unplug(struct io_stats *ios, int timer)
 		ios->io_unplugs++;
 }
 
-static inline void account_unplug(struct blk_io_trace *t,
+static inline void account_unplug(struct blk_io_trace2 *t,
 				  struct per_cpu_info *pci, int timer)
 {
 	__account_unplug(&pci->io_stats, timer);
@@ -1519,7 +1519,7 @@ static inline void account_unplug(struct blk_io_trace *t,
 }
 
 static inline void __account_requeue(struct io_stats *ios,
-				     struct blk_io_trace *t, int rw)
+				     struct blk_io_trace2 *t, int rw)
 {
 	if (rw) {
 		ios->wrqueue++;
@@ -1532,7 +1532,7 @@ static inline void __account_requeue(struct io_stats *ios,
 	}
 }
 
-static inline void account_requeue(struct blk_io_trace *t,
+static inline void account_requeue(struct blk_io_trace2 *t,
 				   struct per_cpu_info *pci, int rw)
 {
 	__account_requeue(&pci->io_stats, t, rw);
@@ -1545,31 +1545,31 @@ static inline void account_requeue(struct blk_io_trace *t,
 }
 
 static void log_complete(struct per_dev_info *pdi, struct per_cpu_info *pci,
-			 struct blk_io_trace *t, char *act)
+			 struct blk_io_trace2 *t, char *act)
 {
 	process_fmt(act, pci, t, log_track_complete(pdi, t), 0, NULL);
 }
 
 static void log_insert(struct per_dev_info *pdi, struct per_cpu_info *pci,
-		       struct blk_io_trace *t, char *act)
+		       struct blk_io_trace2 *t, char *act)
 {
 	process_fmt(act, pci, t, log_track_insert(pdi, t), 0, NULL);
 }
 
-static void log_queue(struct per_cpu_info *pci, struct blk_io_trace *t,
+static void log_queue(struct per_cpu_info *pci, struct blk_io_trace2 *t,
 		      char *act)
 {
 	process_fmt(act, pci, t, -1, 0, NULL);
 }
 
 static void log_issue(struct per_dev_info *pdi, struct per_cpu_info *pci,
-		      struct blk_io_trace *t, char *act)
+		      struct blk_io_trace2 *t, char *act)
 {
 	process_fmt(act, pci, t, log_track_issue(pdi, t), 0, NULL);
 }
 
 static void log_merge(struct per_dev_info *pdi, struct per_cpu_info *pci,
-		      struct blk_io_trace *t, char *act)
+		      struct blk_io_trace2 *t, char *act)
 {
 	if (act[0] == 'F')
 		log_track_frontmerge(pdi, t);
@@ -1577,38 +1577,38 @@ static void log_merge(struct per_dev_info *pdi, struct per_cpu_info *pci,
 	process_fmt(act, pci, t, -1ULL, 0, NULL);
 }
 
-static void log_action(struct per_cpu_info *pci, struct blk_io_trace *t,
+static void log_action(struct per_cpu_info *pci, struct blk_io_trace2 *t,
 			char *act)
 {
 	process_fmt(act, pci, t, -1ULL, 0, NULL);
 }
 
-static void log_generic(struct per_cpu_info *pci, struct blk_io_trace *t,
+static void log_generic(struct per_cpu_info *pci, struct blk_io_trace2 *t,
 			char *act)
 {
 	process_fmt(act, pci, t, -1ULL, 0, NULL);
 }
 
-static void log_unplug(struct per_cpu_info *pci, struct blk_io_trace *t,
+static void log_unplug(struct per_cpu_info *pci, struct blk_io_trace2 *t,
 		      char *act)
 {
 	process_fmt(act, pci, t, -1ULL, 0, NULL);
 }
 
-static void log_split(struct per_cpu_info *pci, struct blk_io_trace *t,
+static void log_split(struct per_cpu_info *pci, struct blk_io_trace2 *t,
 		      char *act)
 {
 	process_fmt(act, pci, t, -1ULL, 0, NULL);
 }
 
-static void log_pc(struct per_cpu_info *pci, struct blk_io_trace *t, char *act)
+static void log_pc(struct per_cpu_info *pci, struct blk_io_trace2 *t, char *act)
 {
 	unsigned char *buf = (unsigned char *) t + sizeof(*t);
 
 	process_fmt(act, pci, t, -1ULL, t->pdu_len, buf);
 }
 
-static void dump_trace_pc(struct blk_io_trace *t, struct per_dev_info *pdi,
+static void dump_trace_pc(struct blk_io_trace2 *t, struct per_dev_info *pdi,
 			  struct per_cpu_info *pci)
 {
 	int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
@@ -1657,7 +1657,7 @@ static void dump_trace_pc(struct blk_io_trace *t, struct per_dev_info *pdi,
 	}
 }
 
-static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
+static void dump_trace_fs(struct blk_io_trace2 *t, struct per_dev_info *pdi,
 			  struct per_cpu_info *pci)
 {
 	int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
@@ -1722,6 +1722,13 @@ static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
 			account_unplug(t, pci, 1);
 			log_unplug(pci, t, "UT");
 			break;
+		case __BLK_TA_ZONE_PLUG:
+			log_action(pci, t, "ZP");
+			break;
+		case __BLK_TA_ZONE_UNPLUG:
+			account_unplug(t, pci, 0);
+			log_unplug(pci, t, "ZU");
+			break;
 		case __BLK_TA_SPLIT:
 			log_track_split(pdi, t);
 			log_split(pci, t, "X");
@@ -1737,12 +1744,12 @@ static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
 			/* dump to binary file only */
 			break;
 		default:
-			fprintf(stderr, "Bad fs action %x\n", t->action);
+			fprintf(stderr, "Bad fs action %llx\n", t->action);
 			break;
 	}
 }
 
-static void dump_trace(struct blk_io_trace *t, struct per_cpu_info *pci,
+static void dump_trace(struct blk_io_trace2 *t, struct per_cpu_info *pci,
 		       struct per_dev_info *pdi)
 {
 	if (text_output) {
@@ -2023,7 +2030,7 @@ static void show_device_and_cpu_stats(void)
 	struct io_stats total, *ios;
 	unsigned long long rrate, wrate, msec;
 	int i, j, pci_events;
-	char line[3 + 8/*cpu*/ + 2 + 32/*dev*/ + 3];
+	char line[3 + 8/*cpu*/ + 2 + 32/*dev*/ + 3 + 2];
 	char name[32];
 	double ratio;
 
@@ -2162,7 +2169,7 @@ static void find_genesis(void)
 	}
 }
 
-static inline int check_stopwatch(struct blk_io_trace *bit)
+static inline int check_stopwatch(struct blk_io_trace2 *bit)
 {
 	if (bit->time < stopwatch_end &&
 	    bit->time >= stopwatch_start)
@@ -2185,7 +2192,7 @@ static int sort_entries(unsigned long long *youngest)
 
 	*youngest = 0;
 	while ((t = trace_list) != NULL) {
-		struct blk_io_trace *bit = t->bit;
+		struct blk_io_trace2 *bit = t->bit;
 
 		trace_list = t->next;
 
@@ -2264,7 +2271,7 @@ static int check_cpu_map(struct per_dev_info *pdi)
 
 static int check_sequence(struct per_dev_info *pdi, struct trace *t, int force)
 {
-	struct blk_io_trace *bit = t->bit;
+	struct blk_io_trace2 *bit = t->bit;
 	unsigned long expected_sequence;
 	struct per_cpu_info *pci;
 	struct trace *__t;
@@ -2315,7 +2322,7 @@ static void show_entries_rb(int force)
 {
 	struct per_dev_info *pdi = NULL;
 	struct per_cpu_info *pci = NULL;
-	struct blk_io_trace *bit;
+	struct blk_io_trace2 *bit;
 	struct rb_node *n;
 	struct trace *t;
 
@@ -2412,40 +2419,112 @@ static int read_data(int fd, void *buffer, int bytes, int block, int *fdblock)
 	return 0;
 }
 
-static inline __u16 get_pdulen(struct blk_io_trace *bit)
+static inline __u16 get_pdulen(__u16 pdu_len)
 {
 	if (data_is_native)
-		return bit->pdu_len;
+		return pdu_len;
 
-	return __bswap_16(bit->pdu_len);
+	return __bswap_16(pdu_len);
 }
 
-static inline __u32 get_magic(struct blk_io_trace *bit)
+static inline __u32 get_magic(__u32 magic)
 {
 	if (data_is_native)
-		return bit->magic;
+		return magic;
 
-	return __bswap_32(bit->magic);
+	return __bswap_32(magic);
 }
 
+static int read_one_bit(int fd, struct blk_io_trace2 **bit2, int block,
+			int *fdblock)
+{
+	struct blk_io_trace2 *new = *bit2;
+	struct blk_io_trace *bit;
+	int ret;
+	int pdu_len;
+	void *p;
+
+	bit = malloc(sizeof(*bit));
+	if (!bit)
+		return -1;
+
+	bit->magic = new->magic;
+
+	p = (void *) ((u8 *)bit + sizeof(__u32));
+
+	ret = read_data(fd, p, sizeof(*bit) - sizeof(__u32), block, fdblock);
+	if (ret)
+		return ret;
+
+	pdu_len = get_pdulen(bit->pdu_len);
+	if (pdu_len) {
+		void *ptr = realloc(bit, sizeof(*bit) + pdu_len);
+
+		ret = read_data(fd, ptr + sizeof(*bit), pdu_len, 1, fdblock);
+		if (ret) {
+			free(ptr);
+			return ret;
+		}
+		bit = ptr;
+
+		new = realloc(*bit2, sizeof(struct blk_io_trace2) + pdu_len);
+	}
+
+	bit_trace_to_cpu(bit);
+	bit_to_bit2(bit, new);
+	free(bit);
+	*bit2 = new;
+
+	return 0;
+}
+
+static int read_one_bit2(int fd, struct blk_io_trace2 **bit2, int block,
+			 int *fdblock)
+{
+	struct blk_io_trace2 *new = *bit2;
+	int ret;
+	int pdu_len;
+	void *p;
+
+	p = (void *) ((u8 *)new + sizeof(__u32));
+
+	ret = read_data(fd, p, sizeof(*new) - sizeof(__u32), block, fdblock);
+	if (ret)
+		return ret;
+
+	pdu_len = get_pdulen(new->pdu_len);
+	if (pdu_len) {
+		void *ptr = realloc(new, sizeof(*new) + pdu_len);
+
+		ret = read_data(fd, ptr + sizeof(*new), pdu_len, 1, fdblock);
+		if (ret) {
+			free(ptr);
+			return ret;
+		}
+		new = ptr;
+	}
+
+	bit2_trace_to_cpu(new);
+	*bit2 = new;
+
+	return 0;
+}
 static int read_events(int fd, int always_block, int *fdblock)
 {
 	struct per_dev_info *pdi = NULL;
 	unsigned int events = 0;
 
 	while (!is_done() && events < rb_batch) {
-		struct blk_io_trace *bit;
 		struct trace *t;
-		int pdu_len, should_block, ret;
+		int should_block, ret;
 		__u32 magic;
-
-		bit = bit_alloc();
+		u8 version;
 
 		should_block = !events || always_block;
 
-		ret = read_data(fd, bit, sizeof(*bit), should_block, fdblock);
+		ret = read_data(fd, &magic, sizeof(magic), should_block,
+				fdblock);
 		if (ret) {
-			bit_free(bit);
 			if (!events && ret < 0)
 				events = ret;
 			break;
@@ -2455,56 +2534,96 @@ static int read_events(int fd, int always_block, int *fdblock)
 		 * look at first trace to check whether we need to convert
 		 * data in the future
 		 */
-		if (data_is_native == -1 && check_data_endianness(bit->magic))
+		if (data_is_native == -1 && check_data_endianness(magic))
 			break;
 
-		magic = get_magic(bit);
+		magic = get_magic(magic);
 		if ((magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
 			fprintf(stderr, "Bad magic %x\n", magic);
 			break;
 		}
+		version = magic & 0xff;
+		if (version == SUPPORTED_VERSION) {
+			struct blk_io_trace2 *bit;
+			bit = bit_alloc();
+			bit->magic = magic;
+
+			ret = read_one_bit(fd, &bit, 1, fdblock);
+			if (ret)
+				break;
 
-		pdu_len = get_pdulen(bit);
-		if (pdu_len) {
-			void *ptr = realloc(bit, sizeof(*bit) + pdu_len);
+			/*
+			 * not a real trace, so grab and handle it here
+			 */
+			if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+			    (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
+				handle_notify(bit);
+				output_binary(bit, sizeof(*bit) + bit->pdu_len);
+				continue;
+			}
 
-			if (read_data(fd, ptr + sizeof(*bit), pdu_len, 1, fdblock)) {
-				bit_free(ptr);
-				break;
+			if (verify_trace(bit->magic)) {
+				bit_free(bit);
+				bit = NULL;
+				continue;
 			}
 
-			bit = ptr;
-		}
+			t = t_alloc();
+			memset(t, 0, sizeof(*t));
+			t->bit = bit;
+			t->read_sequence = read_sequence;
 
-		trace_to_cpu(bit);
+			t->next = trace_list;
+			trace_list = t;
 
-		if (verify_trace(bit)) {
-			bit_free(bit);
-			continue;
-		}
+			if (!pdi || pdi->dev != bit->device)
+				pdi = get_dev_info(bit->device);
 
-		/*
-		 * not a real trace, so grab and handle it here
-		 */
-		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
-			handle_notify(bit);
-			output_binary(bit, sizeof(*bit) + bit->pdu_len);
-			continue;
-		}
+			if (bit->time > pdi->last_read_time)
+				pdi->last_read_time = bit->time;
+		} else if (version == SUPPORTED_VERSION2) {
+			struct blk_io_trace2 *bit;
+			bit = bit_alloc();
+			bit->magic = magic;
 
-		t = t_alloc();
-		memset(t, 0, sizeof(*t));
-		t->bit = bit;
-		t->read_sequence = read_sequence;
+			ret = read_one_bit2(fd, &bit, 1, fdblock);
+			if (ret)
+				break;
 
-		t->next = trace_list;
-		trace_list = t;
+			/*
+			 * not a real trace, so grab and handle it here
+			 */
+			if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+			    (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
+				handle_notify(bit);
+				output_binary(bit, sizeof(*bit) + bit->pdu_len);
+				continue;
+			}
 
-		if (!pdi || pdi->dev != bit->device)
-			pdi = get_dev_info(bit->device);
+			if (verify_trace(bit->magic)) {
+				bit_free(bit);
+				bit = NULL;
+				continue;
+			}
+
+			t = t_alloc();
+			memset(t, 0, sizeof(*t));
+			t->bit = bit;
+			t->read_sequence = read_sequence;
+
+			t->next = trace_list;
+			trace_list = t;
+
+			if (!pdi || pdi->dev != bit->device)
+				pdi = get_dev_info(bit->device);
+
+			if (bit->time > pdi->last_read_time)
+				pdi->last_read_time = bit->time;
+		} else {
+			fprintf(stderr, "unsupported version %d\n", version);
+			continue;
+		}
 
-		if (bit->time > pdi->last_read_time)
-			pdi->last_read_time = bit->time;
 
 		events++;
 	}
@@ -2592,73 +2711,118 @@ static int ms_prime(struct ms_stream *msp)
 	struct trace *t;
 	struct per_dev_info *pdi = msp->pdi;
 	struct per_cpu_info *pci = get_cpu_info(pdi, msp->cpu);
-	struct blk_io_trace *bit = NULL;
-	int ret, pdu_len, ndone = 0;
+	struct blk_io_trace2 *bit = NULL;
+	int ret, ndone = 0;
 
 	for (i = 0; !is_done() && pci->fd >= 0 && i < rb_batch; i++) {
-		bit = bit_alloc();
-		ret = read_data(pci->fd, bit, sizeof(*bit), 1, &pci->fdblock);
+		u8 version;
+
+		ret = read_data(pci->fd, &magic, sizeof(magic), 1,
+				&pci->fdblock);
 		if (ret)
 			goto err;
 
-		if (data_is_native == -1 && check_data_endianness(bit->magic))
+		if (data_is_native == -1 && check_data_endianness(magic))
 			goto err;
 
-		magic = get_magic(bit);
+		magic = get_magic(magic);
 		if ((magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
 			fprintf(stderr, "Bad magic %x\n", magic);
 			goto err;
 
 		}
+		version = magic & 0xff;
+		if (version == SUPPORTED_VERSION) {
+			bit = bit_alloc();
+			bit->magic = magic;
 
-		pdu_len = get_pdulen(bit);
-		if (pdu_len) {
-			void *ptr = realloc(bit, sizeof(*bit) + pdu_len);
-			ret = read_data(pci->fd, ptr + sizeof(*bit), pdu_len,
-							     1, &pci->fdblock);
-			if (ret) {
-				free(ptr);
-				bit = NULL;
+			ret = read_one_bit(pci->fd, &bit, 1, &pci->fdblock);
+			if (ret)
 				goto err;
+
+			if (verify_trace(bit->magic))
+				goto err;
+
+			if (bit->cpu != pci->cpu) {
+				fprintf(stderr,
+					"cpu %d trace info has error cpu %d\n",
+					pci->cpu, bit->cpu);
+				continue;
 			}
 
-			bit = ptr;
-		}
+			if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+			    (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
+				handle_notify(bit);
+				output_binary(bit, sizeof(*bit) + bit->pdu_len);
+				bit_free(bit);
+				bit = NULL;
 
-		trace_to_cpu(bit);
-		if (verify_trace(bit))
-			goto err;
+				i -= 1;
+				continue;
+			}
 
-		if (bit->cpu != pci->cpu) {
-			fprintf(stderr, "cpu %d trace info has error cpu %d\n",
-				pci->cpu, bit->cpu);
-			continue;
-		}
+			if (bit->time > pdi->last_read_time)
+				pdi->last_read_time = bit->time;
 
-		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
-			handle_notify(bit);
-			output_binary(bit, sizeof(*bit) + bit->pdu_len);
-			bit_free(bit);
+			t = t_alloc();
+			memset(t, 0, sizeof(*t));
+			t->bit = bit;
 
-			i -= 1;
-			continue;
-		}
+			if (msp->first == NULL)
+				msp->first = msp->last = t;
+			else {
+				msp->last->next = t;
+				msp->last = t;
+			}
+		} else if (version == SUPPORTED_VERSION2) {
+			bit = bit_alloc();
+			bit->magic = magic;
 
-		if (bit->time > pdi->last_read_time)
-			pdi->last_read_time = bit->time;
+			ret = read_one_bit2(pci->fd, &bit, 1, &pci->fdblock);
+			if (ret)
+				goto err;
 
-		t = t_alloc();
-		memset(t, 0, sizeof(*t));
-		t->bit = bit;
+			if (verify_trace(bit->magic))
+				goto err;
 
-		if (msp->first == NULL)
-			msp->first = msp->last = t;
-		else {
-			msp->last->next = t;
-			msp->last = t;
-		}
+			if (bit->cpu != pci->cpu) {
+				fprintf(stderr,
+					"cpu %d trace info has error cpu %d\n",
+					pci->cpu, bit->cpu);
+				continue;
+			}
 
+			if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+			    (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
+				handle_notify(bit);
+				output_binary(bit, sizeof(*bit) + bit->pdu_len);
+				bit_free(bit);
+				bit = NULL;
+
+				i -= 1;
+				continue;
+			}
+
+			if (bit->time > pdi->last_read_time)
+				pdi->last_read_time = bit->time;
+
+			t = t_alloc();
+			memset(t, 0, sizeof(*t));
+			t->bit = bit;
+
+			if (msp->first == NULL)
+				msp->first = msp->last = t;
+			else {
+				msp->last->next = t;
+				msp->last = t;
+			}
+
+		} else {
+			fprintf(stderr, "unsupported version %d\n", version);
+			continue;
+		}
 		ndone++;
+		bit = NULL;
 	}
 
 	return ndone;
@@ -2737,7 +2901,7 @@ static int handle(struct ms_stream *msp)
 	struct trace *t;
 	struct per_dev_info *pdi;
 	struct per_cpu_info *pci;
-	struct blk_io_trace *bit;
+	struct blk_io_trace2 *bit;
 
 	t = ms_peek(msp);
 
diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 9b83d1d..06b055b 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -8,6 +8,7 @@
 #include <unistd.h>
 #include <ctype.h>
 #include <time.h>
+#include <stdbool.h>
 
 #include "blktrace.h"
 
@@ -50,28 +51,54 @@ int add_format_spec(char *option)
 	return 0;
 }
 
-static inline void fill_rwbs(char *rwbs, struct blk_io_trace *t)
+static inline void fill_rwbs(char *rwbs, struct blk_io_trace2 *t)
 {
-	int w = t->action & BLK_TC_ACT(BLK_TC_WRITE);
-	int a = t->action & BLK_TC_ACT(BLK_TC_AHEAD);
-	int s = t->action & BLK_TC_ACT(BLK_TC_SYNC);
-	int m = t->action & BLK_TC_ACT(BLK_TC_META);
-	int d = t->action & BLK_TC_ACT(BLK_TC_DISCARD);
-	int f = t->action & BLK_TC_ACT(BLK_TC_FLUSH);
-	int u = t->action & BLK_TC_ACT(BLK_TC_FUA);
+	bool w = !!(t->action & BLK_TC_ACT(BLK_TC_WRITE));
+	bool a = !!(t->action & BLK_TC_ACT(BLK_TC_AHEAD));
+	bool s = !!(t->action & BLK_TC_ACT(BLK_TC_SYNC));
+	bool m = !!(t->action & BLK_TC_ACT(BLK_TC_META));
+	bool d = !!(t->action & BLK_TC_ACT(BLK_TC_DISCARD));
+	bool f = !!(t->action & BLK_TC_ACT(BLK_TC_FLUSH));
+	bool u = !!(t->action & BLK_TC_ACT(BLK_TC_FUA));
+	bool za = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_APPEND));
+	bool zr = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_RESET));
+	bool zra = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_RESET_ALL));
+	bool zf = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_FINISH));
+	bool zo = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_OPEN));
+	bool zc = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_CLOSE));
 	int i = 0;
 
 	if (f)
 		rwbs[i++] = 'F'; /* flush */
 
-	if (d)
+	if (d) {
 		rwbs[i++] = 'D';
-	else if (w)
+	} else if (za) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'A';
+	} else if (zr) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+	} else if (zra) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+		rwbs[i++] = 'A';
+	} else if (zf) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'F';
+	} else if (zo) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'O';
+	} else if (zc) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'C';
+	} else if (w) {
 		rwbs[i++] = 'W';
-	else if (t->bytes)
+	} else if (t->bytes) {
 		rwbs[i++] = 'R';
-	else
+	} else {
 		rwbs[i++] = 'N';
+	}
 
 	if (u)
 		rwbs[i++] = 'F'; /* fua */
@@ -145,16 +172,16 @@ static char *dump_pdu(unsigned char *pdu_buf, int pdu_len)
 	return p;
 }
 
-#define pdu_start(t)	(((void *) (t) + sizeof(struct blk_io_trace)))
+#define pdu_start(t)	(((void *) (t) + sizeof(struct blk_io_trace2)))
 
-static unsigned int get_pdu_int(struct blk_io_trace *t)
+static unsigned int get_pdu_int(struct blk_io_trace2 *t)
 {
 	__u64 *val = pdu_start(t);
 
 	return be64_to_cpu(*val);
 }
 
-static void get_pdu_remap(struct blk_io_trace *t, struct blk_io_trace_remap *r)
+static void get_pdu_remap(struct blk_io_trace2 *t, struct blk_io_trace_remap *r)
 {
 	struct blk_io_trace_remap *__r = pdu_start(t);
 	__u64 sector_from = __r->sector_from;
@@ -165,7 +192,7 @@ static void get_pdu_remap(struct blk_io_trace *t, struct blk_io_trace_remap *r)
 }
 
 static void print_field(char *act, struct per_cpu_info *pci,
-			struct blk_io_trace *t, unsigned long long elapsed,
+			struct blk_io_trace2 *t, unsigned long long elapsed,
 			int pdu_len, unsigned char *pdu_buf, char field,
 			int minus, int has_w, int width)
 {
@@ -274,7 +301,7 @@ static void print_field(char *act, struct per_cpu_info *pci,
 }
 
 static char *parse_field(char *act, struct per_cpu_info *pci,
-			 struct blk_io_trace *t, unsigned long long elapsed,
+			 struct blk_io_trace2 *t, unsigned long long elapsed,
 			 int pdu_len, unsigned char *pdu_buf,
 			 char *primary_format)
 {
@@ -300,8 +327,23 @@ static char *parse_field(char *act, struct per_cpu_info *pci,
 	return p;
 }
 
+static void process_zoned(char *act, struct blk_io_trace2 *t, char *name)
+{
+	switch (act[1]) {
+	case 'P': /* Zone Plug */
+		fprintf(ofp, "[%s]\n", name);
+		break;
+	case 'U': /* Zone Unplug */
+		fprintf(ofp, "[%s] %u\n", name, get_pdu_int(t));
+		break;
+	default:
+		fprintf(stderr, "Unknown zoned action %c\n", act[1]);
+		break;
+	}
+}
+
 static void process_default(char *act, struct per_cpu_info *pci,
-			    struct blk_io_trace *t, unsigned long long elapsed,
+			    struct blk_io_trace2 *t, unsigned long long elapsed,
 			    int pdu_len, unsigned char *pdu_buf)
 {
 	struct blk_io_trace_remap r = { .device_from = 0, };
@@ -428,6 +470,9 @@ static void process_default(char *act, struct per_cpu_info *pci,
 		fprintf(ofp, "%*s\n", pdu_len, pdu_buf);
 		break;
 
+	case 'Z':	/* Zoned command */
+		process_zoned(act, t, name);
+		break;
 	default:
 		fprintf(stderr, "Unknown action %c\n", act[0]);
 		break;
@@ -435,7 +480,7 @@ static void process_default(char *act, struct per_cpu_info *pci,
 
 }
 
-void process_fmt(char *act, struct per_cpu_info *pci, struct blk_io_trace *t,
+void process_fmt(char *act, struct per_cpu_info *pci, struct blk_io_trace2 *t,
 		 unsigned long long elapsed, int pdu_len,
 		 unsigned char *pdu_buf)
 {
diff --git a/blkrawverify.c b/blkrawverify.c
index ed5d258..8e863cb 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -55,7 +55,7 @@ static struct trace_info traces[] = {
 #define N_TRACES (sizeof(traces) / sizeof(struct trace_info))
 
 struct act_info {
-	__u32 val;
+	__u64 val;
 	char *string;
 };
 
@@ -80,12 +80,12 @@ static struct act_info acts[] = {
 };
 #define N_ACTS (sizeof(acts) / sizeof(struct act_info))
 
-static char *act_to_str(__u32 action)
+static char *act_to_str(__u64 action)
 {
 	static char buf[1024];
 	unsigned int i;
-	unsigned int act = action & 0xffff;
-	unsigned int trace = (action >> BLK_TC_SHIFT) & 0xffff;
+	unsigned long long act = action & 0xffffffff;
+	unsigned long long trace = (action >> BLK_TC_SHIFT) & 0xffffffff;
 
 	if (act < N_ACTS) {
 		sprintf(buf, "%s ", acts[act].string);
@@ -97,7 +97,7 @@ static char *act_to_str(__u32 action)
 			}
 	}
 	else
-		sprintf(buf, "Invalid action=%08x", action);
+		sprintf(buf, "Invalid action=%016llx", action);
 
 	return buf;
 }
@@ -181,9 +181,9 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 		if (data_is_native == -1)
 			check_data_endianness(bit->magic);
 
-		trace_to_cpu(bit);
+		bit_trace_to_cpu(bit);
 
-		if (!CHECK_MAGIC(bit)) {
+		if (!CHECK_MAGIC(bit->magic)) {
 			INC_BAD("bad trace");
 			continue;
 		}
diff --git a/blktrace.c b/blktrace.c
index 038b2cb..72562fd 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -279,7 +279,7 @@ static int max_cpus;
 static int ncpus;
 static cpu_set_t *online_cpus;
 static int pagesize;
-static int act_mask = ~0U;
+static unsigned long long act_mask = ~0U;
 static int kill_running_trace;
 static int stop_watch;
 static int piped_output;
@@ -1067,6 +1067,36 @@ static void close_client_connections(void)
 	}
 }
 
+static int setup_buts2(void)
+{
+	struct list_head *p;
+	int ret = 0;
+
+	__list_for_each(p, &devpaths) {
+		struct blk_user_trace_setup2 buts2;
+		struct devpath *dpp = list_entry(p, struct devpath, head);
+
+		memset(&buts2, 0, sizeof(buts2));
+		buts2.buf_size = buf_size;
+		buts2.buf_nr = buf_nr;
+		buts2.act_mask = act_mask;
+
+		if (ioctl(dpp->fd, BLKTRACESETUP2, &buts2) >= 0) {
+			dpp->ncpus = max_cpus;
+			dpp->buts_name = strdup(buts2.name);
+			dpp->setup_done = 1;
+			if (dpp->stats)
+				free(dpp->stats);
+			dpp->stats = calloc(dpp->ncpus, sizeof(*dpp->stats));
+			memset(dpp->stats, 0, dpp->ncpus * sizeof(*dpp->stats));
+		} else {
+			ret++;
+		}
+	}
+
+	return ret;
+}
+
 static int setup_buts(void)
 {
 	struct list_head *p;
@@ -2684,9 +2714,11 @@ static int run_tracers(void)
 	if (net_mode == Net_client)
 		printf("blktrace: connecting to %s\n", hostname);
 
-	if (setup_buts()) {
-		done = 1;
-		return 1;
+	if (setup_buts2()) {
+		if (setup_buts()) {
+			done = 1;
+			return 1;
+		}
 	}
 
 	if (use_tracer_devpaths()) {
diff --git a/blktrace.h b/blktrace.h
index 944fc08..ba06237 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -6,6 +6,7 @@
 #include <byteswap.h>
 #include <endian.h>
 #include <sys/types.h>
+#include <string.h>
 
 #include "blktrace_api.h"
 #include "rbtree.h"
@@ -67,8 +68,9 @@ extern FILE *ofp;
 extern int data_is_native;
 extern struct timespec abs_start_time;
 
-#define CHECK_MAGIC(t)		(((t)->magic & 0xffffff00) == BLK_IO_TRACE_MAGIC)
+#define CHECK_MAGIC(magic)		(((magic) & 0xffffff00) == BLK_IO_TRACE_MAGIC)
 #define SUPPORTED_VERSION	(0x07)
+#define SUPPORTED_VERSION2	(0x08)
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define be16_to_cpu(x)		__bswap_16(x)
@@ -88,22 +90,64 @@ extern struct timespec abs_start_time;
 #error "Bad arch"
 #endif
 
-static inline int verify_trace(struct blk_io_trace *t)
+static inline int verify_trace(__u32 magic)
 {
-	if (!CHECK_MAGIC(t)) {
-		fprintf(stderr, "bad trace magic %x\n", t->magic);
+	u8 version;
+
+	if (!CHECK_MAGIC(magic)) {
+		fprintf(stderr, "bad trace magic %x\n", magic);
 		return 1;
 	}
-	if ((t->magic & 0xff) != SUPPORTED_VERSION) {
-		fprintf(stderr, "unsupported trace version %x\n", 
-			t->magic & 0xff);
+
+	version = magic & 0xff;
+	if (version != SUPPORTED_VERSION &&
+	    version != SUPPORTED_VERSION2) {
+		fprintf(stderr, "unsupported trace version %x\n", version);
 		return 1;
 	}
 
 	return 0;
 }
 
-static inline void trace_to_cpu(struct blk_io_trace *t)
+static inline void bit_to_bit2(struct blk_io_trace *old,
+			       struct blk_io_trace2 *new)
+{
+	new->magic	= old->magic;
+	new->sequence	= old->sequence;
+	new->time	= old->time;
+	new->sector	= old->sector;
+	new->bytes	= old->bytes;
+	new->action	= 0 | old->action;
+	new->pid	= old->pid;
+	new->device	= old->device;
+	new->cpu	= old->cpu;
+	new->error	= old->error;
+	new->pdu_len	= old->pdu_len;
+
+	if (new->pdu_len)
+		memcpy(((u8 *) new + sizeof(*new)), ((u8 *)old + sizeof(*old)),
+		       old->pdu_len);
+}
+
+static inline void bit2_trace_to_cpu(struct blk_io_trace2 *t)
+{
+	if (data_is_native)
+		return;
+
+	t->magic	= be32_to_cpu(t->magic);
+	t->sequence	= be32_to_cpu(t->sequence);
+	t->time		= be64_to_cpu(t->time);
+	t->sector	= be64_to_cpu(t->sector);
+	t->bytes	= be32_to_cpu(t->bytes);
+	t->action	= be64_to_cpu(t->action);
+	t->pid		= be32_to_cpu(t->pid);
+	t->device	= be32_to_cpu(t->device);
+	t->cpu		= be32_to_cpu(t->cpu);
+	t->error	= be16_to_cpu(t->error);
+	t->pdu_len	= be16_to_cpu(t->pdu_len);
+}
+
+static inline void bit_trace_to_cpu(struct blk_io_trace *t)
 {
 	if (data_is_native)
 		return;
@@ -142,9 +186,9 @@ static inline int check_data_endianness(u32 magic)
 
 extern void set_all_format_specs(char *);
 extern int add_format_spec(char *);
-extern void process_fmt(char *, struct per_cpu_info *, struct blk_io_trace *,
+extern void process_fmt(char *, struct per_cpu_info *, struct blk_io_trace2 *,
 			unsigned long long, int, unsigned char *);
-extern int valid_act_opt(int);
+extern unsigned long long valid_act_opt(unsigned long long);
 extern int find_mask_map(char *);
 extern char *find_process_name(pid_t);
 
diff --git a/blktrace_api.h b/blktrace_api.h
index 8c760b8..8db24fc 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -24,11 +24,20 @@ enum {
 	BLK_TC_DRV_DATA	= 1 << 14,	/* binary driver data */
 	BLK_TC_FUA	= 1 << 15,	/* fua requests */
 
-	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
+	BLK_TC_END_V1	= 1 << 15,	/* we've run out of bits! */
+
+	BLK_TC_ZONE_APPEND      = 1ull << 16,   /* zone append */
+        BLK_TC_ZONE_RESET       = 1ull << 17,   /* zone reset */
+        BLK_TC_ZONE_RESET_ALL   = 1ull << 18,   /* zone reset all */
+        BLK_TC_ZONE_FINISH      = 1ull << 19,   /* zone finish */
+        BLK_TC_ZONE_OPEN        = 1ull << 20,   /* zone open */
+        BLK_TC_ZONE_CLOSE       = 1ull << 21,   /* zone close */
+
+        BLK_TC_END_V2           = 1ull << 21,
 };
 
 #define BLK_TC_SHIFT		(16)
-#define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)
+#define BLK_TC_ACT(act)        ((__u64)(act) << BLK_TC_SHIFT)
 
 /*
  * Basic trace actions
@@ -51,6 +60,9 @@ enum {
 	__BLK_TA_REMAP,			/* bio was remapped */
 	__BLK_TA_ABORT,			/* request aborted */
 	__BLK_TA_DRV_DATA,		/* binary driver data */
+	__BLK_TA_ZONE_PLUG,		/* zone write plug was plugged */
+	__BLK_TA_ZONE_UNPLUG,		/* zone write plug was unplugged */
+	__BLK_TA_ZONE_MGMT,		/* zone management command was issued */
 	__BLK_TA_CGROUP = 1 << 8,
 };
 
@@ -85,12 +97,20 @@ enum blktrace_notify {
 #define BLK_TA_ABORT		(__BLK_TA_ABORT | BLK_TC_ACT(BLK_TC_QUEUE))
 #define BLK_TA_DRV_DATA		(__BLK_TA_DRV_DATA | BLK_TC_ACT(BLK_TC_DRV_DATA))
 
+#define BLK_TA_ZONE_APPEND      (__BLK_TA_COMPLETE |\
+				 BLK_TC_ACT2(BLK_TC_ZONE_APPEND))
+#define BLK_TA_ZONE_MGMT        __BLK_TA_ZONE_MGMT
+#define BLK_TA_ZONE_PLUG        (__BLK_TA_ZONE_PLUG | BLK_TC_ACT(BLK_TC_QUEUE))
+#define BLK_TA_ZONE_UNPLUG      (__BLK_TA_ZONE_UNPLUG |\
+				 BLK_TC_ACT(BLK_TC_QUEUE))
+
 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))
 
 #define BLK_IO_TRACE_MAGIC	0x65617400
 #define BLK_IO_TRACE_VERSION	0x07
+#define BLK_IO_TRACE2_VERSION	0x08
 
 /*
  * The trace itself
@@ -118,6 +138,22 @@ struct blk_io_trace_remap {
 	__u64 sector_from;
 };
 
+struct blk_io_trace2 {
+	__u32 magic;            /* MAGIC << 8 | BLK_IO_TRACE2_VERSION */
+	__u32 sequence;         /* event number */
+	__u64 time;             /* in nanoseconds */
+	__u64 sector;           /* disk offset */
+	__u32 bytes;            /* transfer length */
+	__u32 pid;              /* who did it */
+	__u64 action;           /* what happened */
+	__u32 device;           /* device number */
+	__u32 cpu;              /* on what cpu did it happen */
+	__u16 error;            /* completion error */
+	__u16 pdu_len;          /* length of data after this trace */
+	__u8 pad[12];
+	/* cgroup id will be stored here if exists */
+};
+
 /*
  * Payload with originating cgroup info
  */
@@ -127,7 +163,7 @@ struct blk_io_cgroup_payload {
 };
 
 /*
- * User setup structure passed with BLKSTARTTRACE
+ * User setup structure passed with BLKTRACESETUP
  */
 struct blk_user_trace_setup {
 	char name[32];			/* output */
@@ -139,9 +175,25 @@ struct blk_user_trace_setup {
 	__u32 pid;
 };
 
+/*
+ * User setup structure passed with BLKTRACESETUP2
+ */
+struct blk_user_trace_setup2 {
+	char name[64];			/* output */
+	__u64 act_mask;			/* input */
+	__u32 buf_size;			/* input */
+	__u32 buf_nr;			/* input */
+	__u64 start_lba;
+	__u64 end_lba;
+	__u32 pid;
+	__u32 flags;			/* currently unused */
+	__u64 reserved[11];
+};
+
 #define BLKTRACESETUP _IOWR(0x12,115,struct blk_user_trace_setup)
 #define BLKTRACESTART _IO(0x12,116)
 #define BLKTRACESTOP _IO(0x12,117)
 #define BLKTRACETEARDOWN _IO(0x12,118)
+#define BLKTRACESETUP2 _IOWR(0x12, 142, struct blk_user_trace_setup2)
 
 #endif
diff --git a/btreplay/doc/btreplay.tex b/btreplay/doc/btreplay.tex
index 8b0ecf7..98509bb 100644
--- a/btreplay/doc/btreplay.tex
+++ b/btreplay/doc/btreplay.tex
@@ -46,7 +46,7 @@ Performance Group.
 
 To build these tools, one needs to
 place the source directory next to a valid
-\texttt{blktrace}\footnote{\texttt{git://git.kernel.dk/blktrace.git}}
+\texttt{blktrace}\footnote{\texttt{git://git.kernel.org/pub/scm/linux/kernel/git/axboe/blktrace.git}}
 directory, as it includes \texttt{../blktrace} in the \texttt{Makefile}.
 
 
