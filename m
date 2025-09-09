Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE4322745;
	Tue,  9 Sep 2025 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416078; cv=none; b=Xh3elsLePiqzm0tjypqY11+1F+b904QDUsgcNnX+/MT14vYdY3lY2c/LUJqARJp/J/vvT/r8ht2iUAnPP/y5Z/8cdRoCGHGl7X5f3X7yZICWtQcJrwEYNKG8caz8x7NgyCyWL0hGXqnpyXvZ9zBY++uqcNHr/cevxOxPB2zFWfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416078; c=relaxed/simple;
	bh=mPQj5kqwyRWqC+fMnaW0oDN1trAQZBc40cPOBN7KYso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INdUCbN6cldh9WV7g8QZm3ht5ZJaWqNcxV4v0FmttkdPsuMlCKEs8wISn3jScPoNngvM0Sty/vTEhIr22OCqzICclRl0cggldO16LAn3mzvjIiXmxMv+YovimMrmmq8pT/63UWTwpLMIi940r3bU0JlEqPHstMsqHeJ/QzqUWJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Af1s1WGT; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Af1s1WGT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416077; x=1788952077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mPQj5kqwyRWqC+fMnaW0oDN1trAQZBc40cPOBN7KYso=;
  b=Af1s1WGTVyAtkrya/9R3IdC2winmZWmk4fiRBDuPtdp3KeR+GDra+CmK
   VEXkfVZmp0PmUxKVoyymoBhpJQ+vH3r1Gorq+IamtJoILaQpCB1mcUXtW
   FyYPzzyN+9gIMXgCiw9whn1rbsn1JKtxhxbHWbTt24rH3FVTzhuD69Td+
   LNOUWro0x+YzqUEV5u6cb9WW4SGlyZiJ+T7IT//c3xob25Ig4Z297bjvl
   U6MsdIRzPw0lo5KGGGz5KQ2giyJDcrAM96HpExm5M7GTj8QCPiCxEwgLq
   ib/3EkO6MtoaBw9d0CkTIiNrbQdkPxI8c7gF2igGtjRBVkdbWYXTyaJu6
   g==;
X-CSE-ConnectionGUID: M7LnDVyoQ7Wg/sNBX1UYxw==
X-CSE-MsgGUID: F1ym+dmmSQa9X3nbGLvaHQ==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810650"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:07:57 +0800
IronPort-SDR: 68c00a8d_9Pd8PBHzjIZxkO8HaHsRIXSbPEWgYMMDJB61U9twUNgk1Ya
 x2rA/bixeUidEYpmXMPtqEPUCSdZaondK60r7jA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:07:57 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:07:53 -0700
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
Subject: [PATCH 06/21] blktrace: support protocol version 8
Date: Tue,  9 Sep 2025 13:07:08 +0200
Message-Id: <20250909110723.75676-7-johannes.thumshirn@wdc.com>
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

