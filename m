Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBB831B805;
	Wed, 15 Oct 2025 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525697; cv=none; b=cCd0G0yPyCgWPlhswS2ur4nSaowqVy4ZSD+kvPuy/Km8S2kcclguxtPg1o9FmTs1ce+w7UVkYkEW7n5fFjcllFOfxeJgUleATxuzaiYW1mM+EBTreFjsOFfcNGsf8jQ1Ptm6yp9dICfrHRZiVdK5B2nd4PZ+x+rSO1vffkv3xxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525697; c=relaxed/simple;
	bh=aSKlpte3/6fimeQh+rQvxtI4gXBHXMXDuYzzfy+EVC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=os+zsl+QbPLyXheVI+sotXNP/eCELu0FUEn6XMl51yaEWWWj/KyS8s/lGfqtcn6wGUKUzk8zY4ifbSoyhtcEmMWmi9QuQ5i0dMUVubEXKpywok3KulpmI7NlFR9pHmeIFwcpQP25A5PRlc2UG2V0A46XzB0Ka0TPgWwDekP7WBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NDSuPOmZ; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NDSuPOmZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525695; x=1792061695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aSKlpte3/6fimeQh+rQvxtI4gXBHXMXDuYzzfy+EVC0=;
  b=NDSuPOmZ2cyI1RuYqeKl4ldLtT9bfyMMy1hdmqP4ROWXGwpC/hVD6UII
   UEedvdxQMoB7rkx8lwZpOxjEqkEEoBQOGpKz/S24dLC3b4idqADnrk8NM
   vvyzFu8VmIreEAm2TLKLclu2+Ypd1R9fsdyTNav2UJXzxvflEKel4CYJ2
   sbWy0l2VgicojQwUeWFND4hSEeVaZzDMTR4ECI1dzc1NfrKldU/zm+nUn
   93Jm14ck7nDR8Rs4vNtfSWFeMQBbvf3uTZjXvNZwoM9BO0ZGXoPCupsGL
   rkVv/O0jJaDhETEGStwqSKymfnEh8aYKB/tsnt+EZWGlK+/+eVyPzROY6
   w==;
X-CSE-ConnectionGUID: w8p8xhXcR+WnVBg81kwSOg==
X-CSE-MsgGUID: VJYp5GWhQOadPI29In/JGA==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="133261986"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:54:55 +0800
IronPort-SDR: 68ef7d7f_hcSXdjwcnzwFaFa7B1PPLYIoUN9tWtJ09CXQqwEg0X14Hs9
 LLq8HREHSl4cNc0BzmJmKsbmniVgmVC/Pkv0pAQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:54:55 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:54:52 -0700
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
Subject: [PATCH v3 03/16] blktrace: split out relaying a blktrace event
Date: Wed, 15 Oct 2025 12:54:22 +0200
Message-ID: <20251015105435.527088-4-johannes.thumshirn@wdc.com>
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

Split out the code relaying a blktrace event to user-space using relayfs.

This enables adding a second version supporting a new version of the
protocol.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 60 ++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 25a0a1b09747..51745832c713 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -91,6 +91,26 @@ static void record_blktrace_event(struct blk_io_trace *t, pid_t pid, int cpu,
 		memcpy((void *)t + sizeof(*t) + cgid_len, pdu_data, pdu_len);
 }
 
+static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
+				 pid_t pid, int cpu, sector_t sector, int bytes,
+				 u32 what, int error, u64 cgid,
+				 ssize_t cgid_len, void *pdu_data, int pdu_len)
+{
+	struct blk_io_trace *t;
+	size_t trace_len = sizeof(*t) + pdu_len + cgid_len;
+
+	t = relay_reserve(bt->rchan, trace_len);
+	if (!t)
+		return;
+
+	t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
+	t->sequence = sequence;
+	t->time = ktime_to_ns(ktime_get());
+
+	record_blktrace_event(t, pid, cpu, sector, bytes, what, bt->dev, error,
+			      cgid, cgid_len, pdu_data, pdu_len);
+}
+
 /*
  * Send out a notify message.
  */
@@ -126,16 +146,9 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 	if (!bt->rchan)
 		return;
 
-	t = relay_reserve(bt->rchan, trace_len);
-	if (t) {
-		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
-		t->time = ktime_to_ns(ktime_get());
-
-		record_blktrace_event(t, pid, cpu, 0, 0,
-				      action | (cgid ? __BLK_TN_CGROUP : 0),
-				      bt->dev, 0, cgid, cgid_len, (void *)data,
-				      len);
-	}
+	relay_blktrace_event(bt, 0, pid, cpu, 0, 0,
+			     action | (cgid ? __BLK_TN_CGROUP : 0), 0, cgid,
+			     cgid_len, (void *)data, len);
 }
 
 /*
@@ -246,7 +259,6 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	struct task_struct *tsk = current;
 	struct ring_buffer_event *event = NULL;
 	struct trace_buffer *buffer = NULL;
-	struct blk_io_trace *t;
 	unsigned long flags = 0;
 	unsigned long *sequence;
 	unsigned int trace_ctx = 0;
@@ -278,20 +290,21 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 		return;
 	cpu = raw_smp_processor_id();
 
-	trace_len = sizeof(*t) + pdu_len + cgid_len;
 	if (blk_tracer) {
 		tracing_record_cmdline(current);
 
 		buffer = blk_tr->array_buffer.buffer;
 		trace_ctx = tracing_gen_ctx_flags(0);
+		trace_len = sizeof(struct blk_io_trace) + pdu_len + cgid_len;
 		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
 						  trace_len, trace_ctx);
 		if (!event)
 			return;
-		t = ring_buffer_event_data(event);
 
-		record_blktrace_event(t, pid, cpu, sector, bytes, what, bt->dev,
-				      error, cgid, cgid_len, pdu_data, pdu_len);
+		record_blktrace_event(ring_buffer_event_data(event),
+				      pid, cpu, sector, bytes, what, bt->dev,
+				      error, cgid, cgid_len, pdu_data,
+				      pdu_len);
 
 		trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
 		return;
@@ -306,19 +319,10 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	 * from coming in and stepping on our toes.
 	 */
 	local_irq_save(flags);
-	t = relay_reserve(bt->rchan, trace_len);
-	if (t) {
-		sequence = per_cpu_ptr(bt->sequence, cpu);
-
-		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
-		t->sequence = ++(*sequence);
-		t->time = ktime_to_ns(ktime_get());
-
-		record_blktrace_event(t, pid, cpu, sector, bytes, what,
-				      bt->dev, error, cgid, cgid_len,
-				      pdu_data, pdu_len);
-	}
-
+	sequence = per_cpu_ptr(bt->sequence, cpu);
+	(*sequence)++;
+	relay_blktrace_event(bt, *sequence, pid, cpu, sector, bytes, what,
+			     error, cgid, cgid_len, pdu_data, pdu_len);
 	local_irq_restore(flags);
 }
 
-- 
2.51.0

