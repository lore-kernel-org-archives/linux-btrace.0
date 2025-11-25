Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A091433BC;
	Tue, 25 Nov 2025 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057148; cv=none; b=M2/J229sAA4PBdh5vNZGZ3DS3wDZMRweVrLri2KDUlIu5jTQHmav7zCV7gcUiiphlmcN398CEoGz8Tz/B7vZLi09Jama1q2TvMe7xzn5XsTjPJDfdw+lqoV6sP65i56TjKGzYkeSZGznk3K30lj9RnhTKbPkrN9npEXA5k6bTv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057148; c=relaxed/simple;
	bh=9wRgDAM+/ixElO+LfC60jEKwmuSIJsYAYnZbJZrmy9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXZh52D0Lnw0ze72gc6warhG6us02Z+57z/rSby9p9XUkRrqFRvGp4EpzYDhQ3CJCMeWlx10IfaRnbSL+IuoFfFHkuaxCpMyRaWWiR3U39UBVuzxeK37/I0SkfgFY4Ty+bbbTqssiZBPzl1jFtONMmDsJfHomXf0Yx+8BwGWmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KNPn+XyV; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KNPn+XyV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057147; x=1795593147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9wRgDAM+/ixElO+LfC60jEKwmuSIJsYAYnZbJZrmy9I=;
  b=KNPn+XyVE4y6T8Kxdz0Es77oTCLlZipRlJJZ6gLDJGmcAl+mPJETttyX
   TjmCquefRNFNy74/gm1sTERubpiEj7beK6ZxGV7E8DzF9/p4YAUFYx/kB
   EzMTZSkvEGuQvwzNRnn+6mOgoeThsnY+Wcmz789EGvrLY/gyq6I3rZPDV
   3uW8RC1cLc3t1tTu5xrLkO+6xsCMl14FJ5siW4MVNYLMAajvuALPLC/T3
   eXA7n7khMTIlqdpjdJ0dm4fb5ICcVY/W+BbobgAc3LwcRIlO/UDYGpBfP
   WIeujWQXUmc3ORKCpEJk5A6Ka9NFhBJiDEAco7KVHwZB2Cbpb62ZSdGQQ
   g==;
X-CSE-ConnectionGUID: YmvXNM6qTMqmCAwZKgcf9A==
X-CSE-MsgGUID: FAWKMywTRcW4/C4+nVXiqg==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749801"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:27 +0800
IronPort-SDR: 6925603b_g+YhaavMDb88nf1hv+MiuLv3+JYWrl4chq7qhDGZCsFwJ52
 Sfg2Ill/L63q3piRQrXTYmHB1jlT/tK1VNck5ww==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:27 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:26 -0800
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
Subject: [PATCH v4 11/20] blkiomon: read 'magic' first
Date: Mon, 24 Nov 2025 23:51:57 -0800
Message-ID: <20251125075206.876902-12-johannes.thumshirn@wdc.com>
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

Similar to blkparse, read the 'magic' portion of 'struct blk_io_trace'
first when reading the trace.

This is a preparation of supporting multiple trace protocol versions.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkiomon.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/blkiomon.c b/blkiomon.c
index f8b0c9d..05f2d00 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -460,19 +460,28 @@ static int blkiomon_do_fifo(void)
 	bit = &t->bit;
 
 	while (up) {
+		__u32 magic;
+
+		if (fread(&magic, sizeof(magic), 1, ifp) != 1) {
+			if (!feof(ifp))
+				fprintf(stderr,
+					"blkiomon: could not read trace");
+			break;
+		}
 		if (fread(bit, sizeof(*bit), 1, ifp) != 1) {
 			if (!feof(ifp))
 				fprintf(stderr,
 					"blkiomon: could not read trace");
 			break;
 		}
+		bit->magic = magic;
 		if (ferror(ifp)) {
 			clearerr(ifp);
 			fprintf(stderr, "blkiomon: error while reading trace");
 			break;
 		}
 
-		if (data_is_native == -1 && check_data_endianness(bit->magic)) {
+		if (data_is_native == -1 && check_data_endianness(magic)) {
 			fprintf(stderr, "blkiomon: endianess problem\n");
 			break;
 		}
-- 
2.51.1

