Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD22E88A1;
	Mon, 24 Nov 2025 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969904; cv=none; b=hjpz1SAuucFfqJsJl2PEtSX9Z67Bv7TZkqnrNHEKKy7FxWLy1mvP+neFTY55oIIi6pNkYk1HE90ayP1JFI1OloZXi8ReequBUSsNy7QExqDAODoGH/cWp8Eljq1Kfgow6VXR+Gxt8CTJe8yKLGs7ZW0IFGOtYjbDhtsfdKYjBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969904; c=relaxed/simple;
	bh=3onupmVD5/2IoDoElAt/o05PCAfeDat+6p0RvJChYCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBYHARt9p+aCId6KCBpKVtZEA1YiFLAS0T7TKk0GX/Ga23KrV27kVrxYP/Up8QLhuTQUAupo5/k6/F5g6FmGxePvddT4MMjwR9a50nPSIInuBeDi5q5C7TMSF8Wg0Q5WJffoxms25dg5JLpxIvqO+Z9GSHvIDj+Eme9L/PCi3XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pKQHTSUM; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pKQHTSUM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969902; x=1795505902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3onupmVD5/2IoDoElAt/o05PCAfeDat+6p0RvJChYCo=;
  b=pKQHTSUMpKjmYBP3pui3/Mjlb+zkMNmKVV1tGxP5m/9GjdrMjhQNZmvh
   xayWb4AZcjTs6H34OCnKAgkK4hBlD0NQwMG8oMXfq/evfZqvGiAWSVtSq
   2ixf622plS9IKgpey1YWhAzAqlI5kQSx6iXMaP7xTvWBTtzk/ECpBsgUW
   b09bOHhToC2kJ50r2kqnGX3lEDqNsBeAy7g48LxT4erwnGaEuQu8FDLsc
   ycN+g/FZ0IUwTXHCvC2e914aZVe7rOW0y5J9pHFK8+iS06r1bBYonvwxA
   x3qLAgbelw7p4nENv+bYuSnomKnhLVuFKYOY04/0TGsMpN8AAisnJDJjD
   A==;
X-CSE-ConnectionGUID: u0LwhbJxR2uKb/FhQxPvzg==
X-CSE-MsgGUID: GPi6ztehSJ2xaYXVOSQxJA==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619363"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:38:22 +0800
IronPort-SDR: 69240b6e_UBMiepl443P12Irmmsh+6+fz8nHqx/RjrqzWOBYrUrgZaA9
 g/2qO9i22i/h0HVQFverReFf6zb+vx8ntxBr89w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:38:23 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:38:19 -0800
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
Subject: [RESEND PATCH blktrace v3 10/20] blkparse: skip unsupported protocol versions
Date: Mon, 24 Nov 2025 08:37:29 +0100
Message-ID: <20251124073739.513212-11-johannes.thumshirn@wdc.com>
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

Skip unsupported protocol versions for now.

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
2.51.0

