Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00702D879C;
	Tue, 25 Nov 2025 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055685; cv=none; b=OkbrRoa1Isr4SaqvX4P0VHveuf71rg54+BO4iZ8Vj264a4q8tzxUmPxdZsvLx3BMYWouljB+RjHMu5xSvXmS1mO1ergWEBbl4SSXUi0ADnVLjioymdz5o0oTQW4g8XmcRW8prlNFBzniSdt2T3VQFtzFhaHaawmrUXEE6cj5/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055685; c=relaxed/simple;
	bh=IbSe+3D1Vfp2D/8aOQDpfCguF580eM63YmmBlh6Br/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USCmPzG7ltZc98jjRHzER2cmmMGsV94l+/+MLZuNPckLjxbYlyDW4AMfwmWtxwkfJa96YjUjrdPx3EJ0O+9rIy73L/cMe1NYBa4fNqJtEmyLzVII6RqqodSmgJRlh4SyuFz0vylWtsLv3Zo5h9nv2pljrNpgYz22ARRZMrZqrS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=S/pKQIQy; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S/pKQIQy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764055683; x=1795591683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IbSe+3D1Vfp2D/8aOQDpfCguF580eM63YmmBlh6Br/I=;
  b=S/pKQIQyWp7z60PQXic7b1Dcxp1ALLCwVuXIvAxypwh75q5eQeacvESm
   tWyAtVQEfC67UmXjHV454U2LboPFBJ2DmUDh4AYqadqwPFxVynhsVzgK0
   wUDVZ6Oj8/q1zEG3GZPaBwhq3HgrGyfkO8WNqrziIw+Y1mdQLfmcJxeGk
   vZJD89CHio4nOe7z49AX3lLtZ9CaGyVasXTxW3LiGuMZ7RvPf7sUu32dB
   n1uKkFS0FCWblQZc+VEk2E04OWR08vTepp7py5w4854CsSo+ikJEyjoqs
   m87ImSKsFc8KUDM8Vtj4qfobeRWHXXQYvJ4TmFunHfE7z5srcsZbY1B7D
   g==;
X-CSE-ConnectionGUID: G1yCakyUTAuH5fzrw7wWJw==
X-CSE-MsgGUID: ScrTB5+YToiEItItx6TlKw==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135337544"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:28:03 +0800
IronPort-SDR: 69255a83_JU4mmpnb+XROOJVOqkxGAxGzbABa2HY2Wxjcz+fURfO5D+R
 /qNPBakr8IBBgDoJore+2s0bxOiOymhKbZtTIJQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:28:04 -0800
WDCIronportException: Internal
Received: from ft4m3x2.ad.shared (HELO neo.wdc.com) ([10.224.28.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2025 23:28:01 -0800
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
Subject: [PATCH v4 08/20] blkparse: factor out reading of a singe blk_io_trace event
Date: Tue, 25 Nov 2025 08:27:18 +0100
Message-ID: <20251125072730.39196-9-johannes.thumshirn@wdc.com>
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

