Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD7A3218CE;
	Wed, 15 Oct 2025 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525860; cv=none; b=XGQwDPD84dsPVT3WfqYQrSd6RTpbaZKTsRqg+72X/DfoOf+K1PL0uPIV/372XHWrUGNjeM0TrrQ63gVZNXqqbLp4WffVaLG1Yk4kixZdf+fPmDpl+32S/KLckZRzhopIeSTwDH4xGqZJK7Ll8k1MAkGaVLca8nxMwsiO0j/m81k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525860; c=relaxed/simple;
	bh=oyYrdXwqykM5wRW6N9yWSSyE3TZgc1QhkApGxvOpN8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xn4b4I4nr8xSWgMFxojgm6gc4XUrff5wzw4XZREoaFEOiWgxTNuV2QTswQtk0cQ3KuTg28namRgP5jvsJF++YUzZ14aDt7HEA5GKEJgD+5lrOu/bdJd/oX6Rzh2pB0wsUTA+yk4Ef6ThWDSA1MmkD8NGW1746qhRLfAGDNtG7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pwJVHRMk; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pwJVHRMk"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525858; x=1792061858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oyYrdXwqykM5wRW6N9yWSSyE3TZgc1QhkApGxvOpN8Q=;
  b=pwJVHRMkfpafwiqicVnlQDlywq205uTPfCQmIXl22DgHkV3bKvo/HlZI
   JX+3L5DJq/BTLIb5SthjTfCOpAWUOc86UxexnBnC0Tk0+eidiVF/Nq4Ki
   8a/32Bv52HEh0nfIY3i9DMkLs71AKE3ggzK+E6r8Nn4uGeHrqeCEykoMl
   bWhkFRId65Hz8A+qDpXEuqIdNfa/FJshyQm6r2/dZQYNY1HA09fLoO5Ju
   nc51TB6MR/9gzHH0bnpRiDsMD7CNTfqvurIrkJy3EK0KF7iMVcvhDAENj
   grYhsHWz6qUIIw2esg3k+D5RPtrUL4KGa967uYAY/byN6CWS9BRq58BND
   A==;
X-CSE-ConnectionGUID: 8mppDlqoRzq+8ZhmKVBnTQ==
X-CSE-MsgGUID: QIE3t4W8RUeDHyhjGro6EA==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935374"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:57:38 +0800
IronPort-SDR: 68ef7e22_nd1itwFCDyNGoH/R36bixjY1w2HE49iVIKWfaAakpRBVB8i
 VFwNKm5vv07jSvACDXvadTPGRhmj0JWzHfdmNMQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:57:38 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:57:35 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: axboe@kernel.dk
Cc: chaitanyak@nvidia.com,
	dlemoal@kernel.org,
	hare@suse.de,
	hch@lst.de,
	john.g.garry@oracle.com,
	linux-block@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	naohiro.aota@wdc.com,
	rostedt@goodmis.org,
	shinichiro.kawasaki@wdc.com,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH blktrace v3 07/20] blkparse: pass magic to get_magic
Date: Wed, 15 Oct 2025 12:56:45 +0200
Message-ID: <20251015105658.527262-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
References: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
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

