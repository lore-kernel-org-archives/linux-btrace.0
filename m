Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA4B2D77E5;
	Tue, 25 Nov 2025 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057153; cv=none; b=P4Ug+2HA63gFf5NJ25msY8dOdcJu0PKYPzGapn1gsDXv9f2RrnSBrzoRq7a1ybVBfO0N5hgd7O4lxA4y90l4LhESkV2kal8BUHoiw8W03/+DJ8NvAyc5c7PwxW5qFghgFlOfsAFcbSPqPS+EH3Ki0iVbZutbZKUv4fTfkZAp5+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057153; c=relaxed/simple;
	bh=8McdkRqxeeYXNUIsIlauh97SMadvf1GTfMnRSRXlTU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4PesDtDWOhbyJiURGMgdxdC1wo/ik8hO2ilUHhXKxR93qJsBKMQofIKJmEvw8BnIp/tc0v2KIAiWQpkBlpHoCtuLGr8wQgz1WNmDT3wmczADx4Zcjpk0oGB8/0G1KuUwl0BJ+gUKCsuFlKtqKZIQhTBAQVOEFmIfOSftV6Sxzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=R6za/NyI; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R6za/NyI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057151; x=1795593151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8McdkRqxeeYXNUIsIlauh97SMadvf1GTfMnRSRXlTU0=;
  b=R6za/NyIBNYMLhFnIzG/XskIFHZfqUzWcArp8YF2t3rcAUjzdk2JVMVC
   NlvNOnMec4CvEksQ1qTn9lmQzdF1xQ6EANyp1oNGWlBgLwxQrZnu2Msnj
   Q366AnJTcGMD2GFof6RkXnZ4uuvvEePqUzV6SVKaI2Wp1hWr0dXdNMLka
   LFocPqhOd5/Y/l876ug7F27ZqmSDZK+zu58yzO3xnNpBvAYzFZh/mwmyf
   emdgoQ2fzvd4FMseTJX4CXO5xfC4a7CCVrTSKrt+ViIpBPf0P/k2RT8Ao
   AKBHnl7zAbmAzX7Hy3uBb9qxY+uTbZOou+8uhfrFmzv4qs9KfnWXDz6lV
   w==;
X-CSE-ConnectionGUID: jYtnwRN4RJuAlv159ALAVw==
X-CSE-MsgGUID: vcQSsVU7Qmyu9NoziXtTMw==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749810"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:31 +0800
IronPort-SDR: 6925603f_Duti4ZB0Bkgoa8k5jwzOmptK+3zl+DlbMRI1rcfnrSH7tEz
 u5hKJwFYiZgyhZu6lqHZlQTgV/YhopQmQpaGdFg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:31 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:30 -0800
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
Subject: [PATCH v4 14/20] blktrace: rename trace_to_cpu to bit_trace_to_cpu
Date: Mon, 24 Nov 2025 23:52:00 -0800
Message-ID: <20251125075206.876902-15-johannes.thumshirn@wdc.com>
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

Rename trace_to_cpu to bit_trace_to_cpu, as bit_trace_to_cpu operates on
'struct blk_io_trace' not on 'struct blk_io_trace2'.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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
index bdea438..00edf92 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -106,7 +106,7 @@ static inline int verify_trace(__u32 magic)
 	return 0;
 }
 
-static inline void trace_to_cpu(struct blk_io_trace *t)
+static inline void bit_trace_to_cpu(struct blk_io_trace *t)
 {
 	if (data_is_native)
 		return;
-- 
2.51.1

