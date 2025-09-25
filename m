Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E262E3B18;
	Thu, 25 Sep 2025 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812572; cv=none; b=s1PADqtg6RSFzA2Q0tbfJ0re1seLsOhU8ItV3TAmJOo2Y1dozuQ055i8E84Hy3nY/3Jz83z8Y4xhRxbJmlpxf1JqmEHdJ/BYt7qohpI6sedBSvAlO22t5kofiUffqz6v2X14lIo4F4MJ5Ub0vHI214sD98C2qk2LNyfD2vun78g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812572; c=relaxed/simple;
	bh=DjULptPUWtUZ4rclbeccoEdPAkhPnzCJtKtItKf/JTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/NeSZ1kfqYqNHYritIsCEaP3JoknbUkbQFOUJRQydOsRV3zBv/XCZJhjx4aaQ4p/rxO/b4jg1AzpZfnxDvsEc6+qtXHSwpOIfl4FLJuk6sL/p7EabDPhotUju4sFnqM5xPUushRgkdUl5G1f2iGvZE0jVHJ1kyZxnh1XGI+P8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IWG7zKfu; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IWG7zKfu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812570; x=1790348570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DjULptPUWtUZ4rclbeccoEdPAkhPnzCJtKtItKf/JTE=;
  b=IWG7zKfuCfxwtizvSuHjdXGKLCyiwePnOLMum+iemHLUso7r94KZckrN
   rmyowR6sqI+IMrUCb0WLTm8ZZpTHYpQo910YT+/X0+CkoQPEaDFs0bnvM
   Qo4tMVE8FXj+QEPnU/XsHmh7rrxGHDwc86WQ0fcn0abxptA3albmuHvh9
   ii4+c0Z7CE2DSEHW6Lhym4L5yWKQhbTYetmDAlrIIlMlMACfM0KCaAuap
   dDanhhsk6CSnt1LLd7dFTJaVeLvvn6WZRkJgD+GLSrg3GASfzSV2AL1+e
   MPuUZaeC/HNQoujxPvFKx2IbLcHcR4ylN3NiecoK9BPZiTsNppGgqJW7z
   w==;
X-CSE-ConnectionGUID: riW+ZCp3TAeB+nhHroW29A==
X-CSE-MsgGUID: KbJ6vxr7SEG31FacNRTDjQ==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130347623"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:02:50 +0800
IronPort-SDR: 68d5599a_xpDocLYnaTgiF0H5YJLb5cNSBpevw9uhiehdKOqia+E9ibe
 W9Gzi3IRal/fpwWnbbIJPBXVbx/YWQ//Qp6ADEw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:02:50 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:02:47 -0700
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
Subject: [PATCH v2 03/15] blktrace: split out relaying a blktrace event
Date: Thu, 25 Sep 2025 17:02:19 +0200
Message-ID: <20250925150231.67342-4-johannes.thumshirn@wdc.com>
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

Split out the code relaying a blktrace event to user-space using relayfs.

This enables adding a second version supporting a new version of the
protocol.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

