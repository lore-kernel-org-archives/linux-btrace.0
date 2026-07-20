Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E823F58C3;
	Mon, 20 Jul 2026 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546101; cv=none; b=ay78jI4JiWlqcJMD1K3MKcbzdh7v9MFSm+84Z9GkEdekmQ0rTZTxIehn7i7gXn/19WUgu4fEtkBaXJpB+Evb36/CRTmuUWmH48Qnq6ul1vunF4VhmstbcIaYUkJwa1JGAToRFENDGvEhctOIcnHbQkvVCm3v59MNR2D1gUqpbSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546101; c=relaxed/simple;
	bh=8kn25TqxxcoHuvGi8OZtvBDKOYpitMw0rM3bA0wg+0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8WOSG/jUZN7Zk0qZUfyyLP/FH8+vduzQuayb1catgrMZ/18iYKxTGGy1tGwXVVjJNdwnwXV6BwZ0c8PfJVjhL9uFFqVdfLZq1EOYnXJ+E1Pd0XFO/RtWfpYyGL+tT18BqDKx+a0nEaixqbK59ejQsscdddv3Z3fAG2ZoBKE1+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AFfLRJt4; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AFfLRJt4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784546099; x=1816082099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8kn25TqxxcoHuvGi8OZtvBDKOYpitMw0rM3bA0wg+0Y=;
  b=AFfLRJt4ilHJ3PxX+VbMLE+wgb/M5JGmKIs3+4La5b7EHyAo4ugA9Bao
   sbSZ9DcmWvsTa+p2Jry0FAGGhq2VtzX9IhJ1RkyuNWZuEIYz+DbCI+VWT
   Q3jQkE1Vd2pFg6CJwwHTZi21fhQviWG1EWnFPfxeQzdOlHpsg0I/TOvOo
   cNzgbhGhVMBdKVB6f2oE7K6JZWmZmKRPs5EZWi+Vs/P4aJVAv2IeQCI70
   jUUb/pzAzCzQh6/XtZC3wXEAiRuM0MZbMRHMUsdPRGomiGPy0vJmnq3A2
   3X5daCyChQAZysohnbE+SJgyGa9kAJtjRHdIoFVBaVYhhaeIHDxJcfT0F
   A==;
X-CSE-ConnectionGUID: FY/XLBbzQbC2UkaYcc8eqw==
X-CSE-MsgGUID: QLWrBDO0S2qstuzKBqW3ZA==
X-IronPort-AV: E=Sophos;i="6.25,174,1779120000"; 
   d="scan'208";a="151105445"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2026 19:14:50 +0800
X-CSE-ConnectionGUID: 3gvlSay1Sz2rmiNhMhjjlQ==
X-CSE-MsgGUID: 8m82kmNNSbqzEdmCRxYnOg==
IronPort-SDR: 6a5e030f_n+wVrEHilNvLnDwIKEn/iPVDITCcBXJh0dsDLAvndjxzRof
 7Tz+0XwiaawMmQTUw3O9hSfFrUNusJ9r0sF8neg==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jul 2026 04:14:23 -0700
X-CSE-ConnectionGUID: UM6X6/8/Rx6y+VvHvop4XQ==
X-CSE-MsgGUID: Qt0YblclRf6bflGrTGVLAg==
WDCIronportException: Internal
Received: from wdap-kyufgunycc.ad.shared (HELO neo.fritz.box) ([10.224.19.3])
  by uls-op-esai1-o.wdc.com with ESMTP; 20 Jul 2026 04:14:21 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 01/11] btt: use blk_io_trace2 internally
Date: Mon, 20 Jul 2026 13:14:07 +0200
Message-ID: <20260720111417.1658507-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
References: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
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

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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

