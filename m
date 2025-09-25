Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6832E3B19;
	Thu, 25 Sep 2025 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812610; cv=none; b=hiVoK3GCYpBa0ARgI9npmbnJ4pf89Rn9yd1Paz1rMBuzQjgoiIpGMDoVZK/vheI4dxoEg56ymJw0uQfypOz9kWPgtT7Z1ekX7HC/fQB2PQAObtweNa2ixVBc3kHqA0IQ3xdGqO2H6ylZzXHuEDJVHRnYkapsAJLgKTnVIVhp75I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812610; c=relaxed/simple;
	bh=d7n7oF1Kd4gbEuXmUbGSa8j7M683G8VRzDhX9N0qsMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/6g8GmEfFc1nxzIVog4qM6+6lHxKWiqQRbxIKPkrRv7Ay5/Q5Gyx/IW/M9j46hKhiFmpyl0+Tq7iEBfGXnpzbQ9iikPpMRdEcVquJ8U9lz261doVtjtOQUDSBbHhXZXUJ6wkRk5K1wNfwzfHvi7nNJdmPsDNWOCwEqBS1k3q1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=M4YdLzZi; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M4YdLzZi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812609; x=1790348609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d7n7oF1Kd4gbEuXmUbGSa8j7M683G8VRzDhX9N0qsMs=;
  b=M4YdLzZiksPW+BrR4y2TmV9zB9uh84yD2UP+/yG1EC7nypkOdTb2HX0B
   hZIkfY3iRHn2fp585ahoyxTzDGPO98rPQk+k8OsskS7fnFs+oGtQvHdhI
   e/iDUmENPSDAxDe28+kxzQgdEgSZ+60T5xVSaGtR73s27b+VWWeUjz+LI
   07x536OMNAhAJgqBCHYAhZuTMyWqO4xf49+h/K/ORrcntgGZxbUVGVfEp
   Dvo13OctsLVWYCHjn/WTDmiWUfEwCyPjr7R74i3JI/xY0UkEqso524cku
   wWvMfbZBce8JH1EhAZ2Ke40FLN1h+Ij6BNudPGqUnih4IcRUOkwqabQrK
   w==;
X-CSE-ConnectionGUID: 0Pv9NeltQm26CxKMHZtWBQ==
X-CSE-MsgGUID: vTbHWCEVRwarKmbbObxlrw==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130348047"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:03:22 +0800
IronPort-SDR: 68d559ba_MY2pMEhZL9l01G9IcKkxcp4nuF2jTFIPRuEzsRxlnV7zF6V
 0zn1SRZTKhULeBFUQv6v9BfVPBwhPi8w63YF1aQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:03:22 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:03:19 -0700
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
Subject: [PATCH v2 11/15] blktrace: add block trace commands for zone operations
Date: Thu, 25 Sep 2025 17:02:27 +0200
Message-ID: <20250925150231.67342-12-johannes.thumshirn@wdc.com>
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

Add block trace commands for zone operations. These are added as a
separate set of 'block trace commands' shifted by 32bit so that they do
not interfere with the old 16bit wide trace command field in 'struct
blk_io_trace' action.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 13 ++++++++++++-
 kernel/trace/blktrace.c           | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index d58ef484de49..0f336140ce4e 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -26,11 +26,22 @@ enum blktrace_cat {
 	BLK_TC_DRV_DATA	= 1 << 14,	/* binary per-driver data */
 	BLK_TC_FUA	= 1 << 15,	/* fua requests */
 
-	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
+	BLK_TC_END_V1	= 1 << 15,	/* we've run out of bits! */
+
+	BLK_TC_ZONE_APPEND	= 1 << 16ull,  	/* zone append */
+	BLK_TC_ZONE_RESET	= 1 << 17ull,	/* zone reset */
+	BLK_TC_ZONE_RESET_ALL	= 1 << 18ull,	/* zone reset all */
+	BLK_TC_ZONE_FINISH	= 1 << 19ull,	/* zone finish */
+	BLK_TC_ZONE_OPEN	= 1 << 20ull,	/* zone open */
+	BLK_TC_ZONE_CLOSE	= 1 << 21ull,	/* zone close */
+
+	BLK_TC_END_V2		= 1 << 21ull,
 };
 
 #define BLK_TC_SHIFT		(16)
 #define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)
+#define BLK_TC_SHIFT2		(32)
+#define BLK_TC_ACT2(act)	((u64)(act) << BLK_TC_SHIFT2)
 
 /*
  * Basic trace actions
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 82ad626d6202..62f6cfcee4f6 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -333,6 +333,24 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	case REQ_OP_FLUSH:
 		what |= BLK_TC_ACT(BLK_TC_FLUSH);
 		break;
+	case REQ_OP_ZONE_APPEND:
+		what |= BLK_TC_ACT2(BLK_TC_ZONE_APPEND);
+		break;
+	case REQ_OP_ZONE_RESET:
+		what |= BLK_TC_ACT2(BLK_TC_ZONE_RESET);
+		break;
+	case REQ_OP_ZONE_RESET_ALL:
+		what |= BLK_TC_ACT2(BLK_TC_ZONE_RESET_ALL);
+		break;
+	case REQ_OP_ZONE_FINISH:
+		what |= BLK_TC_ACT2(BLK_TC_ZONE_FINISH);
+		break;
+	case REQ_OP_ZONE_OPEN:
+		what |= BLK_TC_ACT2(BLK_TC_ZONE_OPEN);
+		break;
+	case REQ_OP_ZONE_CLOSE:
+		what |= BLK_TC_ACT2(BLK_TC_ZONE_CLOSE);
+		break;
 	default:
 		break;
 	}
-- 
2.51.0

