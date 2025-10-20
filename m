Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B98329C52;
	Mon, 20 Oct 2025 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967754; cv=none; b=elgLYUFuQBaJAbGDbP2Vbl79yb0pCyAq3xQHxKS9Omk289j1MKpWgVckwTE1NkTW9SPRSPTBIDXexiKM2tkpYouqd5wnX6+613wGb25/7v3dIfszBnsm+sDNSl3fiO7Ma76K6oHASHn9MHiip3zGuBrYjR5PgfdVwKpSMulhcNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967754; c=relaxed/simple;
	bh=4BZU4ae3v+trGuRWLJAjp1+03O0MIvPY3ejsJ44x7qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIcnFk9HafFpLhSzhqo8xfkiDP/Avw5HoimIqt94AUVJk7qKRwmPI06C4Ir7soOOPNbYyvYMpOeDIS64kiQNilRgtOakNSEqHxGBlbw9qTY0SAkBOmiG0AkLumXi3HGED+jFyNygPOwwAGb0E6WZsjDgGg6q65vTKNsc1CWV7Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EJFiZ3P/; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EJFiZ3P/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760967753; x=1792503753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4BZU4ae3v+trGuRWLJAjp1+03O0MIvPY3ejsJ44x7qo=;
  b=EJFiZ3P/Fb8Gysu3KtWc44cmIk593MV7xZM3eziwO5nJDRid8OWvO5B8
   xpCKGZJXvx6dFp0Cb69oKLPD+dK8iIt8Wz83BiiIL1KkDQBRvx7cvbf9r
   0b7LWEs0ImvWDU5YiTDOpJcJSLqUFNjS1HsjU6JIzV6hC5CTusxb1iPdf
   6Z7uer4EtFlytJIvvL5nxTOin3DlGf+JxZjpWPyszLVxtncCXfqk6Eq0e
   OwkeTU4PrgOZT0Sez9xOxxS2EfNzBq68SLwecSQIA0jS315cHKQfnqpMQ
   r4qBJM5sEC08Y3wUjze3UKzdnRBmtefdPySo2pa0Wr5YOzQcg+yrdjKf4
   A==;
X-CSE-ConnectionGUID: rYZNMJ67RpG+/wkiNHqBvg==
X-CSE-MsgGUID: S7IQrHcHQ7OoD3zlvMmKag==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134518675"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 21:42:33 +0800
IronPort-SDR: 68f63c48_3n+GmQEEQ0NXQnyZjjqKdLOnohBjyGdgUT393iOtMo8Xhjk
 AYxtT9sgV8DewCQ/0m+oXv8W3+CIhwP27biDP8A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2025 06:42:32 -0700
WDCIronportException: Internal
Received: from 1pgdl13.ad.shared (HELO neo.fritz.box) ([10.224.28.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Oct 2025 06:42:28 -0700
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
Subject: [PATCH v4 14/16] blktrace: expose ZONE APPEND completions to blktrace
Date: Mon, 20 Oct 2025 15:41:21 +0200
Message-ID: <20251020134123.119058-15-johannes.thumshirn@wdc.com>
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

Expose ZONE APPEND completions as a block trace completion action to
blktrace.

As tracing of zoned block commands needs the upper 32bit of the widened
64bit action, only add traces to blktrace if user-space has requested
version 2 of the blktrace protocol.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index e8effb6cb393..68a657a1ccf8 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -977,6 +977,22 @@ static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
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
@@ -1207,6 +1223,9 @@ static void blk_register_tracepoints(void)
 	WARN_ON(ret);
 	ret = register_trace_block_getrq(blk_add_trace_getrq, NULL);
 	WARN_ON(ret);
+	ret = register_trace_blk_zone_append_update_request_bio(
+		blk_add_trace_zone_update_request, NULL);
+	WARN_ON(ret);
 	ret = register_trace_block_plug(blk_add_trace_plug, NULL);
 	WARN_ON(ret);
 	ret = register_trace_block_unplug(blk_add_trace_unplug, NULL);
@@ -1226,6 +1245,8 @@ static void blk_unregister_tracepoints(void)
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

