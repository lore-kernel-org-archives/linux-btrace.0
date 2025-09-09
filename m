Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A1322C89;
	Tue,  9 Sep 2025 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416031; cv=none; b=gI+7Gzo9BW2RiHffUZ5SYymnpMJgBCg80zZsYCGItg4yoyFpb3UYGtow9BeMZVrMRyY8lVXWm5euJn6MmWrfovVCww6TwIKQybiIk3HkekfSk/rN/ltjwzE4SRb89OMKtP4SmlJCzevRfX+enM1GlAJMDF5zZMZ899bqhfn6SSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416031; c=relaxed/simple;
	bh=MVeKOflXpQenr21iMEzmsz3U1agvLQMPi/S1gt4iu6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FfYFtb3CrlctV1YntY8SIMmxrFVSbRI2gkbPgs4ol/8qMl5Nj0f8tks15XOvSBMfjiXsdwWKo8S1vwFfb/1UZ58+wm8E8pYoTDzWsX8vvuXfpuot+pxtjUV5yILZlUHU9Gd89b+s/kq/M41fX6YfAlx/9Qn7n7cBDQiF8fHlZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kaflyUnn; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kaflyUnn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416029; x=1788952029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MVeKOflXpQenr21iMEzmsz3U1agvLQMPi/S1gt4iu6M=;
  b=kaflyUnnZxIOImx+iWZRy4WKbRYdH2WACiOxKApvYGiqZ+LRRKyINJuW
   L3rTVPfjNCXuJvnmigBocJVUwNdhlENi0L8FIvRmw5nShOZggdtNXUHaE
   sZt5aBElUUih66sAO7Tmty4dGfzthZse1pptfPzyqOIMWCOHcxHsm1hVt
   niJUFoFUsc0cbWSymodc9ShzpHYrVhjlD85Ont2SbRRvqTWmH77Scs1sM
   k4n5IdfFVDtz++vRaCTJOrLGst9FF5v/a1h0OFF/oOnQW4BvT4FuMkgyK
   t6Qmi7ZWousLmv4/R+oTHA55/FYqAs+JgOmaae3JWhdbuu0b7JqBzTP8G
   A==;
X-CSE-ConnectionGUID: 7zh25NpNR9eXjL+NLIt4yw==
X-CSE-MsgGUID: IPU/jB03TumdA9tHfzN6jQ==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810113"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:07:09 +0800
IronPort-SDR: 68c00a5d_7Mp0fSuDlUc7bfEz6T+h63ukTbsyPn1Asa5yWo12xiKi/a9
 keytbVlZoUSRcbpLuUCyIyHZqSLIoHQ/0XexJ3Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:07:09 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:07:05 -0700
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
Subject: [PATCH 11/16] blktrace: untangle if/else sequence in __blk_add_trace
Date: Tue,  9 Sep 2025 13:06:06 +0200
Message-Id: <20250909110611.75559-12-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909110611.75559-1-johannes.thumshirn@wdc.com>
References: <20250909110611.75559-1-johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 6dc7396c26c2..82ad626d6202 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -324,10 +324,19 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
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

