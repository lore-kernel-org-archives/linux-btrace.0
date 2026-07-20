Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A63F9F5D;
	Mon, 20 Jul 2026 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546105; cv=none; b=NJSwWfjNu5xmabktw9748UbYQUVavGeQtuOcteTZBvOFdjqlkzXeYyqQYudenWx6XFHiz8NHBPOE41R1KRSxsp4twSlClUo6LPb5vhWT5o4u6RWfk98sL8bJY+mTTxHoMbBSVWn9Izji2vzRyXW4wKosYUUgGJfDcwvIrDmBn4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546105; c=relaxed/simple;
	bh=DtcAiVoqiV3zgcU2kKG7jUbxs/ol4xZorL6HVpmEzv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kw6dEM6W7qPY4RdRbltMSMBmMNdlVAUBRMlM0gX1Hod7ICWcP/1wayoupw3BPCXB52MQ4DHR3bF+Ip2qJ4BAGIaCjs34JoXBiqfYS2SjGRTjznD4u0jai0t3iwylzA0BWxwAq3lorg8vOG4TXmQpJrpAHwc7YIaddAndGNe2lFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XhPyUoHo; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XhPyUoHo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784546103; x=1816082103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DtcAiVoqiV3zgcU2kKG7jUbxs/ol4xZorL6HVpmEzv0=;
  b=XhPyUoHo6cPbDmszRSBDP0m5TTyrGObttnbbYbhdwVaQHljgWDtC+feV
   a/hZ8ljJthdYDGKQDW0cejKSzxr6aeFRAokqv+3RNnu49a3mXvqkMw8ng
   NUkAdjFUWTfpZvySsI0EaxRZhscjCCFbld7khDYGulZPf0RlWbWyhRhjJ
   5eZ9Lmi690TaPx4ZIEZRiFfzz+KzU4aIyPMhaGaj2xhMqe2v/2wdp7JkU
   TYGD59IqrxRCF3qxXDH40QvW52GqbcDkBepCmpKFaxInqNE+L1sXsV8bz
   bPcyYRxqDCtDBNC6qKNm/kd25UC/tnLPc7fgIr3AyPkQ0HPfyU6VMDIdv
   g==;
X-CSE-ConnectionGUID: R6K+LMfQSuWr0gdYwLWcgg==
X-CSE-MsgGUID: 2b/3ipPIR5uydYeIv7ADNA==
X-IronPort-AV: E=Sophos;i="6.25,174,1779120000"; 
   d="scan'208";a="151105452"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2026 19:14:51 +0800
X-CSE-ConnectionGUID: pSYaDjzMQt6mYHU52ZNf4A==
X-CSE-MsgGUID: XvgnNxcXSm+XGkVuFn6d1Q==
IronPort-SDR: 6a5e031d_HSTvaTTw2mTq+y87mtWj94pFzgG02EZVSxUd/8MNiKndc+a
 WiDH8MsrnDG5ki/7aMLhWQDGfjPhPI8Ej87Qogw==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jul 2026 04:14:37 -0700
X-CSE-ConnectionGUID: BatfYEqoQmW5VxBhi0WsgQ==
X-CSE-MsgGUID: gt9rX7LOSPSkPdywRp3pqQ==
WDCIronportException: Internal
Received: from wdap-kyufgunycc.ad.shared (HELO neo.fritz.box) ([10.224.19.3])
  by uls-op-esai1-o.wdc.com with ESMTP; 20 Jul 2026 04:14:35 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 07/11] blkiomon: natively parse blk_io_trace2
Date: Mon, 20 Jul 2026 13:14:13 +0200
Message-ID: <20260720111417.1658507-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
References: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Natively parse 'struct blk_io_trace2' from a blktrace binary.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkiomon.c | 79 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 27 deletions(-)

diff --git a/blkiomon.c b/blkiomon.c
index 32580a435fc8..081d1a87dfdc 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -465,6 +465,7 @@ static int blkiomon_do_fifo(void)
 
 	while (up) {
 		__u32 magic;
+		int version;
 
 		if (fread(&magic, sizeof(magic), 1, ifp) != 1) {
 			if (!feof(ifp))
@@ -472,39 +473,63 @@ static int blkiomon_do_fifo(void)
 					"blkiomon: could not read trace");
 			break;
 		}
-		bit1.magic = magic;
-		p = (void *) ((u8 *)&bit1 + sizeof(__u32));
-		if (fread(p, sizeof(bit1) - sizeof(__u32), 1, ifp) != 1) {
-			if (!feof(ifp))
-				fprintf(stderr,
-					"blkiomon: could not read trace");
-			break;
-		}
-		if (ferror(ifp)) {
-			clearerr(ifp);
-			fprintf(stderr, "blkiomon: error while reading trace");
-			break;
-		}
 
 		if (data_is_native == -1 && check_data_endianness(magic)) {
 			fprintf(stderr, "blkiomon: endianess problem\n");
 			break;
 		}
 
-		/* endianess */
-		bit_trace_to_cpu(&bit1);
-
-		bit->magic	= bit1.magic;
-		bit->sequence	= bit1.sequence;
-		bit->time	= bit1.time;
-		bit->sector	= bit1.sector;
-		bit->bytes	= bit1.bytes;
-		bit->action	= bit1.action;
-		bit->pid	= bit1.pid;
-		bit->device	= bit1.device;
-		bit->cpu	= bit1.cpu;
-		bit->error	= bit1.error;
-		bit->pdu_len	= bit1.pdu_len;
+		version = (data_is_native ? magic : be32_to_cpu(magic)) & 0xff;
+
+		if (version == SUPPORTED_VERSION2) {
+			bit->magic = magic;
+			p = (void *) ((u8 *)bit + sizeof(__u32));
+			if (fread(p, sizeof(*bit) - sizeof(__u32), 1, ifp) != 1) {
+				if (!feof(ifp))
+					fprintf(stderr,
+						"blkiomon: could not read trace");
+				break;
+			}
+			if (ferror(ifp)) {
+				clearerr(ifp);
+				fprintf(stderr,
+					"blkiomon: error while reading trace");
+				break;
+			}
+
+			/* endianess */
+			bit2_trace_to_cpu(bit);
+		} else {
+			bit1.magic = magic;
+			p = (void *) ((u8 *)&bit1 + sizeof(__u32));
+			if (fread(p, sizeof(bit1) - sizeof(__u32), 1, ifp) != 1) {
+				if (!feof(ifp))
+					fprintf(stderr,
+						"blkiomon: could not read trace");
+				break;
+			}
+			if (ferror(ifp)) {
+				clearerr(ifp);
+				fprintf(stderr,
+					"blkiomon: error while reading trace");
+				break;
+			}
+
+			/* endianess */
+			bit_trace_to_cpu(&bit1);
+
+			bit->magic	= bit1.magic;
+			bit->sequence	= bit1.sequence;
+			bit->time	= bit1.time;
+			bit->sector	= bit1.sector;
+			bit->bytes	= bit1.bytes;
+			bit->action	= bit1.action;
+			bit->pid	= bit1.pid;
+			bit->device	= bit1.device;
+			bit->cpu	= bit1.cpu;
+			bit->error	= bit1.error;
+			bit->pdu_len	= bit1.pdu_len;
+		}
 
 		if (verify_trace(bit->magic)) {
 			fprintf(stderr, "blkiomon: bad trace\n");
-- 
2.54.0

