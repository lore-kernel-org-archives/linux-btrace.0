Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A733F8BD;
	Wed, 22 Oct 2025 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133368; cv=none; b=Mm+TD/u7gjyYm4gICt7LlJe0sLKWSsq5AfyvyIudQYmlRMXl2Nu3aFnviYqJtueGhajVf+5vqxvpT2x4xzWVQmmbHL75CZBHto85PNdNUoYc8Tuk9rHXv1/07LXiRQgWZGL4iqUQgLUXr9ve9OKBGv1nvux1/ejsZsqqkf7xPgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133368; c=relaxed/simple;
	bh=mFiBi3Qc+9B/JELtOoFO2CfJzbXZg5Eb/g44EpfjJA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myJLNVSGFM36vTQr32qVze6LwHfTZhzQHk1DNtDt1jOnNKvkD9YI2QgglckIXNwGCSj4/j4tMzc0NzUauImSUeMdieBl8+Q2VFkb8xMli6rOaJg6YhD7lNpnPcq09L5De5x4YcR3E/XKnBrn2vlhdNoGx7r/G7JrnTwXLyslsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Npv+1xFZ; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Npv+1xFZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761133367; x=1792669367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mFiBi3Qc+9B/JELtOoFO2CfJzbXZg5Eb/g44EpfjJA8=;
  b=Npv+1xFZmWPD17A1dD6d7tD9WehX4XNvqFey/igpGD7BvUhHxl3+6Ckj
   UxU0LP6gApiZG1TgyAG9+O1767EAHecE1oCN8nr2hGasmN+ZejypfKwuc
   kpIvuJ+jP8+ppm4sG3dO7wuZoKaeXZ560wEKGsBX+j1s6NrwI9IHXakhT
   0vsVYNgTvFaF4qMoZfE0om24Pv7yQl9qoEVxKgN2TpqYKVhfNsyzQbuyg
   BzGkUAQb+aLA0Yil32JA4CXXjQXyxWTGWqh1luxoH5cyxL+O7q9A1F1+1
   bpgHT70xjLV/4KQAP07DmFk8DW5n2Bs+SJtb+ySeEyi1wc+ZRrGliJUWc
   w==;
X-CSE-ConnectionGUID: 3YHVlVeKRQGLUgP238SrnA==
X-CSE-MsgGUID: JSi7Vd8uR9aiyLZ4Tudk2w==
X-IronPort-AV: E=Sophos;i="6.19,247,1754928000"; 
   d="scan'208";a="130696117"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 19:42:47 +0800
IronPort-SDR: 68f8c336_usCoP6zDQEjjaS/RO2wkPDu/2egN5/E0Lx/Md+J4kgu1b6g
 suuD7Y37j9uUlZy+lYhi7mBjZS+L4dVahcn46QQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 04:42:46 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 04:42:39 -0700
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
Subject: [PATCH v5 13/16] blktrace: add block trace commands for zone operations
Date: Wed, 22 Oct 2025 13:41:12 +0200
Message-ID: <20251022114115.213865-14-johannes.thumshirn@wdc.com>
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

Add block trace commands for zone operations. These commands can only be
handled with version 2 of the blktrace protocol. For version 1, warn if a
command that does not fit into the 16 bits reserved for the command in
this version is passed in.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 13 +++++++++++--
 kernel/trace/blktrace.c           | 29 +++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 9f9834d76e00..190a3c5ab0a0 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -26,11 +26,20 @@ enum blktrace_cat {
 	BLK_TC_DRV_DATA	= 1 << 14,	/* binary per-driver data */
 	BLK_TC_FUA	= 1 << 15,	/* fua requests */
 
-	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
+	BLK_TC_END_V1	= 1 << 15,	/* we've run out of bits! */
+
+	BLK_TC_ZONE_APPEND	= 1ull << 16,  	/* zone append */
+	BLK_TC_ZONE_RESET	= 1ull << 17,	/* zone reset */
+	BLK_TC_ZONE_RESET_ALL	= 1ull << 18,	/* zone reset all */
+	BLK_TC_ZONE_FINISH	= 1ull << 19,	/* zone finish */
+	BLK_TC_ZONE_OPEN	= 1ull << 20,	/* zone open */
+	BLK_TC_ZONE_CLOSE	= 1ull << 21,	/* zone close */
+
+	BLK_TC_END_V2		= 1ull << 21,
 };
 
 #define BLK_TC_SHIFT		(16)
-#define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)
+#define BLK_TC_ACT(act)		((u64)(act) << BLK_TC_SHIFT)
 
 /*
  * Basic trace actions
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 49f73cb3cb33..fb5935885abc 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -163,8 +163,8 @@ static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
 					     bytes, what, error, cgid, cgid_len,
 					     pdu_data, pdu_len);
 	return relay_blktrace_event1(bt, sequence, pid, cpu, sector, bytes,
-				     lower_32_bits(what), error, cgid, cgid_len,
-				     pdu_data, pdu_len);
+				     what, error, cgid, cgid_len, pdu_data,
+				     pdu_len);
 }
 
 /*
@@ -342,10 +342,32 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	case REQ_OP_FLUSH:
 		what |= BLK_TC_ACT(BLK_TC_FLUSH);
 		break;
+	case REQ_OP_ZONE_APPEND:
+		what |= BLK_TC_ACT(BLK_TC_ZONE_APPEND);
+		break;
+	case REQ_OP_ZONE_RESET:
+		what |= BLK_TC_ACT(BLK_TC_ZONE_RESET);
+		break;
+	case REQ_OP_ZONE_RESET_ALL:
+		what |= BLK_TC_ACT(BLK_TC_ZONE_RESET_ALL);
+		break;
+	case REQ_OP_ZONE_FINISH:
+		what |= BLK_TC_ACT(BLK_TC_ZONE_FINISH);
+		break;
+	case REQ_OP_ZONE_OPEN:
+		what |= BLK_TC_ACT(BLK_TC_ZONE_OPEN);
+		break;
+	case REQ_OP_ZONE_CLOSE:
+		what |= BLK_TC_ACT(BLK_TC_ZONE_CLOSE);
+		break;
 	default:
 		break;
 	}
 
+	if (WARN_ON_ONCE(bt->version == 1 &&
+		     (what >> BLK_TC_SHIFT) > BLK_TC_END_V1))
+		return;
+
 	if (cgid)
 		what |= __BLK_TA_CGROUP;
 
@@ -386,8 +408,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	sequence = per_cpu_ptr(bt->sequence, cpu);
 	(*sequence)++;
 	relay_blktrace_event(bt, *sequence, pid, cpu, sector, bytes,
-			     lower_32_bits(what), error, cgid, cgid_len,
-			     pdu_data, pdu_len);
+			     what, error, cgid, cgid_len, pdu_data, pdu_len);
 	local_irq_restore(flags);
 }
 
-- 
2.51.0

