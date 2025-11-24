Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681A22E8B63;
	Mon, 24 Nov 2025 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969896; cv=none; b=uFbAhAanjCkD5K7YLaTU6Caxv0Ap+k7GH65g0MijuUjhFM1t2xmqpr3ZyUwopN7OAoSz51AiB3sKv6DZ3UcEzJYktiuPG6XFfnTp1w0GlHLCrGmv1SVoMixcq2ymF9f+1/FCRqtdPVlyUMaIowjGbtsIOodMsF5jkTxHuSOxiRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969896; c=relaxed/simple;
	bh=FTAoOSz6/+aBx9BQg8CKa15JSKRi7Q8RjuynnHXeh2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slJPDpSPvdVQzImaeYoUfJaRQpPu7nDmTipsPI9nwfR+WEWqMbv4bnu+yEuLgJCkKSfIusAuc/EATnoIsKHdpViFPC/eFqDcxapYH2HhWHow6TjnO8ooH38sAMxtYnRR91VvioUxNbtRDpVY+ItA8+vAfEhAtnujxXF5QRdAO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NVoQjx1a; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NVoQjx1a"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969895; x=1795505895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FTAoOSz6/+aBx9BQg8CKa15JSKRi7Q8RjuynnHXeh2U=;
  b=NVoQjx1aCk4YVjMFGUnDVQtgbGacsrB2imSsu3MkiL/mFx4h7VFNIPis
   jorSEtOc/e3uFrl1u4pnayW9a6I/NOryXK/Iz3ozKF5PQI7JZLnbzCZ5x
   TkOByxOAvby8s83z3oS9XfL5NJVnOVeDPhSDknYLoQ80tLj4CLlxPRxOC
   xXKcW8DXN/Xm/2spKxsJOTUlr2EjBimTrjKriQimpKkWGEHGurjMa2wxM
   kdLSaFkA4C3GKN3CGGncHwwFfHfvPFfBH2keO2fkM1HN/JbtCBhw+pHW8
   zJ7YQuA9zDFDzcLVFRNagJcXWzjsE2ZdmskMmwG7mjY8qDAmtfgnsk/N+
   g==;
X-CSE-ConnectionGUID: icYX5E7iTX6SpE5H8qcDIg==
X-CSE-MsgGUID: A6uOVFZ3ScaOVg6hsGlZSg==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619357"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:38:15 +0800
IronPort-SDR: 69240b67_9UOzTcVxCIihBafl4tjH6KEkoDeWVlZ4lLLSgocjUj+N1SM
 eO4EpZLdm4rAXHuUs3X4NKA4jGk4pMcZjSRvGqQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:38:15 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:38:12 -0800
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
Subject: [RESEND PATCH blktrace v3 08/20] blkparse: read 'magic' first
Date: Mon, 24 Nov 2025 08:37:27 +0100
Message-ID: <20251124073739.513212-9-johannes.thumshirn@wdc.com>
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

Read the 'magic' portion of 'struct blk_io_trace' first when reading the
tracefile and only if all magic checks succeed, read the rest of the
trace.

This is a preparation of supporting multiple trace protocol versions.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index d58322c..5645c31 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2438,14 +2438,13 @@ static int read_events(int fd, int always_block, int *fdblock)
 		struct trace *t;
 		int pdu_len, should_block, ret;
 		__u32 magic;
-
-		bit = bit_alloc();
+		void *p;
 
 		should_block = !events || always_block;
 
-		ret = read_data(fd, bit, sizeof(*bit), should_block, fdblock);
+		ret = read_data(fd, &magic, sizeof(magic), should_block,
+				fdblock);
 		if (ret) {
-			bit_free(bit);
 			if (!events && ret < 0)
 				events = ret;
 			break;
@@ -2455,15 +2454,28 @@ static int read_events(int fd, int always_block, int *fdblock)
 		 * look at first trace to check whether we need to convert
 		 * data in the future
 		 */
-		if (data_is_native == -1 && check_data_endianness(bit->magic))
+		if (data_is_native == -1 && check_data_endianness(magic))
 			break;
 
-		magic = get_magic(bit->magic);
+		magic = get_magic(magic);
 		if ((magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
 			fprintf(stderr, "Bad magic %x\n", magic);
 			break;
 		}
 
+		bit = bit_alloc();
+		bit->magic = magic;
+		p = (void *) ((u8 *)bit + sizeof(magic));
+
+		ret = read_data(fd, p, sizeof(*bit) - sizeof(magic),
+				should_block, fdblock);
+		if (ret) {
+			bit_free(bit);
+			if (!events && ret < 0)
+				events = ret;
+			break;
+		}
+
 		pdu_len = get_pdulen(bit);
 		if (pdu_len) {
 			void *ptr = realloc(bit, sizeof(*bit) + pdu_len);
@@ -2596,20 +2608,30 @@ static int ms_prime(struct ms_stream *msp)
 	int ret, pdu_len, ndone = 0;
 
 	for (i = 0; !is_done() && pci->fd >= 0 && i < rb_batch; i++) {
-		bit = bit_alloc();
-		ret = read_data(pci->fd, bit, sizeof(*bit), 1, &pci->fdblock);
+		void *p;
+
+		ret = read_data(pci->fd, &magic, sizeof(magic), 1,
+				&pci->fdblock);
 		if (ret)
 			goto err;
 
-		if (data_is_native == -1 && check_data_endianness(bit->magic))
+		if (data_is_native == -1 && check_data_endianness(magic))
 			goto err;
 
-		magic = get_magic(bit->magic);
+		magic = get_magic(magic);
 		if ((magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
 			fprintf(stderr, "Bad magic %x\n", magic);
 			goto err;
 
 		}
+		bit = bit_alloc();
+		bit->magic = magic;
+		p = (void *) ((u8 *)bit + sizeof(magic));
+
+		ret = read_data(pci->fd, p, sizeof(*bit) - sizeof(magic), 1,
+				&pci->fdblock);
+		if (ret)
+			goto err;
 
 		pdu_len = get_pdulen(bit);
 		if (pdu_len) {
@@ -2639,6 +2661,7 @@ static int ms_prime(struct ms_stream *msp)
 			handle_notify(bit);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
 			bit_free(bit);
+			bit = NULL;
 
 			i -= 1;
 			continue;
@@ -2659,6 +2682,7 @@ static int ms_prime(struct ms_stream *msp)
 		}
 
 		ndone++;
+		bit = NULL;
 	}
 
 	return ndone;
-- 
2.51.0

