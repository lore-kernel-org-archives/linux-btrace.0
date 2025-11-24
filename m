Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D312E7F08;
	Mon, 24 Nov 2025 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969878; cv=none; b=LHsuDd4Rbp1rcUOaMi+u2RjZuxN8gXY/M5l3yjcQuC7nGC/pHshqxMR+P/H4/37KaQT6HTHb1So2nzL+XnjQSN4//hPd3ZKYNZRJnuWCFij9F049EArJN48bYkowjoLmJ7W5xxQG8UsvF7SWWWTK3ZYRm/lNrFgTTigL+yCmR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969878; c=relaxed/simple;
	bh=A9i/EQhJi0Ow9YEwo+10DFKddH+N3wGL4JtkApNzI1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTdw9Ms8+i309eOnGhsP3jcGRslhAkYS484GeDDEBWj1utq4QhthQgFk5BYDNAtHDbubW25JWsC8h+ThaqRpiXZiP+/Cp1UdXHMWH8mmJt+e/WPd7J+cesBfiXuHZnytTdDJs/q3FcCCJitIWNEiomkshGEUqMlnwCs/kOqCqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JJrIEkE0; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JJrIEkE0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969877; x=1795505877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A9i/EQhJi0Ow9YEwo+10DFKddH+N3wGL4JtkApNzI1g=;
  b=JJrIEkE0J1t5UsRxuWPkP56HlAWXjkTfQ8rsqSeoaPfJyaukutaW3O2W
   YthtgZH9uWwlU9FpZ7XwZM0BCeFEIqXOE+6eFT2f62mfkHeDDdkXjRxMN
   45SV6PI8ZVR+6sv+dq6UKt8mCpetT7ujsq0xrjlJKC/CO+uUs+SSbAsA5
   PGNC3RprvwpyIhGIrLE5GebexuDsVQ3vtbdjQ4p299U0LNNiqtHBYVLk5
   1qb+GafILOUw5Ncv6cS6CaiLevBovVh6KpWKIXtD1XYXzR3Mxl+/toGVw
   tEcFCFhGMD2uT7P8v+Wf2/9iBn2Xc02ma3gqzyJ8jT2+XdX3cNFRkaZlO
   g==;
X-CSE-ConnectionGUID: UfbjxKTERuiNCs0zvQ87FQ==
X-CSE-MsgGUID: X8JtyckWRza8mybbMZLuag==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619317"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:37:57 +0800
IronPort-SDR: 69240b54_vHiZRPwDuE8tGO1Z4E73J2oi9ubgG4UAcJzjC1ZCgWcdnQA
 I8CTf5ziEi9PtJDInYO4/p0kjYBQzbVjWybwr8Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:37:57 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:37:54 -0800
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
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RESEND PATCH blktrace v3 03/20] blktrace: add definitions for BLKTRACESETUP2
Date: Mon, 24 Nov 2025 08:37:22 +0100
Message-ID: <20251124073739.513212-4-johannes.thumshirn@wdc.com>
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

Add definitions for a new BLKTRACESETUP2 ioctl(2).

This new ioctl(2) will request a new, updated structure layout from the
kernel which enhances the storage size of the 'action' field in order to
store additional tracepoints.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blktrace_api.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/blktrace_api.h b/blktrace_api.h
index 172b4c2..ecffe6e 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -139,9 +139,25 @@ struct blk_user_trace_setup {
 	__u32 pid;
 };
 
+/*
+ * User setup structure passed with BLKTRACESETUP2
+ */
+struct blk_user_trace_setup2 {
+	char name[64];			/* output */
+	__u64 act_mask;			/* input */
+	__u32 buf_size;			/* input */
+	__u32 buf_nr;			/* input */
+	__u64 start_lba;
+	__u64 end_lba;
+	__u32 pid;
+	__u32 flags;			/* currently unused */
+	__u64 reserved[11];
+};
+
 #define BLKTRACESETUP _IOWR(0x12,115,struct blk_user_trace_setup)
 #define BLKTRACESTART _IO(0x12,116)
 #define BLKTRACESTOP _IO(0x12,117)
 #define BLKTRACETEARDOWN _IO(0x12,118)
+#define BLKTRACESETUP2 _IOWR(0x12, 142, struct blk_user_trace_setup2)
 
 #endif
-- 
2.51.0

