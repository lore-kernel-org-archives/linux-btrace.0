Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253031C588;
	Wed, 15 Oct 2025 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525717; cv=none; b=t5X2bxd33q3exftztYJf4o211RthZNgmSfBSPcTdzGfkY9MIYQNvAFKfmnTeUSSW/rvqzZ1r2i1wP0wwPPiSOiIhbjQDw/Ttqlo+nPKs1pA722eii1P01s8yTvtthHicl31e4DczbIPcDKnL6jyodQnNxC8eRgFQ+ZCBqmczwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525717; c=relaxed/simple;
	bh=mAUp0WL7pToU8KKdjl0PWb6H3xb1MjwU+oTRkb9kEfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QL+EtF3ouU3wdKLlEhyhkaqINcnf29++fQKZwoJXyFJLLyPWjzupCnSA52IiBA/+in0vCJzWzPPsli3PWtNVNAP/qxvwIbL6MWXSwFeOY56bAPFL08vM7QI/xzPD5u8fmmbGAAwN88MRDLC/TLBXueOcifm40bdfDCmxRLeFzu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RvO1eOl2; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RvO1eOl2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525715; x=1792061715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mAUp0WL7pToU8KKdjl0PWb6H3xb1MjwU+oTRkb9kEfo=;
  b=RvO1eOl2hlDmreweeqz1NnzUoYIDmh50ENaFtVLMSrH0oamB7SlSZOLw
   l+3NCsTNNw96dj6EtSbOftIBToQoayZhQxpS6YcCnsGjJStzGCUstMuK+
   LUnNIBwe0ma3a8Z92lXfpS1y03D0fBPp/TFegt1qwZ5LWUFFtR2ei+mUw
   QksL1jYrMvaMrY8ISHEneWj5Amnyu/XWeq0WVWc9xLkZz0IfjKE7lINrA
   kHiTebUy+YrnYAZ3nMiaaTWsroh6tB6AKnZAcVotUpdNaiPTOJG2pGGEs
   hcPFFTXWLnNjj/oxk26Wff7bi/LguQTZ+yzXSCdnPPsRndbiaMsAwvu7B
   w==;
X-CSE-ConnectionGUID: IlHXX8HdTu+iO+X3yTpRgw==
X-CSE-MsgGUID: 7/rxy+PDRt+/9W+vEvgvOQ==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="134197608"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:55:09 +0800
IronPort-SDR: 68ef7d8d_F0DUvF/esy7DiMH8Q9Uf73N4XPW8t9sN3ECNnsHXbtX+vLZ
 XxxvUeQ+4cfsIC7X44BcdM00dxCap1vvezd6C6g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:55:09 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:55:02 -0700
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
Subject: [PATCH v3 05/16] blktrace: change the internal action to 64bit
Date: Wed, 15 Oct 2025 12:54:24 +0200
Message-ID: <20251015105435.527088-6-johannes.thumshirn@wdc.com>
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

Change the internal use of the action in blktrace to 64bit. Although for
now only the lower 32bits will be used.

With the upcoming version 2 of the blktrace user-space protocol the upper
32bit will also be utilized.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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

