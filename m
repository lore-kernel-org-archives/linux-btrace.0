Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B480322A09;
	Wed, 15 Oct 2025 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525887; cv=none; b=ky9CuwKAtoHKauB+4JhkVLbtiYyEO3qYZgJPoeMWHhHCobwF0vXxWeMaXU12c6f7c6UQ4N/nMQDH6RpEVXuvBfoO6jbLJ1MTXcSPvwbzFQo4ttoCRidGE3VO3Mp+SEKu2n4CJlA+ZnnloQOchHbuMo4MHamc3Mf1ZSOUU8m5QNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525887; c=relaxed/simple;
	bh=3oS1kgcAgXjp0aHkhvXj8mPE9QIVrKKYTq1StaQgUmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/PkHFpXqRgMkgCbWkRHU6/aQuQYPfODChwxb1Yj9LygQdKU6LaP07fArOL/0aCUVzY7pPV8TWiaqTlEPsLOfU1sv7FGieeicAzcejHfG4cRP7qriiHgrQDUD+9GxuSYHq8vSBJyw0u5nrTvQqULj1IRJyUUFxcnlQOuZx3A3Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Jo9BQ9Kf; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jo9BQ9Kf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525885; x=1792061885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3oS1kgcAgXjp0aHkhvXj8mPE9QIVrKKYTq1StaQgUmk=;
  b=Jo9BQ9Kf/TvOfbAIkGMbv15zjhP8DazHHk6WCNetqGteUQN43KqIEyc5
   8d8aPoT/0SuXIqGTsR0N83pAnjrJVNQiQxP+hY+gWrvBtxWVpYy626J12
   gxL94ToeMD/zIzITCVytlLWRmklt8KPFJiXNDeAbj0DT+y1rcA9M69AIZ
   6AHQF96hVwCo/47uL58QOaGGKQWawUWONvER9sOTWdhl7gCgj+8BpAJeL
   j4RpCv/EyEiDnGx6HZAb0aMsPfOiocB73YDvJX+fNbHWTQqy1B2jlpxcb
   k24GvJeAQp5476ewPPWpGvg9ePAvflGo15daSNRwucV/Ss5nCP0tKv3i8
   g==;
X-CSE-ConnectionGUID: 9I81SbKlRoeFqzhmE17lgg==
X-CSE-MsgGUID: /XfhXczoS/yWj8TkHfJZtw==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935407"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:58:05 +0800
IronPort-SDR: 68ef7e3d_Cu833hOZEO5yli6UgVar3eXlLL61rWhV0Fcbrev9QSPr7/r
 /sgjcd1XYVkuxVu//XQ6GSSWhO2+og3+Dl49SXg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:58:05 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:58:02 -0700
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
Subject: [PATCH blktrace v3 13/20] blktrace: pass magic to CHECK_MAGIC macro
Date: Wed, 15 Oct 2025 12:56:51 +0200
Message-ID: <20251015105658.527262-14-johannes.thumshirn@wdc.com>
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

Pass only the magic number itself to the CHECK_MAGIC() macro.

This enables support for multiple versions.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkrawverify.c | 2 +-
 blktrace.h     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/blkrawverify.c b/blkrawverify.c
index 9c5d595..cc5b06e 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -183,7 +183,7 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 
 		trace_to_cpu(bit);
 
-		if (!CHECK_MAGIC(bit)) {
+		if (!CHECK_MAGIC(bit->magic)) {
 			INC_BAD("bad trace");
 			continue;
 		}
diff --git a/blktrace.h b/blktrace.h
index 3305fa0..81a5b51 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -67,7 +67,7 @@ extern FILE *ofp;
 extern int data_is_native;
 extern struct timespec abs_start_time;
 
-#define CHECK_MAGIC(t)		(((t)->magic & 0xffffff00) == BLK_IO_TRACE_MAGIC)
+#define CHECK_MAGIC(magic)		(((magic) & 0xffffff00) == BLK_IO_TRACE_MAGIC)
 #define SUPPORTED_VERSION	(0x07)
 #define SUPPORTED_VERSION2	(0x08)
 
@@ -93,7 +93,7 @@ static inline int verify_trace(struct blk_io_trace *t)
 {
 	u8 version;
 
-	if (!CHECK_MAGIC(t)) {
+	if (!CHECK_MAGIC(t->magic)) {
 		fprintf(stderr, "bad trace magic %x\n", t->magic);
 		return 1;
 	}
-- 
2.51.0

