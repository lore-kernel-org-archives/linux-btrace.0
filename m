Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BF831D399;
	Mon, 20 Oct 2025 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967701; cv=none; b=Ed1qEluby3t8WtLsqMLntWiIQGVo5Ly+b2+6yMLTj9LnPVpNlDh5pmnKT69RJVngFVA68S7hFUNiGXUGx8Sw+Q3VfLQHpWNBt+t5koqgYH4cmGYv9hMR3k67eibYESqyceGd9Wgl1TmVl735GPn4aUVLcGbbNxtI3QxwY0/uUNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967701; c=relaxed/simple;
	bh=yErRjf71H9zMBluMUonZMg66O7BNcka3G9hCyQbx+VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3R3XLDdNzn5VcQ0IwdWiXGvmlppN0RBHhYKwMMjD8uITEsXMReF5Y1eFS7gVSHbolomoqgXVBpiGnEZITrqU0SLRPQCnD4/OuptN+MrKLPVWC+DCp+CqwwwOspbeQ17iFNznGPxpRoe7f0WlVaMgWS9ODq6ymoLfiYKQ3QI5so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LIsiaPf4; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LIsiaPf4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760967700; x=1792503700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yErRjf71H9zMBluMUonZMg66O7BNcka3G9hCyQbx+VU=;
  b=LIsiaPf4fEkJ2RNnP0YXI08Kk0yhkXSg8/M4PKf9TEMlaEIAmcxQ36Cz
   bk6UmaQvd/hstDlgqDuOBw8ODK5XJokehCLgc58DEZ9e0KZj3FdmD2hHH
   TcUtst9KFdVyxH2W6c59f3jR7RTveU97cjbQsKTeR6PmfTS6PnlwWuBLc
   p/ERWw9rTWCUiStqwQxBtole8eaSTvD/AsZvgQrwRnv7ixddJFP7dN+DP
   i3S/MMCl3F8NEbZdHQgMR3jo/49bH2nS7a9pHU+QUw6IDz3UXjrKvuox6
   xU8CN5mserk+X+gVUfst4yW6W79nePUTO6G0AM/X/XY42YDHD4OMl1xxZ
   w==;
X-CSE-ConnectionGUID: 2uHyiqdrQY6kY7M3XnP6JQ==
X-CSE-MsgGUID: tTkLtLXuRNuWmEQAAAmTXA==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134518620"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 21:41:40 +0800
IronPort-SDR: 68f63c13_CAMPNdqJ99Am9tS1KF0WGkJdvzUD5hWzGrgyC88L21Hrssk
 xhmJuaXBagh7uZOwNuBSDqCxvn0lJbv1PffGkoA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2025 06:41:39 -0700
WDCIronportException: Internal
Received: from 1pgdl13.ad.shared (HELO neo.fritz.box) ([10.224.28.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Oct 2025 06:41:35 -0700
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
Subject: [PATCH v4 02/16] blktrace: factor out recording a blktrace event
Date: Mon, 20 Oct 2025 15:41:09 +0200
Message-ID: <20251020134123.119058-3-johannes.thumshirn@wdc.com>
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

Factor out the recording of a blktrace event into its own function,
deduplicating the code.

This also enables recording different versions of the blktrace protocol
later on.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 89 +++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index bc4b885f2cec..25a0a1b09747 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -63,6 +63,34 @@ static int blk_probes_ref;
 static void blk_register_tracepoints(void);
 static void blk_unregister_tracepoints(void);
 
+static void record_blktrace_event(struct blk_io_trace *t, pid_t pid, int cpu,
+				  sector_t sector, int bytes, u32 what,
+				  dev_t dev, int error, u64 cgid,
+				  ssize_t cgid_len, void *pdu_data, int pdu_len)
+
+{
+	/*
+	 * These two are not needed in ftrace as they are in the
+	 * generic trace_entry, filled by tracing_generic_entry_update,
+	 * but for the trace_event->bin() synthesizer benefit we do it
+	 * here too.
+	 */
+	t->cpu = cpu;
+	t->pid = pid;
+
+	t->sector = sector;
+	t->bytes = bytes;
+	t->action = what;
+	t->device = dev;
+	t->error = error;
+	t->pdu_len = pdu_len + cgid_len;
+
+	if (cgid_len)
+		memcpy((void *)t + sizeof(*t), &cgid, cgid_len);
+	if (pdu_len)
+		memcpy((void *)t + sizeof(*t) + cgid_len, pdu_data, pdu_len);
+}
+
 /*
  * Send out a notify message.
  */
@@ -87,7 +115,12 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 		if (!event)
 			return;
 		t = ring_buffer_event_data(event);
-		goto record_it;
+		record_blktrace_event(t, pid, cpu, 0, 0,
+				      action | (cgid ? __BLK_TN_CGROUP : 0),
+				      bt->dev, 0, cgid, cgid_len, (void *)data,
+				      len);
+		trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
+		return;
 	}
 
 	if (!bt->rchan)
@@ -97,18 +130,11 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 	if (t) {
 		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
 		t->time = ktime_to_ns(ktime_get());
-record_it:
-		t->device = bt->dev;
-		t->action = action | (cgid ? __BLK_TN_CGROUP : 0);
-		t->pid = pid;
-		t->cpu = cpu;
-		t->pdu_len = len + cgid_len;
-		if (cgid_len)
-			memcpy((void *)t + sizeof(*t), &cgid, cgid_len);
-		memcpy((void *) t + sizeof(*t) + cgid_len, data, len);
-
-		if (blk_tracer)
-			trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
+
+		record_blktrace_event(t, pid, cpu, 0, 0,
+				      action | (cgid ? __BLK_TN_CGROUP : 0),
+				      bt->dev, 0, cgid, cgid_len, (void *)data,
+				      len);
 	}
 }
 
@@ -263,7 +289,12 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 		if (!event)
 			return;
 		t = ring_buffer_event_data(event);
-		goto record_it;
+
+		record_blktrace_event(t, pid, cpu, sector, bytes, what, bt->dev,
+				      error, cgid, cgid_len, pdu_data, pdu_len);
+
+		trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
+		return;
 	}
 
 	if (unlikely(tsk->btrace_seq != blktrace_seq))
@@ -282,32 +313,10 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
 		t->sequence = ++(*sequence);
 		t->time = ktime_to_ns(ktime_get());
-record_it:
-		/*
-		 * These two are not needed in ftrace as they are in the
-		 * generic trace_entry, filled by tracing_generic_entry_update,
-		 * but for the trace_event->bin() synthesizer benefit we do it
-		 * here too.
-		 */
-		t->cpu = cpu;
-		t->pid = pid;
-
-		t->sector = sector;
-		t->bytes = bytes;
-		t->action = what;
-		t->device = bt->dev;
-		t->error = error;
-		t->pdu_len = pdu_len + cgid_len;
-
-		if (cgid_len)
-			memcpy((void *)t + sizeof(*t), &cgid, cgid_len);
-		if (pdu_len)
-			memcpy((void *)t + sizeof(*t) + cgid_len, pdu_data, pdu_len);
-
-		if (blk_tracer) {
-			trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
-			return;
-		}
+
+		record_blktrace_event(t, pid, cpu, sector, bytes, what,
+				      bt->dev, error, cgid, cgid_len,
+				      pdu_data, pdu_len);
 	}
 
 	local_irq_restore(flags);
-- 
2.51.0

