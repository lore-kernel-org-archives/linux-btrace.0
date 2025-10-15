Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8F320A37;
	Wed, 15 Oct 2025 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525753; cv=none; b=U+Iu8UBtmJeCJ41+UrF/JYxnQGMtckQisKGUU0SwjmlSr1zYvQH26ImIVwqm1MIh53L8mUxHWrGRAMFAYgfLQZS0VDvPVMhDiqDs1h401aZAmwm1QdMhrbt+EqXZa2KeGqknepGApL0a3L59AS/AFZZ42D1Ig8UYjmXbBXiwy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525753; c=relaxed/simple;
	bh=XayDPDgP2j7sxCnVhJGQo1K9aBcXHLJPZ/nBiAwCbaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNbQriu68iUtpdf/HkkMX9+LCGbzkGdODX9UE/d0VhEIKzPV5FJ3lV3hrZZrcMrZeq70dob6ApDJWKaZPvyGe7E2sF3BhNN4Lzk1hc6qXal1mVSbTLz1P4ctD/VBqzpwvJblF55LoG6Umx840e7oRpyRi/ISmGALDzwSZsmfj2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CLGzisVr; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CLGzisVr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525751; x=1792061751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XayDPDgP2j7sxCnVhJGQo1K9aBcXHLJPZ/nBiAwCbaw=;
  b=CLGzisVrN10ypJGlGbPaevb6bXMI2Drrf1sdmhYF8T6tmStmLLkCxmdN
   6zvvWQakTO67R3U2GD1A7EuZNKW2cfWsFA9mV33qLFni6rW3CQtgvhFqK
   0l8Hy4mZZt2EO7Lzyh7BE3yB0qXfkUpHntwPcbFLUXSlD6BmQKz200vsQ
   PTLHmQ/h7AeMqHO1T3u0J1jOkfqHSJ21kODLxNTqcZ4fDqRcsApt4J60s
   M1V0CqiO74nxMq/4ICt669SDk8tDZ94l8SoR0C37CyrpZCeShdtn0A4S6
   Fh85he3OYVUqZPnfRSEvxOTue86AxOwOUSIOTEQHAIR4afo+gScPD6tdO
   g==;
X-CSE-ConnectionGUID: twbPeJ7kRMuOMbUQF//yrg==
X-CSE-MsgGUID: 3eWpgvZDQ+2wZmqdTJeF+w==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="133262109"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:55:50 +0800
IronPort-SDR: 68ef7db7_xJT4XDL+7WSp8KCxzkVGNXfqZZ1uEIaoYLZvGiX0H/l2bee
 0h7iRz8FAHj38N5c5WOg1tA1bBpeG3wEhtvfZ2Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:55:51 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:55:47 -0700
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
Subject: [PATCH v3 13/16] blktrace: add block trace commands for zone operations
Date: Wed, 15 Oct 2025 12:54:32 +0200
Message-ID: <20251015105435.527088-14-johannes.thumshirn@wdc.com>
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

Add block trace commands for zone operations.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 13 +++++++++++--
 kernel/trace/blktrace.c           | 25 +++++++++++++++++++++----
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 3a771b9802aa..925f78af939e 100644
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
index 8ffb218e9fb7..90b225c5bad7 100644
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
@@ -342,6 +342,24 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
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
@@ -386,8 +404,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
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

