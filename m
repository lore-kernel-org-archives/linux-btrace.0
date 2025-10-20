Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B447328625;
	Mon, 20 Oct 2025 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967741; cv=none; b=GEiBZ4eH36WcfVZ4DsZW+aBPwltR8XFW4wcfpOM3HS93HRu3Y7RZBsAcEJSQH0iiIqG/KBul4IpdvoCLQ4n0fYXYr8nJi4Eoq9keQavcCKpZGJHc4Ajyb5pN363ZYPiPB4a7XqT6CJa+HJDuFfgFkd+28b+RI7pFj0ifRJ8MPTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967741; c=relaxed/simple;
	bh=OdfjZtE4yrZPklJRJdAbMW23KQKawKbqo1RInESKj3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cp1MEY5vaKzqpc9Mui0ClsrQS5OlekfRUmg9pbwmzYm7NUDGRT9sLvYVSd/XCw/sBBFl2nDtgOyR0r4/DdWx6RPHOI8e595NcBJC8XX63jqF/klQBwzJzxju2vSf+YQ40jEAPfjH4OY6b9Kew74pIiufiGoCmJpb1aUCTEFaeBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oaKf5m/c; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oaKf5m/c"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760967740; x=1792503740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OdfjZtE4yrZPklJRJdAbMW23KQKawKbqo1RInESKj3k=;
  b=oaKf5m/cu/+ikClh7tooesyQjDphqfxDvibc475aauQeBC26B+9wYp0u
   NukHWc3iTEXdKNwu9sZuM+nifrju39cKppun41KwFUdrAacUB64YcxNQ4
   wpvGoIxhghp6Ct3bzcm/3L1j2jIRON8bfknsxgoQwsQduY25hiSfNH767
   rAcA0LtfQ4geXCFHCboPtH+52uR3MBIf6AhaY7Dtnqxr9DRgS6f/Fw8HD
   i6s+oZqcEJM43WqocT56sHwB8Wt93OhX027dTAb2rupz6/CTWNBtKDNtx
   u1oc2sTUXHDG+gFhMM+c1dXK7Q32ZJ5EregHnQh+6WifM62krLHxOlXlK
   A==;
X-CSE-ConnectionGUID: Q+OpfOvlQ+WGT0H7Din4tQ==
X-CSE-MsgGUID: 98nyvdNxS6GU2NTHHAtjfQ==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134518659"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 21:42:20 +0800
IronPort-SDR: 68f63c3b_GBf19eEcKD69xYEIibUJZKSSAyytyei0+yNNegYZVS7u9kb
 gF010qsHjGOw8OoK5uFONG/pCJwvX688zPn10Sg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2025 06:42:19 -0700
WDCIronportException: Internal
Received: from 1pgdl13.ad.shared (HELO neo.fritz.box) ([10.224.28.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Oct 2025 06:42:15 -0700
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
Subject: [PATCH v4 11/16] blktrace: move trace_note to blk_io_trace2
Date: Mon, 20 Oct 2025 15:41:18 +0200
Message-ID: <20251020134123.119058-12-johannes.thumshirn@wdc.com>
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

Move trace_note() to the new blk_io_trace2 infrastructure.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 074a7d77158c..756d2c7dfdf2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -173,18 +173,18 @@ static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
 static void trace_note(struct blk_trace *bt, pid_t pid, u64 action,
 		       const void *data, size_t len, u64 cgid)
 {
-	struct blk_io_trace *t;
 	struct ring_buffer_event *event = NULL;
 	struct trace_buffer *buffer = NULL;
 	unsigned int trace_ctx = 0;
 	int cpu = smp_processor_id();
 	bool blk_tracer = blk_tracer_enabled;
 	ssize_t cgid_len = cgid ? sizeof(cgid) : 0;
-	size_t trace_len;
 
-	trace_len = sizeof(*t) + cgid_len + len;
 	action = lower_32_bits(action | (cgid ? __BLK_TN_CGROUP : 0));
 	if (blk_tracer) {
+		struct blk_io_trace2 *t;
+		size_t trace_len = sizeof(*t) + cgid_len + len;
+
 		buffer = blk_tr->array_buffer.buffer;
 		trace_ctx = tracing_gen_ctx_flags(0);
 		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
@@ -192,9 +192,9 @@ static void trace_note(struct blk_trace *bt, pid_t pid, u64 action,
 		if (!event)
 			return;
 		t = ring_buffer_event_data(event);
-		record_blktrace_event(t, pid, cpu, 0, 0,
-				      action, bt->dev, 0, cgid, cgid_len,
-				      (void *)data, len);
+		record_blktrace_event2(t, pid, cpu, 0, 0,
+				       action, bt->dev, 0, cgid, cgid_len,
+				       (void *)data, len);
 		trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
 		return;
 	}
@@ -359,7 +359,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 
 		buffer = blk_tr->array_buffer.buffer;
 		trace_ctx = tracing_gen_ctx_flags(0);
-		trace_len = sizeof(struct blk_io_trace) + pdu_len + cgid_len;
+		trace_len = sizeof(struct blk_io_trace2) + pdu_len + cgid_len;
 		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
 						  trace_len, trace_ctx);
 		if (!event)
-- 
2.51.0

