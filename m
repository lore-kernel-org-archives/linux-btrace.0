Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF4E32039B;
	Wed, 15 Oct 2025 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525744; cv=none; b=AJd/BfcrrCgf5I08Lrcf4Rtvgk0S+dzSiJXkUM8zwHmVYJf15JvGTXhs4Ajvp8Rf91cARee9Z95d5m1uo7//FBvuuNBCSt8ScHPS1BDB+YzSSXg4qhIr1/6BlE/aCOR7F1VrPRW3Og+vgJb8okz3hbPfEF6ueAhLUCEGnAIwrRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525744; c=relaxed/simple;
	bh=+zDqYWKpOELxB5RCGGC2Sm7olw1AotTEuLjmyW7FOlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KswEnJwA4s3vMEvqhxtXPT8jlK9JzXSUlTY0yExOmsIV9VG+jlWeH9N9gc3ct/vX0jJb+2TdD9FVsNQcM+gbfPkJkZ0rnNXIoY34rneKLVZG+5mp8kZ3sZSj5hJaDaRY2u8eWo7J5HTeUC0FhZyDUR3ZE2toybTlAZ8DqulcLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IKoHFCbX; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IKoHFCbX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525742; x=1792061742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+zDqYWKpOELxB5RCGGC2Sm7olw1AotTEuLjmyW7FOlU=;
  b=IKoHFCbXc3LAUwQeWAJ+omSNBY6ARVxd3Sejc8HiN54Ntmgt2qji+OQS
   PO741poMSPpGCwkatFxD3InUadHnaaVHuUJxC9lvoweVAB3lVj4E3rA47
   T9n4JpdGbY9vD9z5xIMaTvCvoL6Kf1xF3ErPNVKgw36ftlQIlB6QZ9UE6
   G1qc5P26gyjxZWpV7gmQ6D9g1a3E7vUpykNxBT/vf67hm1AvlYeoOJ0f3
   lqiaXkN9TwkyxucttLF+JoCFsM+y/f6Lhsr2zofcVO1Re/dkPN3VX6BqQ
   LqARspQgkNM2WdUyRH29wQqzicHNhiJFoFool3+APR55OsXvbxt/kQcqg
   A==;
X-CSE-ConnectionGUID: HzRES3+aR32JKgX6OMlRSQ==
X-CSE-MsgGUID: DHlDl8adSx2GndVpQarZCg==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="133262082"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:55:42 +0800
IronPort-SDR: 68ef7dae_0lhDdHSLGa81VJhFKEMIVuBMaHEfbE+uQYTL/tLeqbtWMUW
 RX1La6GCdQW1QD7jrCz9PPwjH8rKkz8VO9oMz6Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:55:42 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:55:39 -0700
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
Subject: [PATCH v3 11/16] blktrace: move trace_note to blk_io_trace2
Date: Wed, 15 Oct 2025 12:54:30 +0200
Message-ID: <20251015105435.527088-12-johannes.thumshirn@wdc.com>
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

Move trace_note() to the new blk_io_trace2 infrastructure.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 074a7d77158c..756d2c7dfdf2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -173,18 +173,18 @@ static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
 static void trace_note(struct blk_trace *bt, pid_t pid, u64 action,
 		       const void *data, size_t len, u64 cgid)
 {
-	struct blk_io_trace *t;
 	struct ring_buffer_event *event = NULL;
 	struct trace_buffer *buffer = NULL;
 	unsigned int trace_ctx = 0;
 	int cpu = smp_processor_id();
 	bool blk_tracer = blk_tracer_enabled;
 	ssize_t cgid_len = cgid ? sizeof(cgid) : 0;
-	size_t trace_len;
 
-	trace_len = sizeof(*t) + cgid_len + len;
 	action = lower_32_bits(action | (cgid ? __BLK_TN_CGROUP : 0));
 	if (blk_tracer) {
+		struct blk_io_trace2 *t;
+		size_t trace_len = sizeof(*t) + cgid_len + len;
+
 		buffer = blk_tr->array_buffer.buffer;
 		trace_ctx = tracing_gen_ctx_flags(0);
 		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
@@ -192,9 +192,9 @@ static void trace_note(struct blk_trace *bt, pid_t pid, u64 action,
 		if (!event)
 			return;
 		t = ring_buffer_event_data(event);
-		record_blktrace_event(t, pid, cpu, 0, 0,
-				      action, bt->dev, 0, cgid, cgid_len,
-				      (void *)data, len);
+		record_blktrace_event2(t, pid, cpu, 0, 0,
+				       action, bt->dev, 0, cgid, cgid_len,
+				       (void *)data, len);
 		trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
 		return;
 	}
@@ -359,7 +359,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 
 		buffer = blk_tr->array_buffer.buffer;
 		trace_ctx = tracing_gen_ctx_flags(0);
-		trace_len = sizeof(struct blk_io_trace) + pdu_len + cgid_len;
+		trace_len = sizeof(struct blk_io_trace2) + pdu_len + cgid_len;
 		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
 						  trace_len, trace_ctx);
 		if (!event)
-- 
2.51.0

