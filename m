Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF5C313D45;
	Thu, 25 Sep 2025 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812714; cv=none; b=qdXeYYAjK0F/65DPTii2PEg58gUq+BYe02xcQre+j/b3+hm94VJoCekVdoXDbZZzjgZfgiB/RnQyAgtvgC5hLiBFHQR9Yq1HOSVBxtMxTske1Iz0FBIICFd+V6YUZldOiYMbhVA8LYqOVy7V/hOFMigqHd+58FPUJTASchRCy6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812714; c=relaxed/simple;
	bh=L+8UyA6iiD9Ekl8XA5j3W5j/jFvgUTnQ+JA5g5clhsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvJ26V1ycDe2cIpbIJi7pX2eipBQ29L/3/JPkqbQZmN2XY8fVuf3bHQL7zAdIELyCJFBu2iH2zEAC1B9OBR6sKTlIXJir6WUBt818KOWsYt9Z6gjXz5iQ5sxpBYp7P3tEYL9gbwKzk+rDmIPweZD3xw8AnhVWjalwmMBZUd8HjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=l88M8hEK; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l88M8hEK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812712; x=1790348712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L+8UyA6iiD9Ekl8XA5j3W5j/jFvgUTnQ+JA5g5clhsg=;
  b=l88M8hEK96vrZ62ou8HDJXQcgT77akXD8firvmriaa1DT7Kj0Ah8qTER
   kboEtUza62hk8u4C1mrZD9zZGEV3RHyRgwNL5VTBZdVdl5CZNZC7Wr1oR
   rztPHQmNOWvPfL4KPZOCUIeyREblgtHYHbBorZEKZG2Gk9OI/EJQpbkh+
   yuEtz2gH1a3Qr51XEtQcy+E8Fp+orkPj/aQTYeX2Pk8ajAU2sFhlX6feo
   3uXmcx9sjomz6B99ZvMYwZurCHJh15qsui7m3hx6LrFMOT5m69BTSYqks
   L4f8X4fBSsuenraLhmpvxwruc2EOl2N0xs/rFN92j+xzYajo7P18Aw2xp
   Q==;
X-CSE-ConnectionGUID: CjxxgMlTT+6QwvohaMNcYg==
X-CSE-MsgGUID: uRZ7A50PRXemktGeKDihCQ==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130348964"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:05:12 +0800
IronPort-SDR: 68d55a28_FOTPvU/fIlyghUs20P4howEFEWxCqeseZeKCPx6RgpI7lDo
 bjlQI0eA5kV/IMWe26XO9tcbBL5Snt9eFDm/oaQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:05:12 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:05:09 -0700
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
Subject: [PATCH blktrace v2 09/22] blkparse: factor out reading of a singe blk_io_trace event
Date: Thu, 25 Sep 2025 17:04:14 +0200
Message-ID: <20250925150427.67394-10-johannes.thumshirn@wdc.com>
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

