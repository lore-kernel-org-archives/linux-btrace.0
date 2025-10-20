Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD6532779B;
	Mon, 20 Oct 2025 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967736; cv=none; b=utqd8JFCvsa+KSEccXAGgb5p9Jh5PIpT2j4oGhmEWB+vE03dc/ruWRq3CcPPgnjxevA3WVQZaTyaDnqvSfTaMjeVRZpX+cuTLYFDWAF9ghyF0qndC1LpRq3CCfJJcLqmcSc1lBlWvuVV2eqz+qQyrJsMPSSXV6gqtxKebqrkLkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967736; c=relaxed/simple;
	bh=RO+2yCpb40QjzkLafpQDfbLu3NGrWhJ+S2FUBqNx35Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIL7qRCCvCL4o/ak9+TKfpyzAB52ZKPmu83jmlzO2FHnQ8gNBMbYYhBsaNBWv8TxWsAZSGPBcy6CaRcrlvWHyeqsrhcqiXO4GuJpqFlQ5n4tsQx19JJY5UiHHWQc1Hc0bqTs5/5DApOpIGlA8DZQlV+kuXa0/KP9mdfolhyGDHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AU/dNqLV; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AU/dNqLV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760967736; x=1792503736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RO+2yCpb40QjzkLafpQDfbLu3NGrWhJ+S2FUBqNx35Q=;
  b=AU/dNqLVO5Q14MWePYqHRPN2aGGLBnq4+Y446XdNKfHAxuFYhtnGHsFx
   PtPUglLFOcJrHudqIc5t5nYU0S3n2jJz9GLFNKqEeXoW1nYhDWhHxEtN1
   +ZYzrgZjcJpetlZoIhNcSupbeb/U8D/6ttkyMOYKHxXoa0zNPAb5A64LR
   ytD8amIcgiNxQ0Wg35bFWxDKDEUbXMy6iYOOORpHZxUBEPoNgPvahvNa2
   QIU23yX+LJZldPLF3RY6nA6Fs5QJwxze0KhjqXNcPoNDnzdzWs4MVMl+3
   +aeOYAG2eu/r2V2yLkyS48BghPgDuKjkskg5+S3dUHGG0BXm0qc4mMtzG
   g==;
X-CSE-ConnectionGUID: WqI5xkj/RR2wF4QipuJ+Vg==
X-CSE-MsgGUID: 121s3fO9REWyoFdv8uKa9Q==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134518657"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 21:42:15 +0800
IronPort-SDR: 68f63c36_E6iPDBSO5IyNYzIDTHY50t+ALqbGWSRfl4oB7YT6igMoNaQ
 fTjzSnmnITAh4C2cBC536Un4Anc4SU+XK1RnwbQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2025 06:42:15 -0700
WDCIronportException: Internal
Received: from 1pgdl13.ad.shared (HELO neo.fritz.box) ([10.224.28.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Oct 2025 06:42:11 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: axboe@kernel.dk
Cc: chaitanyak@nvidia.com,
	dlemoal@kernel.org,
	hare@suse.de,
	hch@lst.de,
	john.g.garry@oracle.com,
	linux-block@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	naohiro.aota@wdc.com,
	rostedt@goodmis.org,
	shinichiro.kawasaki@wdc.com,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 10/16] blktrace: differentiate between blk_io_trace versions
Date: Mon, 20 Oct 2025 15:41:17 +0200
Message-ID: <20251020134123.119058-11-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
References: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Differentiate between blk_io_trace and blk_io_trace2 when relaying to
user-space depending on which version has been requested by the blktrace
utility.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 62 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 185f19c9f772..074a7d77158c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -91,7 +91,29 @@ static void record_blktrace_event(struct blk_io_trace *t, pid_t pid, int cpu,
 		memcpy((void *)t + sizeof(*t) + cgid_len, pdu_data, pdu_len);
 }
 
-static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
+static void record_blktrace_event2(struct blk_io_trace2 *t2, pid_t pid, int cpu,
+				   sector_t sector, int bytes, u64 what,
+				   dev_t dev, int error, u64 cgid,
+				   ssize_t cgid_len, void *pdu_data,
+				   int pdu_len)
+{
+	t2->pid = pid;
+	t2->cpu = cpu;
+
+	t2->sector = sector;
+	t2->bytes = bytes;
+	t2->action = what;
+	t2->device = dev;
+	t2->error = error;
+	t2->pdu_len = pdu_len + cgid_len;
+
+	if (cgid_len)
+		memcpy((void *)t2 + sizeof(*t2), &cgid, cgid_len);
+	if (pdu_len)
+		memcpy((void *)t2 + sizeof(*t2) + cgid_len, pdu_data, pdu_len);
+}
+
+static void relay_blktrace_event1(struct blk_trace *bt, unsigned long sequence,
 				 pid_t pid, int cpu, sector_t sector, int bytes,
 				 u64 what, int error, u64 cgid,
 				 ssize_t cgid_len, void *pdu_data, int pdu_len)
@@ -111,6 +133,40 @@ static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
 			      cgid, cgid_len, pdu_data, pdu_len);
 }
 
+static void relay_blktrace_event2(struct blk_trace *bt, unsigned long sequence,
+				  pid_t pid, int cpu, sector_t sector,
+				  int bytes, u64 what, int error, u64 cgid,
+				  ssize_t cgid_len, void *pdu_data, int pdu_len)
+{
+	struct blk_io_trace2 *t;
+	size_t trace_len = sizeof(struct blk_io_trace2) + pdu_len + cgid_len;
+
+	t = relay_reserve(bt->rchan, trace_len);
+	if (!t)
+		return;
+
+	t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE2_VERSION;
+	t->sequence = sequence;
+	t->time = ktime_to_ns(ktime_get());
+
+	record_blktrace_event2(t, pid, cpu, sector, bytes, what, bt->dev, error,
+			       cgid, cgid_len, pdu_data, pdu_len);
+}
+
+static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
+				 pid_t pid, int cpu, sector_t sector, int bytes,
+				 u64 what, int error, u64 cgid,
+				 ssize_t cgid_len, void *pdu_data, int pdu_len)
+{
+	if (bt->version == 2)
+		return relay_blktrace_event2(bt, sequence, pid, cpu, sector,
+					     bytes, what, error, cgid, cgid_len,
+					     pdu_data, pdu_len);
+	return relay_blktrace_event1(bt, sequence, pid, cpu, sector, bytes,
+				     lower_32_bits(what), error, cgid, cgid_len,
+				     pdu_data, pdu_len);
+}
+
 /*
  * Send out a notify message.
  */
@@ -146,8 +202,8 @@ static void trace_note(struct blk_trace *bt, pid_t pid, u64 action,
 	if (!bt->rchan)
 		return;
 
-	relay_blktrace_event(bt, 0, pid, cpu, 0, 0, action, 0, cgid,
-			     cgid_len, (void *)data, len);
+	relay_blktrace_event(bt, 0, pid, cpu, 0, 0, action, 0, cgid, cgid_len,
+			     (void *)data, len);
 }
 
 /*
-- 
2.51.0

