Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A6240EB8F;
	Thu, 16 Jul 2026 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784199926; cv=none; b=g7OHH18s8lIO6FyU1Q+CmgqPV5Je2GISw9vZbSYmxZXg5xnSa3k+5hKsP9Z7qqilyi76yASV7kd/jHokoKYdReuJfjsZQE2GcKYeVu4Sgmm0HsdDks1WDRwI2FcMfNQS4XkN0kTHrbSIZKdlH4lO3Vxv6/ilMaCdqc58reh0KhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784199926; c=relaxed/simple;
	bh=LC4h+kSW/fKqww0YrohKzHOOFJewVbzk1XOL1Ek7rq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nq3GzU1/25TVKiolEcdcj2bniTHIkHbqQhdQcgK+pcnn3ChM8wjoCDQKI/azsdVGUwC3FQgf752/zlZBjA+tSVwAgdD2ij5srfoe/0vkLzdT9m/97ml2s8ndy+WCO4lAC2Qbg3hZSJtsGImMFrYY6+9nsfuSA3QtPqevZpgM4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iR+z0lqr; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iR+z0lqr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784199925; x=1815735925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LC4h+kSW/fKqww0YrohKzHOOFJewVbzk1XOL1Ek7rq8=;
  b=iR+z0lqrn5VOJTAmjI07QSy1QBbdWFysd4AwNC7psj5Rd7KI7lTAFxFN
   EHCxXM/ha1nYMt26ON+iiuALxIZgKHuvB1dGGfr8ehEdz80aBFlenU3HS
   go2F6cwavIXcJeDYbab4f5OpcIOWapLf48pnMOLCV8m850j8+eg0UdPb5
   A9RjR0h19Gl6/CoR4KIr4r8hM5hg0FQGmJEZvyVstHNjH5DOYaLJWtVL9
   9elvyU9GFAXZwZMNJ4eGCiqjhwG1/OSEbDsSgpWXOaxJnIJHFz4s+vV5v
   3AKrWUapZQ2WmcO0pYms7Qwc3GIU6IfqD4chQYRq7HIEHZxAfxsoKjEZF
   g==;
X-CSE-ConnectionGUID: Ys3KIHlcQzeyOkjxgFrG6Q==
X-CSE-MsgGUID: nMCe40zAS4W0CnLQqrAgWA==
X-IronPort-AV: E=Sophos;i="6.25,167,1779120000"; 
   d="scan'208";a="146986481"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2026 19:05:19 +0800
X-CSE-ConnectionGUID: wSLNPicsS4GzLbPLx1NlkA==
X-CSE-MsgGUID: yDxMshMXSw+4GLkPn4NWtA==
IronPort-SDR: 6a58bae1_N4kY2v3gxsl46gA+rPekGvhZAj5qsHOipVZZrA5FkT5CHsY
 Kov6hsZ42vQmBFethDboidrPSwHtqGMaRxrSHeg==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2026 04:05:05 -0700
X-CSE-ConnectionGUID: LXDMR/jZTmCTWtk3Zb7LZw==
X-CSE-MsgGUID: gkz5+IM/T+CIB0z9jQjEGQ==
WDCIronportException: Internal
Received: from wdap-fln31fg1cp.ad.shared (HELO neo.wdc.com) ([10.224.28.153])
  by uls-op-esai1-o.wdc.com with ESMTP; 16 Jul 2026 04:05:03 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 08/11] iowatcher: use blk_io_trace2 internally
Date: Thu, 16 Jul 2026 13:04:39 +0200
Message-ID: <20260716110442.1291010-9-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
References: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
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

