Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE35931A57C;
	Mon, 20 Oct 2025 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967696; cv=none; b=CFb+4bMhoc4zr+WPF18cFd5eN5A0ELgW0Ktr/CGkDYlWd/Nyohz93D2Ie9O0tj8spklXqwbEaeoBX94KLJE6E4u5hvppVmis3z/DdabLE+KIXRoU0AciSmFHJXN6MZa79IWTWyTsEIA1aDYfaj8XYVU0+gY6XyOjwIFDwbWSnsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967696; c=relaxed/simple;
	bh=ksy8BgshONcRNaaYPA2330I5SQCjqAYhB28T8Qj0gmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeEfn1lNUMgVDuTE8j7x48+QlAL4Di2hejW3Zrh4dlNQ6sktKs4qcfm0BPFs90Kj5rUBPm3Ncqx368x0Qq7+x2VLB6FqgNfDDQZSxf7orfyahjo9FdmlwBgdoK/gJagauW/OFhCbEDjSqKR7EDchR7sOrz2K6VQ4POZ7Fd7jQMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=a9XTaoR/; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a9XTaoR/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760967695; x=1792503695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ksy8BgshONcRNaaYPA2330I5SQCjqAYhB28T8Qj0gmc=;
  b=a9XTaoR/BUHIBVx1zYcmHRrzVkt4B8mVX+KquJYOHdG2lfHbgS7o3t0n
   68I+3KMRH4yO9pklE+KCGKqAZlr35GDNwV5AUCHZwN/orUu7dhobsqusv
   l/fROLzQMAAMTSUUc0XiJlvNXe3w5WsAtpu+sPUl/Jaw7R157PK145hFW
   c2L1zfkfZsJ/pPpYWv6xnv51WbFLVVbPXxBzMfYoz1yPShiwvZb3RIY8X
   E+WiNxUwDYjRIFcgCwBD+UUSyh9rQHgJ/uT4q/4+fPBCpDeVYjDdY2cHJ
   bVxMT2iT1w7uVAU3yNLtXPWk0P38clLBF6DJaKuFgecgnykQInvLYeYRy
   A==;
X-CSE-ConnectionGUID: PDYYkpruTS6tohk+tbh3Xg==
X-CSE-MsgGUID: vF/NfaegRsW5hyANDUqJ/w==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134518614"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 21:41:35 +0800
IronPort-SDR: 68f63c0e_iCvjtP4832ENZ134+DLFEMn6UwBG/bPKtW/uUPDhXkmvxXN
 +NnFAa+YlVberqSeQTNINcw987HoTnkWgsxmbkg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2025 06:41:34 -0700
WDCIronportException: Internal
Received: from 1pgdl13.ad.shared (HELO neo.fritz.box) ([10.224.28.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Oct 2025 06:41:30 -0700
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
Subject: [PATCH v4 01/16] blktrace: only calculate trace length once
Date: Mon, 20 Oct 2025 15:41:08 +0200
Message-ID: <20251020134123.119058-2-johannes.thumshirn@wdc.com>
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

De-duplicate the calculation of the trace length instead of doing the
calculation twice, once for calling trace_buffer_lock_reserve() and once
for calling relay_reserve().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 6941145b5058..bc4b885f2cec 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -76,13 +76,14 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 	int cpu = smp_processor_id();
 	bool blk_tracer = blk_tracer_enabled;
 	ssize_t cgid_len = cgid ? sizeof(cgid) : 0;
+	size_t trace_len;
 
+	trace_len = sizeof(*t) + cgid_len + len;
 	if (blk_tracer) {
 		buffer = blk_tr->array_buffer.buffer;
 		trace_ctx = tracing_gen_ctx_flags(0);
 		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
-						  sizeof(*t) + len + cgid_len,
-						  trace_ctx);
+						  trace_len, trace_ctx);
 		if (!event)
 			return;
 		t = ring_buffer_event_data(event);
@@ -92,7 +93,7 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 	if (!bt->rchan)
 		return;
 
-	t = relay_reserve(bt->rchan, sizeof(*t) + len + cgid_len);
+	t = relay_reserve(bt->rchan, trace_len);
 	if (t) {
 		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
 		t->time = ktime_to_ns(ktime_get());
@@ -228,6 +229,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	bool blk_tracer = blk_tracer_enabled;
 	ssize_t cgid_len = cgid ? sizeof(cgid) : 0;
 	const enum req_op op = opf & REQ_OP_MASK;
+	size_t trace_len;
 
 	if (unlikely(bt->trace_state != Blktrace_running && !blk_tracer))
 		return;
@@ -250,14 +252,14 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 		return;
 	cpu = raw_smp_processor_id();
 
+	trace_len = sizeof(*t) + pdu_len + cgid_len;
 	if (blk_tracer) {
 		tracing_record_cmdline(current);
 
 		buffer = blk_tr->array_buffer.buffer;
 		trace_ctx = tracing_gen_ctx_flags(0);
 		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
-						  sizeof(*t) + pdu_len + cgid_len,
-						  trace_ctx);
+						  trace_len, trace_ctx);
 		if (!event)
 			return;
 		t = ring_buffer_event_data(event);
@@ -273,7 +275,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	 * from coming in and stepping on our toes.
 	 */
 	local_irq_save(flags);
-	t = relay_reserve(bt->rchan, sizeof(*t) + pdu_len + cgid_len);
+	t = relay_reserve(bt->rchan, trace_len);
 	if (t) {
 		sequence = per_cpu_ptr(bt->sequence, cpu);
 
-- 
2.51.0

