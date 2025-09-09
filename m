Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E0321F59;
	Tue,  9 Sep 2025 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416005; cv=none; b=chOHeZXJc16Zw/J1BEzGpvuTGMpAPNO92NGUODOKUiJVLGnd/DiovYEpEbx9rCM+YuORf1zmQ8Y4Wi2CbiYvLO0G7DYUPv+8d1f0HBjvsEKG0m/pWCNUv+A+tHh1tPG8nBbj6v9O8xuUAhZ+sVeeswvdUcXxamZrQKLEVKr2STA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416005; c=relaxed/simple;
	bh=ivX0frZefsWabktsbWppiasU1QZKTjoShPymhWDyYc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HHB6CxFiEMy5EE6nYCTDEctwAavX+JeyAubLwfK2okaIfXrh8VK8gE1EIm3vUv9YGkramo7+8c0Pe4vwnLms+aUeCtt6B41Emxo4AHTH+8Dv9ecy+2kq81G21ZCP+fOgvwAfZE02pLHUR2J9Kij0o2gGuDiF606QO5CAT/AxCbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e4rG0vWi; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e4rG0vWi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416003; x=1788952003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ivX0frZefsWabktsbWppiasU1QZKTjoShPymhWDyYc8=;
  b=e4rG0vWivk5gCLW6ErmW4TsIA8qmwH3LDdQj7IT0rnyvQVeDJHlYHw+V
   5ani1F8V/d+5rRuSqN7Z2laHqw/MAYLd6m3zVatK2XZcVzNtUEzTi9Qga
   vVK4A6F5XGa/fL5tiaWl2rGfSRb6eW7DQXOjpKT5/742gT92+LNGwKzoJ
   vwbMl4pUdIDqRjID3CO7OIo5XiuYJQK7jTCjL9QvytBPXDI72HW2qfb+y
   gtd4eHvXuA54B9mxTtj7If7jx7P4KU4fjeUZHlxnXfJn9KShDBhBWsEiY
   hQA9tLyBLUGhd79ih0I3zWOhfpVqPCri51gZiOLA8ju4ZIwCDJr2nGabb
   g==;
X-CSE-ConnectionGUID: A2MOpbnvTMOkVQEPcxlDoA==
X-CSE-MsgGUID: w7CG3L1qQQaKyNgpPnVnVA==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112809957"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:06:43 +0800
IronPort-SDR: 68c00a43_/A97EwXHrTnQ9nj14HF3ru9iq/vN/7u5JiofPQ2HLloSH2C
 +QMT50S0LxDMSxu0LcD+4dhF4pFdd48E1PTCKkw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:06:43 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:06:39 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/16] blktrace: factor out recording a blktrace event
Date: Tue,  9 Sep 2025 13:06:00 +0200
Message-Id: <20250909110611.75559-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909110611.75559-1-johannes.thumshirn@wdc.com>
References: <20250909110611.75559-1-johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 89 +++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 4a642a812854..5db0c1a4ef5e 100644
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
@@ -86,7 +114,12 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
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
@@ -96,18 +129,11 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
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
 
@@ -261,7 +287,12 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
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
@@ -280,32 +311,10 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
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

