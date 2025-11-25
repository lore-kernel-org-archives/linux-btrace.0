Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B572D839B;
	Tue, 25 Nov 2025 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057147; cv=none; b=RQorEG65prPScBid85qRJM22wKLRe6RqRbYDazcDj69NL3+DW03Zieu11un1Dt7DGejuN1T7B1VmTy8r5xJZx8MARxBQYPlmXcatd//6XpyFir0swHwdEfsWjlbNZmHnmdVAzIQQlOE+d5bAbXffjlpCVgPnDSHLnh/US7fDpVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057147; c=relaxed/simple;
	bh=tex0ATmbu68rvisWlUOnoso+r6xR5x0Sb3D09NGiMko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1vtTAvnES5faxxG1A1QGv4IYRsGcyUJREBrN6nZRDw8sk+kmoGdxW8DaBvQEakPDtIj8MTl0EVucKxlvOzY2uceSYfxQ7ukIzc7U9HUZn++qqNi3vqYCIfJHphgFpcEWBAZXrpvBrHwaKqTqZELSeXhE/N6sBrDPMsWl2qVdpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=H4HqaKjX; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H4HqaKjX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057145; x=1795593145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tex0ATmbu68rvisWlUOnoso+r6xR5x0Sb3D09NGiMko=;
  b=H4HqaKjXzpJysOGD2LgyX/PXg48f+lgsKmQNdcaRt+nRi5KRLCGF6yL4
   /2fjuwuS3Sf94qUjMsxSRmDtf0vwQs5V+NU8RtfFJS22y/u2mxOirr2B/
   65ypiWZuPc4IL318FnS8CTYkDWWNIfQkdQykAtwV6bV3vr4zo6JobL4uK
   NY4Q5i6LpHxRvREZRA963Yzk52km2/Tijh8dHhdaiYpIrCByJmYkk73y8
   siktiH5BaSfLsOj2XB+m7GCpv4mhC3zBwzPLkEgquIjYd6Q1/IxR6ebLq
   Ke9mRmyPErgw7c+iMwZnmqSHS/VZrIrR9IabaEAMpzGg/+3R+LE614Q/b
   Q==;
X-CSE-ConnectionGUID: ZLyDBShmQsGLkXmGgm/ypQ==
X-CSE-MsgGUID: ZTFf0HS7Raiig//ian5MsA==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749799"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:25 +0800
IronPort-SDR: 69256039_n/8U2Z/+oyz7v9+PIJvpJQg5sdV5CHXym7TSo7NOF/MiHqR
 L6gc0Y/pZIh/fBumFyG+qvXKe0hg6E8k6776REg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:25 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:24 -0800
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
Subject: [PATCH v4 10/20] blkparse: make get_pdulen() take the pdu_len
Date: Mon, 24 Nov 2025 23:51:56 -0800
Message-ID: <20251125075206.876902-11-johannes.thumshirn@wdc.com>
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

