Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFBB32A3C9;
	Tue,  9 Sep 2025 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416044; cv=none; b=HaBMNXS+wxFh8WlqD601YpbyZS3/BROg+TY7+cTUpN953rr00Ls/PsfD/zH4WsV3AneX2BECJFhusVbrb3dx5NfIWtEiO0PRGlPwcp7qbh8xaDMR27k8UR4gTW/wY7kGD8KGSlsHfH5b8BWCG9K1aLEPkwmXwg49VTD/Lyv6CGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416044; c=relaxed/simple;
	bh=VvVF5lcm3YgXE3550gu3KVuhHeYhcKcNtyFckeFyJRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cl+pVbg6Zw7RCQuI27JS5pAgYZNf6M5/9sLG/3En2RlZVd4vf0oQncmlJ5evanfUbYfEYTED96AJQfqGfV6LcXbt4HrNG5VeJ4snkZkTdAZl09KOsV37mvaCnasw0Wdks1qGlnPeXcxTm7iOXc5JbkdaX5pH9BT7UgbebN5Ogxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=X6icDhX+; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X6icDhX+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416042; x=1788952042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VvVF5lcm3YgXE3550gu3KVuhHeYhcKcNtyFckeFyJRI=;
  b=X6icDhX+sh7BImEvAaytViFHc5Lqm5PrKZ87SP40mI4EfEkcC8HGacw9
   N1WQyU20MGFd4gEwxkRRXbRPod/dDpn9WcgJe/cKd3SEB7pSbGJiPvIhJ
   pVokCjYC5vbyV8BjMBC9PKS/4VXTfevFpPt5C3VKeAfO2GbdcUXZ0auB/
   tlnm6xW4eSJ5gwKQDQoa5fTvQDwBT9PB4kU49aJhgZOJA4XikEtZsMHjG
   tCi9bPvDfry4B537hgmhhhH2Ide3O1fhihsSaHg+ILceuDLMe/+JVL2xV
   N46apDhj/A9UzsXxL+es3Pu+cjnzjaIB3NAbWQmxMp34X18tgg8QKKUDf
   A==;
X-CSE-ConnectionGUID: /WxBiLg3SPO7s01L1rU4tA==
X-CSE-MsgGUID: T2DhYsmsT+WnC/hfuqNDXg==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810187"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:07:22 +0800
IronPort-SDR: 68c00a6a_+lesa0GOC+i8fNG40rtT/3hGRYOAdBSu8KNWhBZbovRRzMa
 hkx1JEDMyIDD27bJ9f+yBEXro/7ZLcJl8Yx+rww==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:07:22 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:07:18 -0700
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
Subject: [PATCH 14/16] blktrace: trace zone management operations
Date: Tue,  9 Sep 2025 13:06:09 +0200
Message-Id: <20250909110611.75559-15-johannes.thumshirn@wdc.com>
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

Trace zone management operations on block devices.

As tracing of zoned block commands needs the upper 32bit of the widened
64bit action, only add traces to blktrace if user-space has requested
version 2 of the blktrace protocol.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h |  2 ++
 kernel/trace/blktrace.c           | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index c75ae82b2dbc..074c4de62c3e 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -64,6 +64,7 @@ enum blktrace_act {
 	__BLK_TA_REMAP,			/* bio was remapped */
 	__BLK_TA_ABORT,			/* request aborted */
 	__BLK_TA_DRV_DATA,		/* driver-specific binary data */
+	__BLK_TA_ZONE_MGMT,		/* zone management command was issued */
 	__BLK_TA_CGROUP = 1 << 8,	/* from a cgroup*/
 };
 
@@ -101,6 +102,7 @@ enum blktrace_notify {
 
 #define BLK_TA_ZONE_APPEND	(__BLK_TA_COMPLETE |\
 				 BLK_TC_ACT2(BLK_TC_ZONE_APPEND))
+#define BLK_TA_ZONE_MGMT	__BLK_TA_ZONE_MGMT
 
 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index fea6e63ee27c..13424efbb2f6 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1046,6 +1046,22 @@ static void blk_add_trace_getrq(void *ignore, struct bio *bio)
 	blk_add_trace_bio(bio->bi_bdev->bd_disk->queue, bio, BLK_TA_GETRQ, 0);
 }
 
+static void blk_add_trace_blkdev_zone_mgmt(void *ignore, struct bio *bio,
+					   sector_t nr_sectors)
+{
+	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	struct blk_trace *bt;
+
+	rcu_read_lock();
+	bt = rcu_dereference(q->blk_trace);
+	if (unlikely(!bt) || bt->version < 2) {
+		rcu_read_unlock();
+		return;
+	}
+	rcu_read_unlock();
+	blk_add_trace_bio(q, bio, BLK_TA_ZONE_MGMT, 0);
+}
+
 static void blk_add_trace_plug(void *ignore, struct request_queue *q)
 {
 	struct blk_trace *bt;
@@ -1221,6 +1237,9 @@ static void blk_register_tracepoints(void)
 	ret = register_trace_blk_zone_append_update_request_bio(
 		blk_add_trace_zone_update_request, NULL);
 	WARN_ON(ret);
+	ret = register_trace_blkdev_zone_mgmt(blk_add_trace_blkdev_zone_mgmt,
+					      NULL);
+	WARN_ON(ret);
 	ret = register_trace_block_plug(blk_add_trace_plug, NULL);
 	WARN_ON(ret);
 	ret = register_trace_block_unplug(blk_add_trace_unplug, NULL);
@@ -1240,6 +1259,7 @@ static void blk_unregister_tracepoints(void)
 	unregister_trace_block_split(blk_add_trace_split, NULL);
 	unregister_trace_block_unplug(blk_add_trace_unplug, NULL);
 	unregister_trace_block_plug(blk_add_trace_plug, NULL);
+	unregister_trace_blkdev_zone_mgmt(blk_add_trace_blkdev_zone_mgmt, NULL);
 	unregister_trace_blk_zone_append_update_request_bio(
 		blk_add_trace_zone_update_request, NULL);
 	unregister_trace_block_getrq(blk_add_trace_getrq, NULL);
-- 
2.51.0

