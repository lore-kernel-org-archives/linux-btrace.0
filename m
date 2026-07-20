Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754D03FADF8;
	Mon, 20 Jul 2026 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546106; cv=none; b=joN6jiv9wCbFGm7CuphxkrX25AF6rWtAqpst+L4zvT6KqIhkJhiqpZ75e/a5bzkla67X1KgmxiHrLCm9HpUBghb0KSOWNgMdSBK07pESV6qeAHB0ohaoYbbKOkOMWK9ESqU3aJ+7GbbI2g6qdqoIiUYcejZW+QatxONmkgTGs58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546106; c=relaxed/simple;
	bh=XVF0L3FrLA2lslMgQGMhWPWV6ahCpBJr643wb+5+O9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avJPtBcJsduXe3AQ2Yo1R7gTmn3DTNzYX12gVsJb5VmLXdJqPiPObkjSK74ezt1qixZtXcGYgopQ/HenuTa8tPMldNhMu5cLHppvl6/pOIDA8uyEkibdObNSDPBPx3bsDhlnctYSQeh4adnN3nlx1KyhQMSwwlZ/gNCFHZ7hHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UBAbRWNz; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UBAbRWNz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784546105; x=1816082105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XVF0L3FrLA2lslMgQGMhWPWV6ahCpBJr643wb+5+O9g=;
  b=UBAbRWNzDCNmpUbJnBt+/DNEOOlX+H7tJjkzc9MctfCLU35qZEVYIiZ/
   IqKNjKPwFSKzcAAxA61dfbM/wNCsOlw4N/0LWjrkf/nrDxXV6H0sBRDWM
   Q6HplxNLNdgQsIooTh6HxdVd6siEgU6RNzq3+f4tcUHA2RbOvYeX5cZWo
   15HqMRHpiNDzvIgeyb+Tq3ncZmRIjJkI6q/AyvJEFHjWc8JzDsWD6B4Qa
   zFgnfkJc2fh7NLak0pJnAMi0RzenyFVg8zZgeW3Om6cGJHdkrsVrcmK8D
   N1oNaBhY2oPRT2hr+2YhOPePiWjAuKMWhEjUcucXihZDGNO8idbXmCejA
   A==;
X-CSE-ConnectionGUID: d8khslZMR6igZRh42pik0w==
X-CSE-MsgGUID: 87Cg37reSriJTkiLhhUW6A==
X-IronPort-AV: E=Sophos;i="6.25,174,1779120000"; 
   d="scan'208";a="151105456"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2026 19:14:52 +0800
X-CSE-ConnectionGUID: XaYnKJzXS7C7imsrmToKsA==
X-CSE-MsgGUID: 8OUl3TOxTEmiIIFydRapYw==
IronPort-SDR: 6a5e0324_XyDncMKx6KtipZTxFwgHJw1mR3SXK/OFzZl8McKuE7BLEjZ
 UeJEbxo5yo1+tFXbDrE5dZk5WXqBSfuUMKIGS0A==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jul 2026 04:14:44 -0700
X-CSE-ConnectionGUID: wgQ6WlHkSf20XTgUk8NjOw==
X-CSE-MsgGUID: tGBheZ8sTlCqSR0La2bXTA==
WDCIronportException: Internal
Received: from wdap-kyufgunycc.ad.shared (HELO neo.fritz.box) ([10.224.19.3])
  by uls-op-esai1-o.wdc.com with ESMTP; 20 Jul 2026 04:14:42 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 10/11] btreplay: support blk_io_trace2 in btrecord
Date: Mon, 20 Jul 2026 13:14:16 +0200
Message-ID: <20260720111417.1658507-11-johannes.thumshirn@wdc.com>
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

Read the 'magic' portion of the trace first and then parse either 'struct
blk_io_trace' or 'struct blk_io_trace2' depending on the protocol version
of the trace, so btrecord can process both trace file versions.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 btreplay/btrecord.c | 83 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 16 deletions(-)

diff --git a/btreplay/btrecord.c b/btreplay/btrecord.c
index a07ca07aae1f..c1c94567409a 100644
--- a/btreplay/btrecord.c
+++ b/btreplay/btrecord.c
@@ -200,7 +200,7 @@ static inline void fatal(const char *errstring, const int exitval,
  * match - Return true if this trace is a proper QUEUE transaction
  * @action: Action field from trace
  */
-static inline int match(__u32 action)
+static inline int match(__u64 action)
 {
 	return ((action & 0xffff) == __BLK_TA_QUEUE) &&
 				       (action & BLK_TC_ACT(BLK_TC_QUEUE));
@@ -483,41 +483,92 @@ void handle_args(int argc, char *argv[])
 static int next_io(struct ifile_info *iip, struct io_spec *spec)
 {
 	ssize_t ret;
-	__u32 action;
+	__u64 action;
 	__u16 pdu_len;
+	__u32 magic;
+	int version;
 	struct blk_io_trace t;
+	struct blk_io_trace2 t2;
+	void *p;
 
 again:
-	ret = read(iip->ifd, &t, sizeof(t));
+	ret = read(iip->ifd, &magic, sizeof(magic));
 	if (ret < 0) {
 		fatal(iip->file_name, ERR_SYSCALL, "Read failed\n");
 		/*NOTREACHED*/
 	}
 	else if (ret == 0)
 		return 0;
-	else if (ret < (ssize_t)sizeof(t)) {
+	else if (ret < (ssize_t)sizeof(magic)) {
 		fprintf(stderr, "WARNING: Short read on %s (%d)\n", 
 			iip->file_name, (int)ret);
 		return 0;
 	}
 
 	if (data_is_native == -1)
-		check_data_endianness(t.magic);
+		check_data_endianness(magic);
 
 	assert(data_is_native >= 0);
-	if (data_is_native) {
-		spec->time = t.time;
-		spec->sector = t.sector;
-		spec->bytes = t.bytes;
-		action = t.action;
-		pdu_len = t.pdu_len;
+
+	version = (data_is_native ? magic : be32_to_cpu(magic)) & 0xff;
+
+	if (version == SUPPORTED_VERSION2) {
+		t2.magic = magic;
+		p = (void *) ((u8 *)&t2 + sizeof(__u32));
+		ret = read(iip->ifd, p, sizeof(t2) - sizeof(__u32));
+		if (ret < 0) {
+			fatal(iip->file_name, ERR_SYSCALL, "Read failed\n");
+			/*NOTREACHED*/
+		}
+		else if (ret < (ssize_t)(sizeof(t2) - sizeof(__u32))) {
+			fprintf(stderr, "WARNING: Short read on %s (%d)\n",
+				iip->file_name, (int)ret);
+			return 0;
+		}
+
+		if (data_is_native) {
+			spec->time = t2.time;
+			spec->sector = t2.sector;
+			spec->bytes = t2.bytes;
+			action = t2.action;
+			pdu_len = t2.pdu_len;
+		}
+		else {
+			spec->time = be64_to_cpu(t2.time);
+			spec->sector = be64_to_cpu(t2.sector);
+			spec->bytes = be32_to_cpu(t2.bytes);
+			action = be64_to_cpu(t2.action);
+			pdu_len = be16_to_cpu(t2.pdu_len);
+		}
 	}
 	else {
-		spec->time = be64_to_cpu(t.time);
-		spec->sector = be64_to_cpu(t.sector);
-		spec->bytes = be32_to_cpu(t.bytes);
-		action = be32_to_cpu(t.action);
-		pdu_len = be16_to_cpu(t.pdu_len);
+		t.magic = magic;
+		p = (void *) ((u8 *)&t + sizeof(__u32));
+		ret = read(iip->ifd, p, sizeof(t) - sizeof(__u32));
+		if (ret < 0) {
+			fatal(iip->file_name, ERR_SYSCALL, "Read failed\n");
+			/*NOTREACHED*/
+		}
+		else if (ret < (ssize_t)(sizeof(t) - sizeof(__u32))) {
+			fprintf(stderr, "WARNING: Short read on %s (%d)\n",
+				iip->file_name, (int)ret);
+			return 0;
+		}
+
+		if (data_is_native) {
+			spec->time = t.time;
+			spec->sector = t.sector;
+			spec->bytes = t.bytes;
+			action = t.action;
+			pdu_len = t.pdu_len;
+		}
+		else {
+			spec->time = be64_to_cpu(t.time);
+			spec->sector = be64_to_cpu(t.sector);
+			spec->bytes = be32_to_cpu(t.bytes);
+			action = be32_to_cpu(t.action);
+			pdu_len = be16_to_cpu(t.pdu_len);
+		}
 	}
 
 
-- 
2.54.0

