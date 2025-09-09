Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3704334710;
	Tue,  9 Sep 2025 11:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416083; cv=none; b=I+H89isOG5kbvcw1KDqctgbzM3mf+TQKqmugsGDD0xtlA4M3ryR/pd/6cJSzu4LAfDpqVzwM16/oZsXGRk8fqd5lPL6hv5J+SNeiaOftIiq+EJBZWFNuT8Ce2BMWeXy3951L+tkiyzuz3yVi03I96GNNUsN3tBc+r9orwlEOXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416083; c=relaxed/simple;
	bh=RGAsutA2LvxTDqGe9NrO9ENxqQJN2cUV2soMGRzFjgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VUtQquU6659Qq6FFdbzkcTuEUnlJRkLgO5y43fLTK1yNpdaejJ2p01/F8UEof9D6pYMNES4FwIxwvSvNnUjsLbkPVYYMvCzcM8GmZ28rqInoeA10tBNsM1MAWKpuXZuTOFScByLSov9+xZbKH1lRkzaC6Wm8H+fUZR1bFUySCTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NxQ1FG6T; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NxQ1FG6T"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416082; x=1788952082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RGAsutA2LvxTDqGe9NrO9ENxqQJN2cUV2soMGRzFjgc=;
  b=NxQ1FG6TjAJOqM0KFeUBv9Fv9jd5p3LCY/XUQQqp0zWXAqaMSMrzDbzw
   vF91r+DHZia4aEuUiyckSz+auCbCj34rIiaXUL4SQMHhDszUNNBQYYN3A
   Q4eFtupFvLlGPZJkALkH2QfWU4sRVACdHAwdqJoLuUZ7LMdvog+ZriXBE
   OA7e9joLAKq0TbMHuvuVo1pFw6K/7NXHv8LkF1IshYsgj72QKxw06cVOk
   Sh0OHCjHW/6WoHlVTY8ip49mCOTCFwSYngVsDokRbEdbc7jW6jZxWQwiV
   jJ4+pjFQtS1RKcwHuFZlGYpE73On4jYHPNfNZPpWHvAV/MTyMb3AJkDhG
   A==;
X-CSE-ConnectionGUID: ajZJFarURqST8sY75Fah4A==
X-CSE-MsgGUID: DtMcEZIKRzavEBMr8AKf4A==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810686"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:08:01 +0800
IronPort-SDR: 68c00a91_tQcjyT8ZJpwOok773ZhUYYYcP8f35W/rlFrhjkAhoY32dVs
 ZJHyHStnIicVwep9OBeWK6RDvchkACuvdFhAsTg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:08:01 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:07:57 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 07/21] blkparse: pass magic to get_magic
Date: Tue,  9 Sep 2025 13:07:09 +0200
Message-Id: <20250909110723.75676-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
References: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
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
index c720af6..03df2a7 100644
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

