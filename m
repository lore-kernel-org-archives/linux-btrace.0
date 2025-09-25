Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB22F5330;
	Thu, 25 Sep 2025 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812580; cv=none; b=gLPlemt76izXmVhTH0ei+pz09+LnL2bIIWGZsjyWFfvdPUxQaVrprUx2CsZXB05QlR8oCZTM2n41JedkcL4nNYnR9qIM/x64plGwW3HhhZMmx11vuxigWxJ15lLk2mFqrNnr8VfGsUcthqIFVF10H0rZTxn+8FuDucTVGo4k+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812580; c=relaxed/simple;
	bh=7+ylNvniXJ824dXkKqdVRoNNkoGIWyG9y9Xz28bxgWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rB2Cn7klENxUXF3fn7gl4zcwo7jRTw08B9LPW794Jchmm7FuGQ2XS1eCDsgxh0YQW+B4QApZeUCJRNjRdX+l0WbZPgbwxfLhYn/bytk7x69b5AFA8WgeApzi1DyEXjveKpNL6c6XzkwRUdNqI1d0d5UfP6XIZFfxSORhviEiiZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hDJ01wc1; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hDJ01wc1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812578; x=1790348578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7+ylNvniXJ824dXkKqdVRoNNkoGIWyG9y9Xz28bxgWk=;
  b=hDJ01wc1++9z81NXDl4ChQxg2cyk/67QgHL4L9PtciRwVnL5dVrXUJc6
   FQN8zY935y9v0d2zeXwnXXDnMxbdnuKCLpJooWK4LMpzt/HK6or9dJuET
   DR7JNf0mhJLCIJsCRdyv7Zb/ktZw+cWcs15k+SVa9csxKRvzKQtYzesV1
   4CM2M1G6AjbRUxc4BKXQ4UMGvI3Zng0Qqlw4mHHbuiOLpKioLLb8Tx4Dk
   7C0EIKnagtXkocYnQhOhrrfv0IePYtLNngYwmaTGSWtB1lY7Zn7TUT0Lt
   JP0iJg2kbVpqMN8nily4BSA8pzn6tfP1MnzBYgm7YrmZ3xVcTcfUsgBxD
   g==;
X-CSE-ConnectionGUID: rYL8tohBQOe5QuVF7LafyA==
X-CSE-MsgGUID: AWZTbfCERuqC9RcOVKv1bw==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130347719"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:02:58 +0800
IronPort-SDR: 68d559a2_0OC+D6qZiAB9Wf5NilK5CmZsOzHNTFjiIqzlCutyWo87Zlj
 GBKrNuPoOPO6T7W7KUFS9gtoF8sx8xVxzAhSrsg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:02:58 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:02:55 -0700
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
Subject: [PATCH v2 05/15] blktrace: change the internal action to 64bit
Date: Thu, 25 Sep 2025 17:02:21 +0200
Message-ID: <20250925150231.67342-6-johannes.thumshirn@wdc.com>
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

Change the internal use of the action in blktrace to 64bit. Although for
now only the lower 32bits will be used.

With the upcoming version 2 of the blktrace user-space protocol the upper
32bit will also be utilized.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 11e264f67851..51c001e4981c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
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
+				      lower_32_bits(what), bt->dev, error,
+				      cgid, cgid_len, pdu_data, pdu_len);
 
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

