Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA30E2E8882;
	Mon, 24 Nov 2025 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969886; cv=none; b=TD6XeXxzx3K+YSUADJAH0lpRVcIzw+BLuOfVgIevQKtDnFGeZOKf9A1ua4TM9ajATyAS+hEPTSZ3I5NgeYnJraBrg/HJoXMomKHeTJyGJuxVtJbu1jUyOl2E2W01pDFFZnNjOxQbQgoXGUoGWrSkHEBCITN36dcoT4vEL9Wigxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969886; c=relaxed/simple;
	bh=OHO0PZMEV04mH6ZwDWXnqB/zzMaDZanQ5BQfINKFFrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgpYDIRzxVtiCwPk2csJfsZBDE65/XxgO8yBZWtAPl8dXPT4JQ+sGqxHCZK1Beuc6Zm14iGTZvv2Mcd15BrdeApNgIRKJMk/dr7e6RrHF8LhOgQ8pZb/B8bkiGqjUXJmEWXKiv7nGB4KJKaviyvbClpPDaMmHl8vyfm/7P1x45w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FamWuWnZ; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FamWuWnZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969885; x=1795505885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OHO0PZMEV04mH6ZwDWXnqB/zzMaDZanQ5BQfINKFFrw=;
  b=FamWuWnZTUrkGqjU/044m+97UKcN5fQjTGVPId/e0YbrV9IF3FlqYSJJ
   h85TBJ/eU7neRWr5tS33k3pGwHYcFvdhGoqlyXUpHG4klmqGoREC9eFJk
   0zjJqLj6CcnRFB/iAchAZQGtSGpkloXbTH5G/69FzA3Tb9vMgg2EG5VHW
   IiF+LsabBLomaEy4g2609qkftuIWgvkMJii64QW7gI4uur/Pz0pdnAZAA
   262NoWCQ6k83gsDEhCk5o7K+pFmigFcNVU9wbsUp5XtC9PAtO68Qyfjbv
   dkZr8Pzgp/istWok8V1xCg+3+N5jFRsJ2u8zHu1kbhTa+qiiTQ/c2X+s1
   A==;
X-CSE-ConnectionGUID: R4PfK004Thid/jSavUorzQ==
X-CSE-MsgGUID: muEkCZaVQoif6rDFYcc51A==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619342"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:38:04 +0800
IronPort-SDR: 69240b5c_ehy2CzpRpG9LV301e969KzTRc3TStJb3z+dFPtxmZUdCbLt
 4FgbmL8Ec2E6E+6oQYz1SeLgorFtI3Ta3AMH6hA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:38:05 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:38:01 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RESEND PATCH blktrace v3 05/20] blktrace: add definitions for blk_io_trace2
Date: Mon, 24 Nov 2025 08:37:24 +0100
Message-ID: <20251124073739.513212-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'struct blk_io_trace2' which represents the extended version of the
blktrace protocol.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blktrace_api.h | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/blktrace_api.h b/blktrace_api.h
index ecffe6e..04e81de 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -24,11 +24,20 @@ enum {
 	BLK_TC_DRV_DATA	= 1 << 14,	/* binary driver data */
 	BLK_TC_FUA	= 1 << 15,	/* fua requests */
 
-	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
+	BLK_TC_END_V1	= 1 << 15,	/* we've run out of bits! */
+
+	BLK_TC_ZONE_APPEND      = 1ull << 16,   /* zone append */
+        BLK_TC_ZONE_RESET       = 1ull << 17,   /* zone reset */
+        BLK_TC_ZONE_RESET_ALL   = 1ull << 18,   /* zone reset all */
+        BLK_TC_ZONE_FINISH      = 1ull << 19,   /* zone finish */
+        BLK_TC_ZONE_OPEN        = 1ull << 20,   /* zone open */
+        BLK_TC_ZONE_CLOSE       = 1ull << 21,   /* zone close */
+
+        BLK_TC_END_V2           = 1ull << 21,
 };
 
 #define BLK_TC_SHIFT		(16)
-#define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)
+#define BLK_TC_ACT(act)        ((__u64)(act) << BLK_TC_SHIFT)
 
 /*
  * Basic trace actions
@@ -51,6 +60,7 @@ enum {
 	__BLK_TA_REMAP,			/* bio was remapped */
 	__BLK_TA_ABORT,			/* request aborted */
 	__BLK_TA_DRV_DATA,		/* binary driver data */
+	__BLK_TA_ZONE_MGMT,		/* zone management command was issued */
 	__BLK_TA_CGROUP = 1 << 8,
 };
 
@@ -85,12 +95,20 @@ enum blktrace_notify {
 #define BLK_TA_ABORT		(__BLK_TA_ABORT | BLK_TC_ACT(BLK_TC_QUEUE))
 #define BLK_TA_DRV_DATA		(__BLK_TA_DRV_DATA | BLK_TC_ACT(BLK_TC_DRV_DATA))
 
+#define BLK_TA_ZONE_APPEND      (__BLK_TA_COMPLETE |\
+				 BLK_TC_ACT2(BLK_TC_ZONE_APPEND))
+#define BLK_TA_ZONE_MGMT        __BLK_TA_ZONE_MGMT
+#define BLK_TA_ZONE_PLUG        (__BLK_TA_ZONE_PLUG | BLK_TC_ACT(BLK_TC_QUEUE))
+#define BLK_TA_ZONE_UNPLUG      (__BLK_TA_ZONE_UNPLUG |\
+				 BLK_TC_ACT(BLK_TC_QUEUE))
+
 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))
 
 #define BLK_IO_TRACE_MAGIC	0x65617400
 #define BLK_IO_TRACE_VERSION	0x07
+#define BLK_IO_TRACE2_VERSION	0x08
 
 /*
  * The trace itself
@@ -118,6 +136,22 @@ struct blk_io_trace_remap {
 	__u64 sector_from;
 };
 
+struct blk_io_trace2 {
+	__u32 magic;            /* MAGIC << 8 | BLK_IO_TRACE2_VERSION */
+	__u32 sequence;         /* event number */
+	__u64 time;             /* in nanoseconds */
+	__u64 sector;           /* disk offset */
+	__u32 bytes;            /* transfer length */
+	__u32 pid;              /* who did it */
+	__u64 action;           /* what happened */
+	__u32 device;           /* device number */
+	__u32 cpu;              /* on what cpu did it happen */
+	__u16 error;            /* completion error */
+	__u16 pdu_len;          /* length of data after this trace */
+	__u8 pad[12];
+	/* cgroup id will be stored here if exists */
+};
+
 /*
  * Payload with originating cgroup info
  */
-- 
2.51.0

