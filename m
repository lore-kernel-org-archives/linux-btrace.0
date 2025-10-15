Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89A7320CB7;
	Wed, 15 Oct 2025 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525757; cv=none; b=TVAvtl4V51nsULO0+kzok9KcJlB7/YUpxgpRiP3RhO/zzowG761DpSV2roCslLS67qLZsxyJiayo1MH/tVcbo94uhVish0MkD8IOiGbBAHemF+/splzgC/a8MZaywG3cE4H18RqR+bWxyZJx48GE2i3WGlabWwy2uGqzLR/3cG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525757; c=relaxed/simple;
	bh=p7XVM3vTJBCJSavUKqr4cuLzNOi/1S71EoE0M1StZsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=En2V/O5n8ZL8+lyQEH0RE5ZGY+PEYJRx+0kE8TiruBOkiG33g4K61u7zPuecrGn4BBzydcXwVoDjSayo4InE4yxj2rBJixWqSxwkPHw9Y19PaK2jXdPYVO8Y6/C+/rtGVgVYz1vFd7hKEwJOwZYgVOdr8IzvSKGOJ0PN2pOoUmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=M8Q/gRUn; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M8Q/gRUn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525755; x=1792061755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p7XVM3vTJBCJSavUKqr4cuLzNOi/1S71EoE0M1StZsQ=;
  b=M8Q/gRUn6Fh71qSM1hmzmjshKCh42qAq/MoHpHGzHrX+B/FjkKq7ZWaD
   oN175C3yi3SS5P/YNRtNZA5tN6k0Ql4IAeYuFE7eTjcPRyla5k3spWij/
   fT5BIB8nc6tzHL4drL7ODemE2iHdr71FuUyAsVw1q6H/HxuC5ky4WsgLC
   lioz+6HFgTxAsK5bmdjvFKprES9bZfRwZezLuEl1GTYnqzfg8EdrYB6ow
   rExsbSN6O/GBxpS8MecKnrPDJaYBjcmiuMnwVG03C8OBq6qcvSNAuHGTd
   avx6yR4xqXf2AbMn6DkFByge557y7WYP5RjGeLbHXbTVBjhMo8DjD6H1n
   g==;
X-CSE-ConnectionGUID: 9s96LQNWRfetYlO7JOiaAA==
X-CSE-MsgGUID: +1ZqY4YXROuA1KJ3ZyhF3Q==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="133262121"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:55:55 +0800
IronPort-SDR: 68ef7dbb_2FqPbwLAxsD2cr8kSjR5whjnO9gqaX16NGxKMI4ATfrtgWO
 muToje+7I9XFRAQIM4nmPH6Up+LZoyLFPK8SXGg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:55:56 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:55:52 -0700
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
Subject: [PATCH v3 14/16] blktrace: expose ZONE APPEND completions to blktrace
Date: Wed, 15 Oct 2025 12:54:33 +0200
Message-ID: <20251015105435.527088-15-johannes.thumshirn@wdc.com>
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

Expose ZONE APPEND completions as a block trace completion action to
blktrace.

As tracing of zoned block commands needs the upper 32bit of the widened
64bit action, only add traces to blktrace if user-space has requested
version 2 of the blktrace protocol.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h |  3 +++
 kernel/trace/blktrace.c           | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 925f78af939e..bf41e34df3c8 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -97,6 +97,9 @@ enum blktrace_notify {
 #define BLK_TA_ABORT		(__BLK_TA_ABORT | BLK_TC_ACT(BLK_TC_QUEUE))
 #define BLK_TA_DRV_DATA	(__BLK_TA_DRV_DATA | BLK_TC_ACT(BLK_TC_DRV_DATA))
 
+#define BLK_TA_ZONE_APPEND	(__BLK_TA_COMPLETE |\
+				 BLK_TC_ACT(BLK_TC_ZONE_APPEND))
+
 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 90b225c5bad7..e8d562ad21f9 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -974,6 +974,22 @@ static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
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
@@ -1204,6 +1220,9 @@ static void blk_register_tracepoints(void)
 	WARN_ON(ret);
 	ret = register_trace_block_getrq(blk_add_trace_getrq, NULL);
 	WARN_ON(ret);
+	ret = register_trace_blk_zone_append_update_request_bio(
+		blk_add_trace_zone_update_request, NULL);
+	WARN_ON(ret);
 	ret = register_trace_block_plug(blk_add_trace_plug, NULL);
 	WARN_ON(ret);
 	ret = register_trace_block_unplug(blk_add_trace_unplug, NULL);
@@ -1223,6 +1242,8 @@ static void blk_unregister_tracepoints(void)
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

