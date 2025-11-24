Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFEE2E8B84;
	Mon, 24 Nov 2025 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969920; cv=none; b=WT61XsDo2ewFQNPzS8z/Sj9++ZZTZs1hYHCXdLXLPyUavOOCG2zBx/NFNGbesI9kCc0IGA+P1dpBOkDfLgC/ZR2ZcFUEopXUEyZ4eX6XgdA0SVhMK83+dTlrlNrJUU1jng+4Te7KDl3AZNgRfQM9G0c1HYazDXqoqDZsQHUNdFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969920; c=relaxed/simple;
	bh=dnN2KHhWPoTWDTwcp7qpeQ3vd4h7ztKe0w6q2T21s34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqwx8X+MQQa5WK0F8/shPtohV8zhWY8Qugnr6RJ5W6hcXEGL85CGIwPe1m90hNJ7J+ARzoaA2PnVAeGM4BJ/nkMg+rdGsgrRdudQM/AJiXkuI1o2gQYHMtpq6FoMD5/WqiTGYDnsWSOFPeGSkDcFGCYR6UEwhx0btROYMHKbRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=m3p4lYgs; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m3p4lYgs"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969919; x=1795505919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dnN2KHhWPoTWDTwcp7qpeQ3vd4h7ztKe0w6q2T21s34=;
  b=m3p4lYgs8hKj95WP5OpG8wxQNXA5ndaBSNc51SpBV3BR1lGEspQ+UEgg
   IGvJPbd3I0Qifczb7qmuJ2sTDkO4ljakEQ/RthjSLpFDegEEHwjNBpJxu
   KoT+f+zpQOZqprgOBOhjqBiziPdesM1MkYr6IpnplCs7eccXpnVzFgnWp
   oLmlMCovUNreCd51g8nSZ583X2R/+Np+8SpGKi/v8EDy8p5Pr34XQGnsc
   ApN024lta6wV4IbAX1C+uvI9hdxP7ByjMCI9f5Ivx2aOopd8HnM9MMSBD
   cPYfWoNux+D7pFP3737kXfJd+ztbrJNjXa3lpgc/8KzeSt9qb2IOfNNLA
   Q==;
X-CSE-ConnectionGUID: NZuVWSrnTt2gbgDNEWLo3g==
X-CSE-MsgGUID: ORjLNCtSSqWz1WfahBsKBg==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619384"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:38:39 +0800
IronPort-SDR: 69240b7f_idWHaqQuQ3ea/BLJDTVKMY1nWRPEtYMACIxuoVqcgRUAb41
 Jhdz/vuVRxmbMI3mPb9BCvMTZk9BXdIPnWKYdpQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:38:39 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:38:36 -0800
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
Subject: [RESEND PATCH blktrace v3 15/20] blktrace: rename trace_to_cpu to bit_trace_to_cpu
Date: Mon, 24 Nov 2025 08:37:34 +0100
Message-ID: <20251124073739.513212-16-johannes.thumshirn@wdc.com>
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

