Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E802E2DDE;
	Thu, 25 Sep 2025 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812569; cv=none; b=RX4d+3rXFnyToz1a2oehuPEUf4/2tRj1+tpalNNQIkrUlFHx3cSPzJA6oJaDLkZAhicXlEY7I2tO4YS/O1CL+hL+fWNEErSCDb6JBEkTPh8D+EvnHWZWbR3VXZgsjXj0muVDWWXEa+E5xsEvmLMa8iJnVBXrR9ZXsegalk677R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812569; c=relaxed/simple;
	bh=HaS6ytGAQxinLK781e8ldhD37Fi9fCITvN6+0+H1/ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMJeVDg0QJHRKDoDIZzCj+MjTJVMDghWOBwKMxUVAMTN5vy23Mx6Bt4E5sjqD3TmJqUQtgKDVW2Nvi/5bJHMazt8olRWhoBWC/tWxCo/p0ex8xzl79EHetFNpP/jvz+Gv5/3bUYxt0KVAr9MITePW6/WgpTBjrs6t0Vql2CNAN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CkTd3/bC; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CkTd3/bC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812567; x=1790348567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HaS6ytGAQxinLK781e8ldhD37Fi9fCITvN6+0+H1/ZE=;
  b=CkTd3/bCl2lO0kl1QVcbr7A9sz8YuQEdj+dK+zTXdyKI7+PjKas+ldV0
   NvluXIIENzLclsF95MtkezXyHUnh3OpuQQLhrOHTXu6WM18NVWRMrAh3m
   HORJJeOJcWHG5uQ5dCi+6ayNhiTda/I9oMmX3RmLTui9mRumE2mxCPXoU
   7V/Umh6CgLpI1s4XSHIwKqB6XAVQ4LxS09f7tv4ikJs9jTnU2DM1oPVKs
   C7eUtssXumyLgp6afl27xUQ5TX+gIAdaXw6/r0tkbewfcoiPM5jV6oUq0
   xZXos1wNJO/+nCEcLlASbLKmeUsm3E14UIRftQjVWKwrluBvHJLf/zjm7
   Q==;
X-CSE-ConnectionGUID: d0SBv5JcTNmiiiXjCjiAkQ==
X-CSE-MsgGUID: nBc+0YAwT7ayYmArAdeyig==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130347601"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:02:46 +0800
IronPort-SDR: 68d55996_LvqUbxTqsypp4pqPRJdN9mB2LnMI1Vx1jdTYbhJrjft2xHI
 z/mFf/8GKrbtVJ2oQG1VM2bU1dVGcfpAtF0AJcg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:02:46 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:02:43 -0700
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
Subject: [PATCH v2 02/15] blktrace: factor out recording a blktrace event
Date: Thu, 25 Sep 2025 17:02:18 +0200
Message-ID: <20250925150231.67342-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
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

