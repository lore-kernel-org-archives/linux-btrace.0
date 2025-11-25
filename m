Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EE72D5C95;
	Tue, 25 Nov 2025 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055668; cv=none; b=dYD39T20RQCK3+UHQPlaXUgHcy+XBSnOhSTjZd3uRXdxIZ21j1WR107CuKs8p8LAZIa9yqH66egANwrYTc/dGoH7TTWU11bzWayatynSnPtm47owqy9G5G/cMyD1rLhTR44zPDmIyFsp/H8QQe4Scand9q5EDLfWNnMVu4rq3p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055668; c=relaxed/simple;
	bh=1fpsUTq6wS+69n/GhYTAUNkyfMfZLj5j/5qqrqyUNfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKeCGJYS77eQHRDsV9cVxZHZTiuztopwF6EBEJ1b5r3Wtyf9qvIF+vrnmZKJ6AGemAVtTFa0QFq0y1iCnm6lSYKXLtrDo/263Udt9iljIVdebJA0HpgC2pZcXlsikx0bt8keJYQfd+NmGp03iFC+WXiTdoaTnKD38mgoJ9t4DbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Y8ntnAot; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y8ntnAot"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764055666; x=1795591666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1fpsUTq6wS+69n/GhYTAUNkyfMfZLj5j/5qqrqyUNfo=;
  b=Y8ntnAotM3AKgfNqsjuVzAH9QX6SefOymi/kymV8mlhKmlh02QE8stU4
   1z30w/0t1u1HVFUHcRJhh3+QTLODe5tB68iKtwYy2q31yqMEbU0RIh0Sr
   Hm7OZKln7cu0fow+ju1ON4Hqe+IsK7AyXa9iQausF+BuPzycishZg3r+L
   iRxO+0QbvyOs/vCYuk9KC03eyqBm7VUPs7WKYQrys5LylIwJgms0eYMni
   Vx9z1rU4QzMFNTP69QO40En+xen5CeIxc79Ku43IVcGYp3xkWps1nVz6h
   o8s9CPS3a0fb9hWGDNQLqbDq8YQvvO7p0mjmhmnJFZJ21ANKwCml2e1Ir
   Q==;
X-CSE-ConnectionGUID: 9vl41+pESbSt7NbIWog9NA==
X-CSE-MsgGUID: W7CS4hmzTyet2ivu6PXN/A==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135337514"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:27:46 +0800
IronPort-SDR: 69255a72_+bawBuUgoIGi6HtMAi2d0TieY2V6AbF/I4lhw1DNl4kFvL8
 5rhJuCDsSxzqdo7naMf6PX5HSPSidAWkK+YgO8A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:27:47 -0800
WDCIronportException: Internal
Received: from ft4m3x2.ad.shared (HELO neo.wdc.com) ([10.224.28.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2025 23:27:43 -0800
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
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 03/20] blktrace: add definitions for BLKTRACESETUP2
Date: Tue, 25 Nov 2025 08:27:13 +0100
Message-ID: <20251125072730.39196-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125072730.39196-1-johannes.thumshirn@wdc.com>
References: <20251125072730.39196-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add definitions for a new BLKTRACESETUP2 ioctl(2).

This new ioctl(2) will request a new, updated structure layout from the
kernel which enhances the storage size of the 'action' field in order to
store additional tracepoints.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blktrace_api.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/blktrace_api.h b/blktrace_api.h
index 172b4c2..ecffe6e 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -139,9 +139,25 @@ struct blk_user_trace_setup {
 	__u32 pid;
 };
 
+/*
+ * User setup structure passed with BLKTRACESETUP2
+ */
+struct blk_user_trace_setup2 {
+	char name[64];			/* output */
+	__u64 act_mask;			/* input */
+	__u32 buf_size;			/* input */
+	__u32 buf_nr;			/* input */
+	__u64 start_lba;
+	__u64 end_lba;
+	__u32 pid;
+	__u32 flags;			/* currently unused */
+	__u64 reserved[11];
+};
+
 #define BLKTRACESETUP _IOWR(0x12,115,struct blk_user_trace_setup)
 #define BLKTRACESTART _IO(0x12,116)
 #define BLKTRACESTOP _IO(0x12,117)
 #define BLKTRACETEARDOWN _IO(0x12,118)
+#define BLKTRACESETUP2 _IOWR(0x12, 142, struct blk_user_trace_setup2)
 
 #endif
-- 
2.51.1

