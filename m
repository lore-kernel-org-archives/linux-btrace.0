Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CD933EB14;
	Tue,  9 Sep 2025 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416136; cv=none; b=HTQtlySq9pU7oM7qqKy3Crng/LmL5Gsb9tgskyoOWKJh74WiX+FZRnr0+zO2aMAA9MrPry0Q1SUK4o3ii3FR4o3WlVrItEk/dl/F8IJ04xHi9OPTY0Lg36x1dKWziTi2fwht303YwaYkOFgar8XrZqvEtt9SUjI9XLFlmU1H2Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416136; c=relaxed/simple;
	bh=bEHjRAgcAgUgIx12l2d9svhT+oC6b0Yi9goSkoKt2nA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZegGebHkmlb/vZh9qB0FZaaEpJJyhzrflELgQ3B7SJLSL/s8m9g/BEak/Y+jrH5M5l7bJi4mSnAhZgKfjSJzxalHpt0wU9+xtB4svTuZ+Nth50UJtAkQ5Jn1UWmK7XW43oVlJuZestR4H6vt4Dvg094NtefRhZqBfnznfIar8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rmlr3rzc; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rmlr3rzc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416134; x=1788952134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bEHjRAgcAgUgIx12l2d9svhT+oC6b0Yi9goSkoKt2nA=;
  b=rmlr3rzcdMh0qoJ5Xky9lyUN+1N69ibqAuvfI8Qs/2QnBaoz8ELvif2l
   GKj/yKn09WJb+gbEU89y2Lg7HzPuJ7f91xcmLHxtz87dqoHCC9Au1t3RD
   uKBV/Bk/oae4Or7BvPUyoboPUnd2FsQlS351i+4eekPnNJbyziQ83tw2r
   PAWRYTaY4Lw0WQ5AhJfm4jFE+Qi2p81ZbvuQONz1Tez2ISD0nSxAM3OZ2
   uUEk8woJI84WgZG593Nqc6jWOeGM6VAyUTlxY/ZDicNrEW2W9krhii/hb
   fxGLpjf1q3aka03VJPR0S5mLPODXpTyvHTw4YhSRBGADBSLSBbyL6FDq1
   w==;
X-CSE-ConnectionGUID: R5/D1noLS3elwHws2MKzlA==
X-CSE-MsgGUID: caroMDrfRJmB42g/u0DjyA==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810944"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:08:54 +0800
IronPort-SDR: 68c00ac6_6E6pRBzbFCQmgiAP+vamferFmsdGlDP2/6QcHmCzCIk+Xe2
 w1GZPpb4eeopoC16y7Z4W8W6q9C9Koh8On2n9/g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:08:54 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:08:50 -0700
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
Subject: [PATCH 19/21] blkparse: add zoned commands to fill_rwbs()
Date: Tue,  9 Sep 2025 13:07:21 +0200
Message-Id: <20250909110723.75676-20-johannes.thumshirn@wdc.com>
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

Parse zoned commands in blkparse.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse_fmt.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index a5f721f..467c8c5 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -60,19 +60,45 @@ static inline void fill_rwbs(char *rwbs, struct blk_io_trace2 *t)
 	bool d = !!(t->action & BLK_TC_ACT(BLK_TC_DISCARD));
 	bool f = !!(t->action & BLK_TC_ACT(BLK_TC_FLUSH));
 	bool u = !!(t->action & BLK_TC_ACT(BLK_TC_FUA));
+	bool za = !!(t->action & BLK_TC_ACT2(BLK_TC_ZONE_APPEND));
+	bool zr = !!(t->action & BLK_TC_ACT2(BLK_TC_ZONE_RESET));
+	bool zra = !!(t->action & BLK_TC_ACT2(BLK_TC_ZONE_RESET_ALL));
+	bool zf = !!(t->action & BLK_TC_ACT2(BLK_TC_ZONE_FINISH));
+	bool zo = !!(t->action & BLK_TC_ACT2(BLK_TC_ZONE_OPEN));
+	bool zc = !!(t->action & BLK_TC_ACT2(BLK_TC_ZONE_CLOSE));
 	int i = 0;
 
 	if (f)
 		rwbs[i++] = 'F'; /* flush */
 
-	if (d)
+	if (d) {
 		rwbs[i++] = 'D';
-	else if (w)
+	} else if (za) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'A';
+	} else if (zr) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+	} else if (zra) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+		rwbs[i++] = 'A';
+	} else if (zf) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'F';
+	} else if (zo) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'O';
+	} else if (zc) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'C';
+	} else if (w) {
 		rwbs[i++] = 'W';
-	else if (t->bytes)
+	} else if (t->bytes) {
 		rwbs[i++] = 'R';
-	else
+	} else {
 		rwbs[i++] = 'N';
+	}
 
 	if (u)
 		rwbs[i++] = 'F'; /* fua */
-- 
2.51.0

