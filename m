Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960133EB1A;
	Wed, 22 Oct 2025 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133349; cv=none; b=UUb9f5c20lqbEzzScdTjRReswwx+K9conEjjf2b0707tukLufJ2KmgGSQOTczPh5knQzAwKoUs4h7nGphVc3IVpK3XIu1AuQAcDmnXHPfn36bhjuUE4YuTbkVSZgyphG62Ukj5q1O8aCHG0I0GR7S/FjCwGBs88hXE1DKRqyOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133349; c=relaxed/simple;
	bh=037FbZQmDVubQU4lKjBcgHnjO77xnBw5gmh0v/JuuxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiwgz9yLayBj8p632SNHpN8JAwzG+iIgkuTYHe/EXqZWkWfIc5czb138jBVDGuGu24E9ftxzh+G0U+uBoCPo9tF9LRxpM8CUhM9OmdJ/lmUFVau5Dc+muy1111pmoG9EzmubcPGvQfjAoxytmWmY47sZzD47+Qw9Gnc1H1FtL+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kdx6LKwK; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kdx6LKwK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761133348; x=1792669348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=037FbZQmDVubQU4lKjBcgHnjO77xnBw5gmh0v/JuuxI=;
  b=kdx6LKwKLPuLfnhm8X2Q1/Dia4gQMdMX48egOYPjfbkIJ/lBLV91K5x6
   EMdVNwiD/KPZ1JQXgwEmJt+/SnhOn4LRY3/ODrVJ5qAI2WcTNo8uAYsHK
   ebUJNKE+CM0QJbJTtLzBHMY0TzQh9DiaSYC9Ob7Z8ZS2v4hSojgTi9fN+
   C/q6OzkW8Ej3Lq5JPoykbJz4cBCk/rtf/r+C+WnQoQVhgcWHGUc/yos+h
   OHH2Z56JzbRGmKP/PYLKJ5ZxPCf35NyYNfoMhPd4mxAC7J1kfm391cMaY
   cYME/DBE5iHtu5AiyEZGTqDkI/nck0LQRzGdZhz+E050ykXVTmQI0+ehJ
   w==;
X-CSE-ConnectionGUID: RgQB2KMhQ1+K5fhHR3+zew==
X-CSE-MsgGUID: OnpNB9Q4RyKvf14aiIAVFQ==
X-IronPort-AV: E=Sophos;i="6.19,247,1754928000"; 
   d="scan'208";a="134645063"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 19:42:27 +0800
IronPort-SDR: 68f8c322_+XAqUIoGQQDrbz8X3tKKNlwqqU0p4Mb7/hBdUft2SFNwttH
 TcrVTU+inse3Lpo0eL/DIIneoNl1UTGdKfwFJKw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 04:42:26 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 04:42:21 -0700
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
Subject: [PATCH v5 10/16] blktrace: differentiate between blk_io_trace versions
Date: Wed, 22 Oct 2025 13:41:09 +0200
Message-ID: <20251022114115.213865-11-johannes.thumshirn@wdc.com>
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

Differentiate between blk_io_trace and blk_io_trace2 when relaying to
user-space depending on which version has been requested by the blktrace
utility.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 58 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 185f19c9f772..5f8ecf88a196 100644
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
-- 
2.51.0

