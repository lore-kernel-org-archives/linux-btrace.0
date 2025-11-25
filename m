Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D72701D9;
	Tue, 25 Nov 2025 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056299; cv=none; b=IdGqGdxfNIkQFsmRt7ds7bpE5AR33iWWedcgaGnUMzBSkLTK/BicHMVmMPj/x0CuPZ3tZQSm6q5C12jtR9izudNyZXwiLe+Bdd9ml4Rz5ampK+B24ZXZVNwoQNSkwvnaU6zLkTeRvdoi3TBwyRTGJTH+JOAXI3jAKd6vTVPLZ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056299; c=relaxed/simple;
	bh=9wRgDAM+/ixElO+LfC60jEKwmuSIJsYAYnZbJZrmy9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Es1uRlBVKLb766XXaAegSp3KRWUmBEHVrPyx18jBVhsE2yFFGMXnq2aRO+G5Hqf62xR4Lh7NIFmQcjmaM/Roev2g6zvV0rIFgUTuR5isVrWgd8Ni7BRld3G8yQiMsmPkOOlWXey5rE58/RPo5FACBCAm5Bioju0fHak+6f7ttoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ebLTEAUc; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ebLTEAUc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764056298; x=1795592298;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9wRgDAM+/ixElO+LfC60jEKwmuSIJsYAYnZbJZrmy9I=;
  b=ebLTEAUctxYyLVqO6F7ga0wmM75eg2ErbcNAMHASjwUGQFSazKM4mlsF
   /hhi0xySOfxwMlBXwCwAiLhAy5n0fW4BMfRfxAkiqhXf+pSRnLAAnTDa+
   xT3famsM/Gi9bV3DxCPRvPnt1sriyJAmVQH9KFLb3bF9fUaSLZzOtJb+I
   zweePmFank/yFfSn4RY4FTuWbv6U5Bl8jRDHAEaD62n83ssgoCIIu1hfa
   4iYqat+rPTcGj/mr/OjAIX8RzI0Wfs1fNL1kof88zNRmF7H5a0qvwTOG9
   AhOYK0oblMCCa1vDuj4Dqo6NfLknfuzPk2akDsnSMEOMUTuepTtyvjv23
   Q==;
X-CSE-ConnectionGUID: NCg6vtgHSAW7fovYz5XHEQ==
X-CSE-MsgGUID: UMUxXkvPT6asoSsgnIZvxQ==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="132688741"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:38:11 +0800
IronPort-SDR: 69255ce3_eKpsTCBiVB1J40ecvJlyjoqE/NbJdzTtNCL8HC3b1X++Nnm
 EFwh9+Ax1RnbwF1H16L6FtLoP1nSmLc4SjW+JNg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:38:11 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:38:08 -0800
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
Subject: [PATCH v4 11/20] blkiomon: read 'magic' first
Date: Tue, 25 Nov 2025 08:37:57 +0100
Message-ID: <20251125073806.50762-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.1
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

