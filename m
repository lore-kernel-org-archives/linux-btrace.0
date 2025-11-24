Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D163A2E8B8B;
	Mon, 24 Nov 2025 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969907; cv=none; b=d69chm0ctQn6nYu0+j14LwPJsBwHmY4cuwe/bRfiedYbGxUTJzljh87BIBI5CCDCCDi/7/FpsI8M0hy+tPoi0YJpVzGKemA5JalOzWerM0az8vQqmEtrZcqhQkNEQnSjbyohg1URamze2zTKyihbDHxu6EwkmbD7/0tP6evdClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969907; c=relaxed/simple;
	bh=nrVNfhwCQTLkgVxk9oq1vWA9GizwOPAGrwaJjZXIj0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQ97AbhL1H8SoGcqOFs0jeoH3DNfXh41mt3OWfqQAB6iSM2Kb31oPqB3I4HZcYFVwS0FLWJ41mABzqqnq2HNxI8/uy2qNexWouKi8Bs8pypSxu/Q0ro8XJCpqQMLVJquVSmedb7TCc+A1vaSN5aC0/PeJw8uYKmUO1/WDUG/ybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MJ6h5uwh; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MJ6h5uwh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969906; x=1795505906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nrVNfhwCQTLkgVxk9oq1vWA9GizwOPAGrwaJjZXIj0A=;
  b=MJ6h5uwhussF3T5nTd0VEgi7W2BhWMbDsSIiuKSjICX9EAPoSsiQNQge
   4LI7j13nG+0/muJxC+6OpF/IOYPPleL+pi/3XuQq7P05p++DMuDWfbgZJ
   2pz31usrYJ6eNHLs9k6SA7PCI5RR7GYwMT4jL9l16NmeSScJ4PxI2U32A
   /UGE2ySa5gnrtXT8z6mJRmeylpkRwd2/qupefwruH7ulhtekMDkr2ykZ1
   4mPgwGHwHiucNqRZ3e4/qz0Xvv6IO9DnVg220I2MA88Jf4psJSRgOL2Sj
   bKK6Z6cX03CjwpKZXQMy7itFsLryIWE+6wtH9qA4xu86DoffyRCvxYNHO
   Q==;
X-CSE-ConnectionGUID: W9V00g6ST3S81DiykZbaNw==
X-CSE-MsgGUID: 7ij2bsKsTh2lJRU5ZXucdA==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619365"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:38:25 +0800
IronPort-SDR: 69240b71_6vv/TFE2Xn0wiGhxMP2IQkA+h7ll1LlUtHY+EPw/UfjqMtZ
 lnS+LSfYjgivpF5XTwKMzJhjUOcmD2CXFWYkw4A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:38:26 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:38:23 -0800
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
Subject: [RESEND PATCH blktrace v3 11/20] blkparse: make get_pdulen() take the pdu_len
Date: Mon, 24 Nov 2025 08:37:30 +0100
Message-ID: <20251124073739.513212-12-johannes.thumshirn@wdc.com>
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

Directly pass in the pdu_len into get_pdulen() and only care about the
byte swapping in get_pdulen().

This enables us to use the function for different versions of the
protocol.

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
2.51.0

