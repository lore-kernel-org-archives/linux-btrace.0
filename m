Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B692931E0F7;
	Wed, 15 Oct 2025 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525741; cv=none; b=e6qVsqB+oWlCYtk1J97MhdYIEwTJTKHlZgkqofXauIsoFjeaWzTqXL1E5yiPDKwFW0mdbQ1J1dO+juwYdg1pYqprlyQXND8Qo1mPTJgnjkcAmMzI/gNwXUgjS+l+naSPFvCqJdwTguZgf8Vj+zYDF1DnQ2UqsKNP++BP/gVrc5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525741; c=relaxed/simple;
	bh=RO+2yCpb40QjzkLafpQDfbLu3NGrWhJ+S2FUBqNx35Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYCM0bjtDvPcQUpU4ki/tVslFVg9GxV/ixjabDtbjKdmMLKGLNhuNLQRnDQQTY3lFUXKaj+v+y7NFJEyZiBpEUkHaxR4cFA3QmQmA5MdR7P9TB04+d2S7q0N0rvN6T54KAv37rlb8Ur9tYSoAK37SjfK4gEegrikD9WZMR3FPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Z04XSSFK; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z04XSSFK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525739; x=1792061739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RO+2yCpb40QjzkLafpQDfbLu3NGrWhJ+S2FUBqNx35Q=;
  b=Z04XSSFKQc2eL2KV10N8WpA49FfAR1s5HdAEP0zOvcD+ny4z3fi+/I7v
   2GXYX2GcjWckFdCqkgy9J+pU95cjX4KO6/ZrrRMAUceAGhsLnkue9P29y
   3y8+vEIRsFdYhfgkKW/s9zPWc5sCrGdXVXfLO5REO2WBkFgOdGTpgI31/
   ++DF4bkauzO5Q/nhav8/TsKJttqu+FJKMTFwb+dmALXcek1tKAaMCjaA0
   VyPoOxdY2KXtLID0iX8BK1QTAScR76qSKlcyiQoc8UTuO4RgapA+p69Jr
   Fi1PTdOGuS+YjF8H8tDWwQLUAUjyfhv+BDlkOlOHjqWAG1neqJjYnTSVX
   Q==;
X-CSE-ConnectionGUID: sPxZOnseR3S5spM4fhB3tg==
X-CSE-MsgGUID: Lm/h3Wt2Tn6hwHMN3M3Flg==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="133262076"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:55:37 +0800
IronPort-SDR: 68ef7da9_HXVhFuy2eKF2YXlU2xhvi7OUurajdNmJ+tLvN85kuyzq8yK
 XngcfQ/kYHC+0z9296XVrYOdPcO5PM1i9jLujWg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:55:38 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:55:34 -0700
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
Subject: [PATCH v3 10/16] blktrace: differentiate between blk_io_trace versions
Date: Wed, 15 Oct 2025 12:54:29 +0200
Message-ID: <20251015105435.527088-11-johannes.thumshirn@wdc.com>
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

Differentiate between blk_io_trace and blk_io_trace2 when relaying to
user-space depending on which version has been requested by the blktrace
utility.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 62 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 185f19c9f772..074a7d77158c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -91,7 +91,29 @@ static void record_blktrace_event(struct blk_io_trace *t, pid_t pid, int cpu,
 		memcpy((void *)t + sizeof(*t) + cgid_len, pdu_data, pdu_len);
 }
 
-static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
+static void record_blktrace_event2(struct blk_io_trace2 *t2, pid_t pid, int cpu,
+				   sector_t sector, int bytes, u64 what,
+				   dev_t dev, int error, u64 cgid,
+				   ssize_t cgid_len, void *pdu_data,
+				   int pdu_len)
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
+static void relay_blktrace_event1(struct blk_trace *bt, unsigned long sequence,
 				 pid_t pid, int cpu, sector_t sector, int bytes,
 				 u64 what, int error, u64 cgid,
 				 ssize_t cgid_len, void *pdu_data, int pdu_len)
@@ -111,6 +133,40 @@ static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
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
+static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
+				 pid_t pid, int cpu, sector_t sector, int bytes,
+				 u64 what, int error, u64 cgid,
+				 ssize_t cgid_len, void *pdu_data, int pdu_len)
+{
+	if (bt->version == 2)
+		return relay_blktrace_event2(bt, sequence, pid, cpu, sector,
+					     bytes, what, error, cgid, cgid_len,
+					     pdu_data, pdu_len);
+	return relay_blktrace_event1(bt, sequence, pid, cpu, sector, bytes,
+				     lower_32_bits(what), error, cgid, cgid_len,
+				     pdu_data, pdu_len);
+}
+
 /*
  * Send out a notify message.
  */
@@ -146,8 +202,8 @@ static void trace_note(struct blk_trace *bt, pid_t pid, u64 action,
 	if (!bt->rchan)
 		return;
 
-	relay_blktrace_event(bt, 0, pid, cpu, 0, 0, action, 0, cgid,
-			     cgid_len, (void *)data, len);
+	relay_blktrace_event(bt, 0, pid, cpu, 0, 0, action, 0, cgid, cgid_len,
+			     (void *)data, len);
 }
 
 /*
-- 
2.51.0

