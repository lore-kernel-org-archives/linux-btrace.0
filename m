Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1369328B57;
	Mon, 20 Oct 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967745; cv=none; b=ApnNSWdIbjaz12YxpZ2LFYsDb/vBuNCR1gOdKlLLHx75I0+ezhyYnN7C0JGyuk/kP5qIOGYqAZ7GbUFQWToaHIZKYAORPqKa8fwnznQo2afrL4ish7rcorMMp5N79i/lgzef2+MYUZfO0zQZd4KiZDWE4JXbs6MJxs7L8Z2/QSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967745; c=relaxed/simple;
	bh=9fyo4x15I5nOU+yV4Ur/7W1Z4uAKxE2toCSFZxXkOwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JM47N8S9Pz+SJnNQVMaGwVNI0gYZds3u9ujWy8HgL0dCJl4qwC2H0xKQfoyB4bEQZd62yzBmIW0kTWKM6G7jxhVyi19p8IeZ4aJJkcm6y1WHOImA3gz8L+T+nJekI9E+GY3ImWjvsZGaIej5OQWK4qdC8d9rydg3jo2EMzCCoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IEnVSMco; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IEnVSMco"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760967744; x=1792503744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9fyo4x15I5nOU+yV4Ur/7W1Z4uAKxE2toCSFZxXkOwA=;
  b=IEnVSMcoOZRG6xixNJgJST+WVafdcmFF20zB2BIK7+B/Z8PJl2XnQChM
   b1ruamuU9NC5JXhh4gp8C6tQ4Si/fGyw6ELbJHJOsz60VmKj6swNnLRPD
   /Nc7Dd0r42XhBL9K0/AjCgI30iFYOo7i90DIh34hBZX2r9nLTT8gTvF6W
   wqFl6R5wNCqweJn3ihlenC6oow0Z6No2ulsuOS1k53L2/70gxs1Kgadi9
   MGJ3SU+OD4MYNsl757w8mye4+Wq6zxE4dggkSx9yJ6Zls0YoZNMm8NQe9
   34Aej5gHw/zNdvNwsgskRBOmWRLtCE0B8ydyRTG1f+nyDLB0AShwCfGaf
   w==;
X-CSE-ConnectionGUID: d2BqNXT3T1iOmjAP1yfjIA==
X-CSE-MsgGUID: f0rrhf6cRieKacebQ4z36A==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134518665"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 21:42:24 +0800
IronPort-SDR: 68f63c3f_IoIeyfsA9whCqSWs6KqBXC4VHa9t6mpHRqE64J0z2rSALIQ
 L88+bcNzMOTQcVFH9A4yGxMKx+uw02og9fWdgwQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2025 06:42:23 -0700
WDCIronportException: Internal
Received: from 1pgdl13.ad.shared (HELO neo.fritz.box) ([10.224.28.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Oct 2025 06:42:20 -0700
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
Subject: [PATCH v4 12/16] blktrace: move ftrace blk_io_tracer to blk_io_trace2
Date: Mon, 20 Oct 2025 15:41:19 +0200
Message-ID: <20251020134123.119058-13-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
References: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move ftrace's blk_io_tracer to the new blk_io_trace2 infrastructure.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 756d2c7dfdf2..8ffb218e9fb7 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1224,7 +1224,7 @@ static void blk_unregister_tracepoints(void)
  * struct blk_io_tracer formatting routines
  */
 
-static void fill_rwbs(char *rwbs, const struct blk_io_trace *t)
+static void fill_rwbs(char *rwbs, const struct blk_io_trace2 *t)
 {
 	int i = 0;
 	int tc = t->action >> BLK_TC_SHIFT;
@@ -1259,9 +1259,9 @@ static void fill_rwbs(char *rwbs, const struct blk_io_trace *t)
 }
 
 static inline
-const struct blk_io_trace *te_blk_io_trace(const struct trace_entry *ent)
+const struct blk_io_trace2 *te_blk_io_trace(const struct trace_entry *ent)
 {
-	return (const struct blk_io_trace *)ent;
+	return (const struct blk_io_trace2 *)ent;
 }
 
 static inline const void *pdu_start(const struct trace_entry *ent, bool has_cg)
@@ -1320,7 +1320,7 @@ static void blk_log_action_classic(struct trace_iterator *iter, const char *act,
 	unsigned long long ts  = iter->ts;
 	unsigned long nsec_rem = do_div(ts, NSEC_PER_SEC);
 	unsigned secs	       = (unsigned long)ts;
-	const struct blk_io_trace *t = te_blk_io_trace(iter->ent);
+	const struct blk_io_trace2 *t = te_blk_io_trace(iter->ent);
 
 	fill_rwbs(rwbs, t);
 
@@ -1334,7 +1334,7 @@ static void blk_log_action(struct trace_iterator *iter, const char *act,
 	bool has_cg)
 {
 	char rwbs[RWBS_LEN];
-	const struct blk_io_trace *t = te_blk_io_trace(iter->ent);
+	const struct blk_io_trace2 *t = te_blk_io_trace(iter->ent);
 
 	fill_rwbs(rwbs, t);
 	if (has_cg) {
@@ -1555,7 +1555,7 @@ static enum print_line_t print_one_line(struct trace_iterator *iter,
 {
 	struct trace_array *tr = iter->tr;
 	struct trace_seq *s = &iter->seq;
-	const struct blk_io_trace *t;
+	const struct blk_io_trace2 *t;
 	u16 what;
 	bool long_act;
 	blk_log_action_t *log_action;
@@ -1592,8 +1592,8 @@ static enum print_line_t blk_trace_event_print(struct trace_iterator *iter,
 static void blk_trace_synthesize_old_trace(struct trace_iterator *iter)
 {
 	struct trace_seq *s = &iter->seq;
-	struct blk_io_trace *t = (struct blk_io_trace *)iter->ent;
-	const int offset = offsetof(struct blk_io_trace, sector);
+	struct blk_io_trace2 *t = (struct blk_io_trace2 *)iter->ent;
+	const int offset = offsetof(struct blk_io_trace2, sector);
 	struct blk_io_trace old = {
 		.magic	  = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION,
 		.time     = iter->ts,
-- 
2.51.0

