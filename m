Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D173375B7;
	Tue,  9 Sep 2025 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416101; cv=none; b=SIoYn4tcsnZC/RIhpDuc4M2fSBzfu0f0IQLigMwzYjHNXkiClG43E/9uoxN/C3jsyGdpdvKUPWor0Jb4yjkXmXEnlucVoPKUgoFx73F7j6yWuVQ90zzHU3ikUS4AGGPHMBD0akKIS0M3MsYrNZEUjUJzvzSyU6ecejcJSEX4jPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416101; c=relaxed/simple;
	bh=P9BXDgzGLXQwW3Va5jL6Zsgr+hSb3rFcWs06lTgG0no=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MfcIX+nzvy72NigN/1RMwYAadBM50C/0ALHy61nV6LLIIk3bq+66FTqnMHpwXRnSI2slE6PxFqlPHY9o3JYoUnLKwyDdD91urQlpMCEp+kzLMA8AySTt//N2e+zmpl2zcywoQHfSJOOWWc9ljL7cYWp3DaTZyQkdMMLXcGCPyHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=b+oR6+NE; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b+oR6+NE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416099; x=1788952099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P9BXDgzGLXQwW3Va5jL6Zsgr+hSb3rFcWs06lTgG0no=;
  b=b+oR6+NEGwJ0c9s3r1Oo/6LBDxUPS8Z9cHtcWwaLvtbW2EAswftzPh87
   mTaPdOwOYtY5USkumb8YOZdeakdNK8DpPz08uym7IbU4GvgWnzdJCxCzh
   qvPpfzQsPhr3egi676Hc1YaDykwmWQZRfv393tSBe4qeQWWh9i6D7TKiJ
   JgDlXHX+CbKaasLKP7JwT1qcfpuVmrmLLC9x1BVfWgkqQBQF6zMDIybvk
   MrzpSu4hQH4BU+2tvSh0VyYsHBJ5MGEyk1baXLp/NHIKqifNbt6VIoGQe
   U+XqlIdHMWHvMqYm7yq7JvT0hcLfPH9mHGl7QRkfGMdt6QCIToN2RuHqF
   g==;
X-CSE-ConnectionGUID: cDcXPQ0HQt+MCLXQnrm27w==
X-CSE-MsgGUID: LP1/nkrtTI+IwadFerHfzQ==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810733"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:08:19 +0800
IronPort-SDR: 68c00aa3_QRDyc6OgoIlRS7YeJvMG9DJzqCis0RXS4hW4XSsA7Tfsl+O
 aCK7FPqAiwtpEoHq+bY97TwRSwTPa/72d03OVqQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:08:19 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:08:15 -0700
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
Subject: [PATCH 11/21] blkparse: make get_pdulen() take the pdu_len
Date: Tue,  9 Sep 2025 13:07:13 +0200
Message-Id: <20250909110723.75676-12-johannes.thumshirn@wdc.com>
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

Directly pass in the pdu_len into get_pdulen() and only care about the
byte swapping in get_pdulen().

This enables us to use the function for different versions of the
protocol.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 0873c13..3609ca9 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2412,12 +2412,12 @@ static int read_data(int fd, void *buffer, int bytes, int block, int *fdblock)
 	return 0;
 }
 
-static inline __u16 get_pdulen(struct blk_io_trace *bit)
+static inline __u16 get_pdulen(__u16 pdu_len)
 {
 	if (data_is_native)
-		return bit->pdu_len;
+		return pdu_len;
 
-	return __bswap_16(bit->pdu_len);
+	return __bswap_16(pdu_len);
 }
 
 static inline __u32 get_magic(__u32 magic)
@@ -2439,7 +2439,7 @@ static int read_one_bit(int fd, struct blk_io_trace *bit, int block,
 	if (ret)
 		return ret;
 
-	pdu_len = get_pdulen(bit);
+	pdu_len = get_pdulen(bit->pdu_len);
 	if (pdu_len) {
 		void *ptr = realloc(bit, sizeof(*bit) + pdu_len);
 
-- 
2.51.0

