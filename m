Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5EF32255D;
	Tue,  9 Sep 2025 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416074; cv=none; b=iL+pj2eC3TDfrR5ew6jikV93JVWe3Qm6C6x5ctrY3Gr6vz/lVnw0w0vm9MWcqufdIp3CsLnhirc26dzx40a2RlmD9HqQGXCQRHdpt2JqMROm7Iqxd0WYf2SRRvHoWwp8rwZ5ndtp9vhy6h3+tBoJOaDXnnKYhz5CvY2GLWr+hEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416074; c=relaxed/simple;
	bh=2SBoig+2av9xZLZVm0aXbXBPvQ0ssmJIyDrkle9d9eA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bRwY1GJ/OQClJYx8nrig5yRfueQZcGMCCWvElja+MRFUj5OQD2wxp/ZoixPZEo3UB1SptVCD2dEGAovNaXAaa9svZju6QMisjxlBMO1/nZV4rw7psF8ctkj7lvPBBih9bzUzWg94DmSyYCalZQZU6eaRBIbuvB758OJpSioU+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jy57nhm8; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jy57nhm8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416073; x=1788952073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2SBoig+2av9xZLZVm0aXbXBPvQ0ssmJIyDrkle9d9eA=;
  b=jy57nhm8Ooy8saFgQGLqQ77jL1O5Mahaqr1cFpT7IyYBXRaq0Y14GtWt
   nARGCr2PqXOYz0FNHZ9oOCdrOUaHeMbit7gILxLHGcOXBqucItMTxU+l3
   pUYBNg26fcp/LUIqyakwT0zzPHGD27ZSzgs3EZOGy0P/XcVM0oKLH78s3
   Cjo0AHeeeKKmSDcFn/5lKH3VtaKABH3JgcDLUqbwdiuaBF81On60OZLvd
   a9ObGXaLK2T5u+RONAa/i24j01mgHVwqHPH6BkTXWiISII+3wCH+POnh9
   IUEVJDj06U7yxuNnsbYKZAcwAPUbcEeue2v97GKOJgHZziiBzZJPAu5dd
   w==;
X-CSE-ConnectionGUID: WWVSvsa2TsarXsK4ml2YqQ==
X-CSE-MsgGUID: qF/yOp6qRsCWmU4NL4V0lg==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810609"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:07:52 +0800
IronPort-SDR: 68c00a88_3yIQ/waE35wr5Lckq635YIfUTfh3BmtrfHh1AtqFxhcJddp
 Vw+VR6HREtKYaAkrGAeNDRs4hNV2h7CLZBlemWw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:07:53 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:07:48 -0700
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
Subject: [PATCH 05/21] blktrace: add definitions for blk_io_trace2
Date: Tue,  9 Sep 2025 13:07:07 +0200
Message-Id: <20250909110723.75676-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
References: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
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

