Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1262D3A96;
	Tue, 25 Nov 2025 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055688; cv=none; b=bQg1yzG55q52HIhEvZaa7fIPsvueSIyHXKK439SVJe599vbWoY3hNx2KKu/msQDxCOwduZHJM11kcyMKvoI+RM2YnrZ2gZG7xT7QiY8Uc12vXa7qasoanZ37R+AGn2krVME3Qp2JrI1UhTc8ifVc4rT4c01UhcXLgOdMXWdo4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055688; c=relaxed/simple;
	bh=LqWeUmKJ6NQR38aDiso79Ju7WYePOGVRayUoPjimp0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNDxpnemRlRjvt53dSS8o6ZWSyEKzwpMF+ROwZRozjQk+xN3a8sx3Cv6L0KmyONTr1YURAMv7TsSCly12pu9a4fWLzST0q4DS4ZNlJ0/s8nEQ3/jHuzFf5xpMF/mGaxzwo3C92460zphL78BEmSoj47COWE4nDNKVSb3SIMb6wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WC4vJXYi; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WC4vJXYi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764055687; x=1795591687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LqWeUmKJ6NQR38aDiso79Ju7WYePOGVRayUoPjimp0w=;
  b=WC4vJXYiJkULLSBk2nLmg3QiXaBZCMlEwf0Gizuh5YnwZzeZDeWive5y
   XrPHoQTOHGt4XBeND2O30sL4Px+dPfu38dHtMwvfvmPPncoLirzVmp5ap
   Ju3/ixQ8oEqbRTD4GtU9zh68tOxsVpHtT9ij5mvt1XSEl5mdsvYpqQju0
   ClcUvuFFtu9Ly7NuTHNHjBNsouGwybcl5nc3Sz1lq/8pL8XQYH7aAJRj7
   dCXM+JBhWkzFaOjlfvwJ1ocspCCKcBveQMwxX+og0gsohc7xhTy/2ZKtQ
   0Hd0KfmuQTCXEJ8+wMCl1XnImEQSeBJvfl8yN4BUYw3HFt2viK5aR4j+S
   g==;
X-CSE-ConnectionGUID: tivns5/mRGekqx/kTooOhA==
X-CSE-MsgGUID: 8jY9imjMSzeIhtKAGh7Ebg==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135337553"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:28:06 +0800
IronPort-SDR: 69255a86_GDyAncfAhGZz4egz46MDDU19vv8xuN5iWzZZGUOZpBLSAIJ
 sU+8XVIBm6NA3Y1TI/nyIIs0XDMgDlR6KbsDwlA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:28:07 -0800
WDCIronportException: Internal
Received: from ft4m3x2.ad.shared (HELO neo.wdc.com) ([10.224.28.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2025 23:28:04 -0800
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
Subject: [PATCH v4 09/20] blkparse: skip unsupported protocol versions
Date: Tue, 25 Nov 2025 08:27:19 +0100
Message-ID: <20251125072730.39196-10-johannes.thumshirn@wdc.com>
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

