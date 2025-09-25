Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81672FDC44;
	Thu, 25 Sep 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812680; cv=none; b=RlTPBsYSDusdUwBSR9stAgqfIslUgBfZhtymK4PnKdhcn6ZZeSMdLwIf9pIztHVLBN6XkRv81gusSdWqKQOtTxJKYfTHSk0J5zcp3+IiO74gHLXBPpL7zOoAuoBwZuX32XoT43bCmYcyQjMblzMUyzoXpM8e6YCWGBcfh2VVWNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812680; c=relaxed/simple;
	bh=ZK4lOcTS5NnW+oaUnr0KaAHRKGM2EOkI4dmLtFxJ+8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVe8ji5SL17lcA6Ey5lSFKsjjJZuG+imITDT8pxZ3J8pEx72oC7ESADQG18LRSd3Go9spwAUtH4MnrlXOPRtNC2Pi4P3q1jsIQjk9+Rw2f80mnj+aitX+xx4llB+/bzz8f2bzgCLJZcnH/IGhJ/I84tFrd+jN/NvG6ZMYmN0CVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=a2YnTUqB; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a2YnTUqB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812678; x=1790348678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZK4lOcTS5NnW+oaUnr0KaAHRKGM2EOkI4dmLtFxJ+8k=;
  b=a2YnTUqBfIHjMZdUiK7P2PrLmg8KEJMQ3tkLeURjmH1MZwoB54gdyvyY
   M4syPw8lFMG5UpAR42shf8++ALgamN/ZV2dQY3irAN0zqAp9JfSfsYCiB
   DJ12mdM85v/H5Cq8JdsIr12afCP1kPWDB0wgVm0Ir+gnO1W6YMLJD7cTi
   EF7NifXj9lDfsfeW9eOTrADOWFox/jwVZ3onXtYjRPp3GlfaIYvyBvGv+
   OV388CcZkLhgrR/AFWIH2/kqcP7S2RcQFvC3d1df4qPgWYt8amiiJPnOD
   l8PwKh21ZseoPDQoIh1d8tB/pE/r6R3ehk5aZMkLWSVYcQjBIo+Z+aL54
   A==;
X-CSE-ConnectionGUID: 4jD6rXsoRYqMCoNs5v9ZKw==
X-CSE-MsgGUID: cZnGGF3nRbiTDHK1bFqQSg==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130348654"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:04:38 +0800
IronPort-SDR: 68d55a06_z++MEzmFVAmqfxm03YHxGt26Rj/FxK0Imi+SAJDYrYekoiY
 ZTk1dDU6c0+p2bc/zZuSFbjGbHmCqicHFrEFbhw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:04:38 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:04:35 -0700
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
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktrace v2 01/22] blktrace: fix comment for struct blk_trace_setup:
Date: Thu, 25 Sep 2025 17:04:06 +0200
Message-ID: <20250925150427.67394-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
References: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a comment misnaming the ioctl(2) passing struct blk_trace_setup.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
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

