Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B062D7DC2;
	Tue, 25 Nov 2025 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057144; cv=none; b=AIrPO/s/Cp1Tb47zv7RS5DhIcZy7XpL09q7keOmTwTFT5N0F5xvWBGxralrETXlVngFZLEmTtonGCyNbtgaH7TuXS8ADwVW+6KpuqjkB4GSsL0jrpSvgCsrvLxe/PjpF+BvivWCOq0CcnoyVFu6v5my5v9Gm5i0vG2kzjieSakg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057144; c=relaxed/simple;
	bh=IbSe+3D1Vfp2D/8aOQDpfCguF580eM63YmmBlh6Br/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLR4/qP/ljhIuu/mtmlI5Oj3O4FY8e/SUwR054GA4b5jzswjaUFRq3yrLGzxf6nv4YRqUotCqLfFr75v9K2jlnfSDRp0WX3tC54HTqPpMIt5ZMNtsqUrhxQDX1XhOvnoMvR4DJAbmG0lAosXHuOC3z/BfpWPwPzMD43SZUUvXPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BTtDc/eE; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BTtDc/eE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057142; x=1795593142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IbSe+3D1Vfp2D/8aOQDpfCguF580eM63YmmBlh6Br/I=;
  b=BTtDc/eE+UULnpKDcKyBE3aX4QBeJ1DcZ4HT8K4ggK80Dtf8F5XM7kvz
   uTSvw8D2hXaKyK7G8vijoqzmBffpP/VDomFus41ROsNKHANYdSQzTiNN9
   PcGWNXA7Aw84TryhojrfFP1m16bbi50GnP2s4gtoEeEwt8SsI3PrjgGqh
   TvhVUQ0KMAGmgSOxEdlOSjnSZ/Uo9etAilvkwKovGuvstXqN5qmxfUhTj
   4Klag13Riha3QgOgih3qDpGUS+Lar9QXmnbQMlsnx07Pn8A+nDzuoYIb5
   8tm/z50au4uNcvatzVGGreffPj9WF3WE5IA/dxywTkriZd1qHHHMaLWJE
   A==;
X-CSE-ConnectionGUID: VbUbWHKlQl+fJSruImpsCQ==
X-CSE-MsgGUID: /baxG96RTMen7jLsUB0xxw==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749796"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:22 +0800
IronPort-SDR: 69256036_AE3P55BQlbw856w3/TUtDsvgM9Uy0XaKX6eUtc8U96nc+a7
 3jU6ZKPp++PPdRgid5YHxAig5/8VK0O7VTtBZ6A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:22 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:21 -0800
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
Subject: [PATCH v4 08/20] blkparse: factor out reading of a singe blk_io_trace event
Date: Mon, 24 Nov 2025 23:51:54 -0800
Message-ID: <20251125075206.876902-9-johannes.thumshirn@wdc.com>
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

Factor out reading a single blk_io_trace event. This de-duplicates code
and also prepares for expansion with new trace protocol versions.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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
2.51.1

