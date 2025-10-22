Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ACD33EB1A;
	Wed, 22 Oct 2025 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133304; cv=none; b=tX91jmw4Klo8dhz/ymmDQRnWOcaWcZ2q3OUeD1YN5ZKZb12xvGrMcqMdzo47VsH4PsgzF6a6+53UQ/znSBnaWRAX1k0IiXNrqXNn0jinlwVLUDh6NTnKWUQ3C+E3Uvjef1cK0SLhTChL8b3RPZIT15XdkLwiKn+gkruAps7hnII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133304; c=relaxed/simple;
	bh=gv+dFYy3s4VK7ov7yAgwFpwK0TaZXEebgZ82qqjBYbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTmlnwCn132TuAqpUXbKvFPfQQECXhwTnUJmtCYmI4zGhuhTam6B4iIt3zjp87WmLks7ZrldfkL8eaTuyeNGllVPVWB6DatDR6jG2HhCAOcl2rbQ7dnXhZmqDmXcU5MSYiftZRxTzmmEKonGDIiKb4YTouJry3Obq/7a3ZbFI4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=n6dA+vwQ; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n6dA+vwQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761133302; x=1792669302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gv+dFYy3s4VK7ov7yAgwFpwK0TaZXEebgZ82qqjBYbg=;
  b=n6dA+vwQCcEX3G0zJZfwyTKKlQii3Y5e6FqpdPPvqSVOyQxHFJeBttcz
   YkutHe5d9zZaLilfL8iHlcWos43pGbKFqJE2NSvyF/OQCqn8O2LehNbu+
   41Ycp67YTEK/AmwVTwu/+EkKOWCrnc7zt3YgVeZgOJYnw1Dw1/YKtodAo
   ML5olydlgPFxzAYx8lJceNnj/RoYIYFdhGbzPWyRXegeCeAWL6Jx6S2PK
   Zfd5a3IkqzuLt+ymsQLgfiB9+CtM7cp/cMUaTl6h3beebN1sl+OiZfqOk
   utOSsMgppZjg1JemRG2z1uhw/TbEX62FzisBgfyAeJwdp1+g477EAY9xp
   g==;
X-CSE-ConnectionGUID: VQrw5gm2QC2HhbFueSYJsw==
X-CSE-MsgGUID: n07Vk2FmSce54aCGh/R7dg==
X-IronPort-AV: E=Sophos;i="6.19,247,1754928000"; 
   d="scan'208";a="134941203"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 19:41:36 +0800
IronPort-SDR: 68f8c2f0_4BCMyvjNg6/DSvmsKCnaJ9M9t1oIn4IWsLyUy9FyvQf3/Cn
 7fKYvtDtdoJyNJ6Zyq9TuV8dMMvFiJ6wW0uXHeA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 04:41:36 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 04:41:30 -0700
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
Subject: [PATCH v5 02/16] blktrace: factor out recording a blktrace event
Date: Wed, 22 Oct 2025 13:41:01 +0200
Message-ID: <20251022114115.213865-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
References: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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

