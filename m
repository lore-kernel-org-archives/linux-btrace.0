Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E756322A1F;
	Wed, 15 Oct 2025 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525891; cv=none; b=CO7ULe3xsbKuFTqLl9v+vIUmWI1iCv5K/SBhm21TQGxINiXCfoDdVPPsNgBUOoSdljEEmP7/8pJ23iv93m37U6RoafE6N20nQ2ZJZwg/lZqRSR5rrHKXAbVmLBZ2ZGBBRvNQxaR6l6koO8PhJqmbAxGkuJke/Gtu4BDvIVJytGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525891; c=relaxed/simple;
	bh=ahbQzVYzmBGcgTtig5YmAZ5t6E/5eYzq5jKvFA9hLeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPB104f0aNqOd9wEbZxM70SiiC5D5YVGQl5MPBq1KsxLPNaDgNJfz3rhIv2go0LbGeC3iM7xr9CcMi2lOQZOtGmZEE0KQPyzkyU0GXFquT8ZSDE60PqYmRSLypNYGS/qpOn+oroJyRbfnLGLHRRomCZQhXMTCXqlsxTdwic4EBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=c7ffK07I; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c7ffK07I"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525890; x=1792061890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ahbQzVYzmBGcgTtig5YmAZ5t6E/5eYzq5jKvFA9hLeo=;
  b=c7ffK07IfTeye2anlaJmgWbuKjxT/a5DG0zJHeDDfmwEo6hgjj9ztbyE
   +I9ZKjqVtWyzdM8RcUgy9OvIQxzgvvqCFIa3vp+qOKv1i9McpL/5GMYvq
   f31ctw8ZcQJjw/L0P/EK/6YGXU62LurmKLJ95Dqm9C6Fy1hrw87NjOD7i
   GD9yzWmg9KpChLkC30W7aq3+PiKpQXPMd4siALJ10J15ZMa/2BtDLSVB3
   CLKJInvUqhFjZvgKH5Dx+Ao4fytSuWaB93/Z7uY8KkuWRHcF/Y+VDe4nC
   4FInubIK6UqK57xErLALzVzGBTwnaYgn1d+Wd6Y8Cgg5thJuPbwQCeC4p
   Q==;
X-CSE-ConnectionGUID: X9YjLWptTeSmvMGE9d1zqQ==
X-CSE-MsgGUID: N0j1OULpQm+6nnT4ynkX2Q==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935409"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:58:09 +0800
IronPort-SDR: 68ef7e42_m5pKGdfvg8WPP33mxU2R4kwfZFG8bjUgVXsnUCfL2SWPKVC
 D+ExQzWh6K/K3067Pbi4qsf5R1uwARbb0qm2xJg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:58:10 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:58:06 -0700
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
Subject: [PATCH blktrace v3 14/20] blktrace: pass magic to verify_trace
Date: Wed, 15 Oct 2025 12:56:52 +0200
Message-ID: <20251015105658.527262-15-johannes.thumshirn@wdc.com>
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

Pass magic to verify_trace(), this will enable verification of multiple
supported versions.

Singed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkiomon.c | 2 +-
 blkparse.c | 4 ++--
 blktrace.h | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/blkiomon.c b/blkiomon.c
index 05f2d00..373947e 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -488,7 +488,7 @@ static int blkiomon_do_fifo(void)
 
 		/* endianess */
 		trace_to_cpu(bit);
-		if (verify_trace(bit)) {
+		if (verify_trace(bit->magic)) {
 			fprintf(stderr, "blkiomon: bad trace\n");
 			break;
 		}
diff --git a/blkparse.c b/blkparse.c
index 0402e81..9065330 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2509,7 +2509,7 @@ static int read_events(int fd, int always_block, int *fdblock)
 				continue;
 			}
 
-			if (verify_trace(bit)) {
+			if (verify_trace(bit->magic)) {
 				bit_free(bit);
 				bit = NULL;
 				continue;
@@ -2649,7 +2649,7 @@ static int ms_prime(struct ms_stream *msp)
 			if (ret)
 				goto err;
 
-			if (verify_trace(bit))
+			if (verify_trace(bit->magic))
 				goto err;
 
 			if (bit->cpu != pci->cpu) {
diff --git a/blktrace.h b/blktrace.h
index 81a5b51..68c67f2 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -89,16 +89,16 @@ extern struct timespec abs_start_time;
 #error "Bad arch"
 #endif
 
-static inline int verify_trace(struct blk_io_trace *t)
+static inline int verify_trace(__u32 magic)
 {
 	u8 version;
 
-	if (!CHECK_MAGIC(t->magic)) {
-		fprintf(stderr, "bad trace magic %x\n", t->magic);
+	if (!CHECK_MAGIC(magic)) {
+		fprintf(stderr, "bad trace magic %x\n", magic);
 		return 1;
 	}
 
-	version = t->magic & 0xff;
+	version = magic & 0xff;
 	if (version != SUPPORTED_VERSION &&
 	    version != SUPPORTED_VERSION2) {
 		fprintf(stderr, "unsupported trace version %x\n", version);
-- 
2.51.0

