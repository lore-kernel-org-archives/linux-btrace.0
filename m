Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDABF329C78;
	Mon, 20 Oct 2025 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967758; cv=none; b=nfceQAnl3BrGeMG+LRBTY3XhBWBKbdPss7AH+aFQE+n+IPnJAGFcyjTBxETPagFbpd1H3ZmI5+5biY+Xja3VWCoQfCQOvxmrw8c4fUft55TY7PjLmxOd0JF3eR4at5VmuBfYZdfIHuLtdRl81DQgopQFftmchKf2KX9JOGtCoBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967758; c=relaxed/simple;
	bh=0nrXNfD460Mtl1MFFAMvJzwRfMU2OVIxJ2qFN/mJW+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6saC58099aJJgKRQxZM/kQ+nKVxeTtHOfj1iS4nZ2ZSI22fm7TpT1QG8It2J717niP6dPhHlSE7jpVhxTiTZjDzyBVLP9u7veb4UKmBEzI+C1yJjaNXcggqMC4FEuwx2E/h//gYWEuawRMHbnuJJDguDGYVJNvXC+Ya1yA8dNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZCrYfVsm; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZCrYfVsm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760967757; x=1792503757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0nrXNfD460Mtl1MFFAMvJzwRfMU2OVIxJ2qFN/mJW+s=;
  b=ZCrYfVsmTS+fBSZnmP0AD3OFMBij/xVUFAhSamOTQkhJb4lHaEIp6EE4
   DBr/ehxSSxroKNgZfaSh1StfssGFcpgXD0uKmvawx603+zVRq+sDI3scc
   vH+MWJe95GBVbVqpAmI8C2lPn178OUl4p0zYHXVIgDHwh5Wf9ufQTrU6H
   r/GXxsqpi3FRLzzDMyjAIEmS3jPL5D05EMdq4t1hOS/OP1R1Du7mnUNAb
   Pq5aB+pTXMsEcB1+7bT8xzisAid8bRfroZrYgBYpSbuaBEPxz17srqoFk
   mf089mAaFMh1ud3QIJvziGX6PFOYev3ogNWXQR5jPw5FrEtPyYg0/iMyU
   w==;
X-CSE-ConnectionGUID: wxObZOJUQdu/W6PH3SMPnA==
X-CSE-MsgGUID: k0i2bynzS8OhXmQj0Da5Ow==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134518683"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 21:42:37 +0800
IronPort-SDR: 68f63c4c_/Id36soLxXbCOrMp0ddXQ3HvNhl6CTBrr5p1vI5tyRW2uSt
 2SRw5Nhx0lBW31lVk/y4+qpA09I/3+kaQnuJA8Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2025 06:42:36 -0700
WDCIronportException: Internal
Received: from 1pgdl13.ad.shared (HELO neo.fritz.box) ([10.224.28.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Oct 2025 06:42:33 -0700
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
Subject: [PATCH v4 15/16] blktrace: trace zone write plugging operations
Date: Mon, 20 Oct 2025 15:41:22 +0200
Message-ID: <20251020134123.119058-16-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
References: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trace zone write plugging operations on block devices.

As tracing of zoned block commands needs the upper 32bit of the widened
64bit action, only add traces to blktrace if user-space has requested
version 2 of the blktrace protocol.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h |  5 ++++
 kernel/trace/blktrace.c           | 39 +++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index bf41e34df3c8..63de5fb07553 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -62,6 +62,8 @@ enum blktrace_act {
 	__BLK_TA_REMAP,			/* bio was remapped */
 	__BLK_TA_ABORT,			/* request aborted */
 	__BLK_TA_DRV_DATA,		/* driver-specific binary data */
+	__BLK_TA_ZONE_PLUG,		/* zone write plug was plugged */
+	__BLK_TA_ZONE_UNPLUG,		/* zone write plug was unplugged */
 	__BLK_TA_CGROUP = 1 << 8,	/* from a cgroup*/
 };
 
@@ -99,6 +101,9 @@ enum blktrace_notify {
 
 #define BLK_TA_ZONE_APPEND	(__BLK_TA_COMPLETE |\
 				 BLK_TC_ACT(BLK_TC_ZONE_APPEND))
+#define BLK_TA_ZONE_PLUG	(__BLK_TA_ZONE_PLUG | BLK_TC_ACT(BLK_TC_QUEUE))
+#define BLK_TA_ZONE_UNPLUG	(__BLK_TA_ZONE_UNPLUG |\
+				 BLK_TC_ACT(BLK_TC_QUEUE))
 
 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 68a657a1ccf8..75994671d7ee 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1083,6 +1083,37 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 	rcu_read_unlock();
 }
 
+static void blk_add_trace_zone_plug(void *ignore, struct request_queue *q,
+				    unsigned int zno, sector_t sector,
+				    unsigned int sectors)
+{
+	struct blk_trace *bt;
+
+	rcu_read_lock();
+	bt = rcu_dereference(q->blk_trace);
+	if (bt && bt->version >= 2)
+		__blk_add_trace(bt, sector, sectors << SECTOR_SHIFT, 0,
+				BLK_TA_ZONE_PLUG, 0, 0, NULL, 0);
+	rcu_read_unlock();
+
+	return;
+}
+
+static void blk_add_trace_zone_unplug(void *ignore, struct request_queue *q,
+				      unsigned int zno, sector_t sector,
+				      unsigned int sectors)
+{
+	struct blk_trace *bt;
+
+	rcu_read_lock();
+	bt = rcu_dereference(q->blk_trace);
+	if (bt && bt->version >= 2)
+		__blk_add_trace(bt, sector, sectors << SECTOR_SHIFT, 0,
+				BLK_TA_ZONE_UNPLUG, 0, 0, NULL, 0);
+	rcu_read_unlock();
+	return;
+}
+
 static void blk_add_trace_split(void *ignore, struct bio *bio, unsigned int pdu)
 {
 	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
@@ -1226,6 +1257,12 @@ static void blk_register_tracepoints(void)
 	ret = register_trace_blk_zone_append_update_request_bio(
 		blk_add_trace_zone_update_request, NULL);
 	WARN_ON(ret);
+	ret = register_trace_disk_zone_wplug_add_bio(blk_add_trace_zone_plug,
+						     NULL);
+	WARN_ON(ret);
+	ret = register_trace_blk_zone_wplug_bio(blk_add_trace_zone_unplug,
+						NULL);
+	WARN_ON(ret);
 	ret = register_trace_block_plug(blk_add_trace_plug, NULL);
 	WARN_ON(ret);
 	ret = register_trace_block_unplug(blk_add_trace_unplug, NULL);
@@ -1245,6 +1282,8 @@ static void blk_unregister_tracepoints(void)
 	unregister_trace_block_split(blk_add_trace_split, NULL);
 	unregister_trace_block_unplug(blk_add_trace_unplug, NULL);
 	unregister_trace_block_plug(blk_add_trace_plug, NULL);
+	unregister_trace_blk_zone_wplug_bio(blk_add_trace_zone_unplug, NULL);
+	unregister_trace_disk_zone_wplug_add_bio(blk_add_trace_zone_plug, NULL);
 	unregister_trace_blk_zone_append_update_request_bio(
 		blk_add_trace_zone_update_request, NULL);
 	unregister_trace_block_getrq(blk_add_trace_getrq, NULL);
-- 
2.51.0

