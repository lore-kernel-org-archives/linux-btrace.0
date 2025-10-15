Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58447322774;
	Wed, 15 Oct 2025 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525883; cv=none; b=txxpf3JyaviGCeSKny4viu1xw/WKmfe66BySXAVNsPSYi2wcp8t8KOLN4b5cUAWzsQ4kGi7Bkw0KfgBNuogq+EeKwtPCzDzh0TRCq2HyDd7X1dRuXp4UDtM5lkOisN1Zj8aMmMv8AteIGaP66/RfIqWIAgxIxzquQvPKmARJFok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525883; c=relaxed/simple;
	bh=7x/8BV1VwYtiCopSTQrOJDK3TC6H2EX5xtil7lp16lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbP6IyD6az28xaezstqewKvRDlXT1lJPi5YJZeYdoPQTIoW8LANhMgrvwOSkiYDBgY/L5Ht/uVTppqs5q3FPXzIiiyCSMB6h3TX45p2kROQRB3Y/kMxK6vn0wwxP9iED9/YTRcHOpX9iKi7Cyf6O/Jmt4G9ihmLPo62TVdl7PNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VL8jmlnP; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VL8jmlnP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525881; x=1792061881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7x/8BV1VwYtiCopSTQrOJDK3TC6H2EX5xtil7lp16lM=;
  b=VL8jmlnPImbdg646g/dTkP/b1hHlJ8Q2q0RMlIcLed6ZRdwMcew78PlM
   FfSydZFfYtKK6TajD3KzXBfuSQTl9XvYv6tTFqoHmE/BcuuFMRNy9iPzw
   V88nTxweYRBIeC/qptY/Q5odUSzw6dhQtUSXAPEI3+6eu1Aj5WOWVv1ys
   Hx76Lx5T2M8Fo1TGxy+2X3f9bTtM7xUfbNLPzC/rnmxv+DzfM+SY8JKGt
   tVooL3S+4bXVbdMMx1HL1yPFgXqLO6qTVGEoNjBffyhxzv7X5bwa99Nfz
   62yNb0zJnI1E6Xf932exQnQYnyOl5Asv+KEI9xOWxisMnzhtkF8iJpf4R
   g==;
X-CSE-ConnectionGUID: GwP5OmXlQim38rQjGoS6zw==
X-CSE-MsgGUID: Op9lG1aGQnq4l69YyZ4rdw==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935403"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:58:00 +0800
IronPort-SDR: 68ef7e39_O2v31p0VF/HqAX3ugZGqNk7kCGKZyGAfEunPbmKYWWa+KPq
 wrPnBUvU1waibOq6s4EsDMhdFXh6UKg9Hr2b8zA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:58:01 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:57:57 -0700
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
Subject: [PATCH blktrace v3 12/20] blkiomon: read 'magic' first
Date: Wed, 15 Oct 2025 12:56:50 +0200
Message-ID: <20251015105658.527262-13-johannes.thumshirn@wdc.com>
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

Similar to blkparse, read the 'magic' portion of 'struct blk_io_trace'
first when reading the trace.

This is a preparation of supporting multiple trace protocol versions.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkiomon.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/blkiomon.c b/blkiomon.c
index f8b0c9d..05f2d00 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -460,19 +460,28 @@ static int blkiomon_do_fifo(void)
 	bit = &t->bit;
 
 	while (up) {
+		__u32 magic;
+
+		if (fread(&magic, sizeof(magic), 1, ifp) != 1) {
+			if (!feof(ifp))
+				fprintf(stderr,
+					"blkiomon: could not read trace");
+			break;
+		}
 		if (fread(bit, sizeof(*bit), 1, ifp) != 1) {
 			if (!feof(ifp))
 				fprintf(stderr,
 					"blkiomon: could not read trace");
 			break;
 		}
+		bit->magic = magic;
 		if (ferror(ifp)) {
 			clearerr(ifp);
 			fprintf(stderr, "blkiomon: error while reading trace");
 			break;
 		}
 
-		if (data_is_native == -1 && check_data_endianness(bit->magic)) {
+		if (data_is_native == -1 && check_data_endianness(magic)) {
 			fprintf(stderr, "blkiomon: endianess problem\n");
 			break;
 		}
-- 
2.51.0

