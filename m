Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A395B2D7DC2;
	Tue, 25 Nov 2025 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057141; cv=none; b=AdVoS5L3jMkfZ/9voKpdKmSVSftffNI5NR3JJvPwC5yRcRPhQDfbTrn+uAPLmq0EmMwZ8wHj5+Gmfpnv8lLbsZjcLQcAHlMl3FY2mZqKFkePgtCiQJ0TDPZHYBggtn0wCqiAVV/SSBbXCS/UMs1lYD6B8818CmFxU2+fx4NzDAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057141; c=relaxed/simple;
	bh=G3WmpyGCEpDpjNEcl5YKSsBhtGJWNglKA7+YSCF9QIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pP7xL7OqFyFoPh5dQEVma/8OLHW+Q5qtfoaVMq+CfMW/D27yUswpdL+EzzKmv3qnych5GxthED1LCczMAiR31lmqJoqU3xPvyBEVnyhbIejyPUzC7+Q8iRA1JBgaJQ05x19x2Q90LFT04cJhxD/RGPy8mltI8AF6YHAiL8Dw+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TmGyx2r/; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TmGyx2r/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057139; x=1795593139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G3WmpyGCEpDpjNEcl5YKSsBhtGJWNglKA7+YSCF9QIM=;
  b=TmGyx2r/CZ6rv8WP4kc5FrduetMHrBINmonzErCSw+yhWZTSZ47xfkvR
   fFJOrfH1qA9pJj85YIxdFYCbYgw1zaXzEoCHeqFK+798i8r+2LY2FNrkO
   D8UR98IAie1BbSJcWk7DIF6KqoBU4uKNJmCnQ/pwk3oE0eLXO25kGsxdi
   t+j98bijAaWS+8v1lynOfnQqRAli/4aBbtTbghPoD3AovXlks2nfGb3Uq
   EKKP4H3hDs0zwrUrUDmgi/315jxjaTPp4ryyM1mRmAlCR98DfNi/w/9uE
   QpK/3ftz3lyd2KGr9tUoNlKtoiM6hWLkGqfLujZjVLq4QIuCS27AuOgD4
   A==;
X-CSE-ConnectionGUID: 98km32i6T7uoTwWXUaJkGQ==
X-CSE-MsgGUID: mk+djL7KQtmv+e4zzYB31g==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749792"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:19 +0800
IronPort-SDR: 69256033_dHx29th0isKVL4f6uPQVAsEZkBrgXGBSZlhSDddebknGVvw
 eieRoE+PxWOFKoQB74t0XMd+SE+8D1vp/FSQpHg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:19 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:18 -0800
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
Subject: [PATCH v4 06/20] blkparse: pass magic to get_magic
Date: Mon, 24 Nov 2025 23:51:52 -0800
Message-ID: <20251125075206.876902-7-johannes.thumshirn@wdc.com>
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

Pass the magic value to get_magic() instead of the whole 'struct
blk_io_trace'.

This is a preparation for distinguishing between two different types of
blktrace protocol versions in blkparse.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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
2.51.1

