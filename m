Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E5031E0F0;
	Wed, 15 Oct 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525907; cv=none; b=hvnrLI26qXGVegoQwj/DW7hdMuaSATq60kir1qHsKGMyQTACL+6g3oZy9OqS5xtWWsG23vk6mRdVSh3l2M8T2beXNrAo8uKYW7NNlXr33b5OwZg73TAA7r7AmIS0FgyuuDH4OqV95jXTy40/jb21yTw0CyvYeKENycrY72+WIg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525907; c=relaxed/simple;
	bh=NlP9p8yLWcSJahQC+UEL2+MNqHwl4Hkpnif3ssjYDYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QejjdLCJSZGqQK51d+WWDPrFLQQrgZqZbz84aQScvep8YxV3DowBzxbPnLAWglSMuLQan2DFCG8VitfquOqjzfevpdO1Xk2dmjBMebtmbkz1W6xrGQtl4Tz02znxbPXoWkBd5BCt4dmkBH2RpexHn9dEBqiBsI3BUsYAwvPFYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bDTBMkPj; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bDTBMkPj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525904; x=1792061904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NlP9p8yLWcSJahQC+UEL2+MNqHwl4Hkpnif3ssjYDYs=;
  b=bDTBMkPjT06acOBmjykS+pUfbjZ6aKlNQVruzMU18OZQcS7ho/PDWHR8
   dkhqYMQcH78oM6NdO3bgTh7VNmQiozbMO9MLRqsNHgnARzKKHwOc3x9Cd
   YYKXTk01KlAXfa8M8mVjENOv3aHg8Ez4/N1mqMOndPj8DrzoHako5RJlZ
   1761KxafIssRPXwHBHBTPYr4Up2VMK2sKN5I6QqRPcXeUHoDvqkl5MKJL
   RUvuXy6ze2OnDxFYDBvbYqigxcbmcLktTuTk7RRGVVoyuyP3lEWWy9f5w
   LUoN4AnNOyRPpdkoAT8UvVt8FeR8tH/2GGYrUaiNpWOOn/YT4uoSPVGH9
   g==;
X-CSE-ConnectionGUID: 3Be7mg5FRouOP2SvaS5q8g==
X-CSE-MsgGUID: Qs32MYYoQMy5Em+UZjBBWA==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935421"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:58:24 +0800
IronPort-SDR: 68ef7e50_3FM95QLQVU/2KWblVpCCYreAnoMV3CG2Sc/L9+1TilMkcw7
 7PUwcrqriZPKQALyxJlNIVr8V62sFtUTbgMFCcw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:58:24 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:58:21 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: axboe@kernel.dk
Cc: chaitanyak@nvidia.com,
	dlemoal@kernel.org,
	hare@suse.de,
	hch@lst.de,
	john.g.garry@oracle.com,
	linux-block@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	naohiro.aota@wdc.com,
	rostedt@goodmis.org,
	shinichiro.kawasaki@wdc.com,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH blktrace v3 17/20] blkparse: natively parse blk_io_trace2
Date: Wed, 15 Oct 2025 12:56:55 +0200
Message-ID: <20251015105658.527262-18-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
References: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Natively parse 'struct blk_io_trace2' from a blktrace binary.

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
index 196b3c9..ba06237 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -129,6 +129,24 @@ static inline void bit_to_bit2(struct blk_io_trace *old,
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
2.51.0

