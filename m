Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABF03F8EB7;
	Thu, 16 Jul 2026 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784199922; cv=none; b=U7O8lzEMaHp2917iBFjbWFd8lRjzbO6VU6kbVQH78L4coZHW3ajOBNTb9xKcWZCjhXKvL3jnuzfbiWuT2gSZFBRBfQfisq7WdQ0f51BJDD512lVc5KYY+xdmHQka96Ph43YxPr/jVSjrJW3q8RUdQT7ysBRR8sPcG3tEAgevlY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784199922; c=relaxed/simple;
	bh=+YtSk7KwlVCmQAgCgrIVcsDuoXar2jI+NUd2KsuNNGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fdkfm3uqcICy9cAl2dwzSTgLjTrxYHJV7oPAvzmVUeDsLQRM12rR5R3TgzxPzGTfQzNMS6az+amf8XS2V28hlG/EdEe3ygdt9+TMSvPwhoRBUHlxMnzL5lBCsIFBewXEJujYwW1NCq7V+5hYrm5OlxaCKaXuugko8XgBFfpcDKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EPynFr0E; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EPynFr0E"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784199921; x=1815735921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+YtSk7KwlVCmQAgCgrIVcsDuoXar2jI+NUd2KsuNNGU=;
  b=EPynFr0EYuzqiBPmIaI3it0YdAiw+GhFQsdyxHDHcbrZQKsuozCWNbRH
   c4Gl3JhyBPmkTEO8zZ+t+O1c+GRvIXBHE5xllI2DIsjaOgkX1ivgLd9uR
   Mlx7GnZSLg+j0WpWeBZbO/y5ArgV/K/IJDYXoTQLZJ4gKV0an1WVM+rya
   Q7IpT8HDmdgzypb9C13DDg0Y1ZK8xGuHswdyPX1xKUA/c8UOCFSAik3vz
   PNwhslDQxG3TMHDs02kzK56GnMrRM8kHApLE20CPQ7y0wwHky145k9/M2
   sZUlkItKFz80xt9id6fIZEdEJlERUcMfKagdCBDP6G+R2i8y6Oj+IflDb
   Q==;
X-CSE-ConnectionGUID: EbjXXMf+RnyYSDUkttIT+A==
X-CSE-MsgGUID: 76rW3e+3Q96EOtafhsRSlw==
X-IronPort-AV: E=Sophos;i="6.25,167,1779120000"; 
   d="scan'208";a="146986474"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2026 19:05:18 +0800
X-CSE-ConnectionGUID: i++V+FeBTleG6E7T/C4yQg==
X-CSE-MsgGUID: lZCmq0FXQyGrKrqnNsvcnA==
IronPort-SDR: 6a58bad1_VEF4wcJNFU/MzA6GUmUgD5LcO8ZHnSZZB5XlVaanD1oE7n4
 pUCBXqUoyPDm44mKNRSIUWPe7d1C0jL3QG37yeQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2026 04:04:49 -0700
X-CSE-ConnectionGUID: t8iqqbbIStq04WGFSuQxEQ==
X-CSE-MsgGUID: UF7Ytbx6QQWm8K18TFruSw==
WDCIronportException: Internal
Received: from wdap-fln31fg1cp.ad.shared (HELO neo.wdc.com) ([10.224.28.153])
  by uls-op-esai1-o.wdc.com with ESMTP; 16 Jul 2026 04:04:47 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 01/11] btt: use blk_io_trace2 internally
Date: Thu, 16 Jul 2026 13:04:32 +0200
Message-ID: <20260716110442.1291010-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
References: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 'struct blk_io_trace2' as internal representation for a captured
blktrace.

This implies the conversion of 'struct blk_io_trace' into 'struct
blk_io_trace2' when reading the trace from the binary file.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 btt/globals.h |  4 ++--
 btt/mmap.c    | 22 ++++++++++++++++------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/btt/globals.h b/btt/globals.h
index 22a1cb060149..f37b3cbd2edf 100644
--- a/btt/globals.h
+++ b/btt/globals.h
@@ -158,7 +158,7 @@ struct io {
 	__u64 s_time;
 	__u32 d_nsec, c_nsec;
 
-	struct blk_io_trace t;
+	struct blk_io_trace2 t;
 
 	int linked;
 	enum iop_type type;
@@ -260,7 +260,7 @@ void clean_allocs(void);
 /* mmap.c */
 void setup_ifile(char *fname);
 void cleanup_ifile(void);
-int next_trace(struct blk_io_trace *t, void **pdu);
+int next_trace(struct blk_io_trace2 *t, void **pdu);
 double pct_done(void);
 
 /* output.c */
diff --git a/btt/mmap.c b/btt/mmap.c
index 9d4eb3d62fda..766a32b6c9e8 100644
--- a/btt/mmap.c
+++ b/btt/mmap.c
@@ -47,15 +47,25 @@ static inline size_t min_len(size_t a, size_t b)
 }
 
 static inline size_t convert_to_cpu(struct blk_io_trace *t,
-                                    struct blk_io_trace *tp,
+                                    struct blk_io_trace2 *tp,
 				    void **pdu)
 {
 	if (data_is_native == -1)
 		check_data_endianness(t->magic);
 
-	if (data_is_native)
-		memcpy(tp, t, sizeof(*tp));
-	else {
+	if (data_is_native) {
+		tp->magic	= t->magic;
+		tp->sequence	= t->sequence;
+		tp->time	= t->time;
+		tp->sector	= t->sector;
+		tp->bytes	= t->bytes;
+		tp->action	= t->action;
+		tp->pid		= t->pid;
+		tp->device	= t->device;
+		tp->cpu		= t->cpu;
+		tp->error	= t->error;
+		tp->pdu_len	= t->pdu_len;
+	} else {
 		tp->magic	= be32_to_cpu(t->magic);
 		tp->sequence	= be32_to_cpu(t->sequence);
 		tp->time	= be64_to_cpu(t->time);
@@ -75,7 +85,7 @@ static inline size_t convert_to_cpu(struct blk_io_trace *t,
 	} else
 		*pdu = NULL;
 
-	return sizeof(*tp) + tp->pdu_len;
+	return sizeof(*t) + tp->pdu_len;
 }
 
 static int move_map(void)
@@ -127,7 +137,7 @@ void cleanup_ifile(void)
 	close(fd);
 }
 
-int next_trace(struct blk_io_trace *t, void **pdu)
+int next_trace(struct blk_io_trace2 *t, void **pdu)
 {
 	size_t this_len;
 
-- 
2.54.0

