Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17911320CDF;
	Tue,  9 Sep 2025 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416013; cv=none; b=YeNjHvdX/DCd0WiZRPECBUoZYbYOVtO5100qkut5+oStO4ONvs4hnoCYqbMM9kW3C7Bs4Rq2VwGxvzXnRA46XlifF17HSbmYR/k9/sCq+3RDiN7uBp+6bvcjUtG6Zq5BOYqU3JJlPBPevpQIcalyRIPmLwNUkx8YI3eXPZIaPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416013; c=relaxed/simple;
	bh=x3pZFGJDNQ/w9+kotR47LUEQH8ZtHRej2JzDn6otrLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jVu7ajfqmGIkxLur1d1GQzxPizO/AVRWFFtjPUXdjM7cG2hmBxaF9ZvLyGN5c18viECdmMY3UTA59hPSltYd4KWF1OGeHaxkSLDLxa2jw9hwDEEmi3pUlbGvq/LtcLCYOSPoph0wQ93uZ/LC8T7D0Rr2YNqZdimPSa6fuDbZnow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nVduiYQs; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nVduiYQs"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416012; x=1788952012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x3pZFGJDNQ/w9+kotR47LUEQH8ZtHRej2JzDn6otrLY=;
  b=nVduiYQs+WBLuhuL2toDDUxAa/8jki7GaIVejt5q8C1sILkyb5hjvPoB
   s+KJwutm019EYBlURTtNhVSuZleNOXmFa6annpDV19YZLGDdVAOfkaioY
   UQZTUagFEzZzC0WtQytRkKlA3GQb4STE6AkcZipXVK+5nsbGwN31kWqKy
   HLN3dXgRsBfgHEamggbHr9Lcz1QkepMJ2W03nV9ZaOPrgF+mu1HyJfSQt
   kwZGBj9kEHTyfsxUTDfi3v30jWEPEZIxCPVnfTIstu2e4xoBBpIU+D9FS
   knspLyyiscJ8P/U9rtNZ6gRmn2tjgBcgUKyK3Gx2YpdGTf87S4POtvLx2
   Q==;
X-CSE-ConnectionGUID: e3mDCNdGRbeGcF1nj4eytg==
X-CSE-MsgGUID: Lo4qnDtTQwizw+uPwyylGA==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810079"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:06:52 +0800
IronPort-SDR: 68c00a4b_DP5BTWUFWBBXPmgXFyrarNgQveza6twW2/+3YUvBIN/qhSV
 7F6XYnvE2kMzSQYV9MLUcZmDYGQJFkd+tFgfzRA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:06:52 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:06:47 -0700
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
Subject: [PATCH 07/16] blktrace: split out relaying a blktrace event
Date: Tue,  9 Sep 2025 13:06:02 +0200
Message-Id: <20250909110611.75559-8-johannes.thumshirn@wdc.com>
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

Split out the code relaying a blktrace event to user-space using relayfs.

This enables adding a second version supporting a new version of the
protocol.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 50 ++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d06519957c25..24eef7b116b5 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -91,6 +91,26 @@ static void record_blktrace_event(struct blk_io_trace *t, pid_t pid, int cpu,
 		memcpy((void *)t + sizeof(*t) + cgid_len, pdu_data, pdu_len);
 }
 
+static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
+				 pid_t pid, int cpu, sector_t sector, int bytes,
+				 u32 what, int error, u64 cgid,
+				 ssize_t cgid_len, void *pdu_data, int pdu_len)
+{
+	struct blk_io_trace *t;
+	size_t trace_len = sizeof(*t) + pdu_len + cgid_len;
+
+	t = relay_reserve(bt->rchan, trace_len);
+	if (!t)
+		return;
+
+	t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
+	t->sequence = sequence;
+	t->time = ktime_to_ns(ktime_get());
+
+	record_blktrace_event(t, pid, cpu, sector, bytes, what, bt->dev, error,
+			      cgid, cgid_len, pdu_data, pdu_len);
+}
+
 /*
  * Send out a notify message.
  */
@@ -126,16 +146,9 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 	if (!bt->rchan)
 		return;
 
-	t = relay_reserve(bt->rchan, trace_len);
-	if (t) {
-		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
-		t->time = ktime_to_ns(ktime_get());
-
-		record_blktrace_event(t, pid, cpu, 0, 0,
-				      action | (cgid ? __BLK_TN_CGROUP : 0),
-				      bt->dev, 0, cgid, cgid_len, (void *)data,
-				      len);
-	}
+	relay_blktrace_event(bt, 0, pid, cpu, 0, 0,
+			     action | (cgid ? __BLK_TN_CGROUP : 0), 0, cgid,
+			     cgid_len, (void *)data, len);
 }
 
 /*
@@ -306,19 +319,10 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	 * from coming in and stepping on our toes.
 	 */
 	local_irq_save(flags);
-	t = relay_reserve(bt->rchan, trace_len);
-	if (t) {
-		sequence = per_cpu_ptr(bt->sequence, cpu);
-
-		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
-		t->sequence = ++(*sequence);
-		t->time = ktime_to_ns(ktime_get());
-
-		record_blktrace_event(t, pid, cpu, sector, bytes, what,
-				      bt->dev, error, cgid, cgid_len,
-				      pdu_data, pdu_len);
-	}
-
+	sequence = per_cpu_ptr(bt->sequence, cpu);
+	(*sequence)++;
+	relay_blktrace_event(bt, *sequence, pid, cpu, sector, bytes, what,
+			     error, cgid, cgid_len, pdu_data, pdu_len);
 	local_irq_restore(flags);
 }
 
-- 
2.51.0

