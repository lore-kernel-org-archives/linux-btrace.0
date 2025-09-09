Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B8C322546;
	Tue,  9 Sep 2025 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416009; cv=none; b=SjImhB3hu8/vV4IovTudDp2U/a5I2J07tDPLIPNk6Mdrbxxc2wVpSWyhYRuVI8bHmwuCN8bO+GvDTm8QS6cNUXsXwtoP8UkplrLsMLhil5EigG/Fk3LBFPaxE2ynDA6A7ZSoZIFmv5BwR640F2J+52vC7Wa7iEKc75k22HchObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416009; c=relaxed/simple;
	bh=LbDNLaHybVzVZqlmCEc8V9yBV8bvIrwzYqGVl5WMDVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oyvyKO0gOsN7shqMcBJ9ZGEHAXSRHMp+PStcFXvNM2x3W1oqI+KACJThCPZ2Inxwz8oRkqRQRF/h1JhtLr6dMdXA68tUyIBuGmAOUomYyoO/5BqEwdaaQmtRdAkeXnvpXRjrit8bUlKIPZMHkpWgeCx/GVvLuFOuLfQAw+DYBdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hRmVNMf3; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hRmVNMf3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416008; x=1788952008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LbDNLaHybVzVZqlmCEc8V9yBV8bvIrwzYqGVl5WMDVw=;
  b=hRmVNMf33c9z7969D2wJY1PYrDXzdRHquP1A9K5i62pp59Y7Z04wapQf
   q+4etW0PdwAb3kMKI4oRvEBInm1bDZ0MRJGux+Qh1e7wcLihY7JSO2Hhp
   MTLO+YIDwvIFlLC545V1eV8sD684EExiuoCiWnlG+xzkM52V/pQgvP4LH
   8w7gLL3rnocE2gW76NIoaSSyar7f65VtQa64vxYBxQGupms9EsAGRGv96
   6fwe1a29SritxosLljyY6GqY1HZm/GLQtsTCzPM6yTUJSWTJla9CdgYAr
   N1Oh0roVkG0V6nCksI2q+myf6BNgDWJt44U9o+QOLOlFScbCIazxkEpTj
   Q==;
X-CSE-ConnectionGUID: 7Z82lodPTnKqYceHJ0QI4Q==
X-CSE-MsgGUID: Ww/Nm2x2TX6L8vn33+8heg==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810005"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:06:47 +0800
IronPort-SDR: 68c00a47_+MydnkjkLGk73fWAk8QsnANVdII4+7B/8UMRz06VGkonFTs
 fsPckMYXNmTHltd1roXUFAC480IPXKlKqNCH7RA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:06:47 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:06:43 -0700
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
Subject: [PATCH 06/16] blktrace: only calculate trace length once
Date: Tue,  9 Sep 2025 13:06:01 +0200
Message-Id: <20250909110611.75559-7-johannes.thumshirn@wdc.com>
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

De-duplicate the calculation of the trace length instead of doing the
calculation twice, once for calling trace_buffer_lock_reserve() and once
for calling relay_reserve().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 5db0c1a4ef5e..d06519957c25 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -104,13 +104,14 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
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
@@ -125,7 +126,7 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 	if (!bt->rchan)
 		return;
 
-	t = relay_reserve(bt->rchan, sizeof(*t) + len + cgid_len);
+	t = relay_reserve(bt->rchan, trace_len);
 	if (t) {
 		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
 		t->time = ktime_to_ns(ktime_get());
@@ -254,6 +255,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	bool blk_tracer = blk_tracer_enabled;
 	ssize_t cgid_len = cgid ? sizeof(cgid) : 0;
 	const enum req_op op = opf & REQ_OP_MASK;
+	size_t trace_len;
 
 	if (unlikely(bt->trace_state != Blktrace_running && !blk_tracer))
 		return;
@@ -276,14 +278,14 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
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
@@ -304,7 +306,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	 * from coming in and stepping on our toes.
 	 */
 	local_irq_save(flags);
-	t = relay_reserve(bt->rchan, sizeof(*t) + pdu_len + cgid_len);
+	t = relay_reserve(bt->rchan, trace_len);
 	if (t) {
 		sequence = per_cpu_ptr(bt->sequence, cpu);
 
-- 
2.51.0

