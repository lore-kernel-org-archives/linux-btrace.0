Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A33F9F25;
	Mon, 20 Jul 2026 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546103; cv=none; b=mVyf1Wc4UDXyIOwW19p9XN4JnPk4TaBzutKY6g00dGgNisHBVD1HvZMZUf5KZX3EFYzBP2B2cHcoUyZpp60uCMkz2eDg6+Vi9E4REuidn9dfv0+n1R0ZpSUzWLv0OSg1s/Hd4EDZl+DuIaJUtkdFjazESjNQtGPn4bumh174G+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546103; c=relaxed/simple;
	bh=PVkKKpntkH9ENLw8rDLodJcFqjns+ysz3ZQ1ygrOOf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNvKVZflYGQXxGOOVT0Oyo3RkIlOdyurqF4hywTNQB9DMA713BiVXRMTl5rvWPDIxXsJo7CC2aU8b9/mtOhvPYk4isO+SNMywu5K6fZgeVELi8+4vm+zZUssscMiGOooLHSs4IgimKeLwyQcKoaC6z7tcafP779UfuWh2dKiZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=F4TDQPEr; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F4TDQPEr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784546101; x=1816082101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PVkKKpntkH9ENLw8rDLodJcFqjns+ysz3ZQ1ygrOOf0=;
  b=F4TDQPErGiSc4wTdd6kQ6UWwQEbhjAIwOpph+QtssZ1bT04pDdNsOus7
   NGxECYgPoQ5pBZ+Kz4jx8qf+IIY11bFZfsFf7llBxkZzECF0ucqJPObtk
   HNbaBMRyBA9EmM5AxXu06sHkloIy+Ea1CfLh2izt5CCF+JcOVUG5hNPdF
   PXzerl8g48RW1vW/Wj1X4mc4apdGrzrxU2DEU+kxfZeVgui3P6/XyL+T9
   7h258uxUiS+/1yizLvJAhUbzNO1NrCgSbqys0L6unjuB+YGwYR5AD+92u
   lGVAEv/Vk6Nh8J1JcFiG/+jxonlah4+QoMumVTXaOQRyR0dPkzH72qCoP
   A==;
X-CSE-ConnectionGUID: VFozw1DIQYWmtblOKQomsw==
X-CSE-MsgGUID: 2iNAxaAZQy20TNOteMRK+Q==
X-IronPort-AV: E=Sophos;i="6.25,174,1779120000"; 
   d="scan'208";a="151105448"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2026 19:14:51 +0800
X-CSE-ConnectionGUID: FnQ2MtAMQveBf05YyizjZw==
X-CSE-MsgGUID: bCo2mrFuRqeC71hMCAucpw==
IronPort-SDR: 6a5e0316_zBItwtC+FJc6AIbJhgkgrYY5PPPF0aclwND7sEq3GPCFycq
 QfXwio4qsafhGUCdlAvyNvogMW6qJ3rcVQiK+4w==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jul 2026 04:14:30 -0700
X-CSE-ConnectionGUID: 544tuoQOQCyCBkktO9hEgQ==
X-CSE-MsgGUID: y8rzCZdKR+uwj/kHeOFEBw==
WDCIronportException: Internal
Received: from wdap-kyufgunycc.ad.shared (HELO neo.fritz.box) ([10.224.19.3])
  by uls-op-esai1-o.wdc.com with ESMTP; 20 Jul 2026 04:14:28 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 04/11] blkrawverify: use blk_io_trace2 internally
Date: Mon, 20 Jul 2026 13:14:10 +0200
Message-ID: <20260720111417.1658507-5-johannes.thumshirn@wdc.com>
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
 blkrawverify.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/blkrawverify.c b/blkrawverify.c
index 8e863cb39490..2a3aa609581f 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -102,7 +102,7 @@ static char *act_to_str(__u64 action)
 	return buf;
 }
 
-static void dump_trace(FILE *ofp, char *prefix, struct blk_io_trace *bit)
+static void dump_trace(FILE *ofp, char *prefix, struct blk_io_trace2 *bit)
 {
 	fprintf(ofp, "    Dump %s\n", prefix);
 	fprintf(ofp, "        %8s: %08x\n", "magic", bit->magic);
@@ -123,13 +123,13 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 {
 #	define SWAP_BITS() do {						\
 		if (bit_save) {						\
-			struct blk_io_trace *tmp = bit_save;		\
+			struct blk_io_trace2 *tmp = bit_save;		\
 			bit_save = bit;					\
 			bit = tmp;					\
 		}							\
 		else {							\
 			bit_save = bit;					\
-			bit = malloc(sizeof(struct blk_io_trace));	\
+			bit = malloc(sizeof(struct blk_io_trace2));	\
 		}							\
 	} while (0)
 
@@ -145,8 +145,9 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 	FILE *ifp, *ofp;
 	__u32 save_device = 0, save_sequence = 0;
 	__u64 save_time = 0;
-	struct blk_io_trace *bit_save = NULL;
-	struct blk_io_trace *bit = malloc(sizeof(struct blk_io_trace));
+	struct blk_io_trace bit1;
+	struct blk_io_trace2 *bit_save = NULL;
+	struct blk_io_trace2 *bit = malloc(sizeof(struct blk_io_trace2));
 	unsigned int ngood = 0;
 	unsigned int nbad = 0;
 	unsigned int nbad_trace = 0, nbad_pdu = 0, nbad_cpu = 0;
@@ -172,16 +173,28 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 	}
 
 	ofp = *fp;
-	while ((n = fread(bit, sizeof(struct blk_io_trace), 1, ifp)) == 1) {
+	while ((n = fread(&bit1, sizeof(struct blk_io_trace), 1, ifp)) == 1) {
 		if (ferror(ifp)) {
 			clearerr(ifp);
 			perror("fread");
 			break;
 		}
 		if (data_is_native == -1)
-			check_data_endianness(bit->magic);
-
-		bit_trace_to_cpu(bit);
+			check_data_endianness(bit1.magic);
+
+		bit_trace_to_cpu(&bit1);
+
+		bit->magic	= bit1.magic;
+		bit->sequence	= bit1.sequence;
+		bit->time	= bit1.time;
+		bit->sector	= bit1.sector;
+		bit->bytes	= bit1.bytes;
+		bit->action	= bit1.action;
+		bit->pid	= bit1.pid;
+		bit->device	= bit1.device;
+		bit->cpu	= bit1.cpu;
+		bit->error	= bit1.error;
+		bit->pdu_len	= bit1.pdu_len;
 
 		if (!CHECK_MAGIC(bit->magic)) {
 			INC_BAD("bad trace");
-- 
2.54.0

