Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FCC335BAC;
	Tue,  9 Sep 2025 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416092; cv=none; b=acXEosIPgMWX1cCpa9pc2Jlsbl7S2mU7XGRalEh+GhfuF/2WY+oWprUiB3ygGdEAFZvW4hbtyeNCeKJ6ITJzHk0o4LHqEgycOZoKjW1iA6w0jLLyg41wXpNJD6qEPghpMZRt3DIjAWWEsQ6NlSq8Getbu8aYL9HXavRCVZXyMEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416092; c=relaxed/simple;
	bh=Ez4oiGj5L11AjnSxcGg+DGNFghkL7QjvULDGdBfytNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pDrTaOTmdNtwRmcXA8sFsWWXT1YUS5jM6dUDXuY6cEf2btGLa/otIyLvo7D3Edi2svgcouRf+syRefJ4Agkj0EktXKa2zQIx0W9fA++DDHuXfPotavA9XID1Y+YtUYEJfWoKLt9XUroXk0s+nHObisGRj2HjlF7nLm37Qag4iHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FwZOKw2K; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FwZOKw2K"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416091; x=1788952091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ez4oiGj5L11AjnSxcGg+DGNFghkL7QjvULDGdBfytNU=;
  b=FwZOKw2KMVXBEH/YcUiGWXqUPOhVTgKl54/KkJ7hKlvs3rzr7olNViTp
   L6rJwaA9lnXwLP/1PnFYWY+ynJxfBw3u7n+WoLtiqGMeK76JTRgpjdEqW
   baHQW8JR6kptTujJEXsJOIhIUYxNDE2BWV62z1ItcznPczAvqJ2ZIFOHF
   Qzrs3oTbSwYNByQOpj2bS+ygVmaxPm5HKQRE0Nlgs3WseI4YWQBY4tCJD
   YA+/Osi+cmxHjXPZTiYEUPnQDkSvELCqZAbMEpbIvNhIIQEwcBVGvgbwN
   pqFfq3X89CZ9CKjvOAY0jJeBl5HaQ7aTwaKYgnEaenadKLA0hyzxVcrE6
   w==;
X-CSE-ConnectionGUID: WxGLJNA4SoiZLgs/nD1eIQ==
X-CSE-MsgGUID: JPlwgus6R+KSAst0+vCI3A==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810718"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:08:10 +0800
IronPort-SDR: 68c00a9a_AaB5/t57qGLhKPBNhwXWnjgaQwF3DuqelBIcewI1i5zv6no
 HFaDOl/zYOxZh666+CdnBVq+tfzIg79caRa0u3w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:08:10 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:08:06 -0700
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
Subject: [PATCH 09/21] blkparse: factor out reading of a singe blk_io_trace event
Date: Tue,  9 Sep 2025 13:07:11 +0200
Message-Id: <20250909110723.75676-10-johannes.thumshirn@wdc.com>
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

Factor out reading a single blk_io_trace event. This de-duplicates code
and also prepares for expansion with new trace protocol versions.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 78 ++++++++++++++++++++++++------------------------------
 1 file changed, 34 insertions(+), 44 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 8381e20..5d5cd48 100644
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

