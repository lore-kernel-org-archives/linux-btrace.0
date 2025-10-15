Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8231E0F7;
	Wed, 15 Oct 2025 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525748; cv=none; b=cnD459qMudNnViWqO4Zey83S4BECtjlqiNtmRKAQ8RXVxZ8rqWQxYgqg2OH9BJS7u2N9BBNcfb2B0BEpp/pPJEk12rqT69+M090ExQN3sVdS3LBTPAyUiyhH702h2TUeSTryaFbHWUcgdAaFCNN7/4C4mroOe5kfPgYdEXRrDgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525748; c=relaxed/simple;
	bh=HmVTV/nBXVtxhHQVoXPcduOn70IjLc27QU1LE44MtJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIme5xCQoBIMKkwA7kpKDvFG/rmgAetINJWz8nZ8xIcAF2a4FOkW+GCHcPuwIPT+0w9ppZc5l0Q/XqBUAOSOdv1kgpZPrEl1IPEYIPHsYd/o9BHFfQfD58mwJkM8DlJf0iN9tiUiF9Hn7Zr8B5CY/hQIo67Jm6RCD9i0Nwu/Sk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L5beXwnv; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L5beXwnv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525746; x=1792061746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HmVTV/nBXVtxhHQVoXPcduOn70IjLc27QU1LE44MtJY=;
  b=L5beXwnv39diqT9x7k20zEnkOimoAYmQ5yv8c5YWxeZxw1cteC09AJO7
   df/ZOoGDteBWubTr6Jr2BoZHKvokcfC4H4s08myBRyU7d59RkmIAPDXL/
   81RHc45v5vEGF3Xq2H95VudtB34cIUz76vLMiGHgtdsRwLDvod2mZCALE
   iFzBk9jYsVqBNshu7KbkXk3/+suSIQtbQjHzkgWbfFIXxpO1VmICDrgDo
   aH7t7iBouGrAvGrlBJVGOsTc29e0g8t6vepfI6Alx5sKlOKRS0AnbtJF3
   l4DsxdF9y3nhPK4ottRq0Ba0JJFgZqySg9t0mwbz6SOULKNnssDSpJ/vz
   w==;
X-CSE-ConnectionGUID: ZgPRcLOhT4uXAyn2tzBSvg==
X-CSE-MsgGUID: Aa3v791LQkutD4v1dPsVSQ==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="133262101"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:55:46 +0800
IronPort-SDR: 68ef7db2_xl9G6s5AiHgTlZcCzH5lC7f9hdZng7Ki2A0Fp8KcdAaJVvm
 7949fog9MnbKmVaVc5nkUw65Uw5kJApK1gHj+Dw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:55:47 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:55:43 -0700
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
Subject: [PATCH v3 12/16] blktrace: move ftrace blk_io_tracer to blk_io_trace2
Date: Wed, 15 Oct 2025 12:54:31 +0200
Message-ID: <20251015105435.527088-13-johannes.thumshirn@wdc.com>
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

Move ftrace's blk_io_tracer to the new blk_io_trace2 infrastructure.

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

