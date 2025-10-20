Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926E320A10;
	Mon, 20 Oct 2025 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967709; cv=none; b=UBNO0YKgECrsaqjlJq6tQUCx4/1JQvz+voqn66iAE9SwO4ggjCx1aaIe2wBhYuwsCunPeT67zECElJjvSO4SBH/woyzlwQ+n0tdHmrYGl2iRiXhIkxnRr+z5RMC/WO541xMCYQqwo4AvODOfFi5HZ5dVL39OGLQoqAdIH8UNccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967709; c=relaxed/simple;
	bh=cRZvJizN4tgFy915/GAfu4RFBsW6lFtvyycmhNBSCD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMJhd13bFtn4gkoywQylm4X3WsbnZ5mTJQXFC64XlyhcKUMbj/W9IcQnxJ4f5mn20tC+khu6f0c8aWlYzL0/gtWFw6iADVGiJUgUjt4EJ65Sb3pqRahPV7LUdJW6WEEIIhBG8LYt6VeckKkYbaIR3JOuT5xPj7+T3H3aIOlfTxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Eh1d5LWj; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Eh1d5LWj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760967709; x=1792503709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cRZvJizN4tgFy915/GAfu4RFBsW6lFtvyycmhNBSCD4=;
  b=Eh1d5LWj7os7KGmirPoauJjMkfNdLQKZqb25bR7Ggid4eL2O2EXPsstT
   gVouaPHxR2AdsxkT2alNNGiWjD+nbbnFxdq8gGYGnI6PnHf7q404ynG8L
   49PwjCXzQ/jfjOmzGQhv+nMNlD5yxivYxlBbtOXaYUcykzObCnqpCk8H7
   FItkp1Ot7r+7razgZyJ+ZE+oGzEedxa0xE5ZNICeJKiMrDvI/f8xrQ9Wf
   ZYCnhGCkrubzFZMNIURnJUOm0RWeq3cZYc2hSRoeFhygNDvP4cr027+yd
   zrDD+EkL+Vs2xLI7qos1hoJgePm2oRWnejgbSpsN2atpCExOg1wyr7rqn
   w==;
X-CSE-ConnectionGUID: uDQYCGv3QpqWSLtqKg4UTg==
X-CSE-MsgGUID: LQK60W2ARBaqgyeGH+QuGg==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134518626"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 21:41:49 +0800
IronPort-SDR: 68f63c1c_Gh37I5uv5XLeLZb/7kTBchI8urzN+/OUDBJyLf4F8+7yG5P
 NjzR1wnbGLMYLVc7dEvfefJt2T1wThJtn3eO1oA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2025 06:41:48 -0700
WDCIronportException: Internal
Received: from 1pgdl13.ad.shared (HELO neo.fritz.box) ([10.224.28.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Oct 2025 06:41:44 -0700
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
Subject: [PATCH v4 04/16] blktrace: untangle if/else sequence in __blk_add_trace
Date: Mon, 20 Oct 2025 15:41:11 +0200
Message-ID: <20251020134123.119058-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
References: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
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

