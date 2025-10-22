Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7532341654;
	Wed, 22 Oct 2025 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133360; cv=none; b=LNh/Qg54T38fbovGd/O+tFsiTsR7jLMkWTiU/l+5xnQS8CHSJE7JMqjN2s9oAunn93xGDUCNu8MbsRAlv9bVpPb+5YBTzg4fvAJqbymBUQmLH/tV2bQ+CffmKAzKDpSeG8mOvh9hNmhb+8tIdXziCjnimvFR52K6WUg+acmvvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133360; c=relaxed/simple;
	bh=LFEizxCvFbQ0Ntn9zhfflmElENDRtO31yhPsdgpW0ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKRiRMhJ6hAKJc+ubUqZQX01LcifGoobAa/9Qw5FdqqrQN4KBr17zu22YeZLyK3n6MDKp04jDum4XxA+ZEX5/Dd+fjf5+GnFYFypLWu20wDE2slILLFHvema9nipQs/qwcVMbmcMYkzXlMD346cSHqpGdz7N5I3lfasUxFYpEfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=f/Q3Apko; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f/Q3Apko"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761133359; x=1792669359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LFEizxCvFbQ0Ntn9zhfflmElENDRtO31yhPsdgpW0ZM=;
  b=f/Q3ApkobRysMVJj8uOdFvN3Bv3amTNuj+0jc3H5m2awp0/QK7tJK6uS
   OhnGiVpxwmtzVz87lM66WLIEri6XzaF0B59FLIBtQzs6+2JEKo1kCiMbi
   xcd9fqtAhWEh6CcQEYEMuzrSuNLTyKPwmfdAPse+5VXx9Ylv4/qB5EtVl
   L09gdVizxYhcC7imtDUEod6gwuxlfOrg4iBWZ7bOlp+qe9fTjif440dHG
   lwW8wn78K7rkmZV3jvAbrG2wVx+OmaKwGvCwihmNXvBH2f5mEytsuQ8gu
   iuu5vaBw6Gl6CpkLmnLbxCe5In/Rr8A0eG87hS56W6VMSSKru6p0kOY3R
   Q==;
X-CSE-ConnectionGUID: 7zoU02V7QSSXe18sbQlJSA==
X-CSE-MsgGUID: 7g3tZjDrSp2cHmIlJW5uiA==
X-IronPort-AV: E=Sophos;i="6.19,247,1754928000"; 
   d="scan'208";a="133602974"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 19:42:38 +0800
IronPort-SDR: 68f8c32e_tOjQ7NbQsSvG8iHjkjl5tWqwKQ36GD85JjwMPzfZGbyoibA
 Y5KRApgxtD8JqLG9CUxjvqzI5RdUjqzTOIG96FQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 04:42:38 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 04:42:33 -0700
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
Subject: [PATCH v5 12/16] blktrace: move ftrace blk_io_tracer to blk_io_trace2
Date: Wed, 22 Oct 2025 13:41:11 +0200
Message-ID: <20251022114115.213865-13-johannes.thumshirn@wdc.com>
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

Move ftrace's blk_io_tracer to the new blk_io_trace2 infrastructure.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 08c7be671c47..49f73cb3cb33 100644
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

