Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E202EAB71;
	Tue, 25 Nov 2025 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057151; cv=none; b=VYfwuWmSEEc0Eko7wbLKCUVIJzHZkLXee/vF03qq1/V+n8Nm4wDu4QldMUgAbQFSC/nizv9j1Jml0D2xCGXV+yEItW5NqSHUsxcXWIg4MPbMVsEamNC2Zfi/X31gtVNR/47BSfGWfjgkUK7oDzDRzJRsnPaq8H9cDNQtkFLs3SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057151; c=relaxed/simple;
	bh=nJ0Ad8OCBVGVwPDt5jG8FNuQwXmGOcPrpVN45bcZL/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3BQovCCXr6i+f3cxKhr54xxqcaYo3f0SjSKI3iQgf7qxtpkTcHKKaoCq4jPOnEBLhx2oo1BDoxOeBcF1VQVsx8sgUn9Ih7FD6S7SACh+Tk0Vbtpf8j4IYr6SULvSHztc+vFc6bx6zhdSJHg2KuUeeih9LXwfUHSsIpgwVl0sDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iEjck2Q7; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iEjck2Q7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057150; x=1795593150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nJ0Ad8OCBVGVwPDt5jG8FNuQwXmGOcPrpVN45bcZL/I=;
  b=iEjck2Q75t359re9/Kuz+Xiebl/75576ZFDB1KPguqGVdKTit7hJKPX7
   wbPZlBGhbxJQVQvkOHKAz2L4Rlfj/pMRJqW1FoOrwexEnkmcy7ElGprMT
   zE96xsbMi3wwLxph6jKIqJPCcPNjHtJqBkpyhOkjd/ooh3BAj8qhh1H7U
   oqtpskQFgq4UKSm450DHoGsmYDtSOI0AHLuNl6bCZxtbPSg+76SnNgT2Q
   qcGt+lhq+qGCvPJwttdgOS6wfOPkc5rh2oiGo4OOdWq40DiiYUt80Ho+c
   rQh4MQhiIOgHUqtUHGHg20vaPfzuGYHD3cBIVufkNwtpuTzZI2hguRb0W
   w==;
X-CSE-ConnectionGUID: VO81Q2SpRZezZYC+60sgJg==
X-CSE-MsgGUID: EFigp5dmRx6SnzvcuoQ6LA==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749807"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:30 +0800
IronPort-SDR: 6925603e_UauAqYKutjUhH0yRFI3VBpTHUGjaZ7SehTchUA8dHFFYzUM
 KYdOoJbhk+IEatP+GbnJ9nGQyft2W2FH0qEfptw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:30 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:29 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-block@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 13/20] blktrace: pass magic to verify_trace
Date: Mon, 24 Nov 2025 23:51:59 -0800
Message-ID: <20251125075206.876902-14-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
References: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass magic to verify_trace(), this will enable verification of multiple
supported versions.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Singed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkiomon.c |  2 +-
 blkparse.c |  4 ++--
 blktrace.h | 15 +++++++++------
 3 files changed, 12 insertions(+), 9 deletions(-)

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
index 14c0d92..bdea438 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -88,15 +88,18 @@ extern struct timespec abs_start_time;
 #error "Bad arch"
 #endif
 
-static inline int verify_trace(struct blk_io_trace *t)
+static inline int verify_trace(__u32 magic)
 {
-	if (!CHECK_MAGIC(t->magic)) {
-		fprintf(stderr, "bad trace magic %x\n", t->magic);
+	u8 version;
+
+	if (!CHECK_MAGIC(magic)) {
+		fprintf(stderr, "bad trace magic %x\n", magic);
 		return 1;
 	}
-	if ((t->magic & 0xff) != SUPPORTED_VERSION) {
-		fprintf(stderr, "unsupported trace version %x\n", 
-			t->magic & 0xff);
+
+	version = magic & 0xff;
+	if (version != SUPPORTED_VERSION) {
+		fprintf(stderr, "unsupported trace version %x\n", version);
 		return 1;
 	}
 
-- 
2.51.1

