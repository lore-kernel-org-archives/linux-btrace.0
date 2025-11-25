Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321FE2DA77E;
	Tue, 25 Nov 2025 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055691; cv=none; b=PfltobSFUVOIUvKrBOgY2lq+1jYLD3PlDGi9POw0C8Ky38QoAswRu13WJZdtnPrIdxZccS1Y5Uma4M5u2dwyCJuFfDRrxtJ3IE7Gku4KYwB/VlEuApJ+uyH7n5TazZosisgVtB2IMQxTYRs+N8CUFS+mq4ffsbSRB7vkWt07E0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055691; c=relaxed/simple;
	bh=tex0ATmbu68rvisWlUOnoso+r6xR5x0Sb3D09NGiMko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7wlX+uTv11afLhm4Kv2a6DtlCCySbdpaOLxK5RndP+YfZa6TPuwDk4KXxECkuFVs6hsS5itsPAppBxQaUjsVQ+caOImuRKGBJQSmLz2IqHtKKDnvYrLwziJHlCpL42WK1W94iyor3vNpXCnmRnHQSfNHKw5mTcgR6E7e7PzlGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EMG89ajj; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EMG89ajj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764055690; x=1795591690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tex0ATmbu68rvisWlUOnoso+r6xR5x0Sb3D09NGiMko=;
  b=EMG89ajjNkgLlUVs/e1oPBcUOTblCldxEdD61dlzHg0bEDynvlnsX3FQ
   0mwVQao7+6dY9AZa7M3bFvYm/fYyyEEzZP/fxrLYf5yjTgRjv8je3ec3v
   OMFP/4wHNKIeOX98dcazbT5bzpd3we2diIEiq7oCVaOz1Sxyz4RAne6eG
   e229DLTr1AnCLuRGFkQ+1pHH9bvPxMgxC/U1L8sYgIB4KhYHIX/Mfa7pC
   9T0m8uisxzL9N0GSMfpJ4Mqjw4tZ2J3QIyzRc79MIPU12XwPpzwR0nZ+l
   jQpUMWV27kaj+0ZHiSiopC45rJt7bp1Budw913kM7tndEhbWNTFqbOv6U
   g==;
X-CSE-ConnectionGUID: y7ZQkeR8TVW95Q/ENPa3og==
X-CSE-MsgGUID: iOgKUU+4TpSE+cFOI+QPtA==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135337557"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:28:10 +0800
IronPort-SDR: 69255a8a_bRrtXLQbB10U3Tl7ootU49eo3KHFrh45Swrt+f9XJ+xV26W
 xNrGVmiI8ndEcD3muGans8czk4j+8AZ2weosJ1g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:28:10 -0800
WDCIronportException: Internal
Received: from ft4m3x2.ad.shared (HELO neo.wdc.com) ([10.224.28.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2025 23:28:07 -0800
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
Subject: [PATCH v4 10/20] blkparse: make get_pdulen() take the pdu_len
Date: Tue, 25 Nov 2025 08:27:20 +0100
Message-ID: <20251125072730.39196-11-johannes.thumshirn@wdc.com>
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

Directly pass in the pdu_len into get_pdulen() and only care about the
byte swapping in get_pdulen().

This enables us to use the function for different versions of the
protocol.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 163da73..0402e81 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2412,12 +2412,12 @@ static int read_data(int fd, void *buffer, int bytes, int block, int *fdblock)
 	return 0;
 }
 
-static inline __u16 get_pdulen(struct blk_io_trace *bit)
+static inline __u16 get_pdulen(__u16 pdu_len)
 {
 	if (data_is_native)
-		return bit->pdu_len;
+		return pdu_len;
 
-	return __bswap_16(bit->pdu_len);
+	return __bswap_16(pdu_len);
 }
 
 static inline __u32 get_magic(__u32 magic)
@@ -2439,7 +2439,7 @@ static int read_one_bit(int fd, struct blk_io_trace *bit, int block,
 	if (ret)
 		return ret;
 
-	pdu_len = get_pdulen(bit);
+	pdu_len = get_pdulen(bit->pdu_len);
 	if (pdu_len) {
 		void *ptr = realloc(bit, sizeof(*bit) + pdu_len);
 
-- 
2.51.1

