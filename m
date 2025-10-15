Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB59320CC0;
	Wed, 15 Oct 2025 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525855; cv=none; b=gWTSKxes5wvcLhg2VQ3Wt2HYTaimaOtgEe+D4NGZGFvcrFbkFQwzN+yIN/FcQLeCtFg1Oo8zzvAzk1mMbYbtmEPmqagm8I67FBKK3mfUtAFxkXjT9pady44TLo+kDKe2VTboAE+wjzMtQbfwK6o4qwUKSau9e49nrvNGC6TDRo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525855; c=relaxed/simple;
	bh=mPQj5kqwyRWqC+fMnaW0oDN1trAQZBc40cPOBN7KYso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guz3yTHQRUVufsLQbV7zqsjDv1Lp9MckA+UgywdEJ1xafGnO/aPIILd7H4dUGm3PDSvOYXtlmy27t/UC2Fvvg60gtqbyKJ4a8Zxrh7KHLqpMr2+AD9/A7NuJcAhyEE/yQN8MmF8RKbJua4qATj/lfTvITH3R3YBcuqL2U7CtQMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OrSFvZhd; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OrSFvZhd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525854; x=1792061854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mPQj5kqwyRWqC+fMnaW0oDN1trAQZBc40cPOBN7KYso=;
  b=OrSFvZhdBHh0QuhZIbLXY9t7WNSJ8yBMwj8Kg71/0ZoNQj+37rW3GJj2
   Cduzu0AyhaHHhk0fHg3WzZ5vp4j2Z0Yhinrkw+r9UATR4iQXy/eNCZml+
   OkusiJKDh2MzDUZ/8F2ynsWoygI2rXp+Z5y+iTu4AzdNyXklEpWAEDqTC
   FV7UCFCYTNS25lNMtbeGko+i/trw7Isxef6tL0ufULfRpghkZdSG8ex4y
   F+viu5xQpWV5pvRAFStkccvK5dDr1HBpvzyIpi4EJn3MPv/BEfG9opxzx
   hRwkcBzjrwwvV6vAXgynvmC4PL9OGVS5iF+ZUzkFVJfFmwBNy3fbNf0Ge
   Q==;
X-CSE-ConnectionGUID: 3wn43zzqTaSSLQe4Elge/w==
X-CSE-MsgGUID: iozH3l7RSeqBlGQDY3h8GA==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935368"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:57:33 +0800
IronPort-SDR: 68ef7e1d_u7Xwgep2U0qcb1feeOn+O9eUTA5tV4HUWlXBrtppG8AZ70F
 MB8zXeiPAUmGikYESkUpajXax537lHrgz40XrBw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:57:34 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:57:30 -0700
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
Subject: [PATCH blktrace v3 06/20] blktrace: support protocol version 8
Date: Wed, 15 Oct 2025 12:56:44 +0200
Message-ID: <20251015105658.527262-7-johannes.thumshirn@wdc.com>
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

Also support protocol version 8 in conjunction with protocol version 7.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blktrace.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/blktrace.h b/blktrace.h
index 74dfb48..3305fa0 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -69,6 +69,7 @@ extern struct timespec abs_start_time;
 
 #define CHECK_MAGIC(t)		(((t)->magic & 0xffffff00) == BLK_IO_TRACE_MAGIC)
 #define SUPPORTED_VERSION	(0x07)
+#define SUPPORTED_VERSION2	(0x08)
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define be16_to_cpu(x)		__bswap_16(x)
@@ -90,13 +91,17 @@ extern struct timespec abs_start_time;
 
 static inline int verify_trace(struct blk_io_trace *t)
 {
+	u8 version;
+
 	if (!CHECK_MAGIC(t)) {
 		fprintf(stderr, "bad trace magic %x\n", t->magic);
 		return 1;
 	}
-	if ((t->magic & 0xff) != SUPPORTED_VERSION) {
-		fprintf(stderr, "unsupported trace version %x\n", 
-			t->magic & 0xff);
+
+	version = t->magic & 0xff;
+	if (version != SUPPORTED_VERSION &&
+	    version != SUPPORTED_VERSION2) {
+		fprintf(stderr, "unsupported trace version %x\n", version);
 		return 1;
 	}
 
-- 
2.51.0

