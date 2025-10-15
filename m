Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3979C31DDB7;
	Wed, 15 Oct 2025 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525897; cv=none; b=m2CASuEC25VOLmAntE4SMl9qG9g+EYGhkmVOH/zKA4KHECbAadZmu8cfT0c3FiP0XQ3UJTU0gLlKGEMWxy/4y7OPj3+U0xGGLgzQd6/6dqqC+AzRo0zQlKW2gbPIQXxMbKGZO05C0LHzNVCoDuXKVQzVk57cXEYPJrvE07kyNLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525897; c=relaxed/simple;
	bh=dnN2KHhWPoTWDTwcp7qpeQ3vd4h7ztKe0w6q2T21s34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvFErppsjt4b+xneAbUkqP0eiJlh05yHl4R26hm82LYlkTZ6W+xgM3Mz1iM0pWIU4QmAsZFFUbizFcB6FXhGf0cxkImEHAWNNLr6arWrZM4F6fnoZdVLNvyTX6kjH5u3tb4EwDyW1qiyTiQ/duy2oalPzRPYgQ6xUflIkTEU+Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jUCPXHvh; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jUCPXHvh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525895; x=1792061895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dnN2KHhWPoTWDTwcp7qpeQ3vd4h7ztKe0w6q2T21s34=;
  b=jUCPXHvheZPA8gXoJ+kWkfdyaTlfA2/oEjBsNZL/qvyFaeuDJCMoqhJY
   hi9sLHelTtJ2tl6BNMuYlcC55rhW70z0ykWQBV6EQa/cELBTAegPXa41K
   er3TBV207hW8/HpXsHiwxz6C95gSTCLRG+2fI9R0aeQzSoJ48VSupHuGe
   tKUwIuQQ3BfZESYejQVhKppNG/6c8Ovc5x/th76u/VsdrB/3WNaEKP4iI
   CmU01sxIxSScfn0OlwW/UrmSLR2RRJBgWQQYx74o1haeYF4Br1UZsCFUU
   u27QRutbC1CmhJbOpWPqFkJcW2WLWeOh9uwKRGf5nJe5Px2Luzw9HF3cG
   w==;
X-CSE-ConnectionGUID: 38crVWMVQb6tYbRX9cfvzg==
X-CSE-MsgGUID: mzfBkTlMRmSLwjwaHgc30A==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935414"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:58:14 +0800
IronPort-SDR: 68ef7e47_4MiewILAp3HstFIjQVWO1v3gK7qpd8fXofqHYY/Rx7YGwey
 PjercmYNbSTAhGTXYAnXtUBoMQSLJwm3Uw69few==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:58:15 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:58:11 -0700
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
Subject: [PATCH blktrace v3 15/20] blktrace: rename trace_to_cpu to bit_trace_to_cpu
Date: Wed, 15 Oct 2025 12:56:53 +0200
Message-ID: <20251015105658.527262-16-johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkiomon.c     | 2 +-
 blkparse.c     | 2 +-
 blkrawverify.c | 2 +-
 blktrace.h     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/blkiomon.c b/blkiomon.c
index 373947e..9defa2c 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -487,7 +487,7 @@ static int blkiomon_do_fifo(void)
 		}
 
 		/* endianess */
-		trace_to_cpu(bit);
+		bit_trace_to_cpu(bit);
 		if (verify_trace(bit->magic)) {
 			fprintf(stderr, "blkiomon: bad trace\n");
 			break;
diff --git a/blkparse.c b/blkparse.c
index 9065330..6396611 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2451,7 +2451,7 @@ static int read_one_bit(int fd, struct blk_io_trace *bit, int block,
 		bit = ptr;
 	}
 
-	trace_to_cpu(bit);
+	bit_trace_to_cpu(bit);
 
 	return 0;
 }
diff --git a/blkrawverify.c b/blkrawverify.c
index cc5b06e..8e863cb 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -181,7 +181,7 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 		if (data_is_native == -1)
 			check_data_endianness(bit->magic);
 
-		trace_to_cpu(bit);
+		bit_trace_to_cpu(bit);
 
 		if (!CHECK_MAGIC(bit->magic)) {
 			INC_BAD("bad trace");
diff --git a/blktrace.h b/blktrace.h
index 68c67f2..08ac28b 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -108,7 +108,7 @@ static inline int verify_trace(__u32 magic)
 	return 0;
 }
 
-static inline void trace_to_cpu(struct blk_io_trace *t)
+static inline void bit_trace_to_cpu(struct blk_io_trace *t)
 {
 	if (data_is_native)
 		return;
-- 
2.51.0

