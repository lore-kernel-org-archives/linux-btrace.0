Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DC72E8881;
	Mon, 24 Nov 2025 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969893; cv=none; b=V4V06CQIS0mAIcHha+dZkmx0oMX4XIcg60RYYJ7l4+fi3yFq4kTjl6m8YvM6T18KbKnp6OsQimXM08HI4OWhHxDOHgs9ZfOtO3aejYIica3k3421wsz427jowU2vvlz6UUydz9uVeDID8t3g8cJ9bRFF/KGxhSdRphWqLG0+klQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969893; c=relaxed/simple;
	bh=oyYrdXwqykM5wRW6N9yWSSyE3TZgc1QhkApGxvOpN8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoevTAOc/QA83lbwuWNgTKdgxQ5jKi4i/4kX5KvPw0BwZudR6eXb+TBu6SuXRKdgGEv/0pSsMc18YDb6yY2MkemeBP2iNTtaEo9PaKTH3WK2jSeSBX3c9+D1xUzjQOMVFU5SeC9I4sfw8vaMtM7v/cdSKNj6ulfySFQ4sHYvlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ABtslBGg; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ABtslBGg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969891; x=1795505891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oyYrdXwqykM5wRW6N9yWSSyE3TZgc1QhkApGxvOpN8Q=;
  b=ABtslBGgn8y2FZj0RLdghFeOkq0sUpjkuRx/z46SCBl8Q7tVkKvgzNxf
   7wCwHgswVGLSXDZRErLdZtX8YzuKEMiF3k7z4aQI3+/ClMsFTKU80bYo2
   td7vijwehYhVcwRIMW5Jvwa+UfljczdcAz7qUk0ym9Tx4iYcbATIJpRqA
   cSBxHG8d0l79PiYe7rgs00T+Oxcbfi2bZMGlpCNqgPB6KLiltEEb+1Cgg
   nEw0lStL2kBZmRtHgodwZ4RoICHJCvl4tymDPQmpDkNEFHmzNilUj8v6l
   SvuWTUcMj11n1thU6PuqHbbFg99tJ7XfOguiDlIORnDlxh/vV37bR3+IK
   Q==;
X-CSE-ConnectionGUID: MkhAbs4LQcqksS4Lp5LZUg==
X-CSE-MsgGUID: f5qoMjDlSemo57rBPwaRYQ==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619355"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:38:11 +0800
IronPort-SDR: 69240b63_nLt3Z6qhSnQ0jiMT/1LL6IUjxqrQKDCE7X/+wq+StUPCHn6
 WjnGgGiBHqsb48wcvSG9hdxfx/Pshnip39/UXaw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:38:12 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:38:09 -0800
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
Subject: [RESEND PATCH blktrace v3 07/20] blkparse: pass magic to get_magic
Date: Mon, 24 Nov 2025 08:37:26 +0100
Message-ID: <20251124073739.513212-8-johannes.thumshirn@wdc.com>
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

Pass the magic value to get_magic() instead of the whole 'struct
blk_io_trace'.

This is a preparation for distinguishing between two different types of
blktrace protocol versions in blkparse.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 512a2d2..d58322c 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2420,12 +2420,12 @@ static inline __u16 get_pdulen(struct blk_io_trace *bit)
 	return __bswap_16(bit->pdu_len);
 }
 
-static inline __u32 get_magic(struct blk_io_trace *bit)
+static inline __u32 get_magic(__u32 magic)
 {
 	if (data_is_native)
-		return bit->magic;
+		return magic;
 
-	return __bswap_32(bit->magic);
+	return __bswap_32(magic);
 }
 
 static int read_events(int fd, int always_block, int *fdblock)
@@ -2458,7 +2458,7 @@ static int read_events(int fd, int always_block, int *fdblock)
 		if (data_is_native == -1 && check_data_endianness(bit->magic))
 			break;
 
-		magic = get_magic(bit);
+		magic = get_magic(bit->magic);
 		if ((magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
 			fprintf(stderr, "Bad magic %x\n", magic);
 			break;
@@ -2604,7 +2604,7 @@ static int ms_prime(struct ms_stream *msp)
 		if (data_is_native == -1 && check_data_endianness(bit->magic))
 			goto err;
 
-		magic = get_magic(bit);
+		magic = get_magic(bit->magic);
 		if ((magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
 			fprintf(stderr, "Bad magic %x\n", magic);
 			goto err;
-- 
2.51.0

