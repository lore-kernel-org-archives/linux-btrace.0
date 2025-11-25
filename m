Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6312DC788;
	Tue, 25 Nov 2025 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057134; cv=none; b=LcrwT/vocGakq160/Qer4AmerkpggJtPqsxV69ZKQ2CZa6NfALIKy9ZjkGwm1HgnxTIXX7SKT4DaDIxzcNGNIkhO3WQJkLjuUN8zuqQ9/zeynExU5m6SU4MV3yIdfbU6IzV3ZrAUR462GRRQxYFOl7PjDcTtlDhX8FxJemrWTGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057134; c=relaxed/simple;
	bh=mWa4RFBwSUNQmjQ/szlgQNRVFZpgfzLAIm6f+LJRWVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxAN/D9s+xYLOyY5D8TGqhlEduyKB5z1NipjPKOsGax9MWgw4U/Dwlw0WHvccPEBhChz9+RnJR3M/gZBqSHoeqR+07tG2CHKM3+zJVuzA8kRsaGLrgDsWpPgyD9MX1qzNLbJiSQJOL7xid3QehK9S8pCthlARR8E75BMb+foAIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lytJ5JCq; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lytJ5JCq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057132; x=1795593132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mWa4RFBwSUNQmjQ/szlgQNRVFZpgfzLAIm6f+LJRWVM=;
  b=lytJ5JCqWjoc7df0ld8VnQG9Tq6Up/E05IA6Wu52ibHYOULHPkNGM8MG
   QeVUqByYmngbFEc1bMXIGuanIIITbRHCAeeYN8FYeIeHVMYIGgwrwpX0R
   3+kJAl/3tvahLZ0Ez7PCH11yvpDgPzsmjLID6STL8z9QsG4KrqjWwWQo0
   +OIpxX6Hb2eFH/4m+haPDWKP92vpHnNw3lsY/Q0Ut0NQ+eePoftti7gzv
   3KK9a0EVn9nBb/TzozFgPXoOxGvszbBtn2U2ZRE3P4DS1cFUJDvh/dvRK
   U03uMLeQNwIKm9eeKoighQZoHD8X9swWIxWjnypWvCJcZUvzzv8yS+eMm
   w==;
X-CSE-ConnectionGUID: w7xCD34QT8yjVZ6haqQs5g==
X-CSE-MsgGUID: ZPzfwX61RNeoY3IjIzEwDA==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749778"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:11 +0800
IronPort-SDR: 6925602b_SzTR54i1Lnsz0G/4CpoVk7zrnJT0unUg0WlxzG8E0TCl16x
 q9sCM1wUBvSnXTULwJKiM28lgt038Azi2gda3kA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:11 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:11 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-block@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v4 01/20] blktrace: fix comment for struct blk_trace_setup:
Date: Mon, 24 Nov 2025 23:51:47 -0800
Message-ID: <20251125075206.876902-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
References: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a comment misnaming the ioctl(2) passing struct blk_trace_setup.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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
2.51.1

