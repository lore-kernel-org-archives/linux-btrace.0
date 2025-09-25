Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F12E2296;
	Thu, 25 Sep 2025 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812612; cv=none; b=fKQfjcDwuZ3+ToRJTvwc0874xKbWMqqorJKhiM+0hfEsV1XkRsejfj5vLGi1tz76Z8k0yHTic3RsQOc7jBoVjF50+YY3ZrBA9hSVHYanMMv99PcjRQxHwc2vPKk5zMWjGV5arqq9gA4zOUrn9mvqX/B5PyG8a9sJ632c2O/UXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812612; c=relaxed/simple;
	bh=GbOajL+agLCyrU+nnA9+1zCrrzS1e4WUHJj1Cai/8KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MABj1IwqHXFmA920LaSVy3RokHmimYjv59xI3eIr/7+YiujJW1PpYC5ORzMt292L3tlAo7ZJJTO+uw5Hhs/AsfnNKM8ao/+1SpDYKr8+A/3VR1ZS6/bLBx98VgBag/OZv1z71UUOtKDBmNF+Qv2ewymh6wp4XdAcfP1Ha8Q/o3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PriaOqfe; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PriaOqfe"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812610; x=1790348610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GbOajL+agLCyrU+nnA9+1zCrrzS1e4WUHJj1Cai/8KI=;
  b=PriaOqfeuYQN+OuYsH1za+NM2j/vkC7uerOq8mh+PReBa4rCvcB23iCR
   1LnYi/7W7mqowQteY2d5qkEEVYhI/Gs6mHFO1/hR5sI4Mv9mnCTGS+/NP
   6ZPXjQmoJepV0HpGA9MENwgNbNbgCjBcsJpH94PVG8a0Jn89KXH1bqGVb
   1U5P9iTkgvh//R6HENAoxHSaaqFaPiFllRhYnGzqWWhQ1McArx5p8dXDo
   kZumiv9+QapyUhZBF6YMpEwgXMvfd3Ol7iXCWuXZfxPGD0QUScvh4CqZA
   ls0hUF4RplhEImstaxF+218A7z6Fy/HJ8JXL1cWN4hMOeA8Ff51ZNXVOF
   w==;
X-CSE-ConnectionGUID: a/eYUtrwQoWZ8Jpu8/4ePA==
X-CSE-MsgGUID: ApOvhp/YSHGqiYQhe0p6nA==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130348087"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:03:26 +0800
IronPort-SDR: 68d559be_BhPRA0t0fSP5RV2DZ0v+Oq641Gv4hNWUZB8jdYfG5J54UbS
 Fz+w426gyr1PEAHkVizy7LiTBetitEwxqIlKJ9Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:03:26 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:03:23 -0700
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
Subject: [PATCH v2 12/15] blktrace: expose ZONE APPEND completions to blktrace
Date: Thu, 25 Sep 2025 17:02:28 +0200
Message-ID: <20250925150231.67342-13-johannes.thumshirn@wdc.com>
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

Expose ZONE APPEND completions as a block trace completion action to
blktrace.

As tracing of zoned block commands needs the upper 32bit of the widened
64bit action, only add traces to blktrace if user-space has requested
version 2 of the blktrace protocol.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h |  3 +++
 kernel/trace/blktrace.c           | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 0f336140ce4e..ddc9fedf4955 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -99,6 +99,9 @@ enum blktrace_notify {
 #define BLK_TA_ABORT		(__BLK_TA_ABORT | BLK_TC_ACT(BLK_TC_QUEUE))
 #define BLK_TA_DRV_DATA	(__BLK_TA_DRV_DATA | BLK_TC_ACT(BLK_TC_DRV_DATA))
 
+#define BLK_TA_ZONE_APPEND	(__BLK_TA_COMPLETE |\
+				 BLK_TC_ACT2(BLK_TC_ZONE_APPEND))
+
 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 62f6cfcee4f6..fea6e63ee27c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -972,6 +972,22 @@ static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
 			 blk_trace_request_get_cgid(rq));
 }
 
+static void blk_add_trace_zone_update_request(void *ignore, struct request *rq)
+{
+	struct blk_trace *bt;
+
+	rcu_read_lock();
+	bt = rcu_dereference(rq->q->blk_trace);
+	if (likely(!bt) || bt->version < 2) {
+		rcu_read_unlock();
+		return;
+	}
+	rcu_read_unlock();
+
+	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_ZONE_APPEND,
+			 blk_trace_request_get_cgid(rq));
+}
+
 /**
  * blk_add_trace_bio - Add a trace for a bio oriented action
  * @q:		queue the io is for
@@ -1202,6 +1218,9 @@ static void blk_register_tracepoints(void)
 	WARN_ON(ret);
 	ret = register_trace_block_getrq(blk_add_trace_getrq, NULL);
 	WARN_ON(ret);
+	ret = register_trace_blk_zone_append_update_request_bio(
+		blk_add_trace_zone_update_request, NULL);
+	WARN_ON(ret);
 	ret = register_trace_block_plug(blk_add_trace_plug, NULL);
 	WARN_ON(ret);
 	ret = register_trace_block_unplug(blk_add_trace_unplug, NULL);
@@ -1221,6 +1240,8 @@ static void blk_unregister_tracepoints(void)
 	unregister_trace_block_split(blk_add_trace_split, NULL);
 	unregister_trace_block_unplug(blk_add_trace_unplug, NULL);
 	unregister_trace_block_plug(blk_add_trace_plug, NULL);
+	unregister_trace_blk_zone_append_update_request_bio(
+		blk_add_trace_zone_update_request, NULL);
 	unregister_trace_block_getrq(blk_add_trace_getrq, NULL);
 	unregister_trace_block_bio_queue(blk_add_trace_bio_queue, NULL);
 	unregister_trace_block_bio_frontmerge(blk_add_trace_bio_frontmerge, NULL);
-- 
2.51.0

