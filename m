Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585E432277D;
	Tue,  9 Sep 2025 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416018; cv=none; b=amAMEYePBrd49r8q2zU4azfbVKOIJySQELutImlF1RtX4faNqdA50D+PNg7RsGQF7PBzf8LpBDdsu8thmlLpzwX5kUzw8/81D9v64td1ss6YNWybqZrTfL8X4NJ6yk/aIWQmiQbSmIYyrKcgSKVeSwkqbmjsOLSCGVyrUn4WuZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416018; c=relaxed/simple;
	bh=1gUjp/rAf5hBkU+gm0twc+iRy6v7rrG/Iwk4m1W73ZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQjg+RZwskXZFYxGrQ1Grxr3qFewoiX9mmex+JD4X1JLQfgi+PGzV37M5NmieIWCfLwDOumjpXYsTeX4XFHvtAlSpI8g3lmKvH8Ad7r+dmVUdNiucg6zx3St6MSsYr6vc/m1g8cP6CZEVcbvooCtlz4bcWX9AUiS1WH0XAUPthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Zn+6OM4L; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zn+6OM4L"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416016; x=1788952016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1gUjp/rAf5hBkU+gm0twc+iRy6v7rrG/Iwk4m1W73ZA=;
  b=Zn+6OM4LXxqDz2vvA9DAFrMrJHrTCaP0MRyC8TZJQAaunSgiK/uOEGxt
   0L+TnB77s3mScUmxWrHHQhTjCCVo3ojvmQJIL3mKN+uNpQLlZHgL7TjXV
   RubSwjT67nfwrSxjmUOaQDR3e3sQpwZ5UpI6D45tNxSZKI7p0xBfd3myq
   aKrULxvgVAZokm/QimvRpxojwY4X0nEHzjzTnJAvzxfBbRUxsCwh08Qqe
   kM8lX4WGRFu+bTZs+KXrT9VsAUFncNf99nJTLZXCgSWrWyz2ZCXD1bGiQ
   XV+vKiC/QaiZQglHic5gz+5pjpKTK1VIZk3empD/N0KyiTbpFHuv86NKu
   g==;
X-CSE-ConnectionGUID: 17K6U9IaR7uz2fx9eCBxqA==
X-CSE-MsgGUID: J+BbZ3ggRnWjfq7WYZaftQ==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810091"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:06:56 +0800
IronPort-SDR: 68c00a50_IdHAY/kT6bvdQSJud+61fCU387DiiWYgWmA9br/De7tAeNn
 jX+xs/Zyhvnzll8aNZi7rekgWJ9QPk7GWP5gLAw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:06:56 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:06:52 -0700
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
Subject: [PATCH 08/16] blktrace: change the internal action to 64bit
Date: Tue,  9 Sep 2025 13:06:03 +0200
Message-Id: <20250909110611.75559-9-johannes.thumshirn@wdc.com>
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

Change the internal use of the action in blktrace to 64bit. Although for
now only the lower 32bits will be used.

With the upcoming version 2 of the blktrace user-space protocol the upper
32bit will also be utilized.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 24eef7b116b5..5b97dc5e2cfd 100644
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
@@ -303,8 +302,9 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 			return;
 		t = ring_buffer_event_data(event);
 
-		record_blktrace_event(t, pid, cpu, sector, bytes, what, bt->dev,
-				      error, cgid, cgid_len, pdu_data, pdu_len);
+		record_blktrace_event(t, pid, cpu, sector, bytes,
+				      lower_32_bits(what), bt->dev, error,
+				      cgid, cgid_len, pdu_data, pdu_len);
 
 		trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
 		return;
@@ -321,8 +321,9 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
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
 
@@ -841,7 +842,7 @@ blk_trace_request_get_cgid(struct request *rq)
  *
  **/
 static void blk_add_trace_rq(struct request *rq, blk_status_t error,
-			     unsigned int nr_bytes, u32 what, u64 cgid)
+			     unsigned int nr_bytes, u64 what, u64 cgid)
 {
 	struct blk_trace *bt;
 
@@ -905,7 +906,7 @@ static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
  *
  **/
 static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
-			      u32 what, int error)
+			      u64 what, int error)
 {
 	struct blk_trace *bt;
 
@@ -971,7 +972,7 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 	bt = rcu_dereference(q->blk_trace);
 	if (bt) {
 		__be64 rpdu = cpu_to_be64(depth);
-		u32 what;
+		u64 what;
 
 		if (explicit)
 			what = BLK_TA_UNPLUG_IO;
-- 
2.51.0

