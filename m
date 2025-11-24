Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6DD155C97;
	Mon, 24 Nov 2025 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969875; cv=none; b=BZNiI379wfLFpI2Pcdg7TABTr/PX6OL18khSwYWIsa2mwpGLLoA0YBFjDxh83BKt5hXrrn+g1wOriCQxw9uvig7cd7agtnnxDa4gEWHVxCSLiLyE4o+ThVRGpfHG0mFn8Kt/7C5azuBGEafcimK5cIWG+2IDsSNEXq86xi5CXck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969875; c=relaxed/simple;
	bh=/yieYgKvZxbRQYJVflKVuKyK3jBxyXb3uJjWfD87UXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mi2A0J0CnurtV6gXDi/WUSMr93LIz/fRQo3YaNgBIGmPMS8PiD/IDNlh3qBAwGPCIldm+oT2GC7VRXd72WT2QjY2xp0TRcvDinBOD2gvKfWf05JLCmKyzjj59eQorxsN+YgbY13obLDl8AvY14w+wM9r201ZGc3ZN0fIEawwHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Bpu0YCRO; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Bpu0YCRO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969874; x=1795505874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/yieYgKvZxbRQYJVflKVuKyK3jBxyXb3uJjWfD87UXI=;
  b=Bpu0YCROIA8Whh+OOOhdr+hwRAhkK41TAHXBz24CY6zn7OAigM7FaI+g
   1J/iKdZoZPCfCWKWxDWlYleG8tAaXs0+S9ZCIpifUAv2XTQcGKrhdi3a4
   MyAMdHCaQwjjMLwO8qlKX4ZBNOWjXf/pjAJLZXBFsjU+Zbr+i3eI5wj7V
   /CS6ogkXE1m4HdUeVen8uVxTwcP3NDbHIj2fvW85qxfJw0m8x6vJnRpft
   icKmc+xKBtgEw3Cc7SVVwYUcZrUi62+6rR8ZOJuVtwC2BRTzGUW2yd+m6
   uDxv4ULIenoQtWj3nrcHzuFlq/wVrFgxkpjxPGtnqIwB3KoKzQhbkZ33E
   Q==;
X-CSE-ConnectionGUID: Uq7Z8nnKRgiZT3E5+mwcJg==
X-CSE-MsgGUID: izAwGO/wRWiW/+hnx9yGxA==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619310"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:37:49 +0800
IronPort-SDR: 69240b4d_1/F88FgyNtmx0Fn9W5ZxWsXLUXYWNdzDVcrO/BEth4clOBg
 mQvFq9i1dWiJY/KOiATddwxsvNbsnI99PHrtySQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:37:50 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:37:46 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [RESEND PATCH blktrace v3 01/20] blktrace: fix comment for struct blk_trace_setup:
Date: Mon, 24 Nov 2025 08:37:20 +0100
Message-ID: <20251124073739.513212-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
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

