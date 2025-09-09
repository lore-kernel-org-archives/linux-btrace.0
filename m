Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A833A021;
	Tue,  9 Sep 2025 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416118; cv=none; b=r7uVoyfM0OWiRDuvHlN5OiliFkp+oEphcCT7oI0CCVSP4vbSmib4vsv1SXbpNRXS0I6dRIMrOh33lA0nmvCAGWR7b9QILuBOy4rPDK4nAWJTbb8fNtk7NnBVWiAH+6M8IEdlkTAlEpcNmeWBZpfsBmCtBW4DE5xSJNE1/qQB+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416118; c=relaxed/simple;
	bh=LQEvU4huJwrt4jkfJqH99TrPqp77yysYykNycx4NgNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbGIPf7fwPfBiYNgbOAo72zzIoYNPR8i6mo/zaJYyrIHo5mPm9YADzrkmtDlM8+Isq+AdPV8shZwpKS2yRhY3qabk3fip+mejXi6jBZPJYDnKeqxojjjPoPm/g+ufBVKZhFRwwALoa313JwqasAwDUK2G+0Tf3sl+O8ehh5/btU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KxV0NWKP; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KxV0NWKP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416117; x=1788952117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LQEvU4huJwrt4jkfJqH99TrPqp77yysYykNycx4NgNo=;
  b=KxV0NWKP31EoVxF5SqL6nmvTlJPwloe1aCyfb7aGrbDu0reKRXY0MnZK
   +aEBUsVtikO8wazshdociATl23SwssENJ5mZWINIRs0aT1U4axsrzl2Rm
   ijS2bFTIhO+Futkg1ahgbtpRbgMzR4M05fB02QQfq5qnrEYPezBHH96TR
   m+2YtDdVGSRiYnjLPRGNLqKpgmOlOmKP+itRyToTnQNlGFah1u7jmVG8s
   3lwxHL7JAA0xp9GwbOtPB1BCYB+Hxaw3vFxxltorJSyTWgQBMOISHVHW2
   ZyO5anP6H0feyWooPToMW5bb8QAsVg8ghhofk9o/ZmGhkColW45MJ4PbO
   A==;
X-CSE-ConnectionGUID: Wea1qmthQR22v7oyfU8hrw==
X-CSE-MsgGUID: zZI9MMeeTHqsMy8nsQkG9Q==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810797"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:08:36 +0800
IronPort-SDR: 68c00ab4_yzhNKyODBgLalqmm6Zjyg1zCaksyaBjSGw9b8634B0lDWmF
 8f/p+hWmw6fNtynjqbr5JqbI9tjW+AkimQKGf1Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:08:37 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:08:32 -0700
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
Subject: [PATCH 15/21] blktrace: rename trace_to_cpu to bit_trace_to_cpu
Date: Tue,  9 Sep 2025 13:07:17 +0200
Message-Id: <20250909110723.75676-16-johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkiomon.c     | 2 +-
 blkparse.c     | 2 +-
 blkrawverify.c | 2 +-
 blktrace.h     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/blkiomon.c b/blkiomon.c
index 373947e..9defa2c 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -487,7 +487,7 @@ static int blkiomon_do_fifo(void)
 		}
 
 		/* endianess */
-		trace_to_cpu(bit);
+		bit_trace_to_cpu(bit);
 		if (verify_trace(bit->magic)) {
 			fprintf(stderr, "blkiomon: bad trace\n");
 			break;
diff --git a/blkparse.c b/blkparse.c
index cc62dcf..068c4b2 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2451,7 +2451,7 @@ static int read_one_bit(int fd, struct blk_io_trace *bit, int block,
 		bit = ptr;
 	}
 
-	trace_to_cpu(bit);
+	bit_trace_to_cpu(bit);
 
 	return 0;
 }
diff --git a/blkrawverify.c b/blkrawverify.c
index cc5b06e..8e863cb 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -181,7 +181,7 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 		if (data_is_native == -1)
 			check_data_endianness(bit->magic);
 
-		trace_to_cpu(bit);
+		bit_trace_to_cpu(bit);
 
 		if (!CHECK_MAGIC(bit->magic)) {
 			INC_BAD("bad trace");
diff --git a/blktrace.h b/blktrace.h
index 68c67f2..08ac28b 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -108,7 +108,7 @@ static inline int verify_trace(__u32 magic)
 	return 0;
 }
 
-static inline void trace_to_cpu(struct blk_io_trace *t)
+static inline void bit_trace_to_cpu(struct blk_io_trace *t)
 {
 	if (data_is_native)
 		return;
-- 
2.51.0

