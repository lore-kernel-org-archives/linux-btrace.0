Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564522E8B84;
	Mon, 24 Nov 2025 07:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969889; cv=none; b=PxBmn2z2JJIvFhhe41/yOytrsDhPVha054Pl5gZYBvhJR10dkjgqjqyjKSMckg3dQDqDb5JP7VVuEgP8jIy27WBtxup+vKfXk1NxBZWGzjd7PgnTGEMwV6WnST49A1nC9X7ao5/qsenSdpEOQkz7q2f3u4Nkr0BIQ1tlf6XqJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969889; c=relaxed/simple;
	bh=mPQj5kqwyRWqC+fMnaW0oDN1trAQZBc40cPOBN7KYso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glq2Hq9p4oAUi5QRJmV0pupgYN7V0mKDOk5fPIOkC/iUKFDRl9t3I2zJwbsBjg2Y0pznYr96eE3lTSn2k79TizcROes2ljD/+FGTmZjiDfRxuGtXo4fiSG3a9nJtvau1uzfQnRXmf4tR0VFoMpNlrm3jRrrNgjfXGb1uJ0S62BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=a5CpxFbA; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a5CpxFbA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969888; x=1795505888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mPQj5kqwyRWqC+fMnaW0oDN1trAQZBc40cPOBN7KYso=;
  b=a5CpxFbAk/1K/f6uoi/YlK7rMHfVzt0GTjBoR12sKADevi8sX0WMMUg6
   NWEG70bdyEXh1scF1y3OazgI6o2iC7rGlHPud0tdE5SS3Ukev4scplKMx
   5H38fBlx0qLJ/c5DenOH7VbwVAtZ10+MoRudWgbDTnxH6fXR0tX5k4D/M
   BVH1K+4x8yBUK2UOGMZykYtb8CguJ9AzMR4WZ0s1hf7hJE5/P6iyoaS2B
   CQd3JFa1PdKN/RyNOcXg2HoIv6ty4dc8ca8rIW8XX65HU1m3yg42Pvp2a
   ihWkeG9kYvBQdMFxgs7fcuE0Aclyp1Dbf7/1pHGlzTg5eDzABUvoEOND4
   w==;
X-CSE-ConnectionGUID: ne0ScTuMTymF1w3qDaTFyw==
X-CSE-MsgGUID: vH0KbMl7Q1+UCaUjPGrQuw==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619352"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:38:08 +0800
IronPort-SDR: 69240b60_biHUhUaihgYkTw44Y3Gzpo900UHk+ZFc+2UAzC7IcYGiy5S
 xK+FFho9Z+TPyW/yfaS/zqToi/rgMZJeyoCDNAQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:38:08 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:38:05 -0800
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
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RESEND PATCH blktrace v3 06/20] blktrace: support protocol version 8
Date: Mon, 24 Nov 2025 08:37:25 +0100
Message-ID: <20251124073739.513212-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also support protocol version 8 in conjunction with protocol version 7.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blktrace.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/blktrace.h b/blktrace.h
index 74dfb48..3305fa0 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -69,6 +69,7 @@ extern struct timespec abs_start_time;
 
 #define CHECK_MAGIC(t)		(((t)->magic & 0xffffff00) == BLK_IO_TRACE_MAGIC)
 #define SUPPORTED_VERSION	(0x07)
+#define SUPPORTED_VERSION2	(0x08)
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define be16_to_cpu(x)		__bswap_16(x)
@@ -90,13 +91,17 @@ extern struct timespec abs_start_time;
 
 static inline int verify_trace(struct blk_io_trace *t)
 {
+	u8 version;
+
 	if (!CHECK_MAGIC(t)) {
 		fprintf(stderr, "bad trace magic %x\n", t->magic);
 		return 1;
 	}
-	if ((t->magic & 0xff) != SUPPORTED_VERSION) {
-		fprintf(stderr, "unsupported trace version %x\n", 
-			t->magic & 0xff);
+
+	version = t->magic & 0xff;
+	if (version != SUPPORTED_VERSION &&
+	    version != SUPPORTED_VERSION2) {
+		fprintf(stderr, "unsupported trace version %x\n", version);
 		return 1;
 	}
 
-- 
2.51.0

