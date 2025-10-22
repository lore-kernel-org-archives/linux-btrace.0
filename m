Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CE734166B;
	Wed, 22 Oct 2025 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133381; cv=none; b=gf5RyUDPtxfsdlhUIoGmOcqI2qmUi9FLiA1Uo7p8rSrNRRs0AFR/CBy2VUmSTe9WehegzO9dDw1ow8AcTMAoj1IzrKPErz6Pu+tT6cTKVRPT70+iy6AJVFd0kVEFZOL6+tZ/fpQUo8DcyqMpEv8d8JlvI/RytiPwobolvQ6/J+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133381; c=relaxed/simple;
	bh=AZUu7x0EKt0EjHUbPBNmDDgqo1onCFunbAVf6KTHHJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLGebG6V+0HPCr91Efc+ykd0+Jg1R9AEmvD+unFFoeiABSEPuvPLI5R+WKep9XpU3YCEa/AxyweJuQuma5PF2I5z3HqfbcVcDKlLbbxWQgcHpQlx0h426S4rEcaqdAUjzc+mW/QouUMxX9qa0W91qmnRlguQOzdwnkp35Dxkv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YjtNgJOr; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YjtNgJOr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761133379; x=1792669379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AZUu7x0EKt0EjHUbPBNmDDgqo1onCFunbAVf6KTHHJM=;
  b=YjtNgJOrywU986Xbk4FZ+S1K4cKWUAkfctLiYTX32BxPME9GeOh+L5bk
   +P8xSRha5Hg7OV/EH483/10D5U4CmrhrbX6ygg1HFICdJfSydL91TaIqu
   TM7YcvYfY2MLk3j24+YGLcklHmCBJZhosdA3AqtZBeR9CaW1BqwSO+4Tk
   8BGtjvIFnRbpqA68r364vPUzG2OoIE916FLGbM6IICrv4DSUAI5o0ZQ0K
   yGH/TFdFk8Vq0MS/uwmKyy+jnKWK+Mb8zeE6QwFZLC2urx2CN/56ZPQvz
   2DlD7AjcNK3tFvjSWa0fvV87ZtG7ResCpzrdZIYZqnwpECeRxrgZRaiaD
   Q==;
X-CSE-ConnectionGUID: zVkSq77ORAGyaNEUdQF2uA==
X-CSE-MsgGUID: 1W4infycQYWSElr+yuZynw==
X-IronPort-AV: E=Sophos;i="6.19,247,1754928000"; 
   d="scan'208";a="133700779"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 19:42:52 +0800
IronPort-SDR: 68f8c33c_d3GRU/L7vk5pRjntpGdbqwHg3fR8AQNRr9SEwXDCkWCfXnG
 DpdEFtUwH6SvDfpSVKWQdGujCYXuel3lRHPlIdg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 04:42:53 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 04:42:47 -0700
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
Subject: [PATCH v5 14/16] blktrace: expose ZONE APPEND completions to blktrace
Date: Wed, 22 Oct 2025 13:41:13 +0200
Message-ID: <20251022114115.213865-15-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
References: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h |  3 +++
 kernel/trace/blktrace.c           | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 190a3c5ab0a0..289872e51fc5 100644
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
index fb5935885abc..c83577096607 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -978,6 +978,22 @@ static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
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
@@ -1208,6 +1224,9 @@ static void blk_register_tracepoints(void)
 	WARN_ON(ret);
 	ret = register_trace_block_getrq(blk_add_trace_getrq, NULL);
 	WARN_ON(ret);
+	ret = register_trace_blk_zone_append_update_request_bio(
+		blk_add_trace_zone_update_request, NULL);
+	WARN_ON(ret);
 	ret = register_trace_block_plug(blk_add_trace_plug, NULL);
 	WARN_ON(ret);
 	ret = register_trace_block_unplug(blk_add_trace_unplug, NULL);
@@ -1227,6 +1246,8 @@ static void blk_unregister_tracepoints(void)
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

