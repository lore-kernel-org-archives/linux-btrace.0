Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1BB277C9D;
	Tue, 25 Nov 2025 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056300; cv=none; b=N+uQaSHxUhw74DXW3ExbOlc4BvrheTOOIL44yWcx8zimCZs+wUa2bE9qFqBL2bak6UKZdjEmlQh4fVioVI4DrIqL29zKYpQOorVSJXiqqlh6nTm41hqH6siuXgPKZWX9mK8XQoie/q3oSQYpNqY8a7kvskLVDHaFzcTmA/O82QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056300; c=relaxed/simple;
	bh=qSFEjjhSfXm7utrWrROZPlF7K5bQtM2BgslWHsHsEKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hl0XMq+7n/JLseCgJgiR+kwobPv7AHTTZ0zy0bHtCqtVz03zBsgT2ThiykDy74spuywdQqwTvJ2OO1GaAoPbtexz7RgQMek5zmSriezqORYg8LOgSNXwAUXmX8cc8F8cspPeqO+GdYsLvuCoVaiev4Lv/mQAP/ONNshe0PwJaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hkD+ZFQs; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hkD+ZFQs"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764056299; x=1795592299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qSFEjjhSfXm7utrWrROZPlF7K5bQtM2BgslWHsHsEKw=;
  b=hkD+ZFQsoXQ33am05GwX0YZmQArEC7XELuCxw8CL/ye8yoa2a6stJIJC
   Tsq2FIkOaLmR3UAbmtnNfUe1hjGKiylBmXQmSEk29zYbh9kCOnmF/8/V+
   UPKrYjzrqO0KGW0g8tE37szmdrsBgwBSWqABoRwzELg/BDwbx+25SxBYM
   jeeXmoLSbRvv42s2Kcvd9ORbXwz2xQanH1gU3po+LPsgX2YwaIwnpspCJ
   NtPp5e9HcUcUVAQyJQv3KjfUZ3vdNGNhd5uksIuyEjocklFNjrBw3B3S2
   NaaKtqxjZHymf9/HYfPOFIimrqPAPZKcfZiqDgm/8vvg83G4xEoZ33nY/
   w==;
X-CSE-ConnectionGUID: KsRfFSesQqOYsXqmI2VFgw==
X-CSE-MsgGUID: rTuDEjjdSnqJWLOTSnaKZg==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="132688745"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:38:14 +0800
IronPort-SDR: 69255ce6_ZDZ7FitkIgLMecGr8PPHHuwEgtcwm8gCM1AUnWGq12QEp1g
 EaB9tYOa3Ytf6Tmr1rlCKbHJBByRDKgq4OO54cQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:38:14 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:38:11 -0800
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
Subject: [PATCH v4 12/20] blktrace: pass magic to CHECK_MAGIC macro
Date: Tue, 25 Nov 2025 08:37:58 +0100
Message-ID: <20251125073806.50762-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125073806.50762-1-johannes.thumshirn@wdc.com>
References: <20251125073806.50762-1-johannes.thumshirn@wdc.com>
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

