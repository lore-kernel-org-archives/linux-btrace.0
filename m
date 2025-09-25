Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870931159C;
	Thu, 25 Sep 2025 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812697; cv=none; b=CzKBCApdtkwfNL+aEZr0iD3Ve7kjRxzQgpVY9e+E9YdTmw8KAbDTk92Qz6hwGrW3R22wYdx0ZIFNdUDoWZbw5cET1WzaJZQqQmTwxh5dwfWGkLpawPyUaq/wfQH82TYgkW/o66touLTAQTKcigk3WVtazwnMYLjVyO1rXB6dO9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812697; c=relaxed/simple;
	bh=2SBoig+2av9xZLZVm0aXbXBPvQ0ssmJIyDrkle9d9eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4+9u5RxsSUfXV3QcRGuOlKbolGAzo6etwOv0/vu7ZDxr/zy1ssgv4S4ir05pNqnh0u78Uv3zJZur7zpxaFDwnU3EVD0iVBRNhaY3ClLlWb5zxbuVVdctDanz6iHo2kQc6tG/WNhW6iYGWu4XpkrwE1u9jeRqNVFtE1qJvdCRCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=j7mv42si; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j7mv42si"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812695; x=1790348695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2SBoig+2av9xZLZVm0aXbXBPvQ0ssmJIyDrkle9d9eA=;
  b=j7mv42si6cm8P8ypBzK6QECFVjPRDk4jaj6yr2pomB9Fit7b9WfYPSca
   PuBCwP7Q62Q81gf3KpLxCBAKAgZ8LPhsGWyqcZ6u8WxzEomHLl5M7xhwe
   7InBqnsvztuaUYsjF54ydo4HC/dozQIsLSuMtiOD/9V+8Z0nmxS2HA7k7
   XlIOXH9MgzzIduoaOTnK7Ry708HoNdTrZ3HBRLxwCBtmwVSdCTaEjUd0E
   PC7sZBAgHKfGAmRj4EX07xH7Z75hpjIYPtByUt8/XHY+yFrVeneoGzWCE
   xE1YyG1Bn1MpknB7Z0JQ0afyVXC56npkNyRQgcCJ67InH1JHasPUEKAy+
   w==;
X-CSE-ConnectionGUID: DaaShNV6QG+NjzP2aqM+nA==
X-CSE-MsgGUID: pdkHUg/xSfq8pOnErtn2OQ==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130348843"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:04:55 +0800
IronPort-SDR: 68d55a17_rObRgyxLzQel/zhRBfiyB+kWeXhKbc17NjGFb7o221PUO9L
 1aAoN94ex7EALreRQRyQ6lAvJQRFrPFWtrQTJLA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:04:55 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:04:52 -0700
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
Subject: [PATCH blktrace v2 05/22] blktrace: add definitions for blk_io_trace2
Date: Thu, 25 Sep 2025 17:04:10 +0200
Message-ID: <20250925150427.67394-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
References: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
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
 blktrace_api.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/blktrace_api.h b/blktrace_api.h
index 9f435a5..bbf075f 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -27,8 +27,19 @@ enum {
 	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
 };
 
+enum blktrace_cat2 {
+	BLK_TC_ZONE_APPEND      = 1 << 1ull,    /* zone append */
+	BLK_TC_ZONE_RESET       = 1 << 2ull,    /* zone reset */
+	BLK_TC_ZONE_RESET_ALL   = 1 << 3ull,    /* zone reset all */
+	BLK_TC_ZONE_FINISH      = 1 << 4ull,    /* zone finish */
+	BLK_TC_ZONE_OPEN        = 1 << 5ull,    /* zone open */
+	BLK_TC_ZONE_CLOSE       = 1 << 6ull,    /* zone close */
+};
+
 #define BLK_TC_SHIFT		(16)
 #define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)
+#define BLK_TC_SHIFT2           (32)
+#define BLK_TC_ACT2(act)        ((__u64)(act) << BLK_TC_SHIFT2)
 
 /*
  * Basic trace actions
@@ -51,6 +62,7 @@ enum {
 	__BLK_TA_REMAP,			/* bio was remapped */
 	__BLK_TA_ABORT,			/* request aborted */
 	__BLK_TA_DRV_DATA,		/* binary driver data */
+	__BLK_TA_ZONE_MGMT,		/* zone management command was issued */
 	__BLK_TA_CGROUP = 1 << 8,
 };
 
@@ -85,12 +97,20 @@ enum blktrace_notify {
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
@@ -118,6 +138,21 @@ struct blk_io_trace_remap {
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
+	/* cgroup id will be stored here if exists */
+};
+
 /*
  * Payload with originating cgroup info
  */
-- 
2.51.0

