Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5DE326D7E;
	Tue,  9 Sep 2025 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416039; cv=none; b=U8BdFwFKFKxLDd3gw+XpzzFNnnex6nhtg2T9CK2QBxSVEQOgb9AWZDbJkL5eINN/6SWPGlhVlOQQgwM0G5q32i/s4lGgaEkY5eRWduoJDAB0g8xUnxMzCYPM3LRn2AXzmHxbsDw8i1kKOqEDPSH9UF+2JkzZ9tZkJp39sVFVD6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416039; c=relaxed/simple;
	bh=v9S9YA7POwnG0gnHcQwpf/aO6DOFbgB5FeqDaZbKBwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PXQdui+i0yQqhchIoJzHP9YKAYEQRjvwsMHW5aCqM+/Hf5dWZnUKW4vZ944NHfP3uCPZtc+fRLl9eFmSyTqTVu/Mo/uLtGBXIQPyOXvqBf9cYkdGNK5iJLsmFPNEkrYT7blfKyUo3WVrwqVJLOpyJYNfeC+atH8qtxlmzNfZJIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Xj46sOyG; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xj46sOyG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416038; x=1788952038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v9S9YA7POwnG0gnHcQwpf/aO6DOFbgB5FeqDaZbKBwg=;
  b=Xj46sOyGyo3PCafvv71OmIPTzbw7eUOVNF0wEp5PgBpKSC9FUMB0M6e6
   2ZhqFiCCH3NggiJ3vyhqHQVfBH/mWVyx35TNR5J85puL0tJdJC6CpAIvS
   0H6+8iF/ct6qav6AUNNnblvE8c66mj52yPPrhrFDib4FqSH2z7aomhIlu
   NXjJQX+0KVd4UqYUYznSu3wQBETMS52OmlzLO4pz/GPUJoWxPnWjHlti8
   XtVaL5udsqBx7hdHOraCRSzCLhAS8lApT5ZWNFFaTj+FasJQDZlo3SRy1
   LM16A2uFNSghgbQAZ6tWKwUg6M+N8A2YowbXnUHHLFsiUAKy2zFG7Axyr
   A==;
X-CSE-ConnectionGUID: Twuk32YmQ0CFsj3s6sAVIw==
X-CSE-MsgGUID: 551YRJ3+TEypQLWVnjCAGg==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810178"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:07:18 +0800
IronPort-SDR: 68c00a66_KZIltkz7HyIuUiZRSTjQmE+Lm0q+cTvfVOUbVeHycb7K7Sx
 ZyEAMcKHkJ4yh6aQWxAupud7hO12JhKLODaFa3w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:07:18 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:07:13 -0700
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
Subject: [PATCH 13/16] blktrace: expose ZONE APPEND completions to blktrace
Date: Tue,  9 Sep 2025 13:06:08 +0200
Message-Id: <20250909110611.75559-14-johannes.thumshirn@wdc.com>
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
index d5047467c8ee..c75ae82b2dbc 100644
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

