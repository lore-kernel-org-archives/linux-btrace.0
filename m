Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968531A06A;
	Thu, 25 Sep 2025 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812740; cv=none; b=IrC3SgUrSciXs+rvcNkVreTIrST6SC+J8tcDVej/AsbARfgI2VPJhz7WTExbgmvAkhVWFtn04mAkUjxBa36d06Ti5EnSok/8FebdwJrNBX6uqNXgueG3MsEZpt5An+B8SRFJG5WfRBNNiLuBCkSr8/sMgbPJsgM7e1Ma5sn0B+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812740; c=relaxed/simple;
	bh=dnN2KHhWPoTWDTwcp7qpeQ3vd4h7ztKe0w6q2T21s34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDyff/QzlLcXDNq/TAqYu5pSxulW+9X9Ab0GnuldBJJ/ZctKde77PT+kapM5MK2QQTSnqrTTxyTRIcK+WqGFlWvsf1zCyszwW0LqYnN9T9F8e8xkOGUZZ5iN//Y3l5TQRm+4n2Wnv2J4GHqUlkR/3vSQASVlHqG46apwQCsiEN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pW6q6SJg; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pW6q6SJg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812738; x=1790348738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dnN2KHhWPoTWDTwcp7qpeQ3vd4h7ztKe0w6q2T21s34=;
  b=pW6q6SJgsLys+TzWRxo1yBt/7+o0o0F+JPCVmUmDzLuir8QT7hji0Me7
   oPjACnibFgGmL/sf6AdOXq/Clo3lP9rxOjqMFP1tIM/LjZcOf/ilqviOd
   OYxxyHC32omdUFjSm+pnLDVtgBL9fvBoW9Np4PCPOjlKF+LVkRR5Pd8Um
   n07CJZvESiFTAii0+NbeaQ/mOPVfWgyVishohUujY/9i7VIBM1P4QZIaC
   Z6Ma3GAutzyT+O+1DiweQLJdsttZXToW/SKC7hacKqNOPpvoiwJneAnbe
   OSJGTH9fsI56q/zdrX+Uu3WNaR2NSJuuF1QxHisSg00FBblvMv+/YIvLR
   Q==;
X-CSE-ConnectionGUID: LtgENWZFQWCFTS8cxPI09A==
X-CSE-MsgGUID: Mql7HflCSiCio+/QkD7Jgg==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130349316"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:05:37 +0800
IronPort-SDR: 68d55a41_UULpGNAlmtr3akeU6zkyxD9LEa0dAsfB5kL81VICDJaZVeb
 50xY84/U2WTbH49NdWIiOG5PHzMCf+KuO8wWghA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:05:37 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:05:34 -0700
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
Subject: [PATCH blktrace v2 15/22] blktrace: rename trace_to_cpu to bit_trace_to_cpu
Date: Thu, 25 Sep 2025 17:04:20 +0200
Message-ID: <20250925150427.67394-16-johannes.thumshirn@wdc.com>
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

