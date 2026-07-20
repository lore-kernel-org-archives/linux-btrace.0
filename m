Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207913F9F45;
	Mon, 20 Jul 2026 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546105; cv=none; b=Sh8Z2OJvl6Qioy8oGN4b1ICR8iQjpwRXagPHq/CM/vnZUNwDl/oBZnaylYSpQUs7Tyw1pum+I9P+uf/quKzyqwHxC3ugxks5lUeQ6TbG3Z8NdHu7WiO5jzVyc1oeCJnujT1LZn9PCJhHYujm3+U2LFs2nBVpdy3ZO33He0JucyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546105; c=relaxed/simple;
	bh=dIVGW8bJXPOaCewzroaK3lDTB0mfCjd29TUo7yVCWhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPtEMd2Nhnhuk/gq3rwqikC0rQ0N8rjfJZDtSn+a6EKd4LLbypJDBmqNMPq+U9YjOzV9yx2oMgBawE7h2HqD4FJtihz4jCE3u2Ei0FNLFZ2LIS8bgbszg60myYiDhIfQEhBrd+BS829fGL+9c7m0vRi0Bt6wD3CwUUCGqrP3v5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oz/3c9d8; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oz/3c9d8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784546104; x=1816082104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dIVGW8bJXPOaCewzroaK3lDTB0mfCjd29TUo7yVCWhA=;
  b=oz/3c9d87FBMKDBjX54r9sfFBp3RjlyVGQzRe4xVB3Cw1757wstSeimv
   Nt1oYM+6ZsDS92ww2IfIIXizVEuBsTP07o5ZgQaFxNRT2JJj7FLvhmwRc
   QTsUhzafWKczDXfu1WOvP+FloCbuxkOCkQJwyLMJVQiNzqpIgXHumTTmL
   sQMtxA0rWiuUY5XlRG/tdMdx9CU8k5ACCxXMEb/gMz86ZeR0ZKLnP/tOr
   3jR1mJ0H/r3pu/4wT2MXPsXmz3CSAqEYRGpGeGyOC3lUMThsvaBLFtJJl
   d/pIb6ToGArilhnvh2/eGyn0OY6USEAHmoP1iVbt4jgadOrD8l7UwhHiJ
   A==;
X-CSE-ConnectionGUID: Om6Q+greQHCJqkLb5uFC3Q==
X-CSE-MsgGUID: xF+a2zMSQh+ay43DvtBRvg==
X-IronPort-AV: E=Sophos;i="6.25,174,1779120000"; 
   d="scan'208";a="151105454"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2026 19:14:51 +0800
X-CSE-ConnectionGUID: u1CRVIiIRae8HCxGncjqKw==
X-CSE-MsgGUID: uIGbJ3RTTM6mZGlFNtM3Cw==
IronPort-SDR: 6a5e031f_wcDd1CFGtfDuBnPmPOaqYfKp7qCqLKqgip9X1ndBuH0vO6U
 ikNHVo8Xidjl9SiQh7o/dRYmTGqoaI59evFu0lA==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jul 2026 04:14:39 -0700
X-CSE-ConnectionGUID: BADJLsLsRoanks7SuKHBXg==
X-CSE-MsgGUID: EBtAIUDPSci9df9tgvsCRQ==
WDCIronportException: Internal
Received: from wdap-kyufgunycc.ad.shared (HELO neo.fritz.box) ([10.224.19.3])
  by uls-op-esai1-o.wdc.com with ESMTP; 20 Jul 2026 04:14:37 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 08/11] iowatcher: use blk_io_trace2 internally
Date: Mon, 20 Jul 2026 13:14:14 +0200
Message-ID: <20260720111417.1658507-9-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
References: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 'struct blk_io_trace2' as internal representation for a captured
blktrace.

This implies the conversion of 'struct blk_io_trace' into 'struct
blk_io_trace2' when reading the trace from the binary file.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 iowatcher/blkparse.c | 83 ++++++++++++++++++++++++--------------------
 iowatcher/blkparse.h |  2 +-
 2 files changed, 46 insertions(+), 39 deletions(-)

diff --git a/iowatcher/blkparse.c b/iowatcher/blkparse.c
index 0518083a1089..ee1c2c511de6 100644
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
@@ -288,27 +288,53 @@ static void handle_notify(struct trace *trace)
 	}
 }
 
+static void trace_convert_io(struct trace *trace)
+{
+	struct blk_io_trace *old = (struct blk_io_trace *)trace->cur;
+	struct blk_io_trace2 *io;
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
 	int skip = trace->io->pdu_len;
 	u64 offset;
 
-	trace->cur += sizeof(*trace->io) + skip;
+	trace->cur += sizeof(struct blk_io_trace) + skip;
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
@@ -332,30 +358,11 @@ static int is_io_event(struct blk_io_trace *test)
 
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
@@ -373,7 +380,7 @@ static int parse_fio_bank_message(struct trace *trace, u64 *bank_ret, u64 *offse
 	char *s;
 	char *next;
 	char *message;
-	struct blk_io_trace *test = trace->io;
+	struct blk_io_trace2 *test = trace->io;
 	int len = test->pdu_len;
 	u64 bank;
 	u64 offset;
@@ -428,7 +435,7 @@ out:
 	return -1;
 }
 
-static struct dev_info *lookup_dev(struct trace *trace, struct blk_io_trace *io)
+static struct dev_info *lookup_dev(struct trace *trace, struct blk_io_trace2 *io)
 {
 	u32 dev = io->device;
 	int i;
@@ -481,7 +488,7 @@ static void map_devices(struct trace *trace)
 	}
 }
 
-static u64 map_io(struct trace *trace, struct blk_io_trace *io)
+static u64 map_io(struct trace *trace, struct blk_io_trace2 *io)
 {
 	struct dev_info *di = lookup_dev(trace, io);
 	u64 val = trace->io->sector << 9;
@@ -532,7 +539,7 @@ void find_extreme_offsets(struct trace *trace, u64 *min_ret, u64 *max_ret, u64 *
 
 static void check_io_types(struct trace *trace)
 {
-	struct blk_io_trace *io = trace->io;
+	struct blk_io_trace2 *io = trace->io;
 	int action = io->action & BLK_TA_MASK;
 
 	if (!(io->action & BLK_TC_ACT(BLK_TC_NOTIFY))) {
@@ -850,7 +857,7 @@ struct trace *open_trace(char *filename)
 	trace->len = st.st_size;
 	trace->start = p;
 	trace->cur = p;
-	trace->io = (struct blk_io_trace *)p;
+	trace_convert_io(trace);
 	return trace;
 
 fail_fd:
@@ -901,7 +908,7 @@ static inline int io_event(struct trace *trace)
 void add_tput(struct trace *trace, struct graph_line_data *writes_gld,
 	      struct graph_line_data *reads_gld)
 {
-	struct blk_io_trace *io = trace->io;
+	struct blk_io_trace2 *io = trace->io;
 	struct graph_line_data *gld;
 	int action = io->action & BLK_TA_MASK;
 	int seconds;
@@ -962,7 +969,7 @@ static struct pid_map *get_pid_map(struct trace_file *tf, u32 pid)
 
 void add_io(struct trace *trace, struct trace_file *tf)
 {
-	struct blk_io_trace *io = trace->io;
+	struct blk_io_trace2 *io = trace->io;
 	int action = io->action & BLK_TA_MASK;
 	u64 offset;
 	int index;
@@ -999,7 +1006,7 @@ void add_io(struct trace *trace, struct trace_file *tf)
 void add_pending_io(struct trace *trace, struct graph_line_data *gld)
 {
 	unsigned int seconds;
-	struct blk_io_trace *io = trace->io;
+	struct blk_io_trace2 *io = trace->io;
 	int action = io->action & BLK_TA_MASK;
 	double avg;
 	struct pending_io *pio;
@@ -1068,7 +1075,7 @@ account_io:
 void add_completed_io(struct trace *trace,
 		      struct graph_line_data *latency_gld)
 {
-	struct blk_io_trace *io = trace->io;
+	struct blk_io_trace2 *io = trace->io;
 	int seconds;
 	int action = io->action & BLK_TA_MASK;
 	struct pending_io *pio;
@@ -1107,7 +1114,7 @@ void add_completed_io(struct trace *trace,
 
 void add_iop(struct trace *trace, struct graph_line_data *gld)
 {
-	struct blk_io_trace *io = trace->io;
+	struct blk_io_trace2 *io = trace->io;
 	int action = io->action & BLK_TA_MASK;
 	int seconds;
 
diff --git a/iowatcher/blkparse.h b/iowatcher/blkparse.h
index f82876325ed6..304431e0f0d9 100644
--- a/iowatcher/blkparse.h
+++ b/iowatcher/blkparse.h
@@ -39,7 +39,7 @@ struct trace {
 	u64 len;
 	char *start;
 	char *cur;
-	struct blk_io_trace *io;
+	struct blk_io_trace2 *io;
 	u64 start_timestamp;
 	struct timespec abs_start_time;
 
-- 
2.54.0

