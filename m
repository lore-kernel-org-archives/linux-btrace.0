Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487453FA5FA;
	Mon, 20 Jul 2026 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546106; cv=none; b=mZNy2UlFOmzvjsUW4vCffeM8FA7HLfDYc0LQYNStW3yXKBG36k77TxBSGbO23H3SgspXzo93sMMuxP4pYHWVO9ZxYGyYJUfgKDf5KiloqEwbSyzA4fns4vo9204P5m21Nsp7810gcja/u8v1cps01GRZwEvfE59TqqL23H8pS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546106; c=relaxed/simple;
	bh=bYz5hgqQUVwq/PfXO33dNgAqng6fyyW8NcYi4tqFlpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ci1PtOJQoYK1yDmM0kuOISgUYQEd60QZeqSnL2/WKmeyZ4ayqW3WE1biVz/yS2GTyGZnLjjIrEmWv4/G/gobBUIvClZh+RC6DFLzCCMZqrBhhLJUcviNEeaqClCHoIrgXd+IYCcWL5ajKZFhaONiu02n4DkmOjnPRzYQUm1AyP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SxrEKnv1; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SxrEKnv1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784546105; x=1816082105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bYz5hgqQUVwq/PfXO33dNgAqng6fyyW8NcYi4tqFlpw=;
  b=SxrEKnv1QaUU08h7oQnLb7hMjJZcco1KjBbNy797yqIifDlNkbJTwXuG
   vWUHjuCPW0JZg77NMWq6ZefVnlumt9obDO/+rtAL5CgUHX9M/2vAzTRp8
   kvYb14GEogXTKYBN1yaglblh0ktAUCeAOg/yx+G8ww5LNEHxChI/YdCOE
   xpiR81x+FQzQyB+LIUmXPVX3XTBzpPkfcJo5l+vKloRCyj1mgXnA/Mpze
   nyL8zSzP/XLXgx87nXtm33qhplLI7klPT0oPFRBX/JtlB9bQY/YdPp6tS
   R/sRhY6l5hAW0bRNWgCmoznCKD7X8F99mhLho4UwiTJkLLtREL+sE/Xu0
   g==;
X-CSE-ConnectionGUID: QEUXx+WYTtGgn3zMVqaFUw==
X-CSE-MsgGUID: /V4D4J6/TFOG112bbtHqhA==
X-IronPort-AV: E=Sophos;i="6.25,174,1779120000"; 
   d="scan'208";a="151105455"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2026 19:14:51 +0800
X-CSE-ConnectionGUID: b/+7jQWGQFOfbsrzmShK0Q==
X-CSE-MsgGUID: 9Ed2mg5gQm6E+PL04zN1vg==
IronPort-SDR: 6a5e0322_kmp3u1Ai+DbzEA9NCXsz9Q+qao1ZBmhsVcyZroznXAd9dLX
 Jqbgk5kF70EamQnvySvDTI5lP+rdB173IqWjzkQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jul 2026 04:14:42 -0700
X-CSE-ConnectionGUID: zRzZ0MHhSDeT7vwQFSCWHw==
X-CSE-MsgGUID: JHwL10/vRqadXKUjZyuOrg==
WDCIronportException: Internal
Received: from wdap-kyufgunycc.ad.shared (HELO neo.fritz.box) ([10.224.19.3])
  by uls-op-esai1-o.wdc.com with ESMTP; 20 Jul 2026 04:14:40 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 09/11] iowatcher: natively parse blk_io_trace2
Date: Mon, 20 Jul 2026 13:14:15 +0200
Message-ID: <20260720111417.1658507-10-johannes.thumshirn@wdc.com>
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

Natively parse 'struct blk_io_trace2' from a blktrace binary.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 iowatcher/blkparse.c | 69 +++++++++++++++++++++++++++++++++++++++++++-
 iowatcher/blkparse.h |  1 +
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/iowatcher/blkparse.c b/iowatcher/blkparse.c
index ee1c2c511de6..92ee1cc8ec31 100644
--- a/iowatcher/blkparse.c
+++ b/iowatcher/blkparse.c
@@ -288,11 +288,75 @@ static void handle_notify(struct trace *trace)
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
 static void trace_convert_io(struct trace *trace)
 {
 	struct blk_io_trace *old = (struct blk_io_trace *)trace->cur;
 	struct blk_io_trace2 *io;
 
+	if (trace->version == BLK_IO_TRACE2_VERSION) {
+		struct blk_io_trace2 *new = (struct blk_io_trace2 *)trace->cur;
+
+		io = realloc(trace->io, sizeof(*new) + new->pdu_len);
+		memcpy(io, new, sizeof(*new) + new->pdu_len);
+		trace->io = io;
+		return;
+	}
+
 	io = realloc(trace->io, sizeof(struct blk_io_trace2) + old->pdu_len);
 
 	io->magic	= old->magic;
@@ -316,10 +380,12 @@ static void trace_convert_io(struct trace *trace)
 
 int next_record(struct trace *trace)
 {
+	int hdr = (trace->version == BLK_IO_TRACE2_VERSION) ?
+		  sizeof(struct blk_io_trace2) : sizeof(struct blk_io_trace);
 	int skip = trace->io->pdu_len;
 	u64 offset;
 
-	trace->cur += sizeof(struct blk_io_trace) + skip;
+	trace->cur += hdr + skip;
 	offset = trace->cur - trace->start;
 	if (offset >= trace->len)
 		return 1;
@@ -857,6 +923,7 @@ struct trace *open_trace(char *filename)
 	trace->len = st.st_size;
 	trace->start = p;
 	trace->cur = p;
+	trace->version = detect_trace_version(trace);
 	trace_convert_io(trace);
 	return trace;
 
diff --git a/iowatcher/blkparse.h b/iowatcher/blkparse.h
index 304431e0f0d9..c59bcf7b5277 100644
--- a/iowatcher/blkparse.h
+++ b/iowatcher/blkparse.h
@@ -39,6 +39,7 @@ struct trace {
 	u64 len;
 	char *start;
 	char *cur;
+	int version;
 	struct blk_io_trace2 *io;
 	u64 start_timestamp;
 	struct timespec abs_start_time;
-- 
2.54.0

