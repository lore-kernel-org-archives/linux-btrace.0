Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50C032BF24;
	Tue,  9 Sep 2025 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416048; cv=none; b=NA4GJp4UYUpm7pbKbqBzp6knsVeBpyL+px0DTiunKIWYnZ5gdbqoz4A5r0APMk+ksxF+qjzs4w2ww6WRWcxl10/jeVDQrPUYOA0PwustKDXN/ESKqczYhvCQEwTxaaKMlg4sapXpSBeAdkjo3qFfo84WWLRGHbPO95RZ7b9IsPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416048; c=relaxed/simple;
	bh=PiP2qNGmDC0An92BDWQlk63SDSUUtB4HhoU+NEAxy7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/c0N3zp2d/0BII+GYqYNbHB2hJF/AF36oW0EinKYMe1sTtKfaVH0Lw+h4qce00BRbBsjx8Grjae8+4wg8+Hf/vX0wGBc7gJpcV78wwCJ3vZ36YNC8pex36gj1vEBbADDtZeL6iKlogY5Pqa1/op9CKcmGiagfei283Gcfm5ngY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hsHTt14l; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hsHTt14l"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416047; x=1788952047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PiP2qNGmDC0An92BDWQlk63SDSUUtB4HhoU+NEAxy7Q=;
  b=hsHTt14l9Tpkba8oMXPaI9ZlFIoO0N8HaMQMiM8yR8J8747vASVtPtcD
   DXsh4nn9xkb+R3CLNV70OXaGEM0ws1R4zTIe5pD0oci27u/tnIlhDdOS4
   smFQE8gizXx2+2jy1i+CBKcAx2Qd07FpbF10LEnITilLuUyXWJUiAHKmH
   roivy/DYwLMNksFyljcTDlRdDPUynGvH1rnQLAtjR8OOShIKgBzn3A2hC
   /6L0HNOB02QybNesiukH/ibyMQdMktCu5msnia4mu4qn3tb5RshodoMto
   L2vBg89HhlhOz/lbXmMZN5BZwOr6gPGCSa9MQAnB7PPR7i0G5XOT+Mx+L
   g==;
X-CSE-ConnectionGUID: o9aJCBaCTyeAiGjYFGHaWQ==
X-CSE-MsgGUID: vVPmp+byQXmv6sPWfYeRYw==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810276"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:07:26 +0800
IronPort-SDR: 68c00a6e_E/KZZWebPU//1ZAZerRwqKYBvHvg3TTAblKjxoWiSBEqJ0t
 a9h8cT7BU4Axl2Yty5Vk1E3uMpyUx+u1Tt/lWRg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:07:27 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:07:22 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 15/16] blktrace: trace zone write plugging operations
Date: Tue,  9 Sep 2025 13:06:10 +0200
Message-Id: <20250909110611.75559-16-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909110611.75559-1-johannes.thumshirn@wdc.com>
References: <20250909110611.75559-1-johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h |  5 ++++
 kernel/trace/blktrace.c           | 39 +++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 074c4de62c3e..dc1aa8e4d787 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -64,6 +64,8 @@ enum blktrace_act {
 	__BLK_TA_REMAP,			/* bio was remapped */
 	__BLK_TA_ABORT,			/* request aborted */
 	__BLK_TA_DRV_DATA,		/* driver-specific binary data */
+	__BLK_TA_ZONE_PLUG,		/* zone write plug was plugged */
+	__BLK_TA_ZONE_UNPLUG,		/* zone write plug was unplugged */
 	__BLK_TA_ZONE_MGMT,		/* zone management command was issued */
 	__BLK_TA_CGROUP = 1 << 8,	/* from a cgroup*/
 };
@@ -103,6 +105,9 @@ enum blktrace_notify {
 #define BLK_TA_ZONE_APPEND	(__BLK_TA_COMPLETE |\
 				 BLK_TC_ACT2(BLK_TC_ZONE_APPEND))
 #define BLK_TA_ZONE_MGMT	__BLK_TA_ZONE_MGMT
+#define BLK_TA_ZONE_PLUG	(__BLK_TA_ZONE_PLUG | BLK_TC_ACT(BLK_TC_QUEUE))
+#define BLK_TA_ZONE_UNPLUG	(__BLK_TA_ZONE_UNPLUG |\
+				 BLK_TC_ACT(BLK_TC_QUEUE))
 
 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 13424efbb2f6..3e7cd8f46c0c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1094,6 +1094,37 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
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
@@ -1240,6 +1271,12 @@ static void blk_register_tracepoints(void)
 	ret = register_trace_blkdev_zone_mgmt(blk_add_trace_blkdev_zone_mgmt,
 					      NULL);
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
@@ -1259,6 +1296,8 @@ static void blk_unregister_tracepoints(void)
 	unregister_trace_block_split(blk_add_trace_split, NULL);
 	unregister_trace_block_unplug(blk_add_trace_unplug, NULL);
 	unregister_trace_block_plug(blk_add_trace_plug, NULL);
+	unregister_trace_blk_zone_wplug_bio(blk_add_trace_zone_unplug, NULL);
+	unregister_trace_disk_zone_wplug_add_bio(blk_add_trace_zone_plug, NULL);
 	unregister_trace_blkdev_zone_mgmt(blk_add_trace_blkdev_zone_mgmt, NULL);
 	unregister_trace_blk_zone_append_update_request_bio(
 		blk_add_trace_zone_update_request, NULL);
-- 
2.51.0

