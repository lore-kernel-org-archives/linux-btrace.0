Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3D2D8773;
	Tue, 25 Nov 2025 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057162; cv=none; b=iQ74BCkU3hnarkNV1tprNGnvC/jDEkYm+DTJZkZQLSc7p2b8LfnjexNCsgX0Yv6hXDyPGOSO3LVQKn8tw7o0tZ/QKHuBnGITzEQboX6TryD4S+x3scX4XgL7V47PHD55+Q9srxsNPc+NKVf1uBEdbhlSTRSI41qQ4TMW0RbizGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057162; c=relaxed/simple;
	bh=8aDF/jdFHu/yBIZxwSPDVPrCQ6q0N9Ht8S73CaPHLOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aw+muX05YIIFOHMr16/BgyzuS/s1vJjmhpeAzGKKMubbEtcsPfnb2tijnqS/SQV0WUMVOZ9vi0+c2UiOQO5hukpr2+pbv2cfOFfFPGEqsM9XFH0ynHKAv3Nxz+apby6UtM11ULsKvTppSt6vgSnlkzCaqzX33GN9CK+5rwSz2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PqYvoNR6; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PqYvoNR6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057160; x=1795593160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8aDF/jdFHu/yBIZxwSPDVPrCQ6q0N9Ht8S73CaPHLOg=;
  b=PqYvoNR6fYuTOYL4JAjtDgs50YvFKqspSRJV6Q87bphi6a8/eB6EX1dX
   AJ6iJ6Aa5w0NbXXSym9oJtnmNeixlykiWsGc//w+Fom/hmviNrRFUjcXb
   hKnJj1YNFw1fDKyTkDvyY8KgWDfAtVdBhPhvdzMPsgGKDytaKF7JL1YRJ
   tOz4MluA+cGVfeMB2uwamLYDMiopzfCunv0nFtE2xBIJsWNa3JbOzLr3R
   jf+Ttv9jYUUytqDWXnf+AX95sJA43IHHn1LKORiVhC5P4AX7NFC09i6k0
   1DNfi26Gggcd/33em8dcurQpMl4m3OGa/L7d2E+wJ8elVDT89M3+sjpg4
   A==;
X-CSE-ConnectionGUID: wTloQon+SnOlESsbFsauDA==
X-CSE-MsgGUID: AEeKdIodTJiBg1uU4JLugw==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749830"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:40 +0800
IronPort-SDR: 69256048_+eCvFySyTsd7RRQO3QpCQ/hlOSuJQfglbLSJvElO2mCfuAr
 2hxZcf11OIjH70cpCTtHUjkSG+3DZwaOUvqcARg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:40 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:40 -0800
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
Subject: [PATCH v4 20/20] blktrace: support protocol version 8
Date: Mon, 24 Nov 2025 23:52:06 -0800
Message-ID: <20251125075206.876902-21-johannes.thumshirn@wdc.com>
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

Also support protocol version 8 in conjunction with protocol version 7.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blktrace.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/blktrace.h b/blktrace.h
index 0281088..ba06237 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -70,6 +70,7 @@ extern struct timespec abs_start_time;
 
 #define CHECK_MAGIC(magic)		(((magic) & 0xffffff00) == BLK_IO_TRACE_MAGIC)
 #define SUPPORTED_VERSION	(0x07)
+#define SUPPORTED_VERSION2	(0x08)
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define be16_to_cpu(x)		__bswap_16(x)
@@ -99,7 +100,8 @@ static inline int verify_trace(__u32 magic)
 	}
 
 	version = magic & 0xff;
-	if (version != SUPPORTED_VERSION) {
+	if (version != SUPPORTED_VERSION &&
+	    version != SUPPORTED_VERSION2) {
 		fprintf(stderr, "unsupported trace version %x\n", version);
 		return 1;
 	}
-- 
2.51.1

