Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC802D7813;
	Tue, 25 Nov 2025 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057139; cv=none; b=HIpYD24ebqa1y3i3b4g51lohBUFFCzHboL0hDPYnSkxqfefK1fpGGi70KVkXwfpULMMrhp3Je0vu56/mmqcfFGyEuHJFHBbWamhtXolz2FvRPpmfnU7ShvVA4+mHsDzuZlzzoVr5ml8+2JvJsQ332GJ0OnbZ4EyXAbNKKWrqKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057139; c=relaxed/simple;
	bh=6ciFPCT9OFL/mupgPfnetxUX1J52Y/KZ8Q9RWgSdDow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diHCQ+tnlyOCFR9aNaF+2w59oUGgzf0Ed7MEnvFb4L8EeLP0rFHFPr5hn7c2TmuMdm+xW2feQDJj616CwkUWF+cMyU/q9H6iEdx9IG1FTZD0a4T73o291W1BKXRheocEbEac5VOam6CqierTXB0noMlN7nUra7RSBzLldb/dD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cnzLQJZH; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cnzLQJZH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057138; x=1795593138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ciFPCT9OFL/mupgPfnetxUX1J52Y/KZ8Q9RWgSdDow=;
  b=cnzLQJZH75RrB4ZUXgpuGps4PynJGhWK9+bvvWJrywqfD6+Z0idrzkew
   n8Z4FgUJOuTjn3Tbc/ACNH6+oxaGyJAUunY+VTF2I/sUDPRSsFx72j68A
   qRDxox1Y8kxRUft02oBBQrjfesIwASWqroXKL9I+8M69tzD5j7jc6bfmU
   e75+0rZTbQ2WJYHpGm6twTCbFAz6BPYOrJPMmSn504nNIrJpR7jYPr8gd
   +xR/Xg2H2rcYZlcphuMHhtJIGwHz7SSgf4fu1WzymV2Hlt7vnhwm80JDJ
   NhJZGoGZXQVKQxKx4yRmsD9gsTwKm+eQqfRvJSyKxu/lZUPqfpLPlN9E/
   Q==;
X-CSE-ConnectionGUID: 4uQ5GMTtS+ag9GDkQz9iGQ==
X-CSE-MsgGUID: zkF65aJZT8ecC766cFF6sg==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749790"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:17 +0800
IronPort-SDR: 69256031_1GiZpUf1aFZDowAHgJHud0lN+W0k/+65wwR9tO9nXQjiXm2
 oBYMaN3cT+j9b/Bjb23ODwKNM4/n6Fg/RbABB/g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:17 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:17 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-block@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 05/20] blktrace: add definitions for blk_io_trace2
Date: Mon, 24 Nov 2025 23:51:51 -0800
Message-ID: <20251125075206.876902-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
References: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'struct blk_io_trace2' which represents the extended version of the
blktrace protocol.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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
2.51.1

