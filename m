Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D733EB1A;
	Wed, 22 Oct 2025 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133355; cv=none; b=aNcVEbHPDYjHTiRejg3UGH+gJmSpPzCSw7JHeM7qF+wlg039G8E/R5liZ+jpk41QVpS46HIINki42/eYb74SWZwyDumcxF1YEzBxmDIcDZfASpzas5PX/npvhth7gc0CV1S+LSPUNfooktT7cFJnydCz9sE/2CF8aTmZ0e9hSqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133355; c=relaxed/simple;
	bh=Tg+InoiUkixMTHRjKqO+3LE4IbRDh+1Zw8VhpQekT20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rb3dgRsg1Q/qY246Jx/WCfsJvMkyDM8g9wOmQKDoIMYTfb2EIot9E0xLWqYD0NSRwLNZMp2k7PV7XGpEw3UbxJozpnvTmbtK5lAJYHM3TodKODL9u5pGfFGM4PZWzZMY7+/48OgGHfEslznl5uE0xFysvKwmAC+omEZK51BKZ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gHnbhSC8; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gHnbhSC8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761133353; x=1792669353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tg+InoiUkixMTHRjKqO+3LE4IbRDh+1Zw8VhpQekT20=;
  b=gHnbhSC8iVPeRKFxloCickHG7Vs53KMSlvurQamWVytKLmbk4jrsMP53
   Wq5gn9nU8r5Hk/twcMqbMFpJTpt3jvp1HpASeFnqZJOwRn4K47Fs5yBBn
   7LYpgBz4p7l3nQ97wL4aGZFFVxEGsI5uuNJvr1jJ2x4zDhwyqEw4iPvQF
   g+o8GJYyB5F1cvhR78DTzStOSOnuxbIgNpkYKqGPFmcB+mRegINoQ8wYi
   bxmXXrZvVese3Qkzh7M0JTyeTCJc37YUovgM2SfK6D0Ab71t4LZIzJvkD
   b8DoiSYgCzo5hFQrgH7jzDOUrDze25N0Lo0L9n1eO5xZq7lxy7HUqla69
   A==;
X-CSE-ConnectionGUID: j6t1p72fRS+p2e4ReBqImQ==
X-CSE-MsgGUID: l4LFWQDVT3ehXxIHnbSTew==
X-IronPort-AV: E=Sophos;i="6.19,247,1754928000"; 
   d="scan'208";a="133602971"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 19:42:32 +0800
IronPort-SDR: 68f8c328_JjQpdq0BI8qfTDBgrZOvMLqw94bT0V61Scd27TnviZQvSHO
 +5onhUwG0/oVhO8Oj89aFmKAAINPhL0r9ltMQeQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 04:42:32 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 04:42:27 -0700
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
Subject: [PATCH v5 11/16] blktrace: move trace_note to blk_io_trace2
Date: Wed, 22 Oct 2025 13:41:10 +0200
Message-ID: <20251022114115.213865-12-johannes.thumshirn@wdc.com>
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

Move trace_note() to the new blk_io_trace2 infrastructure.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 5f8ecf88a196..08c7be671c47 100644
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

