Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB0F2D948F;
	Tue, 25 Nov 2025 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057156; cv=none; b=YhYIQYlyRooP+FB/qv51fPybiKTYicB+1sjsss1uN/gHZsLmaLvGX+exLLGiga2PsERXBRpF+x/xVB3V65DhGtXzn2kCvNtkOy/feMDv6oupR+jTa9CI4oBw32ougxmEFCxVj07wjPHVO0qr2mAf78q8BNaMs925tQwNdzGMUnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057156; c=relaxed/simple;
	bh=z7K/T1kODCOW4xcy6pMJcbTD9bVcrrQbKn+FmrJjrpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qewnCVgcaRAgtNJjbLl+gddaNUHtWYktxT6ygwECvnZm7JPqpW58WWk4q7uOOh1DE/YAbeWyRF7xLgJaRFX1neHpPbR6t4zP+TkGJ/pw94cb5ajEA0lyABq/Sk48HydRTAGmqhl9Gxanz5ohiimVUCBNgPZc2AovXVItf9J+8bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fL1rc5Vw; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fL1rc5Vw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057154; x=1795593154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z7K/T1kODCOW4xcy6pMJcbTD9bVcrrQbKn+FmrJjrpk=;
  b=fL1rc5VwIHI96jsoU9AAc2fDdQ+wKi7NHNV23qMguwhTKGyFa5BEA3QP
   1aA2QbTsYRTNaIfnlz1Kwyu6e2FrhRe7xVHBFkRmX7TeiaN5ojjbt2KdO
   B/BaJtkTyIyKtN0c+GCuHGAGf3JzvhI87pU2Oun1rkhAFinM8yWbkqRBA
   cs9zpOeovN3aN1+r1I1H3dNr7zwUs6V1lNA1pDenQ0SOu22qtxHFA7Cub
   Oivsn+PFulGKDPWFKpmmH06ulRuqWPg5PVWL1IC0MUTxBwzO0PAO90qcB
   xQavTb+eK8TOq+uaKAAH7t/6TDMczi7uV0VLEEjAhDW5QUYwHjgQAEli5
   A==;
X-CSE-ConnectionGUID: jIRJN5cyQLaKoBGRMv6vdA==
X-CSE-MsgGUID: ExC8ZjphRxe2gxlvyPakUA==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749816"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:34 +0800
IronPort-SDR: 69256042_n49H5fLrCgyQkbTKwlX99BvGFY0xSKw4i4YQ+lT+dmG0jz5
 hIQeIaHPn0jFLMiNU9LHPlRYcllMPTJW+CHWvIg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:34 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:34 -0800
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
Subject: [PATCH v4 16/20] blkparse: natively parse blk_io_trace2
Date: Mon, 24 Nov 2025 23:52:02 -0800
Message-ID: <20251125075206.876902-17-johannes.thumshirn@wdc.com>
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

Natively parse 'struct blk_io_trace2' from a blktrace binary.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 blktrace.h |  18 +++++++++
 2 files changed, 130 insertions(+)

diff --git a/blkparse.c b/blkparse.c
index 7100009..2eec3a9 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2471,6 +2471,37 @@ static int read_one_bit(int fd, struct blk_io_trace2 **bit2, int block,
 	return 0;
 }
 
+static int read_one_bit2(int fd, struct blk_io_trace2 **bit2, int block,
+			 int *fdblock)
+{
+	struct blk_io_trace2 *new = *bit2;
+	int ret;
+	int pdu_len;
+	void *p;
+
+	p = (void *) ((u8 *)new + sizeof(__u32));
+
+	ret = read_data(fd, p, sizeof(*new) - sizeof(__u32), block, fdblock);
+	if (ret)
+		return ret;
+
+	pdu_len = get_pdulen(new->pdu_len);
+	if (pdu_len) {
+		void *ptr = realloc(new, sizeof(*new) + pdu_len);
+
+		ret = read_data(fd, ptr + sizeof(*new), pdu_len, 1, fdblock);
+		if (ret) {
+			free(ptr);
+			return ret;
+		}
+		new = ptr;
+	}
+
+	bit2_trace_to_cpu(new);
+	*bit2 = new;
+
+	return 0;
+}
 static int read_events(int fd, int always_block, int *fdblock)
 {
 	struct per_dev_info *pdi = NULL;
@@ -2538,6 +2569,44 @@ static int read_events(int fd, int always_block, int *fdblock)
 			t->next = trace_list;
 			trace_list = t;
 
+			if (!pdi || pdi->dev != bit->device)
+				pdi = get_dev_info(bit->device);
+
+			if (bit->time > pdi->last_read_time)
+				pdi->last_read_time = bit->time;
+		} else if (version == SUPPORTED_VERSION2) {
+			struct blk_io_trace2 *bit;
+			bit = bit_alloc();
+			bit->magic = magic;
+
+			ret = read_one_bit2(fd, &bit, 1, fdblock);
+			if (ret)
+				break;
+
+			/*
+			 * not a real trace, so grab and handle it here
+			 */
+			if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+			    (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
+				handle_notify(bit);
+				output_binary(bit, sizeof(*bit) + bit->pdu_len);
+				continue;
+			}
+
+			if (verify_trace(bit->magic)) {
+				bit_free(bit);
+				bit = NULL;
+				continue;
+			}
+
+			t = t_alloc();
+			memset(t, 0, sizeof(*t));
+			t->bit = bit;
+			t->read_sequence = read_sequence;
+
+			t->next = trace_list;
+			trace_list = t;
+
 			if (!pdi || pdi->dev != bit->device)
 				pdi = get_dev_info(bit->device);
 
@@ -2698,6 +2767,49 @@ static int ms_prime(struct ms_stream *msp)
 				msp->last->next = t;
 				msp->last = t;
 			}
+		} else if (version == SUPPORTED_VERSION2) {
+			bit = bit_alloc();
+			bit->magic = magic;
+
+			ret = read_one_bit2(pci->fd, &bit, 1, &pci->fdblock);
+			if (ret)
+				goto err;
+
+			if (verify_trace(bit->magic))
+				goto err;
+
+			if (bit->cpu != pci->cpu) {
+				fprintf(stderr,
+					"cpu %d trace info has error cpu %d\n",
+					pci->cpu, bit->cpu);
+				continue;
+			}
+
+			if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+			    (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
+				handle_notify(bit);
+				output_binary(bit, sizeof(*bit) + bit->pdu_len);
+				bit_free(bit);
+				bit = NULL;
+
+				i -= 1;
+				continue;
+			}
+
+			if (bit->time > pdi->last_read_time)
+				pdi->last_read_time = bit->time;
+
+			t = t_alloc();
+			memset(t, 0, sizeof(*t));
+			t->bit = bit;
+
+			if (msp->first == NULL)
+				msp->first = msp->last = t;
+			else {
+				msp->last->next = t;
+				msp->last = t;
+			}
+
 		} else {
 			fprintf(stderr, "unsupported version %d\n", version);
 			continue;
diff --git a/blktrace.h b/blktrace.h
index 2aace2f..0281088 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -127,6 +127,24 @@ static inline void bit_to_bit2(struct blk_io_trace *old,
 		       old->pdu_len);
 }
 
+static inline void bit2_trace_to_cpu(struct blk_io_trace2 *t)
+{
+	if (data_is_native)
+		return;
+
+	t->magic	= be32_to_cpu(t->magic);
+	t->sequence	= be32_to_cpu(t->sequence);
+	t->time		= be64_to_cpu(t->time);
+	t->sector	= be64_to_cpu(t->sector);
+	t->bytes	= be32_to_cpu(t->bytes);
+	t->action	= be64_to_cpu(t->action);
+	t->pid		= be32_to_cpu(t->pid);
+	t->device	= be32_to_cpu(t->device);
+	t->cpu		= be32_to_cpu(t->cpu);
+	t->error	= be16_to_cpu(t->error);
+	t->pdu_len	= be16_to_cpu(t->pdu_len);
+}
+
 static inline void bit_trace_to_cpu(struct blk_io_trace *t)
 {
 	if (data_is_native)
-- 
2.51.1

