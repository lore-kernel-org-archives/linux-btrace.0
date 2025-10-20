Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF27328B7B;
	Mon, 20 Oct 2025 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967749; cv=none; b=gCXEODx9rN1YYYbge9pmdofL43Wx3amvICfz1negTRMXvTlztDM9SQp2MWjk5elbm3B9e5TZCmwZYwGHFWdVaZH0jvaYG27VIVw532IGAqlqulO0Bcg3K+yAYuu2TwaXX+aKEJZ9DwIw9yPbr4/kLvr7HGhIk3xoJTlIzNJcPIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967749; c=relaxed/simple;
	bh=4Vc1bqhgksAhocQcTB57MIcEHnq1YQ2loxnl4lmFJ8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAZXjKYmYNrz/dtTdBe8FHUCItXgeVH/g9hlM/RGVQfXLMy9uYKXa9iwflODEZM/dtWtlG6M2AUAL3sjEzDYdpW1pZKxyAVB7v8Y4Jb/ZbDKCBN09aSN0pJXt2j3ximFFozfY6Xo5zKCPQoM+A0kOg9cvTJW2s3/LFLEFH6ioZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=p65y8kcE; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p65y8kcE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760967749; x=1792503749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Vc1bqhgksAhocQcTB57MIcEHnq1YQ2loxnl4lmFJ8w=;
  b=p65y8kcEBZdIkKAuSsyS7QVPXEuj/aAqAnC2T9A7KJ1zrBY+httd/8rF
   FsbpbxU0DcwqKKcB+Mm8x5LIJ5eSIXWeL7nYLsWAOs4tilGTwYCwBkr7Z
   KplW0lzfzrND6dMObPcvg6LFAPV2TkDRneK9TRfiHhAQiAvnyilhILDHV
   q8ekemslMVuy3D/r+lE3SwGZLN2T+vjrpChtXkIAWQzALRoXGp7IV5ZLV
   Nt5eJdEnlcqDXHVeX1fAiQij8QYjMTMLQKMWh2Cb1O0X7mXyWvBjmyKjE
   zP+31/LUHiwMKyKOKeyubYP+Yl3e9f36vR/oLLlKP3gvT4ErOHi1Neh1f
   A==;
X-CSE-ConnectionGUID: Hg11s+NgRMS49x85/gX4Lg==
X-CSE-MsgGUID: Kw3W6No8TUa5xD9hlwbqrA==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134518672"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 21:42:28 +0800
IronPort-SDR: 68f63c44_H9yFNYC5hvEFdW4d9qvUU4MiYWFwnw1aq3m/s9RbSvMwe9b
 dxaot4t8laAKNtpZIqS4DXo05ad++YgvX9hvurA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2025 06:42:28 -0700
WDCIronportException: Internal
Received: from 1pgdl13.ad.shared (HELO neo.fritz.box) ([10.224.28.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Oct 2025 06:42:24 -0700
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
Subject: [PATCH v4 13/16] blktrace: add block trace commands for zone operations
Date: Mon, 20 Oct 2025 15:41:20 +0200
Message-ID: <20251020134123.119058-14-johannes.thumshirn@wdc.com>
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

Add block trace commands for zone operations. These commands can only be
handled with version 2 of the blktrace protocol. For version 1, warn if a
command that does not fit into the 16 bits reserved for the command in
this version is passed in.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 13 +++++++++++--
 kernel/trace/blktrace.c           | 28 ++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 6 deletions(-)

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
index 8ffb218e9fb7..e8effb6cb393 100644
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
@@ -342,10 +342,31 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
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
 
+	WARN_ON_ONCE(bt->version == 1 &&
+		     (what >> BLK_TC_SHIFT) > BLK_TC_END_V1);
+
 	if (cgid)
 		what |= __BLK_TA_CGROUP;
 
@@ -386,8 +407,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
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

