Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0E131D382;
	Wed, 15 Oct 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525762; cv=none; b=QXZNW0nEaO6b/ySaqOD4YOvQx2VydoHNTLuPN8IBd4qwyI76U6RmItMQWvqPgsX6tdQVFQEISWSKgu1r6gY22bAhDDiRVHLPmfnZ6+qQuAJc+IgoDi2WdG3fRNHTPgKUj7FcrovBp9Rrll5AITSTQ8nbPVSJRSt6sBSSjHCoPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525762; c=relaxed/simple;
	bh=9/5y2eyJX6JDGnSjJYSXdcz7bzxzyMbQl0mThIQR4JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbbGF4s5ue1OP7+YkjGX2ayQQ6zkAA3Nu07193QU+AKQiMZ8Soup/wirRJRf9LlmgOaAH7eycuAMoMVyAYCN0UbMSfcbJCbeVmt4r0LTUzmzeJTCAODZdOyXvvmilmiZf3wwx8wCxepBjHVJY9learSTlouP2O79YoF3WYEMmGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kn9pbodf; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kn9pbodf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525760; x=1792061760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9/5y2eyJX6JDGnSjJYSXdcz7bzxzyMbQl0mThIQR4JA=;
  b=kn9pbodfPTW9T/sAxGlGA9eSRInwSz+OERgNMHLJDweku8sH0zFCKSqH
   /UrzoXh8T30Zsthp9nM7A5QPBx4nb6qdxiIk7hy8EwlfbY2MNf+DPCMEM
   wzCCCnvUkhvpxtRjbbEkqGpEUv/zrYErUvv1ofZJdTPYPUNTwg4gRHsok
   bfegvh29dywoIupQAI4+7Vffp+G1ZnS8UQRXH9zqXFLJSM3LmTktr81T+
   zZ2Mv88ONnRYXEalgpgkoYEFZYQQSOXVzUxlI8Y5aOlXwfgbfPeh5S2y9
   xJrsUFL8tC4n5Za2MQbVaHzj70xccqMFMSAxFFQnQiaP3we5yZd5Lp4XR
   w==;
X-CSE-ConnectionGUID: hcmxtTr0TDKMhl9zSkMXgw==
X-CSE-MsgGUID: V1Ti70hKSo6wiV6mwg4U8g==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="133262135"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:55:59 +0800
IronPort-SDR: 68ef7dc0_a5CZERa4UNKNdV6/RxpnbOlAodEbCSWbqQbx52OIYYbrBRH
 95bt7HVpcfXWASiTLmFad65rQXPU1WyZWiNGpFQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:56:00 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:55:56 -0700
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
Subject: [PATCH v3 15/16] blktrace: trace zone write plugging operations
Date: Wed, 15 Oct 2025 12:54:34 +0200
Message-ID: <20251015105435.527088-16-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015105435.527088-1-johannes.thumshirn@wdc.com>
References: <20251015105435.527088-1-johannes.thumshirn@wdc.com>
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
index e8d562ad21f9..d659fed0650d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1080,6 +1080,37 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
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
@@ -1223,6 +1254,12 @@ static void blk_register_tracepoints(void)
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
@@ -1242,6 +1279,8 @@ static void blk_unregister_tracepoints(void)
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

