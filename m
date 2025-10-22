Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9793A340DA5;
	Wed, 22 Oct 2025 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133317; cv=none; b=iZA49ubI8fCUF5RwOo/sJ8ilHy8CA25QV0Aoqc/J4mr+Xk5YOz/x13NJMF2gkfE45C4qv4idy+DSAfFjaoff+0R7hvBpWguBymCqlq5xawT++Vcqf+P2xRyWJjWHjPdjw5xp2w1eiaw/YSt8RS0NpI1h/2tyt/bzsyydRvxaeuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133317; c=relaxed/simple;
	bh=vP0ejefhX06ARC5GUWCgLZK36fXmQPZMkH2ll9176xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uk76hxiMWJnoH5SmEiSefJ9F1wRC/5l+Fd6uzuuMSKUh0xuHzS/9gmqmb8an6c7AgYsOausAuVYlicrL5+QHMrIUPn94G1tYetASvcbe7rA+q5stJQJTe+PW+Rq5grS2jDmgnnvJTh0aPljqYHhqbNA8CfKBo2NbvGRyaDqcS+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WYctQU2Y; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WYctQU2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761133315; x=1792669315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vP0ejefhX06ARC5GUWCgLZK36fXmQPZMkH2ll9176xg=;
  b=WYctQU2Y1jfaZt5aOGJ5FOgfFCb0iEVGDVeyOP+YRGQ+0Omufh0Kq8P0
   oS6bojI/U6b/b0bq/47yF9IsfX9+Tmv5nPaNjBG9xtYWUM5WZNU9x0T+j
   EMw8o+Y8befz37AqyBXH3nd6tcC/O/PCM/CyBD1cDcRH7NrMsbvd6pOsX
   lMARjbIqmbbUIyS2puXK3j1HSHiGyF3zLhYXy/Q3N+uRDQIAYkFN57dq6
   1tppjiZitkQ8NmA1N0T1rd63UYTsO3fNolJ6amwyVTFzDhqRa6LKjbfqJ
   7Y/jNYCcmut2JPoMSsNeFCk8wT0gzO5gGw2ocRQgu7qlKzuEs+TRP07+Q
   g==;
X-CSE-ConnectionGUID: crqDarSOQk6j/CTcDPj4Kg==
X-CSE-MsgGUID: hfFcJfDeTnCwptGyQUvcag==
X-IronPort-AV: E=Sophos;i="6.19,247,1754928000"; 
   d="scan'208";a="133361425"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 19:41:55 +0800
IronPort-SDR: 68f8c303_7yswm5UxcQJ/yxzH/XARJWQpzWIHMPS45TQZb8zooYzNkQL
 4K5XJae5vtw4TAB2v/cWmFEt3ZvQm0fsfnQyMGw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 04:41:55 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 04:41:49 -0700
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
Subject: [PATCH v5 05/16] blktrace: change the internal action to 64bit
Date: Wed, 22 Oct 2025 13:41:04 +0200
Message-ID: <20251022114115.213865-6-johannes.thumshirn@wdc.com>
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

Change the internal use of the action in blktrace to 64bit. Although for
now only the lower 32bits will be used.

With the upcoming version 2 of the blktrace user-space protocol the upper
32bit will also be utilized.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 11e264f67851..15d6788700ca 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -64,7 +64,7 @@ static void blk_register_tracepoints(void);
 static void blk_unregister_tracepoints(void);
 
 static void record_blktrace_event(struct blk_io_trace *t, pid_t pid, int cpu,
-				  sector_t sector, int bytes, u32 what,
+				  sector_t sector, int bytes, u64 what,
 				  dev_t dev, int error, u64 cgid,
 				  ssize_t cgid_len, void *pdu_data, int pdu_len)
 
@@ -80,7 +80,7 @@ static void record_blktrace_event(struct blk_io_trace *t, pid_t pid, int cpu,
 
 	t->sector = sector;
 	t->bytes = bytes;
-	t->action = what;
+	t->action = lower_32_bits(what);
 	t->device = dev;
 	t->error = error;
 	t->pdu_len = pdu_len + cgid_len;
@@ -93,7 +93,7 @@ static void record_blktrace_event(struct blk_io_trace *t, pid_t pid, int cpu,
 
 static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
 				 pid_t pid, int cpu, sector_t sector, int bytes,
-				 u32 what, int error, u64 cgid,
+				 u64 what, int error, u64 cgid,
 				 ssize_t cgid_len, void *pdu_data, int pdu_len)
 {
 	struct blk_io_trace *t;
@@ -114,7 +114,7 @@ static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
 /*
  * Send out a notify message.
  */
-static void trace_note(struct blk_trace *bt, pid_t pid, int action,
+static void trace_note(struct blk_trace *bt, pid_t pid, u64 action,
 		       const void *data, size_t len, u64 cgid)
 {
 	struct blk_io_trace *t;
@@ -127,6 +127,7 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 	size_t trace_len;
 
 	trace_len = sizeof(*t) + cgid_len + len;
+	action = lower_32_bits(action | (cgid ? __BLK_TN_CGROUP : 0));
 	if (blk_tracer) {
 		buffer = blk_tr->array_buffer.buffer;
 		trace_ctx = tracing_gen_ctx_flags(0);
@@ -136,9 +137,8 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 			return;
 		t = ring_buffer_event_data(event);
 		record_blktrace_event(t, pid, cpu, 0, 0,
-				      action | (cgid ? __BLK_TN_CGROUP : 0),
-				      bt->dev, 0, cgid, cgid_len, (void *)data,
-				      len);
+				      action, bt->dev, 0, cgid, cgid_len,
+				      (void *)data, len);
 		trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
 		return;
 	}
@@ -146,8 +146,7 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 	if (!bt->rchan)
 		return;
 
-	relay_blktrace_event(bt, 0, pid, cpu, 0, 0,
-			     action | (cgid ? __BLK_TN_CGROUP : 0), 0, cgid,
+	relay_blktrace_event(bt, 0, pid, cpu, 0, 0, action, 0, cgid,
 			     cgid_len, (void *)data, len);
 }
 
@@ -222,7 +221,7 @@ void __blk_trace_note_message(struct blk_trace *bt,
 }
 EXPORT_SYMBOL_GPL(__blk_trace_note_message);
 
-static int act_log_check(struct blk_trace *bt, u32 what, sector_t sector,
+static int act_log_check(struct blk_trace *bt, u64 what, sector_t sector,
 			 pid_t pid)
 {
 	if (((bt->act_mask << BLK_TC_SHIFT) & what) == 0)
@@ -253,7 +252,7 @@ static const u32 ddir_act[2] = { BLK_TC_ACT(BLK_TC_READ),
  * blk_io_trace structure and places it in a per-cpu subbuffer.
  */
 static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
-			    const blk_opf_t opf, u32 what, int error,
+			    const blk_opf_t opf, u64 what, int error,
 			    int pdu_len, void *pdu_data, u64 cgid)
 {
 	struct task_struct *tsk = current;
@@ -311,9 +310,9 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 			return;
 
 		record_blktrace_event(ring_buffer_event_data(event),
-				      pid, cpu, sector, bytes, what, bt->dev,
-				      error, cgid, cgid_len, pdu_data,
-				      pdu_len);
+				      pid, cpu, sector, bytes,
+				      what, bt->dev, error, cgid, cgid_len,
+				      pdu_data, pdu_len);
 
 		trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
 		return;
@@ -330,8 +329,9 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	local_irq_save(flags);
 	sequence = per_cpu_ptr(bt->sequence, cpu);
 	(*sequence)++;
-	relay_blktrace_event(bt, *sequence, pid, cpu, sector, bytes, what,
-			     error, cgid, cgid_len, pdu_data, pdu_len);
+	relay_blktrace_event(bt, *sequence, pid, cpu, sector, bytes,
+			     lower_32_bits(what), error, cgid, cgid_len,
+			     pdu_data, pdu_len);
 	local_irq_restore(flags);
 }
 
@@ -818,7 +818,7 @@ blk_trace_request_get_cgid(struct request *rq)
  *
  **/
 static void blk_add_trace_rq(struct request *rq, blk_status_t error,
-			     unsigned int nr_bytes, u32 what, u64 cgid)
+			     unsigned int nr_bytes, u64 what, u64 cgid)
 {
 	struct blk_trace *bt;
 
@@ -882,7 +882,7 @@ static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
  *
  **/
 static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
-			      u32 what, int error)
+			      u64 what, int error)
 {
 	struct blk_trace *bt;
 
@@ -948,7 +948,7 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 	bt = rcu_dereference(q->blk_trace);
 	if (bt) {
 		__be64 rpdu = cpu_to_be64(depth);
-		u32 what;
+		u64 what;
 
 		if (explicit)
 			what = BLK_TA_UNPLUG_IO;
-- 
2.51.0

