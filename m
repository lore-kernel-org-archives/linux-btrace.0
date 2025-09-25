Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8582E5B08;
	Thu, 25 Sep 2025 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812576; cv=none; b=pr2uzm49KGzRdAFuthfG3Zkneg8Ve/xiXWlDJAfYm5vZ9h2Q+8X3gWVOKjmeVZO6CVIN9SEbPrvN/sFlyMGs7Tvo7v1XIuFZWnvqxIZzuS4/Mf4iYZPjU43AUeh+7RseMIAOuFxcpQ4ick5rcadSUustXeal+rKXaUp/1qT5+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812576; c=relaxed/simple;
	bh=hdrv1AmFvqjTD8G//IqirsAhjDI+6iVgBVskbkdogLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5TaLDNZp9f2aWZucWEf9wz+Lk9dKl/EOMtgxtMKPys6KY1k8YAf2xvvKNcFhLzQ0oYaVn9OBykoA8YVUmpc8f9w1WlCdyxaZxi/YO8NpueTO1GHaIk+mEkKTTN9+EnPzhs+M5WzL2KioXPDgkJ1mFWjP2xXPpDbz9N5/Ec21tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=POnwGlkz; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="POnwGlkz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812574; x=1790348574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hdrv1AmFvqjTD8G//IqirsAhjDI+6iVgBVskbkdogLE=;
  b=POnwGlkzDxFO9Ta+/mKr7kLmwR0BJwmmYNT1al0rl8xc168jzgYBy1DY
   YHajYogcBJ90oJGJbENwzbnjWEgXalETuAvO6lAC44Z8P1dPQ4Vpp2lwb
   5sXWJ7Z6WujbpZmzP6O7VYqNdRA1mKwitnLYVb7aCSHqsAzwL8mj8GNtS
   1/QRO5TyVV+bNvA6J6NJ/IEbzG4ARywdMYhCtsvqJxZMCP1w2zfsm7i+3
   dbA0Jq5fgIiXA4xpF0ZG2t9PYH014ho06L/LUZIWbW1MZpcFPpYDUWmyW
   IVNbTDbjEe4orpPBK2pPhmtzBBzRnE3i1/UsCCWociKrONjZe4Ib8LYoA
   A==;
X-CSE-ConnectionGUID: AgFuHQODTJmPHnAmHHCSQw==
X-CSE-MsgGUID: YobEOcMbQaqk/vYOJmH2bQ==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130347638"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:02:54 +0800
IronPort-SDR: 68d5599e_rljV9ofVt6wOlgMDiIhalKv6L1AoLuyEZj7rXU3iwymyjbB
 PMk4yHu4F5z7RzZnJpAVZsoASMiwNDlmvuBSvtA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:02:54 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:02:51 -0700
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
Subject: [PATCH v2 04/15] blktrace: untangle if/else sequence in __blk_add_trace
Date: Thu, 25 Sep 2025 17:02:20 +0200
Message-ID: <20250925150231.67342-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
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

