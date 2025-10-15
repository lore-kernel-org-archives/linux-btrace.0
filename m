Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333031CA42;
	Wed, 15 Oct 2025 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525694; cv=none; b=noha+zpXHMLJtjrW8ceRWZqgNZoMQx4pYL0zSXpK7H9n685gILzZJDwTIK5DNg2CylC9yGXxGuq3VMgenPAXjwNziSYI3Vo9JM/xJrZNKDfe2KfnuP5vAh+4eYS5xWV4pibwPSI4G1I40rInRdP0eT1dGgkiaPbrlf2pBmXJwVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525694; c=relaxed/simple;
	bh=yErRjf71H9zMBluMUonZMg66O7BNcka3G9hCyQbx+VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPKbUC3EL4q6uOEFBc8fjyj+5lcaHTktsKecO1nH8q2W8cDcI9WLVjjpIt8DJrETxJnfh9GFvZCM8UCUNEN/5YBMN1v5e8L+I82JbSqrteECHvUnV94xHn3wZGe7rMptQ8XW7UHqCUvK2DpxX0H58ENoFfep0yLBrc6ORCgv0t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mLKA75yv; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mLKA75yv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525692; x=1792061692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yErRjf71H9zMBluMUonZMg66O7BNcka3G9hCyQbx+VU=;
  b=mLKA75yvM42oKol+ijE1147gUZEge1SItNGu9Y2bwQNkN9Ec2m6nMDo+
   7ngso3sdnEFijVYeYws7IhuUoUpezlHETJHVzidrGxs6xzJWa+4aL4iOm
   /9H0dJAB4oNQxZJlf/O2hykxsmbQ6F/bG0oOwAZYOg0jE3Tt4WMtMw/CH
   z+ASV64ClLvFJBmbDgrZo3cUq6qPRUk2gSNx7ohx3OxcHI5ai1bnkHdOB
   duNrFPngTXq4X+AbBzZLD2pRM8M0cDDEVL2QwVu6W7PD15MkOTUMKYexC
   GQJopiDsaZBwMfbeOo2Z2cgXO9lUurqgIqba5gCyDnT3VlIA+Itnbwh0r
   Q==;
X-CSE-ConnectionGUID: e0+PRSSUSY2+RCIhS4kUHA==
X-CSE-MsgGUID: 4tZtSkA/QyWxrgMLFXJo8g==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="133261965"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:54:51 +0800
IronPort-SDR: 68ef7d7b_KAYgK7C53NnqRy59XrFq1A7gBk5xlJbRGx/t+QOaB6UffGI
 mzeYRXWKm5wCe0qFBXzfmaYO7YSYXsa+2dk/4BA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:54:51 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:54:47 -0700
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
Subject: [PATCH v3 02/16] blktrace: factor out recording a blktrace event
Date: Wed, 15 Oct 2025 12:54:21 +0200
Message-ID: <20251015105435.527088-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015105435.527088-1-johannes.thumshirn@wdc.com>
References: <20251015105435.527088-1-johannes.thumshirn@wdc.com>
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

