Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73032E1F01;
	Thu, 25 Sep 2025 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812567; cv=none; b=IZb9hzYnpX9O+60KS6hFKSifwBYxX3/nHItukKS3JeGihoJHHsb5iKnl9zqcd+eEm2p7p1EAlZyRub4XmclXfZvXGPywLKjVAHedYCgKrlX84iIVf6U+KQRyGQhDT2g2pjVK/ScgNjF+vXTsLPeekWuDgX1KMNWqub9qo6bS5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812567; c=relaxed/simple;
	bh=3D/XrnT2iXRWVL8VTgMUInLNkbN2LWEivup0mFwVh7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcEt4SDBiruYpvtYYizQJJnqJMNGLdhsQQLhPaAV16kD9hxoxiEX0dBIdSsdtTKkUWrdhp3Mx/AW1vDJfZ/8UvGu9NO2dULO9xtrXNnd0sUKFf1J2sd0lW1JXi0I01JUyxfN1/Uq+XL00ou+oG8D+Lgwhnvfbbjqg2To2M+7ijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=b76itkYb; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b76itkYb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812565; x=1790348565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3D/XrnT2iXRWVL8VTgMUInLNkbN2LWEivup0mFwVh7U=;
  b=b76itkYbYzn5lRIk1uTK+K6r0ngw14I9QvW+88xJoyo4eUd+XuaHat2Q
   pByt6/9T/PzEgkjyBi9NH0fGEeVSoWNCAb1iRRy2avOY5+Pbk25A8VVVx
   FhVBn1ZC+P6L16gocdiRC5geHmSqMTKv5VO7BC97J15tFsdrFEFXbt7/5
   YEGJbFZb9Y9XPqSffxVAD/S1GWrfdvTgZDnaLlZ/YwjAVG2wo5camomON
   Zp0OLEoajnsdvC3jhZLyEJG/WbFrb0gDDL47GPXR9XY9LGNKZtSfNeuag
   fSlYInj/Mh2xbo4IVykHBiP6mfbg4J91aEvZVAhN42Qu2+x2MuSGexVHo
   g==;
X-CSE-ConnectionGUID: fdPhAOKAQmOxxgTVWxRawA==
X-CSE-MsgGUID: HcmKXiB1QNmTeQ/7BWJ36A==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130347522"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:02:42 +0800
IronPort-SDR: 68d55992_797UnHQnuWqMO6w3NvrGc3IDGN3D6WYvgOZjE9XU6T0O8Ws
 W9Emtj/V2HybUgoBlPrPesKzgGR4qEkUOeJRu5A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:02:42 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:02:39 -0700
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
Subject: [PATCH v2 01/15] blktrace: only calculate trace length once
Date: Thu, 25 Sep 2025 17:02:17 +0200
Message-ID: <20250925150231.67342-2-johannes.thumshirn@wdc.com>
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

De-duplicate the calculation of the trace length instead of doing the
calculation twice, once for calling trace_buffer_lock_reserve() and once
for calling relay_reserve().

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

