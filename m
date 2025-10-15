Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74031320CBB;
	Wed, 15 Oct 2025 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525851; cv=none; b=NA1mw5BE5QRBbES8mDLdR/GGnG7qOc4Pxf+nygivqBSuosrWlkl/9hQAYnXUzCoroSjEYcY9eCOPOWrjoZpV0zlgycv5RbN4GB8Q9187avqZ/11GdH2j8t2U4+kTjXlh8x7khEynncfC9fFg1p6b9CkWBpixsDStCuo3RvUjqRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525851; c=relaxed/simple;
	bh=OHO0PZMEV04mH6ZwDWXnqB/zzMaDZanQ5BQfINKFFrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rb3GDokUZcBwLsaWRkh7VJsi4sfpEk9Dbop5LRD6gSF4RHKQ+97DTLDHl1M2H+AXVRbOCJKgjj6QeMG4YekcAQijcHBk2Oyixm8TLKNAxtWJJEnkAbY2zmgKTUNTTJm7M2pwUMG9pinYaeb5x7CH3XGsyFVD53OhwFaMPgb9ry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cECXZoSh; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cECXZoSh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525849; x=1792061849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OHO0PZMEV04mH6ZwDWXnqB/zzMaDZanQ5BQfINKFFrw=;
  b=cECXZoShD757+v30mdHXnn1snbdiY7AedvnWDfsx2EY791UXck00Qa5Y
   Ot6DQ8X4tjVQI85f8JveRbyQNVBaoy+l9Uz/7KGV3UExX9mbO8Y6gtayc
   di1jFszBMCC6/OWEnYYF054cCa5p8+441jMm0A4zoybeRAfdDtKPRFRzK
   0nuL1gSYJNQVYhZb5IH5q82C65pE+nBHhSMj+5wjpuHi7dxJMuVv8pKKm
   r4e/v3DDtYAQq0uSSnjPZqm7ms9gE24cL6SQ/2RabvrJkgjqnuPTL6UfI
   8FvLSD8Dvi7XnRa5p8O0kSarMeND/1JAfUFgxa/8a7wzGO0te0700n+an
   A==;
X-CSE-ConnectionGUID: Z76akLheTECycvdMVvu3IA==
X-CSE-MsgGUID: jchyrtcwTCud9mcEM0S70w==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935363"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:57:29 +0800
IronPort-SDR: 68ef7e19_2+R0Xl99d8zGDdDPs8OVeT50SnDQCnfLWZPCEHKY61zbF35
 emjIxU9P3ftWYDfzqipVsqtarls/BALvhv1Oobw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:57:29 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:57:25 -0700
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
Subject: [PATCH blktrace v3 05/20] blktrace: add definitions for blk_io_trace2
Date: Wed, 15 Oct 2025 12:56:43 +0200
Message-ID: <20251015105658.527262-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
References: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
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

