Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35942E8B61;
	Mon, 24 Nov 2025 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969911; cv=none; b=CRohnqh8Tmack3zlb+fChulcEnBqbCTRwCrPdDLDt+NH3un/ySnNb3NKnAQv1cjbLRkXxw5IixfZL0L78hLx1kNap1zgilb3wDIfbNlELArI0vODgmpZfbUNEgFOmXgrq2F7ft+zYq3GnvKmGx3UPxEL+3+RcG0rhvKIJzJ8riQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969911; c=relaxed/simple;
	bh=7x/8BV1VwYtiCopSTQrOJDK3TC6H2EX5xtil7lp16lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYDsgR38wYInvPBGltIvk/cCIT7nYSGb2e0dZreAmC3DKkTRdcdAImyXGCXdKDmh+CE6Tmg+QMshtouNCPLdZ/F3eM9svZpgQyaGVdeiH073d80DTrPwBqIYUtY6+w3B4i6w3SL3YaZfubhHsWSPrIls/EfcC5CSXOd/UjAV1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qpKobvgF; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qpKobvgF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969909; x=1795505909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7x/8BV1VwYtiCopSTQrOJDK3TC6H2EX5xtil7lp16lM=;
  b=qpKobvgFGHLf1wNw34S/vzbRWAepvfz3XYZTLPvE26Dg11HxKGwMElYr
   hsv+uvUj9Zr/9jH9PL9s8HWEAHtHM2UPQkIHt7Gi1/iMJTea6LpIGXeTF
   6LohPUl5jO+FXJEMOQkmvhSI+bTFzj3oqhVdtGbYeCZeN3/n1XlXi526B
   TQalzm66QdyOvB6i9jBWs0BbBxDoq6fOCV27m4HtpjX1PLF+hrnLJSJLa
   bUyxKM2/PckJ14bNOhfbFN6aOTuNfYkPDJQozjed8QRC1o5Ige3LNepX0
   GV7pyChK1j9+EL7hV7B8UcrmFicmzDX1OfHZxIoHDWGAoV1M57sAWW/Bg
   Q==;
X-CSE-ConnectionGUID: SmXBj9gWTV69v4ZsrKqTIg==
X-CSE-MsgGUID: 1xQ0FQ+3QmKD2zKEOSfSUg==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619371"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:38:29 +0800
IronPort-SDR: 69240b75_wYUupuTMOkTEcEG6HeQMohJ+lnx06IMPCoUzHNQkt37Rog8
 BHGLQFJ+5k+M/UJzGNWONdgINv6KGYclU2Vp5Yw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:38:30 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:38:26 -0800
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
Subject: [RESEND PATCH blktrace v3 12/20] blkiomon: read 'magic' first
Date: Mon, 24 Nov 2025 08:37:31 +0100
Message-ID: <20251124073739.513212-13-johannes.thumshirn@wdc.com>
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

Similar to blkparse, read the 'magic' portion of 'struct blk_io_trace'
first when reading the trace.

This is a preparation of supporting multiple trace protocol versions.

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
2.51.0

