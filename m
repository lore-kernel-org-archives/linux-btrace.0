Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726782D3A96;
	Tue, 25 Nov 2025 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055682; cv=none; b=ktH3mOH+t3yPhi93Gv560v35KNl9QrCoPaqG4uyMepoLgqMsvUsHPK5FdroZ6iTIHDWAUNPiy6kbmmw8+zo51zTyZnYOjIDUm4SdwGpT9uVttlHOvgAKn3SKQkixPoS8HVgdiU9KTzyrBxw555YoYzNxEYkLmnEvm5+yI3lHspY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055682; c=relaxed/simple;
	bh=WxWcgPPA4TdCgsxUrpWY+pAjjHf352OC+hR4QozVTmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C196SwrmKwBFnvDMit9vwyaUHvpl1loeiuaxVWY9MW+atZ+SlyOZnYuolSeux3pSb3rgWPb4jAukUXAo8cSxKRmqOO/T3hA+YTRdhs2GTPZrlxp4te2nqamTN3zs35zv3Fvr7UnVPgwVjE7AMM60tdrwhhCcdzlVf+ttHqwcHyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=f/Y5SBmQ; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f/Y5SBmQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764055680; x=1795591680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WxWcgPPA4TdCgsxUrpWY+pAjjHf352OC+hR4QozVTmw=;
  b=f/Y5SBmQKZCnFGrfHfFGQb1jPg35JJ8Cp9Fzo7BygAwN9QpL5Si97bF8
   yYISpAMieeFE5aifQALL3fIva0GeAOViDnGbwm3aWZpdAEObA6AwIeIi2
   q7N1MOQiArnZQiq6218gbKDc37SBv9wCreit0Qc2sLrB5HhfbVAhPGXik
   VTE13BXNgfYcq4sbbBKX3W4nBn3wS5reh+yfR+gp//+mYeqqvO/52Yfs7
   j77D/Dfvu+h64hsnfOE1kvE4Mnm9z/jvwXhnJswtHHL5E7ycAXv4eHag5
   iOYjstXxa3XCnnFgbkF06akd47xpV5WH5uSxi+nbFYwAYam7sqVGe0Hny
   w==;
X-CSE-ConnectionGUID: Ra15afmCRhuA+CP2e7cl6A==
X-CSE-MsgGUID: cJ0c9oHoSYCrk2wYVHcrOg==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135337540"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:28:00 +0800
IronPort-SDR: 69255a80_6hyYXDgfHK2RZ737LGCbayP7EK68lLyntawFwfuSrwHhifj
 zGBiMo2BR0mMW7sz9+1vdafar6ob8FqFtPkAPqw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:28:00 -0800
WDCIronportException: Internal
Received: from ft4m3x2.ad.shared (HELO neo.wdc.com) ([10.224.28.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2025 23:27:57 -0800
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
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 07/20] blkparse: read 'magic' first
Date: Tue, 25 Nov 2025 08:27:17 +0100
Message-ID: <20251125072730.39196-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125072730.39196-1-johannes.thumshirn@wdc.com>
References: <20251125072730.39196-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read the 'magic' portion of 'struct blk_io_trace' first when reading the
tracefile and only if all magic checks succeed, read the rest of the
trace.

This is a preparation of supporting multiple trace protocol versions.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index d58322c..5645c31 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2438,14 +2438,13 @@ static int read_events(int fd, int always_block, int *fdblock)
 		struct trace *t;
 		int pdu_len, should_block, ret;
 		__u32 magic;
-
-		bit = bit_alloc();
+		void *p;
 
 		should_block = !events || always_block;
 
-		ret = read_data(fd, bit, sizeof(*bit), should_block, fdblock);
+		ret = read_data(fd, &magic, sizeof(magic), should_block,
+				fdblock);
 		if (ret) {
-			bit_free(bit);
 			if (!events && ret < 0)
 				events = ret;
 			break;
@@ -2455,15 +2454,28 @@ static int read_events(int fd, int always_block, int *fdblock)
 		 * look at first trace to check whether we need to convert
 		 * data in the future
 		 */
-		if (data_is_native == -1 && check_data_endianness(bit->magic))
+		if (data_is_native == -1 && check_data_endianness(magic))
 			break;
 
-		magic = get_magic(bit->magic);
+		magic = get_magic(magic);
 		if ((magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
 			fprintf(stderr, "Bad magic %x\n", magic);
 			break;
 		}
 
+		bit = bit_alloc();
+		bit->magic = magic;
+		p = (void *) ((u8 *)bit + sizeof(magic));
+
+		ret = read_data(fd, p, sizeof(*bit) - sizeof(magic),
+				should_block, fdblock);
+		if (ret) {
+			bit_free(bit);
+			if (!events && ret < 0)
+				events = ret;
+			break;
+		}
+
 		pdu_len = get_pdulen(bit);
 		if (pdu_len) {
 			void *ptr = realloc(bit, sizeof(*bit) + pdu_len);
@@ -2596,20 +2608,30 @@ static int ms_prime(struct ms_stream *msp)
 	int ret, pdu_len, ndone = 0;
 
 	for (i = 0; !is_done() && pci->fd >= 0 && i < rb_batch; i++) {
-		bit = bit_alloc();
-		ret = read_data(pci->fd, bit, sizeof(*bit), 1, &pci->fdblock);
+		void *p;
+
+		ret = read_data(pci->fd, &magic, sizeof(magic), 1,
+				&pci->fdblock);
 		if (ret)
 			goto err;
 
-		if (data_is_native == -1 && check_data_endianness(bit->magic))
+		if (data_is_native == -1 && check_data_endianness(magic))
 			goto err;
 
-		magic = get_magic(bit->magic);
+		magic = get_magic(magic);
 		if ((magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
 			fprintf(stderr, "Bad magic %x\n", magic);
 			goto err;
 
 		}
+		bit = bit_alloc();
+		bit->magic = magic;
+		p = (void *) ((u8 *)bit + sizeof(magic));
+
+		ret = read_data(pci->fd, p, sizeof(*bit) - sizeof(magic), 1,
+				&pci->fdblock);
+		if (ret)
+			goto err;
 
 		pdu_len = get_pdulen(bit);
 		if (pdu_len) {
@@ -2639,6 +2661,7 @@ static int ms_prime(struct ms_stream *msp)
 			handle_notify(bit);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
 			bit_free(bit);
+			bit = NULL;
 
 			i -= 1;
 			continue;
@@ -2659,6 +2682,7 @@ static int ms_prime(struct ms_stream *msp)
 		}
 
 		ndone++;
+		bit = NULL;
 	}
 
 	return ndone;
-- 
2.51.1

