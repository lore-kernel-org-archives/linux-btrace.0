Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15D53074A0;
	Thu, 25 Sep 2025 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812613; cv=none; b=Os47L5+5cAuJe8bwiQDk0bPvHRzZTP0t+4Hiv1D3e8/7ikA3mnzq+25sS3P3vEje++oxENAeMzQRAMl7kfIZPx3cjC3aBy9kC97XFacm8pY0cpD9JHMkx3fZvMrjvIRQ215DNSOPbStkVMpLSv3u7HrJ8QtTYSAbdDIwvLUXgsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812613; c=relaxed/simple;
	bh=oNbIceA/0INBmzt1OMqCRCb8aFJ5ICel8fLZJvN7K28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkuzZ9/4L9AMZGiDdP1IACdt8Ng3kRUF8t7IhhPvTjC08U0x0nntLIf/6pBllOe1aviFOhVnYkEbUI60VqVcJOC88nNEf+B+smGl3j2Jurn88RDvD12xrZfy3ZWvcEZdrLySJM1iIzdgeOfjUGoigkzfAm4dwf0Treu7Vf7idKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=i4USPflG; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i4USPflG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812611; x=1790348611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oNbIceA/0INBmzt1OMqCRCb8aFJ5ICel8fLZJvN7K28=;
  b=i4USPflGQKIkgrAALAt2ZnhZOmLoAD0Z4hnttnfa5IR7e+243ciG6L32
   83314ROi6Nn00LVftU/pogDiGc4S2m3QXCYt2sB73oefvB3Z774gqzQjB
   Vj6vobx8ADkawXSvy3J4ZJLHys+8qbsARslQXbGFMg3pctRn3BijI98Tx
   OzD9XEw+6jcLwyu8/YfXt8VXMrhWvjw0G+Xy/3PtbDb/AVTbpbSQcTlnQ
   yckU2QYuTfKby5Yy5IMXSPy8KF+lHFCNaXUJ3v/QHnbJwAdFJpjul2e/c
   aOSOwJSW3JemthEONSGCZLJ4qKecOD/PBqKWS23tABC6LnXQtH0dY6YT6
   w==;
X-CSE-ConnectionGUID: QFd2ZgLgRGO8bzgsYVUTsQ==
X-CSE-MsgGUID: 235WHV2xSW6W816iMCxgsA==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130348105"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:03:30 +0800
IronPort-SDR: 68d559c2_eKaEX728G6B9GBzCOA0aazTa5C+f6ZEGmNYteG84+LaCxc3
 DoPcog8eSyndStXG7U4cOhxZxG21ejiZ8xwOUgw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:03:31 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:03:27 -0700
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
Subject: [PATCH v2 13/15] blktrace: trace zone management operations
Date: Thu, 25 Sep 2025 17:02:29 +0200
Message-ID: <20250925150231.67342-14-johannes.thumshirn@wdc.com>
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
index ddc9fedf4955..e4b6fbbc40ee 100644
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

