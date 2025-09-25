Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D673191C8;
	Thu, 25 Sep 2025 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812735; cv=none; b=W3TWNA8vbN+BIHsk6Pz91kmyuwzLgbbAnLFpOxxXTXQ2FU/FKFoywSQtts+WVUzsdWKsb7XJdff8DKFI1Sbd8vyMMlISI1vRpRY4ea5IXZNbGu6kCXGqx+NFhJf1V45V5X29/7SP8qC5wlzomA6i0CRsMNGv0M1Do7G7BfU3Tvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812735; c=relaxed/simple;
	bh=ahbQzVYzmBGcgTtig5YmAZ5t6E/5eYzq5jKvFA9hLeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZuMzlNSDuw/Seo8L8Ks4DnAJPc/nhtnQkxnscN/CXpbfKPFG7I8sbhXV9gHFdKpE6rLxLFuMWyyhRVl/hnNvH6Fvg00J2Tu3/T6C2pWE8QpcWAi7LKClU3Q66UCValhAGlARegMM3rBl86yZ+GiaaSq/yrOmJLU4XEwCoFmQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gVFK/Q93; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gVFK/Q93"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812733; x=1790348733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ahbQzVYzmBGcgTtig5YmAZ5t6E/5eYzq5jKvFA9hLeo=;
  b=gVFK/Q938Tiwe1b/quj3kr7Qyz5tpjWjBgXGySaID4qzn49uE6k2wG09
   bpJHQif5VRWYvvRSkfLWfalUj51EV+Ce8Kzxjc2Dkg6aduahGXmE8zB6A
   i27z2plFi2n9qwA8UoaXrAC4BqKzeG7nxkoISIIanyzjcC7i0xGmZt/J1
   bshjOvKh8LuVkmHKQhn21Un+9AJyyhvj5o6Z1COzz3vb7Xkx08vufjsMJ
   op9BJ8G6VCYR83mchxN95v2+tmtnApk0MoqQsgVSKKXh0Sn3NSscxrLC7
   mCyp5wnOK/KGj5Ah1lHm3tV7MR+dajKhJiCZqSiNTodTc/y/nyDN6M2/V
   g==;
X-CSE-ConnectionGUID: lBzDbOhRRrWR2VPyVh+sJg==
X-CSE-MsgGUID: HuUgqaDyS9yIlmj3ac0NaQ==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130349241"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:05:33 +0800
IronPort-SDR: 68d55a3d_RKXNpQoDbmUgqY3GFMi12JeErpYaS7cUQ/ljDlk7uJT3ME1
 Hg0FQOw4CtB46sXGTqy2X6TyMJAHFQ1VZ5p0wOw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:05:33 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:05:30 -0700
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
Subject: [PATCH blktrace v2 14/22] blktrace: pass magic to verify_trace
Date: Thu, 25 Sep 2025 17:04:19 +0200
Message-ID: <20250925150427.67394-15-johannes.thumshirn@wdc.com>
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

