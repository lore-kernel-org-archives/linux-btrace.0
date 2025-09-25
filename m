Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3C30B522;
	Thu, 25 Sep 2025 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812617; cv=none; b=Z47StLs0omeHcEQSG7TcWJMXtXm7x+xxGvpQeRN8Hj0O2RnhVgTbskYEvtGOc1qUkvRDWup7eBeJ7/H4SY6Fzk0RcYSuFo6SI0MABXM7HQ2fQueL2a805GcG3OKXgR3dnigbFBYdnPNla609NAPO+QmUESt2JxDFqoIxQkqqP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812617; c=relaxed/simple;
	bh=XWezvbFefLtrtDMLcQIzZ3Sc3Bi11bkmwO4j1F8fEx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8W20Cbuxsiz7wXCNa7BvKtAXQ5G0lyGVUC3B2qXoysalZlwbrs9GypmQ/HLoMVacw+qWjRtbesET+HUIfQOtB/loMvV4pPBT4GTu0EU1GdbNvP+3qd8UUyVl9+jAUkSNwbNL7EHrOdWq9ksxc6b5JKc9T9jpLrFScZRhjNbOP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Fk6XPRjD; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fk6XPRjD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812615; x=1790348615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XWezvbFefLtrtDMLcQIzZ3Sc3Bi11bkmwO4j1F8fEx4=;
  b=Fk6XPRjD8K58aTKo2DM6/UhEjcu2F5y8hg7JyJ+3/hBRkwE+KC04k9vd
   vcSKJLcon+/BVE7dG2QWoHPQ5W45q6YYMH4X4eyXNJXwd2WILm6J0M/rW
   vgd9Z2CMrpnrT+4zY27zxonEHRxgAgO8xWrikOC7/bhhC4F+Lhx2Wea0b
   UTW9YbD3NqolaZ85HBgLYbU89iJP3TORFWxBpCDRQoTYUaOu1Y0hntGM3
   d2HASPTGCDNo7F3HGYXBcWHOtRAbAKmXB2WR22RXF6Rp1VzIDJ+O6W0ka
   hCgWuw+eiZ16JkP7F141l1hRweWkmVvzHh/Wpu+4O8ET/AdeRcnZtqtkB
   w==;
X-CSE-ConnectionGUID: eqhpWfVMT9mR0v7lGr47pg==
X-CSE-MsgGUID: 2cdsB5IVR3uPOosUfAZvlw==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130348131"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:03:34 +0800
IronPort-SDR: 68d559c6_lm2eozP+iuPOkBXLeEbb5ys1UW2u4I2NYzi8EKPnYMdOgHG
 qQfVk8Rqm/EKtzYY0gezoIZo9+FCXcttRtDRIkA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:03:34 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:03:32 -0700
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
Subject: [PATCH v2 14/15] blktrace: trace zone write plugging operations
Date: Thu, 25 Sep 2025 17:02:30 +0200
Message-ID: <20250925150231.67342-15-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
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
index e4b6fbbc40ee..ab5daa1c1161 100644
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

