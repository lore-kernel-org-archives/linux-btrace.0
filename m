Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080CF2E88BD;
	Mon, 24 Nov 2025 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969900; cv=none; b=nTcyYxbmiDaQN+oeoFZktei8Sgd5AUQ6HJfxiFDwkTSYte7YRV3E+80DGHAbEUUflxKBS4X5ItpLu5NqcJNNMJPhDU6CLbiHvih++bDeI/Vy/V5Ull2NvVTw0oTYpF7pZGPvZ5ztAmjbkqNSpwl1pFmja4uEYmfzffr8oHowxZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969900; c=relaxed/simple;
	bh=L+8UyA6iiD9Ekl8XA5j3W5j/jFvgUTnQ+JA5g5clhsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYxSRjIYNz22xUcAmT1aAdmrEUcv8CLAhGZa7IkmB3zRsmr7KvStlyNUdLkIiF88I+xR71ToKRONTYUokJFV4AiTL8zA/PhuckpVRAIlqF+7sZ7P6BxfQgnIcD8jzFSvr53Zy3Oje7LV2yKs/mRSBU8POZry0axOeiK81U6dgAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AztyNIBs; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AztyNIBs"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969899; x=1795505899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L+8UyA6iiD9Ekl8XA5j3W5j/jFvgUTnQ+JA5g5clhsg=;
  b=AztyNIBsymHpCJgm+1nAnowB7ihYLAHiGC64eRn/ui9rQFVBaOv7mUQG
   001/EfpNpMTersVwWGGpGWBPjj7fkFqaSRvQeLdmNMFUWpd+PGsMy6+K0
   int4xsxrUt2K3fZgo4hXFqeZ/JKPnD8j0paJsq0F5JK4lnLQ9d1Aeeggx
   Ho9qCL/Eh9a9m7VqAOWuauF8wdnQVWjas35IozVPFn30+xCrI9GYxYnCL
   xVSAE4PeshCqvUV8vXSk9+bUkiaQ3MNHrDJ6mJW2oXaOh1TjBta50coRF
   jbNOkgquQ1zxStb++ZHXYhLNtBoYbdsrc0uMc8Ta2T531C11kHL5mmvKF
   g==;
X-CSE-ConnectionGUID: 2k0il0MEQnqCBlzzXkrRTQ==
X-CSE-MsgGUID: 72kT2j5kQSWhjdcqF6Q2rw==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619359"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:38:19 +0800
IronPort-SDR: 69240b6a_ILKD8BreJ+F7Xq2RVsCTDQj/TNv4b2syGyGZbGB7cTvkLHG
 sEjeLtMiibMcrEEWuq64ExnmXl9z8fyKHhL1WGQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:38:19 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:38:16 -0800
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
Subject: [RESEND PATCH blktrace v3 09/20] blkparse: factor out reading of a singe blk_io_trace event
Date: Mon, 24 Nov 2025 08:37:28 +0100
Message-ID: <20251124073739.513212-10-johannes.thumshirn@wdc.com>
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

Factor out reading a single blk_io_trace event. This de-duplicates code
and also prepares for expansion with new trace protocol versions.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 78 ++++++++++++++++++++++++------------------------------
 1 file changed, 34 insertions(+), 44 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 5645c31..2e175b8 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2428,6 +2428,34 @@ static inline __u32 get_magic(__u32 magic)
 	return __bswap_32(magic);
 }
 
+static int read_one_bit(int fd, struct blk_io_trace *bit, int block,
+			int *fdblock)
+{
+	int ret;
+	int pdu_len;
+	void *p = (void *) ((u8 *)bit + sizeof(__u32));
+
+	ret = read_data(fd, p, sizeof(*bit) - sizeof(__u32), block, fdblock);
+	if (ret)
+		return ret;
+
+	pdu_len = get_pdulen(bit);
+	if (pdu_len) {
+		void *ptr = realloc(bit, sizeof(*bit) + pdu_len);
+
+		ret = read_data(fd, ptr + sizeof(*bit), pdu_len, 1, fdblock);
+		if (ret) {
+			free(ptr);
+			return ret;
+		}
+		bit = ptr;
+	}
+
+	trace_to_cpu(bit);
+
+	return 0;
+}
+
 static int read_events(int fd, int always_block, int *fdblock)
 {
 	struct per_dev_info *pdi = NULL;
@@ -2436,9 +2464,8 @@ static int read_events(int fd, int always_block, int *fdblock)
 	while (!is_done() && events < rb_batch) {
 		struct blk_io_trace *bit;
 		struct trace *t;
-		int pdu_len, should_block, ret;
+		int should_block, ret;
 		__u32 magic;
-		void *p;
 
 		should_block = !events || always_block;
 
@@ -2465,33 +2492,14 @@ static int read_events(int fd, int always_block, int *fdblock)
 
 		bit = bit_alloc();
 		bit->magic = magic;
-		p = (void *) ((u8 *)bit + sizeof(magic));
 
-		ret = read_data(fd, p, sizeof(*bit) - sizeof(magic),
-				should_block, fdblock);
-		if (ret) {
-			bit_free(bit);
-			if (!events && ret < 0)
-				events = ret;
+		ret = read_one_bit(fd, bit, 1, fdblock);
+		if (ret)
 			break;
-		}
-
-		pdu_len = get_pdulen(bit);
-		if (pdu_len) {
-			void *ptr = realloc(bit, sizeof(*bit) + pdu_len);
-
-			if (read_data(fd, ptr + sizeof(*bit), pdu_len, 1, fdblock)) {
-				bit_free(ptr);
-				break;
-			}
-
-			bit = ptr;
-		}
-
-		trace_to_cpu(bit);
 
 		if (verify_trace(bit)) {
 			bit_free(bit);
+			bit = NULL;
 			continue;
 		}
 
@@ -2605,10 +2613,9 @@ static int ms_prime(struct ms_stream *msp)
 	struct per_dev_info *pdi = msp->pdi;
 	struct per_cpu_info *pci = get_cpu_info(pdi, msp->cpu);
 	struct blk_io_trace *bit = NULL;
-	int ret, pdu_len, ndone = 0;
+	int ret, ndone = 0;
 
 	for (i = 0; !is_done() && pci->fd >= 0 && i < rb_batch; i++) {
-		void *p;
 
 		ret = read_data(pci->fd, &magic, sizeof(magic), 1,
 				&pci->fdblock);
@@ -2626,28 +2633,11 @@ static int ms_prime(struct ms_stream *msp)
 		}
 		bit = bit_alloc();
 		bit->magic = magic;
-		p = (void *) ((u8 *)bit + sizeof(magic));
 
-		ret = read_data(pci->fd, p, sizeof(*bit) - sizeof(magic), 1,
-				&pci->fdblock);
+		ret = read_one_bit(pci->fd, bit, 1, &pci->fdblock);
 		if (ret)
 			goto err;
 
-		pdu_len = get_pdulen(bit);
-		if (pdu_len) {
-			void *ptr = realloc(bit, sizeof(*bit) + pdu_len);
-			ret = read_data(pci->fd, ptr + sizeof(*bit), pdu_len,
-							     1, &pci->fdblock);
-			if (ret) {
-				free(ptr);
-				bit = NULL;
-				goto err;
-			}
-
-			bit = ptr;
-		}
-
-		trace_to_cpu(bit);
 		if (verify_trace(bit))
 			goto err;
 
-- 
2.51.0

