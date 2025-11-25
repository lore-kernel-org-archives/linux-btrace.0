Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3B82D839B;
	Tue, 25 Nov 2025 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057150; cv=none; b=s4wxpew8pAhLVMpQgiOPDWdDcRVuQKh9r4Uc+8Zf3+1/9GLHluDxqeU6c/XhTOnvi5dcGyrcl5owpZltuR441+eD7CKtZw82TnhVFSV3YQEkMvAHUEDkZdN8KjeYalvkUUMlyp55uKcrgHvmGypWM/XeZ/DXaytnWRSizLJefaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057150; c=relaxed/simple;
	bh=qSFEjjhSfXm7utrWrROZPlF7K5bQtM2BgslWHsHsEKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDSEQtEyRYnfmeyhORMNKV142GwN1eQDpq/itZ4ciOSz3DAjoPx8us+GBE+dNmg1e22DFSHKlsvO3N+S/cWGfNs9PBsaVjNuaa5nAUHcYpCQ2d1wszcFz16nvsxhDUDRzge+eUL3spBQcg3ZPY4rAx+UKn5A91ZZMMGKdGkqgxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NRgOqflh; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NRgOqflh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057148; x=1795593148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qSFEjjhSfXm7utrWrROZPlF7K5bQtM2BgslWHsHsEKw=;
  b=NRgOqflhPFg7hFlop1Mv8UvrXAp1CydmCkzdb+B8CUsPG15AIl63wWRR
   H9JENZKoyPiT00oDHccMWyMs0imTygDupobWbugsyhPsTrpDaE9Zd2hLJ
   9ab7j0/6MmLiajf6mT8tCjs0XsB7+2qyY1J38X8sTortvHJwdaFKDqZKu
   IjIPflCMjXhrO95dTZRZu4r2Hvyo51gSO2LQrOK7OmFs0GglBgs6eSnFM
   cyticDvLnilQIlpOEvm3w6t2EyZRgMespG+f2oGRZCFuKpsB+90ggPMhR
   KhrZlVgaBD4Jq81+ZsEbex1301sXzdkMVB2Ray0BMm8nT1qrnTWcZjBtI
   Q==;
X-CSE-ConnectionGUID: p/iI7V0IQq+Rd+VmCf6UIA==
X-CSE-MsgGUID: 6e1lWn6AQTuOTBT0uRo5Lg==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749805"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:28 +0800
IronPort-SDR: 6925603c_PRZUU6NnYAlQAqn4LSLmkhJ7r8XEO8CPA/mixH0Xmp89rxC
 q0piRDLN2GUhhUpxTodkvwlhjvM42Le3MB6uaqQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:28 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:27 -0800
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
Subject: [PATCH v4 12/20] blktrace: pass magic to CHECK_MAGIC macro
Date: Mon, 24 Nov 2025 23:51:58 -0800
Message-ID: <20251125075206.876902-13-johannes.thumshirn@wdc.com>
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

Pass only the magic number itself to the CHECK_MAGIC() macro.

This enables support for multiple versions.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkrawverify.c | 2 +-
 blktrace.h     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/blkrawverify.c b/blkrawverify.c
index 9c5d595..cc5b06e 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -183,7 +183,7 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 
 		trace_to_cpu(bit);
 
-		if (!CHECK_MAGIC(bit)) {
+		if (!CHECK_MAGIC(bit->magic)) {
 			INC_BAD("bad trace");
 			continue;
 		}
diff --git a/blktrace.h b/blktrace.h
index 74dfb48..14c0d92 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -67,7 +67,7 @@ extern FILE *ofp;
 extern int data_is_native;
 extern struct timespec abs_start_time;
 
-#define CHECK_MAGIC(t)		(((t)->magic & 0xffffff00) == BLK_IO_TRACE_MAGIC)
+#define CHECK_MAGIC(magic)		(((magic) & 0xffffff00) == BLK_IO_TRACE_MAGIC)
 #define SUPPORTED_VERSION	(0x07)
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
@@ -90,7 +90,7 @@ extern struct timespec abs_start_time;
 
 static inline int verify_trace(struct blk_io_trace *t)
 {
-	if (!CHECK_MAGIC(t)) {
+	if (!CHECK_MAGIC(t->magic)) {
 		fprintf(stderr, "bad trace magic %x\n", t->magic);
 		return 1;
 	}
-- 
2.51.1

