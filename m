Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678D303A14;
	Thu, 25 Sep 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812701; cv=none; b=LounMZ6fkHb3cLR3QL3tiL1SeGshVZjcK2WUYzW1M2/MD7e3vygSfVlt5o+e6CEuZU6GyisEJnpFzyj13Ev0uGQmoqJN/JRlCMEU5fLGW2R9wbrnbDRkyIEpC8lPZgAmJo/febeyRTEu6Zs9XHjtM5Peh+J50y8lTf2uQZmFeJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812701; c=relaxed/simple;
	bh=mPQj5kqwyRWqC+fMnaW0oDN1trAQZBc40cPOBN7KYso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QM9PvmXnm+7a/Ouwy4h5H+glt/Yonlxo7sVe+BXa2a+1zjZoG8h9K62ucpwNCSKqeTlf+ndwSmG9EeWZIAgS3DlUJ3brDAHsy5dQvqrdLrEn94o9v1aJ1Wx+PImROnNBS8xZ3lL1gh/Cm6ol3s1TV55oq9yXtCRDhltMugBQbNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CCmUzyG0; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CCmUzyG0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812699; x=1790348699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mPQj5kqwyRWqC+fMnaW0oDN1trAQZBc40cPOBN7KYso=;
  b=CCmUzyG0X6dAH5pG/b7o+PeOFTad8xP+evyGfrLd+o/r9wyPHFonDJ8j
   uGwsIEjbmen/mmKxkoX3Nm2uAn0+T33p/h9jrD8p8HNq6v42EBZ1fQo2i
   sZajB41p3nLf0tRW3wcFkl29I7jwvC4HdkkRund7m+7GEcsqQad+ZVrrH
   50W2oSmOfsz3H3AlZLwk7M/Mose56qfQ36eY9DCKWQXfhiTs+WKFFsADm
   A7zfpBkB5LWISnCs4tJFRUh/xab3Q4l4AboY/iORIMHN7WWeFr0b7DeSj
   rju5V9T3G4koBpeEFtr5cKdda/SHuW2S0I+Xfu+7r18SfNRBTUD2+wbLY
   g==;
X-CSE-ConnectionGUID: J8+yJo9lQHmFtg6zbnwxDw==
X-CSE-MsgGUID: fdgnNUXuTv684qvJBpot2g==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130348865"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:04:59 +0800
IronPort-SDR: 68d55a1b_9hfABZjMWnU8gWsM5VU/vbo9e8gsDd+j6jhIIPce8XcD6B5
 uehiUXeAi7TGMpRBFv0HcG8hUtLBLstVUbjLc3w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:04:59 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:04:56 -0700
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
Subject: [PATCH blktrace v2 06/22] blktrace: support protocol version 8
Date: Thu, 25 Sep 2025 17:04:11 +0200
Message-ID: <20250925150427.67394-7-johannes.thumshirn@wdc.com>
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

