Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74C32CF67;
	Tue,  9 Sep 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416057; cv=none; b=pZB7D6foGpXZHOM+0sRkCAVi9uFQWfEj7GPmVcOE5f0R4w5Tb9IBfCdmZr9bqimY5QgYdoH+tFR3tmONz+BNhYf8fkx0Y91VatE6XgCfHDrT+kLax2SP1vSRShzxN2jiwBRdnYJ0Y/D+IGwERAPCwC12Yu3HKXDWtFfYwFTZbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416057; c=relaxed/simple;
	bh=xuD/RysWcAGhVFKyhR6sNICgPdydUjswb4x8pX1x4WM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ME1dlrjWCHsc0tj5r7N7KnwgY2pOEhfaVgJdACRZnlgBcLmRrLJWqqGw/Z2zMzbtmDTkNnpHLHXJ/GFfXoYrTWhBSyJjGQ9kp7o6B2cOoK8JyTTF6db8tCTayMBwq5a+zaLuqLVg0INgCM/dJwCbvbaFVZkSGXB4WXXCBCXxDKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d3fXcU64; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d3fXcU64"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416056; x=1788952056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xuD/RysWcAGhVFKyhR6sNICgPdydUjswb4x8pX1x4WM=;
  b=d3fXcU64qLemb4GXlq5n4KuSPxaznf7ggLPTZVf6C5ENmPeni5lzd+Pq
   /eKUoGPXvWFRaD9X15g96ALtQLqSHy/HlHLDTvf09gGg+wwZGXWG2vuTw
   5Ad6FCTA7HBq82eIJXt4W6iAxS+vNW0KtLZ+60PNSGt7Zzdhbi6sA6/c9
   GMxuKbqeNrQn6uE1Il5LACHfjzcKiWl4PZ4RrAHlb1iD3mIR2weV2dkXZ
   EWFy+JZaI7xDfQSjaVOEuMPo0RQJkVVDNdZczePDy1+O9lwR8jK+xQw+1
   SJyCNMzeI/KY4p/efCC5YOCxpcSgZYFTfrX106Sz3TRi8XfrzctTM0f4J
   g==;
X-CSE-ConnectionGUID: 58OSBwTLQQWY3fStF0OWtQ==
X-CSE-MsgGUID: gA+O/iY9QI6K7O1MO/cWeg==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810372"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:07:35 +0800
IronPort-SDR: 68c00a77_N5n+m0Zmi7fLTy+WF0lpBZbjccv/mBfEd86tgEEv6Cz/gjW
 P5T28fH5cUGJ7bKRWzDcSeOYEufgGf21m3x75Pw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:07:35 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:07:30 -0700
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
Subject: [PATCH 01/21] fix comment for struct blk_trace_setup:
Date: Tue,  9 Sep 2025 13:07:03 +0200
Message-Id: <20250909110723.75676-2-johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blktrace_api.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blktrace_api.h b/blktrace_api.h
index 8c760b8..172b4c2 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -127,7 +127,7 @@ struct blk_io_cgroup_payload {
 };
 
 /*
- * User setup structure passed with BLKSTARTTRACE
+ * User setup structure passed with BLKTRACESETUP
  */
 struct blk_user_trace_setup {
 	char name[32];			/* output */
-- 
2.51.0

