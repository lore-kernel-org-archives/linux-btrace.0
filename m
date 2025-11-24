Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB02EA480;
	Mon, 24 Nov 2025 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969928; cv=none; b=giYrDhsS1SggZJym/MlsMfSSJ2COF0E2zyI6nWuavPP/OiIYPl75qVoJkAXebPcehsQUwSDqhOxL43wdgpwF+4Ei6LLJTPmTHWocdN72RAjqFVatwWWVYXDbQ/mBJVK2qsKjGlXlsa17IziY8peZ2gECUztrSF41/UHXD7/Qqls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969928; c=relaxed/simple;
	bh=NlP9p8yLWcSJahQC+UEL2+MNqHwl4Hkpnif3ssjYDYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFNdmcO3L0KvBOO5aildLrfixQXcK+9VLKO8E/fXYEG9QKamx8IJZ0YIqMAclDOdlaV06i32DTaHo7DUH6up4g4S9SDbOUEs0/oB5wtMg5lwt8Nbf6MrLABjEr16OlQ5NtYsOH4hiM2WPc297WIuGoc+C94+Co/1Y/WoLYkZniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=F91CoBg3; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F91CoBg3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969927; x=1795505927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NlP9p8yLWcSJahQC+UEL2+MNqHwl4Hkpnif3ssjYDYs=;
  b=F91CoBg3Wa7lkp9ifrpghPy/L5Xbs1GfTHjMqITs2c50m2wD96Ovjcq7
   IbF1h70S3RMDRPxUzMOCcL5vxOf+e8rFW+s273VYootjav8jjH+CcS85s
   elMANs+TBU3AZW0iMMdWssebavHC0Dc6/2cQjdtp+CtqDmXN4oMN6gklo
   Bl79ByJhapzdYmOV9Uz3oByxhlV/Ub1enlIvvdXtf5+3cIIW9KBILZ0rX
   4SRYVBMEsoPyhDoReCJI47PBoZyckffHCds2nJApaWrD4AB1kOD9C723y
   /rnpCcGyj1fv2LTZP92czd+XRpoOgYtctki/aX5Zs+hVZdbnxxvJ0L2ns
   w==;
X-CSE-ConnectionGUID: HzoI1tDdRf+eZA/zM4XNFw==
X-CSE-MsgGUID: OGcT6aJNRJ+0DtCUFuEjnQ==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619389"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:38:46 +0800
IronPort-SDR: 69240b86_9pmOTha2qBZEDtLReYOAkq515/al1o50vZIY6UvYZzlt8Ag
 uYqgFd4G53glTDdspGbL7wgNnykEtsIDxt84kWw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:38:47 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:38:43 -0800
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
Subject: [RESEND PATCH blktrace v3 17/20] blkparse: natively parse blk_io_trace2
Date: Mon, 24 Nov 2025 08:37:36 +0100
Message-ID: <20251124073739.513212-18-johannes.thumshirn@wdc.com>
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

