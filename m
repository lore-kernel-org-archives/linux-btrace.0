Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC3633EB01;
	Wed, 22 Oct 2025 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133291; cv=none; b=WHF/g/VMOlUk8UJ5kMLaUz3ALzNAMMlXKLCUaB2j7Nk5YmdnwftH8m4QuGLlsoa0KahYdVDxNO8/IBB2LSFqn5jUsEltYVsHXjEYsiHQs6NBER0iQNeWbgZQOhUBsqWxdDjAFI6v0LfwdzG2tYZ274dEbO7/BJg0RNAap7ZWCJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133291; c=relaxed/simple;
	bh=ADgSVbzcBq0V5YuQtV/YJ3D05FWKwC8OY4ZG3MiehRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INjQCEp4kKGLRGVy0yvKa0uOEiGwo0XA0AWus6D7jTuWCABjsto9F2N1Gn70gyyMUkgl42xNgXwbHbsKKmXlyHPKlhmCg7VnMscnzn7ULhmOTv4Ki8pSzGWHJ9FBR9YoBt2SdZN+rDarp5f978Fxa9p8Jfo0Nzt84xkOailclGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=g0/fIfVx; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g0/fIfVx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761133290; x=1792669290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ADgSVbzcBq0V5YuQtV/YJ3D05FWKwC8OY4ZG3MiehRk=;
  b=g0/fIfVxrJovzoXaiNlwzeNBkzWdnHaCKOtNPgx7cyrwKO48XJ0jO44y
   XMUUSQe8VJKbATmyuDz1j3xC7+CxN8dIMi7cLe+efEYReuvDY7Qj+LzmK
   6v/7dFDYqDnRNrkfLezw5VOC19wYHBIW0q8oIWLor4yFADbT1o3HPgchy
   8oa8RzJjxPRZiGj/K0pRJogIVviKW9PVxkMU/QWvwmzoeP9wNuC5tiieg
   ETqTahv9pj+BA6QYCwM0wP6KEEwMLA61Hs4tu9SlPQk3X2w6nSwtmhp1M
   4WT3TSzpjAlqJ7IxPjhMwwakajcIT4IomOugtlWq2iAlUhK1PSWzf82Yj
   g==;
X-CSE-ConnectionGUID: zJI2/K99SUyIiJuWvst3BA==
X-CSE-MsgGUID: LVjD4RmGT7ShTTIjvvAXAA==
X-IronPort-AV: E=Sophos;i="6.19,247,1754928000"; 
   d="scan'208";a="133361403"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 19:41:29 +0800
IronPort-SDR: 68f8c2e9_EXR0otZSTKDKSo0qtQhGpY8087xHMYWP68lM1Ff9PchOLAm
 e4Ohg912l6Bu/X5W0YxI4XfqGwH0SdUkQuVWJ/w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 04:41:29 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 04:41:24 -0700
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
Subject: [PATCH v5 01/16] blktrace: only calculate trace length once
Date: Wed, 22 Oct 2025 13:41:00 +0200
Message-ID: <20251022114115.213865-2-johannes.thumshirn@wdc.com>
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

De-duplicate the calculation of the trace length instead of doing the
calculation twice, once for calling trace_buffer_lock_reserve() and once
for calling relay_reserve().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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

