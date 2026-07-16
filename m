Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CB440D58B;
	Thu, 16 Jul 2026 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784199924; cv=none; b=VZbjKep+v3vkeR0RwCvB6Sw4BfUcKlfnfYoDjfQAlkUWP2Dv4CYdsb7qktwEibTqaD7VRHaEdJVsRWOtqRJStdt3fvXnlqymqluxuiRip4KQVtBYaOpR9h4rP/HRCcWyxWA+nyisSpaC6ueAnbwjFjtRCG/QJjhot2Ay1OQg6Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784199924; c=relaxed/simple;
	bh=LNmnJC8bpmzgl9/DdmdbQtmNQc3vuENDcu6ZdlyiNZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aiy1blUWZgjMy7/HNxMGG+bJLytHtBENLFUibLh4DJmb/EJg+Efbqf1ZtemR8SvhhEfuSieDUn+D8UJHL+7jdva/AwNUo88d3KtEhYZ5cvVUxUpGLYIXjvgIN+WAkzZ7saBMnV7j8iAcTXn7tJxeJd8IjLkYxAGLHdbgzhWRYsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V3dxon4h; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V3dxon4h"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784199923; x=1815735923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LNmnJC8bpmzgl9/DdmdbQtmNQc3vuENDcu6ZdlyiNZA=;
  b=V3dxon4h8F2rk2f4BpD0S3pctTX3Tm8nC0HCAlkjQeQ4TaBfN6xJ0WxL
   TKYLGMFYMSlEyNogr6q9Qsn6S1kdgOgQ8dbzzSW8Fm8A9H3mWYs2Q0oOl
   AjYzFR2iAxqG3A4h+F6OhNzhQd/0vn43e8sBDiZR4aIJn/eTbFCJslgDp
   VQsJS1bJF+BGxTHv5g+gYvVIAI+n9Ddktpma9YLmHH6wIpMAO/LGRWpq6
   D3BnoJ3IvYjfa69corwJBWjZxRIPTILBt7O3zqwtwhrPI5xZVqnFhPQMk
   n1W0o3JDKpqZGlPkwo+tLgwvF0j1+/VdN1Hn+c3c6WHv0j2JqFGfstZp9
   A==;
X-CSE-ConnectionGUID: kLsojAkeQDuGRfzXHFj3mw==
X-CSE-MsgGUID: k/hxvw+TQgaw7qCDkwhT6A==
X-IronPort-AV: E=Sophos;i="6.25,167,1779120000"; 
   d="scan'208";a="146986477"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2026 19:05:19 +0800
X-CSE-ConnectionGUID: Ww4XhjBvTBWG2dCsdnyUjA==
X-CSE-MsgGUID: aOdBWjgoTtytWUgpebZcmA==
IronPort-SDR: 6a58bad8_M7rv/oD8BA1GyfFWazdJ3O3Ip/BWJB48k5z7hRmG676mhT6
 3tu0DdKOrsMsI7s3rxLTrqmZfb6JONZF94D9EMw==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2026 04:04:56 -0700
X-CSE-ConnectionGUID: 6Qv5zxFPSmacCyUgtn8w+Q==
X-CSE-MsgGUID: G17THoLdReSC7V+KHYIrnQ==
WDCIronportException: Internal
Received: from wdap-fln31fg1cp.ad.shared (HELO neo.wdc.com) ([10.224.28.153])
  by uls-op-esai1-o.wdc.com with ESMTP; 16 Jul 2026 04:04:54 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 04/11] blkrawverify: use blk_io_trace2 internally
Date: Thu, 16 Jul 2026 13:04:35 +0200
Message-ID: <20260716110442.1291010-5-johannes.thumshirn@wdc.com>
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

