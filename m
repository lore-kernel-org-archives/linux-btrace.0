Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B72D8375;
	Tue, 25 Nov 2025 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057146; cv=none; b=h8DVkcYFF0kan7+DPqiTmzDAadO7ZD1fhhlBiqHi6oFn42SRu3tHhuvgsrmwArHHmXnDXlv+w5H908ckab0yh3uq6CpMrLqPte1ax2zIT29/RwxM3OQ7HZToOnRzoP7IpDVhzk5zVkYZQekm8GfRV+WaMGteN/HDztusSIb0NYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057146; c=relaxed/simple;
	bh=LqWeUmKJ6NQR38aDiso79Ju7WYePOGVRayUoPjimp0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiawbKdmeIdFFslPkLDGSNSmgZO36uHuo2hpCG6RrlmZ9O+ee5YyZ8ZlRddtWekuIPQpNBPglgqlr47F5Xj+UgMTnvjzsApwQ6z+OwLlyZYgZMM+PahgZEU+grV9PQfo3nOTXmoJFio5Fvuo0vTp+9HERlA/stKKXvPvwS6WL+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ldf2z1vR; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ldf2z1vR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057144; x=1795593144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LqWeUmKJ6NQR38aDiso79Ju7WYePOGVRayUoPjimp0w=;
  b=Ldf2z1vRmkecU/6sVIXTL9lIb6DEUhg2z7/fbx9hozmYTFCfwczM9NTz
   VkN1JgmjSCi5w50KmJnebaqqXOSBd36K53yEK6PLamxDSRP72VGE7unn3
   hS4rECuVv2ex+tIYf7a3HV+JbpSwycPL2vS+sRnxjX2R1uGT3TWqVHkbm
   vYyZTheg25CbXjYVsOjYcm92YQaZ9W1BYN5o4G/PfHVQOxRIGKzgW5B+V
   iwIXwh+LrYBq8RfWyKfWUuBTNdZnUSYcYJJV3m6HlkTUD1y3Uqxz80TAw
   hcFQuwsfGkNooQPerftFV6wgy9/CnvQdeRL5g6qh6ZOoFBoFgiT8TukR/
   w==;
X-CSE-ConnectionGUID: zt3aNfmzT/2g6l95goGEjA==
X-CSE-MsgGUID: QdWIb8zaSlG5QRcooyZEyA==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749797"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:24 +0800
IronPort-SDR: 69256037_XDKVEBRHnaAu3NInu0eA0c9d200qsv3i8QygIc4fQf2hv7s
 Syd/ZNsrjZp6UgAzAXdIQcS8BGUk2kiV9aZf9Nw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:24 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:23 -0800
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
Subject: [PATCH v4 09/20] blkparse: skip unsupported protocol versions
Date: Mon, 24 Nov 2025 23:51:55 -0800
Message-ID: <20251125075206.876902-10-johannes.thumshirn@wdc.com>
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

Skip unsupported protocol versions for now.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 136 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 76 insertions(+), 60 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 2e175b8..163da73 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2462,10 +2462,10 @@ static int read_events(int fd, int always_block, int *fdblock)
 	unsigned int events = 0;
 
 	while (!is_done() && events < rb_batch) {
-		struct blk_io_trace *bit;
 		struct trace *t;
 		int should_block, ret;
 		__u32 magic;
+		u8 version;
 
 		should_block = !events || always_block;
 
@@ -2489,42 +2489,50 @@ static int read_events(int fd, int always_block, int *fdblock)
 			fprintf(stderr, "Bad magic %x\n", magic);
 			break;
 		}
+		version = magic & 0xff;
+		if (version == SUPPORTED_VERSION) {
+			struct blk_io_trace *bit;
+			bit = bit_alloc();
+			bit->magic = magic;
 
-		bit = bit_alloc();
-		bit->magic = magic;
+			ret = read_one_bit(fd, bit, 1, fdblock);
+			if (ret)
+				break;
 
-		ret = read_one_bit(fd, bit, 1, fdblock);
-		if (ret)
-			break;
+			/*
+			 * not a real trace, so grab and handle it here
+			 */
+			if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+			    (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
+				handle_notify(bit);
+				output_binary(bit, sizeof(*bit) + bit->pdu_len);
+				continue;
+			}
 
-		if (verify_trace(bit)) {
-			bit_free(bit);
-			bit = NULL;
-			continue;
-		}
+			if (verify_trace(bit)) {
+				bit_free(bit);
+				bit = NULL;
+				continue;
+			}
 
-		/*
-		 * not a real trace, so grab and handle it here
-		 */
-		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
-			handle_notify(bit);
-			output_binary(bit, sizeof(*bit) + bit->pdu_len);
-			continue;
-		}
+			t = t_alloc();
+			memset(t, 0, sizeof(*t));
+			t->bit = bit;
+			t->read_sequence = read_sequence;
 
-		t = t_alloc();
-		memset(t, 0, sizeof(*t));
-		t->bit = bit;
-		t->read_sequence = read_sequence;
+			t->next = trace_list;
+			trace_list = t;
 
-		t->next = trace_list;
-		trace_list = t;
+			if (!pdi || pdi->dev != bit->device)
+				pdi = get_dev_info(bit->device);
 
-		if (!pdi || pdi->dev != bit->device)
-			pdi = get_dev_info(bit->device);
+			if (bit->time > pdi->last_read_time)
+				pdi->last_read_time = bit->time;
+		} else {
+			fprintf(stderr, "unsupported version %d\n", version);
+			continue;
+		}
 
-		if (bit->time > pdi->last_read_time)
-			pdi->last_read_time = bit->time;
 
 		events++;
 	}
@@ -2616,6 +2624,7 @@ static int ms_prime(struct ms_stream *msp)
 	int ret, ndone = 0;
 
 	for (i = 0; !is_done() && pci->fd >= 0 && i < rb_batch; i++) {
+		u8 version;
 
 		ret = read_data(pci->fd, &magic, sizeof(magic), 1,
 				&pci->fdblock);
@@ -2631,46 +2640,53 @@ static int ms_prime(struct ms_stream *msp)
 			goto err;
 
 		}
-		bit = bit_alloc();
-		bit->magic = magic;
+		version = magic & 0xff;
+		if (version == SUPPORTED_VERSION) {
+			bit = bit_alloc();
+			bit->magic = magic;
 
-		ret = read_one_bit(pci->fd, bit, 1, &pci->fdblock);
-		if (ret)
-			goto err;
+			ret = read_one_bit(pci->fd, bit, 1, &pci->fdblock);
+			if (ret)
+				goto err;
 
-		if (verify_trace(bit))
-			goto err;
+			if (verify_trace(bit))
+				goto err;
 
-		if (bit->cpu != pci->cpu) {
-			fprintf(stderr, "cpu %d trace info has error cpu %d\n",
-				pci->cpu, bit->cpu);
-			continue;
-		}
+			if (bit->cpu != pci->cpu) {
+				fprintf(stderr,
+					"cpu %d trace info has error cpu %d\n",
+					pci->cpu, bit->cpu);
+				continue;
+			}
 
-		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
-			handle_notify(bit);
-			output_binary(bit, sizeof(*bit) + bit->pdu_len);
-			bit_free(bit);
-			bit = NULL;
+			if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+			    (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
+				handle_notify(bit);
+				output_binary(bit, sizeof(*bit) + bit->pdu_len);
+				bit_free(bit);
+				bit = NULL;
 
-			i -= 1;
-			continue;
-		}
+				i -= 1;
+				continue;
+			}
 
-		if (bit->time > pdi->last_read_time)
-			pdi->last_read_time = bit->time;
+			if (bit->time > pdi->last_read_time)
+				pdi->last_read_time = bit->time;
 
-		t = t_alloc();
-		memset(t, 0, sizeof(*t));
-		t->bit = bit;
+			t = t_alloc();
+			memset(t, 0, sizeof(*t));
+			t->bit = bit;
 
-		if (msp->first == NULL)
-			msp->first = msp->last = t;
-		else {
-			msp->last->next = t;
-			msp->last = t;
+			if (msp->first == NULL)
+				msp->first = msp->last = t;
+			else {
+				msp->last->next = t;
+				msp->last = t;
+			}
+		} else {
+			fprintf(stderr, "unsupported version %d\n", version);
+			continue;
 		}
-
 		ndone++;
 		bit = NULL;
 	}
-- 
2.51.1

