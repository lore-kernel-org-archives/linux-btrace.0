Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60F32255D;
	Wed, 15 Oct 2025 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525874; cv=none; b=Kba4CiJGSdeqP0GgGhrXviScLrq59T8CmOCZcwoeWQU47ZDBYXQ6EO9ygfgYs7t2Tt9xZEomxY/XJUVkI1Yqy98Upbjdx2zE670JFXkmZfJfdN+SJmJ0iJAqjV6R9SnL9Sxlo2hGmP5+i/x34IkqrQMPCf9SrgHy0bgS9X6E56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525874; c=relaxed/simple;
	bh=3onupmVD5/2IoDoElAt/o05PCAfeDat+6p0RvJChYCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlyKR9oUwiCfZvhFyFouXUmpDuCEho4+RkT3XXcpCptf7ZWOfDc/hy6D9nnIQkDvLxlvjdyxMvCgsDgI+6zAQmJQ/he6THG0t/dL1eAogXFjLowfgS3FcchvONFEHCxPsXz3YVe4PdKL2yGTXf+P8HSmnwMTwV0EJSwb0aGjU34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mzGKrRj2; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mzGKrRj2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525872; x=1792061872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3onupmVD5/2IoDoElAt/o05PCAfeDat+6p0RvJChYCo=;
  b=mzGKrRj2b4KC3QO2rMA8AUvbeQL6qOjv5BtEkK9dZ1ml3ZPQ4BohL6r3
   aa7E0QYT4fQp80WWvFNWOUfMn62jDiYABUB2C9HmBZsa/ZvAOfmU6E2NZ
   SeRVglO9IhH5IX1vrxQ4XMvFPiGARPIl5qDY4Xg6Wfi4onVjnGMIReR3f
   VuTdE8YXyPeBiKauEiTLbH4qZfnsZbPgHEChMNyxlv389K08y6tVTp2Dl
   QD72gfL2XtRDiiiEVi5GtFiORn2bWoEwf8EczGs9R0vMygf2wIOfEwXUa
   RLRsZ8wQvUh69uSRFUVWppzkeAo4ldE6gycJOd78vZVtPJFojkIUEB4tk
   w==;
X-CSE-ConnectionGUID: ASpLLS/LRiGe00rUFXPy6Q==
X-CSE-MsgGUID: xZY+5lIfT76DC7oGb0ZIVQ==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935395"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:57:51 +0800
IronPort-SDR: 68ef7e30_XVX7oS2rrsqQmdf1YEq8PX/d6Kcj5srX0nvoW1lPNsO5+7m
 EDMu2Ft+IAqwgOsOQSfXg8Wuo3JtuVTb6LToBlQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:57:52 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:57:48 -0700
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
Subject: [PATCH blktrace v3 10/20] blkparse: skip unsupported protocol versions
Date: Wed, 15 Oct 2025 12:56:48 +0200
Message-ID: <20251015105658.527262-11-johannes.thumshirn@wdc.com>
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

