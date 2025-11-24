Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A11C2E8B75;
	Mon, 24 Nov 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969917; cv=none; b=sNeEdEnhT/fnuHt+k4cwUnjjp0/dcDaAx8BcJvLrDP/QD+XezgQPj9fXTdJ1cbZLdIHFImbzqiYVojrIYVOWO5n+8G6fPg5jj2ZZrlcATC54ct01VHgjNL2yAB4NsCX8ymD8pnHvNiadfS4P5/jJjUTsJD1weXXjxuWwVjXZ6iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969917; c=relaxed/simple;
	bh=ahbQzVYzmBGcgTtig5YmAZ5t6E/5eYzq5jKvFA9hLeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/sN8N7ZcmN03Gc91lvDqRRdWySspep9ThSj108+w7rbnKfiMdaNH4ckZ8XaRUnJBlcroY8Upomz1SShZ4IkpvENS/x7fEtu2EXpKOIAZgz+DIClxcP5z42M6Psu2SPcEZQJ6jTCZCUAN1RV8Xb7D0/8m7nUFkfiTypBi3t/VE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=joVqw/uX; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="joVqw/uX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969916; x=1795505916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ahbQzVYzmBGcgTtig5YmAZ5t6E/5eYzq5jKvFA9hLeo=;
  b=joVqw/uXoxYv+PANs1BwNIN04g4iSsguVKqSwEUupLYFfQqTPkaoWQrA
   fkwwzZUu9pIctplO5589D+cukBM/7f/zimrPxkgenFYadGNQjbw1gWhMi
   opCSQVafOHnHH+XwxsB5KgHG654k/+93yV5emBltPWB478uvtNaCRIDJV
   OSzp/DefxQDOC0b00tFBpHrtFfARRAXrXo98Mh726+aI8Pk11jiSGrXJS
   JUhcUHzMJbpHtdGNKh2rBp1lZdJm+eq7r/suSDe1T5l3HbqMigPs3Cp1Y
   yt2YN2xxr/JJIMM0UP/9xFxREFL1W/n5ZTVsZzIXKH7l2hBiinN19BLs/
   Q==;
X-CSE-ConnectionGUID: Vv4WRBs/Rq6SOWHFAWnYPg==
X-CSE-MsgGUID: lHGkR1e4S768XeRQsQXflg==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619379"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:38:36 +0800
IronPort-SDR: 69240b7b_nyJXyC/l8ri4cNIuRAhdL7t6EP9P9UYYa8rYvenyhZNo0KO
 N23quHGVyclr4oLHL9Rz1xcmBy3Ta+XnYrhjRkQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:38:36 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:38:33 -0800
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
Subject: [RESEND PATCH blktrace v3 14/20] blktrace: pass magic to verify_trace
Date: Mon, 24 Nov 2025 08:37:33 +0100
Message-ID: <20251124073739.513212-15-johannes.thumshirn@wdc.com>
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

Pass magic to verify_trace(), this will enable verification of multiple
supported versions.

Singed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkiomon.c | 2 +-
 blkparse.c | 4 ++--
 blktrace.h | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

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
index 81a5b51..68c67f2 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -89,16 +89,16 @@ extern struct timespec abs_start_time;
 #error "Bad arch"
 #endif
 
-static inline int verify_trace(struct blk_io_trace *t)
+static inline int verify_trace(__u32 magic)
 {
 	u8 version;
 
-	if (!CHECK_MAGIC(t->magic)) {
-		fprintf(stderr, "bad trace magic %x\n", t->magic);
+	if (!CHECK_MAGIC(magic)) {
+		fprintf(stderr, "bad trace magic %x\n", magic);
 		return 1;
 	}
 
-	version = t->magic & 0xff;
+	version = magic & 0xff;
 	if (version != SUPPORTED_VERSION &&
 	    version != SUPPORTED_VERSION2) {
 		fprintf(stderr, "unsupported trace version %x\n", version);
-- 
2.51.0

