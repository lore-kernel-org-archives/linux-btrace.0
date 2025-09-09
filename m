Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BAF322A3F;
	Tue,  9 Sep 2025 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416026; cv=none; b=i2T7QqdUAB4dVpETjZZsz+YJgO17au9bWnJfW+JKW6EquWAXMQ0jOHCmy63V4i/EyJUATP11QX9Ziyfn9uDLk1IgMJ2KKUMIIzhToX/QN0d6KM1wzmWw7kpHDt4QFdVN+GhLJAuhfll8R6+Kjv/Xq1yp+BwHR7NuTi4Ybctuf6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416026; c=relaxed/simple;
	bh=YD57R6IOf+2DW85lb/mytcLQw8QA0ltwv4UTXCmXK+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S61Dn36g5KqOhpf+C51HQ02hkpgjFBxecbA7CcOSlmgfHCo3mT00zZWl/tn7OXda6+IX2u0vCV9IvxU9ruBHvtsyX5IRN8fFs18osydaR+Ltsc5pndfWNqrlCyY+pBW7zVtic7+HTFqLjjl/hR/70ITbilaKzmv39tEKkAGl390=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rG5BUqBr; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rG5BUqBr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416025; x=1788952025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YD57R6IOf+2DW85lb/mytcLQw8QA0ltwv4UTXCmXK+I=;
  b=rG5BUqBrqZp64M9LBXjaO2KdhVw569W2atDlad1vOe8PipvuszAt/Mdd
   n7eVt3EjAzgNsK9E9fD7JuEdpbOJ8mc+eI1KtZg8zPmWQoyMI0mdCLZoX
   Xj/PAihRceE2iAGeIM2S0DtdOidnrTKLt1dfASUZ37zt0g2fH1Q19i+J9
   /4MJUTakTGkUejwTnMm1762H2fFCNWMQQff3eCgVUsyKpflu/8X4MMcF5
   OZ3bHpp79GNpjMdOM4uzr+n8CRwlM6fhY38YGf/rqm8sZdlAQfJIFY/Pf
   eZ9saNkrLPhp7E6e0x9FWORgsDrAXteHWH6svTRDw/8K67oz9Ku4ghwVW
   w==;
X-CSE-ConnectionGUID: r+teHtsYQW24QX3nCSZAIQ==
X-CSE-MsgGUID: d7vBeYl6T16yNiBef+kMfQ==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810106"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:07:05 +0800
IronPort-SDR: 68c00a58_+fzFfcg4SZmSHh/VQX/tSaQ7CzUkrFvXHZFoDzolg6gFgAu
 zeJp4R5kVKsFgJOoBM5yI38PzfjpzaA0ArZPf+g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:07:05 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:07:00 -0700
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
Subject: [PATCH 10/16] blktrace: differentiate between blk_io_trace versions
Date: Tue,  9 Sep 2025 13:06:05 +0200
Message-Id: <20250909110611.75559-11-johannes.thumshirn@wdc.com>
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

Differentiate between blk_io_trace and blk_io_trace2 when relaying to
user-space depending on which version has been requested by the blktrace
utility.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 62 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 14fb4e7296cf..6dc7396c26c2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -91,6 +91,29 @@ static void record_blktrace_event(struct blk_io_trace *t, pid_t pid, int cpu,
 		memcpy((void *)t + sizeof(*t) + cgid_len, pdu_data, pdu_len);
 }
 
+static void record_blktrace_event2(struct blk_io_trace2 *t2, pid_t pid, int cpu,
+				   sector_t sector, int bytes, u64 what,
+				   dev_t dev, int error, u64 cgid,
+				   ssize_t cgid_len, void *pdu_data,
+				   int pdu_len)
+
+{
+	t2->pid = pid;
+	t2->cpu = cpu;
+
+	t2->sector = sector;
+	t2->bytes = bytes;
+	t2->action = what;
+	t2->device = dev;
+	t2->error = error;
+	t2->pdu_len = pdu_len + cgid_len;
+
+	if (cgid_len)
+		memcpy((void *)t2 + sizeof(*t2), &cgid, cgid_len);
+	if (pdu_len)
+		memcpy((void *)t2 + sizeof(*t2) + cgid_len, pdu_data, pdu_len);
+}
+
 static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
 				 pid_t pid, int cpu, sector_t sector, int bytes,
 				 u32 what, int error, u64 cgid,
@@ -111,6 +134,26 @@ static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
 			      cgid, cgid_len, pdu_data, pdu_len);
 }
 
+static void relay_blktrace_event2(struct blk_trace *bt, unsigned long sequence,
+				  pid_t pid, int cpu, sector_t sector,
+				  int bytes, u64 what, int error, u64 cgid,
+				  ssize_t cgid_len, void *pdu_data, int pdu_len)
+{
+	struct blk_io_trace2 *t;
+	size_t trace_len = sizeof(struct blk_io_trace2) + pdu_len + cgid_len;
+
+	t = relay_reserve(bt->rchan, trace_len);
+	if (!t)
+		return;
+
+	t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE2_VERSION;
+	t->sequence = sequence;
+	t->time = ktime_to_ns(ktime_get());
+
+	record_blktrace_event2(t, pid, cpu, sector, bytes, what, bt->dev, error,
+			       cgid, cgid_len, pdu_data, pdu_len);
+}
+
 /*
  * Send out a notify message.
  */
@@ -146,8 +189,12 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 	if (!bt->rchan)
 		return;
 
-	relay_blktrace_event(bt, 0, pid, cpu, 0, 0, action, 0, cgid,
-			     cgid_len, (void *)data, len);
+	if (bt->version == 1)
+		relay_blktrace_event(bt, 0, pid, cpu, 0, 0, action, 0, cgid,
+				     cgid_len, (void *)data, len);
+	else
+		relay_blktrace_event2(bt, 0, pid, cpu, 0, 0, action, 0, cgid,
+				      cgid_len, (void *)data, len);
 }
 
 /*
@@ -320,9 +367,14 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	local_irq_save(flags);
 	sequence = per_cpu_ptr(bt->sequence, cpu);
 	(*sequence)++;
-	relay_blktrace_event(bt, *sequence, pid, cpu, sector, bytes,
-			     lower_32_bits(what), error, cgid, cgid_len,
-			     pdu_data, pdu_len);
+	if (bt->version == 1)
+		relay_blktrace_event(bt, *sequence, pid, cpu, sector, bytes,
+				     lower_32_bits(what), error, cgid,
+				     cgid_len, pdu_data, pdu_len);
+	else
+		relay_blktrace_event2(bt, *sequence, pid, cpu, sector, bytes,
+				      what, error, cgid, cgid_len, pdu_data,
+				      pdu_len);
 	local_irq_restore(flags);
 }
 
-- 
2.51.0

