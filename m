Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4632275D;
	Tue,  9 Sep 2025 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416087; cv=none; b=m/Y6wjUXfq99Vbg0diiwmiTO1ut1pOxV1eoEMBZENUhKARGHZihJUTUUCZV/nibSZUp0Wt6zKxf90cqdZRQeb67bE4TpMiWMxHeLTF4FlkO8HrtGS9oV7/vYu1FBRYcBqKvwDjbX+BRj3Vmpp9hre7Nb7GasVGSGI1ip23OFvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416087; c=relaxed/simple;
	bh=4WnA8o4L2DRIQ3v7RIn87dq0Gk45P9/F4DivHW3wybE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RXTuUI5bsTnoLUopOCDSAzmH+yvJyFj8L6TAAilfK4LixekT77xn4mI0ONnXZ86kEJ0WORE0ovxm4v/ei/ueukmzPUWUPk+9E1IQDnZz03L1tnFodjAWMlky3MErMkZZFGaeRb2UXZTH6/U1PYX+LmHMn5f91hyCuSJ3ghKQwa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=maYIPVOY; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="maYIPVOY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416086; x=1788952086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4WnA8o4L2DRIQ3v7RIn87dq0Gk45P9/F4DivHW3wybE=;
  b=maYIPVOYiXYNaVouehja8fWAC0UZDm1+MJc1VQ1zWLNyTqhfEbvbOqaq
   kt/YY37wR4/zpotdVJkma8He6rt7j8YRuLctHSr0nxlMfnZVIDWqLCu+g
   PKQ84hS1bLQB5gGBpLfli0Ft4HB5+EPUrnt3OvUzN0r3L655CGH5ln98R
   69MaPIyhthOGe14aLM3Q4BEewMbX6d8mRNsBtDbZUcY7+xfPcQcNzXU8X
   1vB9i6rCd0BoI4MZpXwO3hCSBONTFEVT9/BfMWA4pZ8GOuvReNs/7Sf18
   7VadisDw2APNUssPmb8Z5swKo7r/zTJTNvCvFQGi//hdp5K/swNBVv9T9
   Q==;
X-CSE-ConnectionGUID: RBgdgXBURQG2prIgKqRG7A==
X-CSE-MsgGUID: dLFC5gr7Ty2ZKRf2/FnxSA==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810702"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:08:06 +0800
IronPort-SDR: 68c00a96_pa1F4SrLn+dHgm+ZVx1Ge1GBYQE2m1Te78xq0H+XSrpcrQe
 ub5dCE8QRkzCsI0cpZXyU1+OveC0f2OV71eumBw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:08:06 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:08:01 -0700
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
Subject: [PATCH 08/21] blkparse: read 'magic' first
Date: Tue,  9 Sep 2025 13:07:10 +0200
Message-Id: <20250909110723.75676-9-johannes.thumshirn@wdc.com>
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

Read the 'magic' portion of 'struct blk_io_trace' first when reading the
tracefile and only if all magic checks succeed, read the rest of the
trace.

This is a preparation of supporting multiple trace protocol versions.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 03df2a7..8381e20 100644
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
2.51.0

