Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E828C2E8B75;
	Mon, 24 Nov 2025 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969914; cv=none; b=ukNUcpLmYpqmRbjF+y1mVc126K3sLwAPwsixlkahEPrTfOfKN0KEeSpXQTkXS88sBH20W3prJkp8x2FJarMSZRxj+JSIufzVxCzrwPP294jdHgcfniz+jCQWA7iqBTMDXudVgVqNXfxeZy8gpdm5XaF5VMaNA2xX2N7r51JYurU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969914; c=relaxed/simple;
	bh=3oS1kgcAgXjp0aHkhvXj8mPE9QIVrKKYTq1StaQgUmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAkvCIDYkhb63CXNSVSWVbEsqj841WIHjtOFVgpOHfnBxMGXSXR4nRloai/oQpj/Fa8NaFS6P3ilZxNKidI43pmfjF2Kmu1Uai76Y9AHfu6wAYbd+CWlSjmLhjCx+JFuMNHExZs8PF3B+yatxe9I8qB4ezfTdBINihT3YsJOI8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SAB8vuBx; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SAB8vuBx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969913; x=1795505913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3oS1kgcAgXjp0aHkhvXj8mPE9QIVrKKYTq1StaQgUmk=;
  b=SAB8vuBxe1N+Jd8p/GfyW/xunmjhyyTs5WbDaJjxLWVyE+DXLpygxslm
   II9+N7dT4MgWYiS8QxedepsUyJEIk3736XrxtH6kA9Zlr3xHtwnHKyJwb
   kohNGVCtzEKCqCux2Iq3Ou1WLWZ0Y2Q2R3YFjyNUWj9MHN40Ae5Kv3KFL
   Ukt7KXEcE2pZeMO72YdlvbjgSX0+XVpkxF28UKXLSh7OW7TA6kDN3jt39
   KNW9bauyjwnkHZgx0GwT5ubs6mrJblOXsSQoI5XItuFjWE1N52Y3srGDt
   ZZdCiCmhd3EpQ8vycMzsH5fqhC+fe91B+KavUqZVrjbZZtjhaIeosz/zb
   Q==;
X-CSE-ConnectionGUID: Bdav/j4MTqWnlK4LzDoDvA==
X-CSE-MsgGUID: /AAT30AYRSqQKlIV6Dg6ZA==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619375"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:38:32 +0800
IronPort-SDR: 69240b78_yXe1PSbf322MYQyVYfE1DIBWTjgmz5s0c5oQHS77LFjcHUQ
 UYIInIRmd2/psJmffUGIBVzSH6waf2JDjstXynQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:38:33 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:38:30 -0800
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
Subject: [RESEND PATCH blktrace v3 13/20] blktrace: pass magic to CHECK_MAGIC macro
Date: Mon, 24 Nov 2025 08:37:32 +0100
Message-ID: <20251124073739.513212-14-johannes.thumshirn@wdc.com>
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

