Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1DD322A1C;
	Tue,  9 Sep 2025 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416022; cv=none; b=hWTWqQngtnrU+wEsTsZs2Hi3+c6W1oXsCg4pbe/26Yn/zMP+tTZ+hmRrIFx1SNsq0itL9c2+6eiaZzkduKKez2MlEC1jlaW2faCTm1uxnkqH8+PqrkJcCsCu7IHyRA+YLhCWlAMEc7aNrB9UzCzTXPSJCpS/iCxz11lKmGTcSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416022; c=relaxed/simple;
	bh=xZZf8jB01CDi9ndqTpiZS4ugKpC/h2xJEYszhsUzzkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jxYV2cJwE5JBEWM3b5l70DLWW7hQQkfkFrle3tiUrGX8UBZCi+6FK3t8C+re47ODIsKvg05J4hzdDHCH7O90F7Ba6tfzvYsv9UHn8GiXJPcV2miOmJ6v9O50qBNKmenO0j560pP5MX0avc8jXCsXpx3TLHduzQZfrfAq9bPy4aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WB+3doUF; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WB+3doUF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416021; x=1788952021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xZZf8jB01CDi9ndqTpiZS4ugKpC/h2xJEYszhsUzzkY=;
  b=WB+3doUFSWPSDLuwBXRgtUqy45/NKr3a4Pxj8SFgbWTW0e6OjsUUoiXm
   cJX2UtKZnu1i4rAKtCP2TzEgC2oueiDrbMZAuxYFXfMHrXxlol8nrRFsi
   dj9DUOOW3mPwqdG/l9thq/zRhrGG4h6EAAmYnVH1ZVbwmLbX4ikC2Gxiz
   92A3vnZaJ5mFsjFWbUO0bLo6TU+8AT1zG7mcmsDlXRnay9A/hscWHr0Db
   2wCpa2jVwmwuPW2GPtUM4ZCiIzjcgulEkYW4p9P0LNp4SsQCOMrOTvLMi
   b2eVO+MyJTgc+PsGTzF8cIm+xMbik4v1vEPFRwlSZ1VNJp3Mw4kRvurke
   w==;
X-CSE-ConnectionGUID: P1vXulcSTcSDZ5IjcGWxmQ==
X-CSE-MsgGUID: jCxngcu9RxSh/S4Ql0xrEQ==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810102"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:07:00 +0800
IronPort-SDR: 68c00a54_UYXKVw0xCjBUhy06X5AFOLAOE9PlquvCDsqxWvDUycBnPsp
 DJSjrR4I0lnjXNQuCYXDaLQ/0IT5dunY2KkQucg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:07:00 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:06:56 -0700
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
Subject: [PATCH 09/16] blktrace: remove struct blk_io_trace from __blk_add_trace
Date: Tue,  9 Sep 2025 13:06:04 +0200
Message-Id: <20250909110611.75559-10-johannes.thumshirn@wdc.com>
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

Now that relaying the blktrace protocol information via relayfs has been
removed from __blk_add_trace(), it only uses 'struct blk_io_trace' for the
ftrace portion of the function.

Directly pass in the reserved area of the ftrace ring buffer to
record_blktrace_event().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 5b97dc5e2cfd..14fb4e7296cf 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -258,7 +258,6 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	struct task_struct *tsk = current;
 	struct ring_buffer_event *event = NULL;
 	struct trace_buffer *buffer = NULL;
-	struct blk_io_trace *t;
 	unsigned long flags = 0;
 	unsigned long *sequence;
 	unsigned int trace_ctx = 0;
@@ -290,19 +289,19 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
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
 
-		record_blktrace_event(t, pid, cpu, sector, bytes,
+		record_blktrace_event(ring_buffer_event_data(event),
+				      pid, cpu, sector, bytes,
 				      lower_32_bits(what), bt->dev, error,
 				      cgid, cgid_len, pdu_data, pdu_len);
 
-- 
2.51.0

