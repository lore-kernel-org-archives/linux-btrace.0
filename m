Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC42E1F01;
	Thu, 25 Sep 2025 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812609; cv=none; b=mYhEumXxlz7MWHFr6QmnrbEGKqmrpq/D4+i6S1OXlXprhA05L0lcYY+5E11UklxRVn/K90dJLn2bHzl1g/xjEqgeDEIezJCriZ+Y6gPgTcTjrAqeYJf5D4LOBRPfH6hIyFQgcqDlBflsy90b7zIiWvaXYZL5riPKL/4zMP0S9cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812609; c=relaxed/simple;
	bh=ip0Tz9iBZjgRY3k7lF/V06DNImALVP9EBP12vem64xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHovbpUQUfBBhROWw6Pt4Qy9xvZXZxkvrf6CoqNFxT9pxenT/6QeBd4eNamtzsRWV4oPsRHY3HmRpPBp/zDZr+UQJwSbhw0mVJeX6PyESLtXd+EoA9B41IBSqObrpaDez422YuMuYZaF0Ys66ovGXbQKzIHySg0XBpoF3fJf4b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qA1v5hEg; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qA1v5hEg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812607; x=1790348607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ip0Tz9iBZjgRY3k7lF/V06DNImALVP9EBP12vem64xI=;
  b=qA1v5hEgt6n3DzUDbJS2fpKeu88L5niSVD4QkUyjLZ0LUfKskHJscpal
   AlUcXIsPnNUbbTiUW/Z7lnKV1vfoEsLQrgoPCCmP0HsQtigIZNxPSqzmF
   Tq7V3KyEptegYttBHk1I3MkITaybD6RtoOYqTMxtecnLNPD3tiu9/STdK
   kHSeL/STPRTqksxkrHrTuYcdiZqHhnmPvHRcqq5VIkQXWDHKJP+NdaUGR
   ZcZuPaaSKu2ilH0EckLWzWFMwbtoCWttywt1kx0syvJrqqp9euMHEhTsH
   2VzTMdti+LEMq04+7hDWf8ikvp3GsKYLH4y3O3OdtMJRR7T0tEQxQWcrI
   w==;
X-CSE-ConnectionGUID: yjdyjgzHQ4mLxbW/zRkc8Q==
X-CSE-MsgGUID: yeC64/AoRomM9oYIQESNcQ==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130348031"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:03:18 +0800
IronPort-SDR: 68d559b6_wmBkT+3+h/c0pO+9/lLCD7SVam7sNPWRA1gkjbUTGZR5xLW
 ltV7xTeB8Gu8GMMPeMoCHwsb6Ez+IBLIV2Fi1UQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:03:18 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:03:15 -0700
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
Subject: [PATCH v2 10/15] blktrace: differentiate between blk_io_trace versions
Date: Thu, 25 Sep 2025 17:02:26 +0200
Message-ID: <20250925150231.67342-11-johannes.thumshirn@wdc.com>
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

Differentiate between blk_io_trace and blk_io_trace2 when relaying to
user-space depending on which version has been requested by the blktrace
utility.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 62 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 9cd8eb9e7b4b..82ad626d6202 100644
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
@@ -329,9 +376,14 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
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

