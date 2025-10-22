Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FEB33FE29;
	Wed, 22 Oct 2025 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133312; cv=none; b=oql9iMMoe++vTiGgwx5GPWUIq31a06ekqtMy5DX44/0QfKcXH/BFQ9CzNIKuxba2cLDTNnA5JdHjjxmQXoWij/RJ8rYwVJLClA+mx9V28ShQfil3s5A1XVg4lHBf8HvAYIcLcmzPwj7DR671qLe9a6Rq/6jiXARyknNmBPCzGz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133312; c=relaxed/simple;
	bh=6UqJq2BMhc+A1IyyPDtrogLrG71nL4mSKTyglrkvdQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=th8Lx8K4eQmW7E0WCQnKN9isqJfn+Nc3smdtAtlKjFrzqtwXcWZ1K/MB4nS2gM8XXRS5LRDbVBnnA2/9TY39uAqDFn1UxEah8RRlfwwLcj5KrbGCv8+O8uvhMugATHc9B0REkR0u8W7UrGPfH2nY4TEaDpp3uKD6fZVL6dYjggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GLKNrGhz; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GLKNrGhz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761133310; x=1792669310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6UqJq2BMhc+A1IyyPDtrogLrG71nL4mSKTyglrkvdQU=;
  b=GLKNrGhzCVGyGGbrqQ1joehRhazdOmrGijCAIT8oogTMT+0pFJJNUYL3
   jgZlZAmnfmg4w3YwMj8GZwZtZvHuJkgwqPqwSeKUuqGweCbRcJuzW2sjc
   1aEpaIrMjY0iC9JdaKTVNSi8cscyFzpT55CltPeC+wdG91Fm4O9OYUyKs
   MOIUxnc48hNazgCn0lGdJERoFfARxzVtmUIt5ukYcWCMMmUUJkNi37Itw
   XGXFGaDg4p6QQN3iaR6TADYgKSixuwsjADTPPmqZRY5tIZJFvhrias2mK
   p8L2p7OW5sbyivymFAqi6djpHj7sDYBHt4TslRQNn9Cf42dREOJrFKYkx
   A==;
X-CSE-ConnectionGUID: 41vOPZEyTT6kTYhzpxwwCA==
X-CSE-MsgGUID: ohx/GmI4SHum7TEDWQMqtg==
X-IronPort-AV: E=Sophos;i="6.19,247,1754928000"; 
   d="scan'208";a="133361422"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 19:41:49 +0800
IronPort-SDR: 68f8c2fd_ApjH2wFii9jCPTTysdtHZI1LY/rYNRwHryMoPgue9ZoeggU
 OPEtiWrLAln279TR+yDG4DC6Dvcq7ZsYZLuIzGA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 04:41:49 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 04:41:43 -0700
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
Subject: [PATCH v5 04/16] blktrace: untangle if/else sequence in __blk_add_trace
Date: Wed, 22 Oct 2025 13:41:03 +0200
Message-ID: <20251022114115.213865-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
References: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Untangle the if/else sequence setting the trace action in
__blk_add_trace() and turn it into a switch statement for better
extensibility.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 51745832c713..11e264f67851 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -278,10 +278,19 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	what |= MASK_TC_BIT(opf, META);
 	what |= MASK_TC_BIT(opf, PREFLUSH);
 	what |= MASK_TC_BIT(opf, FUA);
-	if (op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE)
+
+	switch (op) {
+	case REQ_OP_DISCARD:
+	case REQ_OP_SECURE_ERASE:
 		what |= BLK_TC_ACT(BLK_TC_DISCARD);
-	if (op == REQ_OP_FLUSH)
+		break;
+	case REQ_OP_FLUSH:
 		what |= BLK_TC_ACT(BLK_TC_FLUSH);
+		break;
+	default:
+		break;
+	}
+
 	if (cgid)
 		what |= __BLK_TA_CGROUP;
 
-- 
2.51.0

