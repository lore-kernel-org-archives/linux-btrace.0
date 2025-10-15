Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE689321448;
	Wed, 15 Oct 2025 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525879; cv=none; b=djEVedKZOaQ2w0t1rlcPDiJRfiNckcnPsCLqy3Pxv35IHHIbmhunxHxGKKIFF5toIcb01bgYqaqtTjdKKO8D12Iwe+OFau51ZlBeoOgEAs+N7lpi9JSIMCJ43B8tAIuXhFLqwrrpvVMFzDEI2IB9MbUWd+AQcdZAJXl8tHm0a5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525879; c=relaxed/simple;
	bh=nrVNfhwCQTLkgVxk9oq1vWA9GizwOPAGrwaJjZXIj0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8CvmV3Zhnkoc9n+t6Tex/EvRhki0kgQMne+VRs9qPWqGo+3EUVn017HB/3KRKop6h/AP6GRK2WuWHW6SQ9D2vexbpzKMPI8O3RrktszTv0ZdrZ7o39c33oz2WKvXRl8jpn81Vm26yrgk/Vi9VYQIDOZ7psaP4txw94Z7a2xdow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qCcl0MC4; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qCcl0MC4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525877; x=1792061877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nrVNfhwCQTLkgVxk9oq1vWA9GizwOPAGrwaJjZXIj0A=;
  b=qCcl0MC4474KB/z/d3D+D1CKViJHb/g/XdUuLuo8IW8Rq/pS5CvFNoyP
   2zY6L9Fgf5bt8KWoSEfVGiRACsNHG41mgzz39Jz0sschZOvjaZ4CSrBk1
   S8/ZjVOlpT5bEIUjAUUwul1aLrbuT+rYmBnpuC+/oXsL9WpJsDiWFBfjX
   SuO6weRWyGCLYgH4q3GQRMUZ+onPYQK+ILA2kPu5j5XphNqaLt2ongXBO
   1vhUau9Xcib/DUWlejMGLaWzmqreLEW29iv2CZcThWHamB8PM7jSN0aWo
   0WF+cnOvzPgOBI89134pq0AhLkovm5TL9bhx7HweurVqSV0PZI/BmTvTO
   g==;
X-CSE-ConnectionGUID: zUGbVLekSdqGM8ZyPUtKZQ==
X-CSE-MsgGUID: zdt6nNmqQoekV1+qKY+tvw==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935399"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:57:56 +0800
IronPort-SDR: 68ef7e34_CnwAUcPOpUiEkFTOllQIlMDpI7x2FKQ1N9tllySQxu8sG56
 Ouh97YG5pqZaIIs13/Xe6ZQe1A3JB0J7UcysYow==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:57:56 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:57:53 -0700
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
Subject: [PATCH blktrace v3 11/20] blkparse: make get_pdulen() take the pdu_len
Date: Wed, 15 Oct 2025 12:56:49 +0200
Message-ID: <20251015105658.527262-12-johannes.thumshirn@wdc.com>
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

