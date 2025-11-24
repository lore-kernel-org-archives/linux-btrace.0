Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30A2E972A;
	Mon, 24 Nov 2025 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969935; cv=none; b=RqtlZCSUS8cN2am4Pfu6vUO652KSKlmdVvn/sDW/0mM5SayFyE0vxQX3dc4WbGCfeJxPtRDVg+cZxMxnqw5N0uqJ8cwlTI/vyIeckqamsw8c+ejixTJ1mKlh9k7iMTRWn63/9EmvP/jA5YW6rWmG/qiGjtXc4HeOLU7R77/QsnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969935; c=relaxed/simple;
	bh=9eWf6LzUuJXvhDm0lpvATvyVyg+h/0pKgJdDvYpoMAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMeCYqedHjgBlLz9O9AjujYzV6/eA8m9NwqTi3K+cJwL9mOGCNPB81rmuj2gEYGOhgRunYCp9Di/I/lAu37cjY2XLkRBYfLm+e5lYm9cO3EQF6sFuoARnTsQdBUjgzHTSTIaEuuEWcopAE612OV7OzYFhJTW4RuBAdex4Kyee0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZJ1UZ3jK; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZJ1UZ3jK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969933; x=1795505933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9eWf6LzUuJXvhDm0lpvATvyVyg+h/0pKgJdDvYpoMAg=;
  b=ZJ1UZ3jKD2UBHh8bzzLLHPGQnULd6Dxboc1g1gFhXZWWNyDB03W0etbV
   mk3U+hP/dEawMlYWSNm4LcLRj8XAzU8yfbCuL6dO0V+Wng6DvAlfvxiE+
   0oFXAmIsuzauiznTe2V65C+Nttd0tcEqPgljlhNDpoqIqdN1zHV5NfQc1
   XrqznGIlMh+C9KeHknJbShvV5cOEyhK82HWAY5iXGVz7z9PCdN2v/lhpV
   3UnBRl1jxzeE++/CrrfQPdO9GysBqjdwKjcfvvACBGe2guQ55ShVGSNtW
   f30HdKwZStummhLyE9eBRuEodZWcOLZjjUKwsDt+PbM8vpiYA78BOgm9k
   g==;
X-CSE-ConnectionGUID: iAicZ46RQpm5bbqm5NGEGg==
X-CSE-MsgGUID: iVSk5J50TwiV5FSwPwjgAA==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619405"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:38:53 +0800
IronPort-SDR: 69240b8d_yq7FiQypI/hjFyPOdx9+20ARIQRACXheIKcQ4gXb2nGyXhy
 +FhBwT+qu4MFaiID/Mz6RONCBE+ChUt8XgCHxKA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:38:54 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:38:51 -0800
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
Subject: [RESEND PATCH blktrace v3 19/20] blkparse: add zoned commands to fill_rwbs()
Date: Mon, 24 Nov 2025 08:37:38 +0100
Message-ID: <20251124073739.513212-20-johannes.thumshirn@wdc.com>
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

Parse zoned commands in blkparse.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse_fmt.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 80e02fc..06b055b 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -60,19 +60,45 @@ static inline void fill_rwbs(char *rwbs, struct blk_io_trace2 *t)
 	bool d = !!(t->action & BLK_TC_ACT(BLK_TC_DISCARD));
 	bool f = !!(t->action & BLK_TC_ACT(BLK_TC_FLUSH));
 	bool u = !!(t->action & BLK_TC_ACT(BLK_TC_FUA));
+	bool za = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_APPEND));
+	bool zr = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_RESET));
+	bool zra = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_RESET_ALL));
+	bool zf = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_FINISH));
+	bool zo = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_OPEN));
+	bool zc = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_CLOSE));
 	int i = 0;
 
 	if (f)
 		rwbs[i++] = 'F'; /* flush */
 
-	if (d)
+	if (d) {
 		rwbs[i++] = 'D';
-	else if (w)
+	} else if (za) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'A';
+	} else if (zr) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+	} else if (zra) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+		rwbs[i++] = 'A';
+	} else if (zf) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'F';
+	} else if (zo) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'O';
+	} else if (zc) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'C';
+	} else if (w) {
 		rwbs[i++] = 'W';
-	else if (t->bytes)
+	} else if (t->bytes) {
 		rwbs[i++] = 'R';
-	else
+	} else {
 		rwbs[i++] = 'N';
+	}
 
 	if (u)
 		rwbs[i++] = 'F'; /* fua */
-- 
2.51.0

