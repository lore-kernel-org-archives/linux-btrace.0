Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A6F40A942;
	Thu, 16 Jul 2026 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784199923; cv=none; b=cB/3uvugJ8TbpTXN4FsIgnXmmkc8Vzh4uWMIYWyaAmo5h3EEsQieHjWQJp4YjpLG3ahEQbs8ghWeIEJSQY8QCzBSlj8rN5DmScX+p0zr3+pPB/5i3iXAZ4MRGGR559iNQkS2MWKPfOBYN7oOrrJkhMUZ7mXNYOMEjGUDhoq7LGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784199923; c=relaxed/simple;
	bh=c4r+BNRO+i9WdlR3TJ7blJdAMG9/1EhmGLPD8wo6gEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELydnupkrySEE5+pe9TrGKtOlpnzF0o6mrSJdr/kh5N8eHioR38R1l4Wl8g0Gfg0NlB9wfkX9kPRUa0RBl83c9kbRgwCnl8OeJHobjcW9aYag/hVFYX+gCQJOuWiesn2Pon5z5yh2RebIghgGeSzqi9INZ11nj0xqT0JAQiMsFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZBpO9adN; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZBpO9adN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784199921; x=1815735921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c4r+BNRO+i9WdlR3TJ7blJdAMG9/1EhmGLPD8wo6gEE=;
  b=ZBpO9adNTuGVpD+YXJZtOThAiM+SW50W+4ydBgJi/bEF+T9PFsiZAK+r
   kRiFNokH1E0LyUS5YTT8e023yTHXOb+G1+TsqyLkQBMQ5TEqIRBx2uxkM
   dQYGkD4BUswe1gPGECt1db3FaWEEAIoAYrIojrlYl6bQk3oaf+ZmIt5FH
   JSerc7IqWW36wSMXfJ+ewnqbhK8MW4BXuwbVC91Gz0ODOSvjGr8i/8cU9
   WJKItqZuCEyc/rtgFYa6aKmr3ubnp8abjdGJQmtNuKetCIo2prsHtIG8r
   04pKbH3h5VFWgdF6SzyzT+82fEHf0/zERk4GK5vaygZkG5a0ApaaS6IyY
   w==;
X-CSE-ConnectionGUID: 13vlJNh8QcijmJLWyDnS0A==
X-CSE-MsgGUID: bBzHUprAQAm3IePJBeSzjQ==
X-IronPort-AV: E=Sophos;i="6.25,167,1779120000"; 
   d="scan'208";a="146986475"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2026 19:05:19 +0800
X-CSE-ConnectionGUID: vD6k2h7pTXuSwyoVPebGww==
X-CSE-MsgGUID: xz31p8hzQ52CGNHcPXX+qA==
IronPort-SDR: 6a58bad4_l249Q8yeGnSLQcPpUWIx1oxbv+Q0FxmtF/p0dhqNjgPKzI7
 bZUUFqLtpC61bc1+5/jmUBOV5XG7xvVKi/3Z10g==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2026 04:04:52 -0700
X-CSE-ConnectionGUID: O3rHm6rpSzaFBPNSRWA7Fw==
X-CSE-MsgGUID: zQJaehbUQAW4amVTDsH0BQ==
WDCIronportException: Internal
Received: from wdap-fln31fg1cp.ad.shared (HELO neo.wdc.com) ([10.224.28.153])
  by uls-op-esai1-o.wdc.com with ESMTP; 16 Jul 2026 04:04:50 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/11] btt: natively parse blk_io_trace2
Date: Thu, 16 Jul 2026 13:04:33 +0200
Message-ID: <20260716110442.1291010-3-johannes.thumshirn@wdc.com>
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

Natively parse 'struct blk_io_trace2' from a blktrace binary.

Detect the layout by parsing the input as both 'struct blk_io_trace' and
'struct blk_io_trace2' and using whichever interprets the trace stream
cleanly.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 btt/mmap.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 2 deletions(-)

diff --git a/btt/mmap.c b/btt/mmap.c
index 766a32b6c9e8..b0a80f4f8e7a 100644
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
 
@@ -88,6 +89,38 @@ static inline size_t convert_to_cpu(struct blk_io_trace *t,
 	return sizeof(*t) + tp->pdu_len;
 }
 
+static inline size_t convert_to_cpu2(struct blk_io_trace2 *t,
+                                     struct blk_io_trace2 *tp,
+				     void **pdu)
+{
+	if (data_is_native == -1)
+		check_data_endianness(t->magic);
+
+	if (data_is_native)
+		memcpy(tp, t, sizeof(*tp));
+	else {
+		tp->magic	= be32_to_cpu(t->magic);
+		tp->sequence	= be32_to_cpu(t->sequence);
+		tp->time	= be64_to_cpu(t->time);
+		tp->sector	= be64_to_cpu(t->sector);
+		tp->bytes	= be32_to_cpu(t->bytes);
+		tp->action	= be64_to_cpu(t->action);
+		tp->pid		= be32_to_cpu(t->pid);
+		tp->device	= be32_to_cpu(t->device);
+		tp->cpu		= be32_to_cpu(t->cpu);
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
 static int move_map(void)
 {
 	if (cur_map != MAP_FAILED)
@@ -137,6 +170,72 @@ void cleanup_ifile(void)
 	close(fd);
 }
 
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
 int next_trace(struct blk_io_trace2 *t, void **pdu)
 {
 	size_t this_len;
@@ -148,7 +247,18 @@ int next_trace(struct blk_io_trace2 *t, void **pdu)
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
-- 
2.54.0

