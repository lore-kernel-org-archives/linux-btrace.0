Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC44322DCC;
	Wed, 15 Oct 2025 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525915; cv=none; b=gssVUsvb5p22yv53xkucCXLQI4h8h+lZRgVZQtDO9xEekM2ln998FnIApWjJZrCtJ+Bb4aEXURph2OhXeJ0LlwPq0lgkoDgZn30lTJ36sTkpm3miHYCnNxwud6tDqu4MxkixI2HUYGokMvkCcXqOMeO/zMPCZO5khAQNwiRMJCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525915; c=relaxed/simple;
	bh=9eWf6LzUuJXvhDm0lpvATvyVyg+h/0pKgJdDvYpoMAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrQHSIAggCbiMVUg511dUxn3nOc57JTlCIQ/3v/1DLBGGadcHWkTmPG4cHqJarNG8tK+pD6P/pC1qTP9g3fAWM6XfC8ebXxE5oSVScEb+ZL8EKSEaQLyxzzd0W3H9IHMlZc2HSRNd2zwcI19f6+cwNgtX4K/QB0dJzZ34XTqxxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HzhYBvSG; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HzhYBvSG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525913; x=1792061913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9eWf6LzUuJXvhDm0lpvATvyVyg+h/0pKgJdDvYpoMAg=;
  b=HzhYBvSG5NxleXYEUnmP9Z7cDwEYxqPvglHWC9HOHBsW9ikaIRQ/85O+
   X/xfrw9FeBP8isr2PChvdbbwy6BkcmPwV1VK/P5SbsH2BQL95KP25f5Qe
   MfIGW3lBG0QkOAOorjcG4zGxztxf3G9OQEqJ96EwJmJ1sb6+HYuTKAAtq
   ZhmiEjED2JB5elfw6OJQMiaGvQwnLiIagvlT2hUE9rI4PVDWOSz3vAZ1z
   6lwQLc2GhhtUJTLHRiRZBNOfzSSuaxbfRGUMkVDqJ1Je//ZU1HoA/rArq
   SgxEThDuc6ciz2dh5mdVVzDoli4q1r8IEk5b54revRA13Xc5RX6HsFm9h
   g==;
X-CSE-ConnectionGUID: kIxDOlhlQnmQwUthdvmiEw==
X-CSE-MsgGUID: LNKx9vQ6S1CpdzggW1tO9g==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935426"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:58:33 +0800
IronPort-SDR: 68ef7e59_6TBLIkUU/iOsIBrEHMZbL38UQShSfEVbDLn0zzzZ5Fxs+OM
 8ioBlxBlzNQxo2OWIg+IuWmuqBm1GJxtNg6AEsw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:58:33 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:58:30 -0700
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
Subject: [PATCH blktrace v3 19/20] blkparse: add zoned commands to fill_rwbs()
Date: Wed, 15 Oct 2025 12:56:57 +0200
Message-ID: <20251015105658.527262-20-johannes.thumshirn@wdc.com>
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

Parse zoned commands in blkparse.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse_fmt.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 80e02fc..06b055b 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -60,19 +60,45 @@ static inline void fill_rwbs(char *rwbs, struct blk_io_trace2 *t)
 	bool d = !!(t->action & BLK_TC_ACT(BLK_TC_DISCARD));
 	bool f = !!(t->action & BLK_TC_ACT(BLK_TC_FLUSH));
 	bool u = !!(t->action & BLK_TC_ACT(BLK_TC_FUA));
+	bool za = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_APPEND));
+	bool zr = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_RESET));
+	bool zra = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_RESET_ALL));
+	bool zf = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_FINISH));
+	bool zo = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_OPEN));
+	bool zc = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_CLOSE));
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

