Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179942BDC03;
	Tue, 25 Nov 2025 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056301; cv=none; b=YY+bsr6jxc4Vr8QPD9S87DzYxwhSpC2CX4tgpoFUcIZwKXCh3wWWZegOjCx86xCA6eAGp8yVIvpJIU++BlJKT5unZ5B9Pn+VwSLCqez/MBFzjLIfy3TP/tYVx0mSV4XI4m5ckBi791w7gBMgXDrEOvst2NczUqm32hPXBAbP1Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056301; c=relaxed/simple;
	bh=nJ0Ad8OCBVGVwPDt5jG8FNuQwXmGOcPrpVN45bcZL/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAROtgX6+wy9ACTmFgGzy5xq0p2YsJiPURgPcbENrTF7hmvY9DuhIRXvz21QiCjgoZQ14a7UadUs6KKNAhXxl9dFiJZFO2bFKAdKfTIjRKjyk6L3MnwHMDhFYbsW+mAZmPWPapOIxEaZq7ny00K2PT/GpMVmqSWsvlAKQ6kGajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=k2w/WMAF; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k2w/WMAF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764056300; x=1795592300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nJ0Ad8OCBVGVwPDt5jG8FNuQwXmGOcPrpVN45bcZL/I=;
  b=k2w/WMAFI7ooqvNkqCBN4H3qXNYZ0mvF5bogPhXKlKIkctlzDYiL4Y95
   ZOzAQv4fRKVcxqjxJBWKA115RwX39e5Y+WWa4I/Eh/eq2ZyxSLXSEpPuG
   cYVGB+WrZd6Xkqhm/EgIYnvLCG2fLab3u4h1X+KW2cVfAh5efWD1C36GZ
   tMHaY3kYVY+k2sgmi7hoy6SBccPSoMbtnzBaU4/xVlLvwGtSbkYxCX8o9
   GqfqR8nMo0XV/8goTSOHbyWlxfIe1hiDoP4bGkD9vVb+i+ajLz7MoJLxR
   /Z2/YeyMKNxMDjsskT95mMGGlxQSmUymmYh7VnGquVRCIfra6JUYfNYGF
   Q==;
X-CSE-ConnectionGUID: Do/MQN9DTpOxTsxbaUS9qg==
X-CSE-MsgGUID: K+CtYWYaQ5GkyMwxXrprwg==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="132688747"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:38:18 +0800
IronPort-SDR: 69255cea_4uTC1o374c+kHi19NmzLWoJ/vBMgYDrJcXRyp1VfirW7au/
 yVlf2S5UH/7p1EoeHBVHzfCrWm5J1Kg+mjrQDpw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:38:18 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:38:15 -0800
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
Subject: [PATCH v4 13/20] blktrace: pass magic to verify_trace
Date: Tue, 25 Nov 2025 08:37:59 +0100
Message-ID: <20251125073806.50762-3-johannes.thumshirn@wdc.com>
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

Pass magic to verify_trace(), this will enable verification of multiple
supported versions.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Singed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkiomon.c |  2 +-
 blkparse.c |  4 ++--
 blktrace.h | 15 +++++++++------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/blkiomon.c b/blkiomon.c
index 05f2d00..373947e 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -488,7 +488,7 @@ static int blkiomon_do_fifo(void)
 
 		/* endianess */
 		trace_to_cpu(bit);
-		if (verify_trace(bit)) {
+		if (verify_trace(bit->magic)) {
 			fprintf(stderr, "blkiomon: bad trace\n");
 			break;
 		}
diff --git a/blkparse.c b/blkparse.c
index 0402e81..9065330 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2509,7 +2509,7 @@ static int read_events(int fd, int always_block, int *fdblock)
 				continue;
 			}
 
-			if (verify_trace(bit)) {
+			if (verify_trace(bit->magic)) {
 				bit_free(bit);
 				bit = NULL;
 				continue;
@@ -2649,7 +2649,7 @@ static int ms_prime(struct ms_stream *msp)
 			if (ret)
 				goto err;
 
-			if (verify_trace(bit))
+			if (verify_trace(bit->magic))
 				goto err;
 
 			if (bit->cpu != pci->cpu) {
diff --git a/blktrace.h b/blktrace.h
index 14c0d92..bdea438 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -88,15 +88,18 @@ extern struct timespec abs_start_time;
 #error "Bad arch"
 #endif
 
-static inline int verify_trace(struct blk_io_trace *t)
+static inline int verify_trace(__u32 magic)
 {
-	if (!CHECK_MAGIC(t->magic)) {
-		fprintf(stderr, "bad trace magic %x\n", t->magic);
+	u8 version;
+
+	if (!CHECK_MAGIC(magic)) {
+		fprintf(stderr, "bad trace magic %x\n", magic);
 		return 1;
 	}
-	if ((t->magic & 0xff) != SUPPORTED_VERSION) {
-		fprintf(stderr, "unsupported trace version %x\n", 
-			t->magic & 0xff);
+
+	version = magic & 0xff;
+	if (version != SUPPORTED_VERSION) {
+		fprintf(stderr, "unsupported trace version %x\n", version);
 		return 1;
 	}
 
-- 
2.51.1

