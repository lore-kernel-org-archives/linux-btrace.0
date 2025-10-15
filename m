Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF8731D749;
	Wed, 15 Oct 2025 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525831; cv=none; b=ALXZ2V5QF0uxfpsOWjBGOnWevanXH2RiN47gLYwDN3DGl1ESH3iUxDdgbyLEUJ3Qu0v407BJj/Myi2pCDacC7EvO188MgRluUdXuL0WHtcvn8Hi/tVcXXcJN1u8MvChA2GH3n6TazZtBFCvyy5zH2ZiEBsuQCLSIR3oV+F2ENB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525831; c=relaxed/simple;
	bh=/yieYgKvZxbRQYJVflKVuKyK3jBxyXb3uJjWfD87UXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxHeg8WainkS9UqtBExSAuYa12YWhga+GCzxuwAUMWO4WnPwGKT++4K7kjV9iBTySD3OT14trvTL/nKNVDwsYeAKwY5H1uERvaUGG+4AyGtX0JMutswFEd6NjGs0FYQ5QzYkpHXV/WoEMrlAAALSKnv66IoZ/D1QdfFJN0K0S5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=S5QqlqMP; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S5QqlqMP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525830; x=1792061830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/yieYgKvZxbRQYJVflKVuKyK3jBxyXb3uJjWfD87UXI=;
  b=S5QqlqMPuyjJslOq5G1M/dPpDSgbQObEIrMuBXRuJaMDPF7+PBjGxaV+
   VBCmazh+/M0JEqXhe4VPCpIaZ8kyv40WTZFVH2OPe++KtLgN2KSIasMHz
   c3gDgMFD+sis0crcPsUOcYcK3s6VPu0rs/dXig1dbHKKPKImYuJTqYM/U
   Mp/u65WzDNceXI6xU8bTrcJcc8ZOrtKkWCNuPfop2YMD2nzWZpEM55BQ2
   4Rm6pF6aueKgBlz31WgVI9sXFZwzWV+mFH6EzCsWGQH1XRTFW73JxNP+i
   TaZ9OV2LU9cCFqTUE2zIuJgYDdol4h4lCS9nRj1rcmG47j8eMwHcQes5T
   Q==;
X-CSE-ConnectionGUID: eQHb+t61T7iIoi6UnC1XcQ==
X-CSE-MsgGUID: ZRkcpzZVQf2bBDajXIDCQw==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="133262232"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:57:09 +0800
IronPort-SDR: 68ef7e05_ZC410RsDbdFWg8o3V+PSAIsYnQg/YPebZBJX6jjkrIO29bt
 ab61EpaIFuk3b/Cbf/eCghWToGZnaKSk6Nfbftg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:57:10 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:57:06 -0700
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
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktrace v3 01/20] blktrace: fix comment for struct blk_trace_setup:
Date: Wed, 15 Oct 2025 12:56:39 +0200
Message-ID: <20251015105658.527262-2-johannes.thumshirn@wdc.com>
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

