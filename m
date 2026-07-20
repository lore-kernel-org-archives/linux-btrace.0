Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3711F3F9263;
	Mon, 20 Jul 2026 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546104; cv=none; b=dwx9FvP83CDTWVrIUAMRllBDY2Nd+Do5mvLWwrYSmpSyqXKmPnROcCTYLu9JI04W9olIrknev/NLlmm4ZtSABRmj8dUiqo5HXHe+HpMooZqyoPYHP7wAvuY3EROJdHAaIGYuwLBR0w6twHbkdjkYg6K/RjJ4vl2H1rX9bclVYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546104; c=relaxed/simple;
	bh=wyz8fmQuRUy+36AkpNg9N8YD2EKXb2oY4rAjUo1SNZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpGxpvhXFD3wZqwxReGpXsgxEImRvlWrHNMYrjo4ONV2BbXN/hIXx7K7x4YrICyOkkVHfc3GWRr7uoWU+sfzjAK5hS7+JWgvWB3+rMF66PLHVWUgge67KTrKvyE99ZiGMuk//x8ewAMYLtyHxZ/tH316zSCRfsZdNQllB8/qSsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bfH2xvy1; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bfH2xvy1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784546102; x=1816082102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wyz8fmQuRUy+36AkpNg9N8YD2EKXb2oY4rAjUo1SNZM=;
  b=bfH2xvy1oY5Cvyes3ZBY28BBvUkpZyz9orvTuvPketS0/JM/yjz1snTd
   cb0I8GJcz8knQLKBY3/WCOhbxKzl9h5EJN+Mi+LIhyhObCg4u42uKTtWh
   mFPtLWnBxatlJeubybp6X+EOVbnVqXLnWfTWJn9hcnESEYuU8nEx6UZ6x
   4J3RHQf3sK0GG82rzCb/rnZlRS652C/oG/LlI4E+APtjiP/m9Ln6zJFfT
   AJNoEI8pmHvEMUCkiMGlwIJYmZUma7hEIbsinXihw57tAZRyknl3KFDkJ
   wLrRYWVg0IAU9JSHqaBqzCRP/r9DzQJ9B9zor9RauneomnYG/8YrskYzf
   w==;
X-CSE-ConnectionGUID: f9IsjlMjT8SjboH1YPsK2A==
X-CSE-MsgGUID: LMn4Ti5qS9WVnkRlGegNuA==
X-IronPort-AV: E=Sophos;i="6.25,174,1779120000"; 
   d="scan'208";a="151105450"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2026 19:14:51 +0800
X-CSE-ConnectionGUID: xGVP3/1YTPuDJTgEz8OVOg==
X-CSE-MsgGUID: OtULSs/IRkqI5YOp5GeTLw==
IronPort-SDR: 6a5e0318_DXFU6PMo2UsvF7A6+cBBN9J9xJJo+SoBYsLTp2C1r7Msypi
 AHxRQ3xPDSZnShdN3t7KN1ArfcZypEURJMVAAkQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jul 2026 04:14:32 -0700
X-CSE-ConnectionGUID: XLF0Q+xlSH6PHfGkh4iBCg==
X-CSE-MsgGUID: fEmFEPDnTa+U9khz2qhsNQ==
WDCIronportException: Internal
Received: from wdap-kyufgunycc.ad.shared (HELO neo.fritz.box) ([10.224.19.3])
  by uls-op-esai1-o.wdc.com with ESMTP; 20 Jul 2026 04:14:30 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 05/11] blkrawverify: natively parse blk_io_trace2
Date: Mon, 20 Jul 2026 13:14:11 +0200
Message-ID: <20260720111417.1658507-6-johannes.thumshirn@wdc.com>
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

Natively parse 'struct blk_io_trace2' from a blktrace binary.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkrawverify.c | 72 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 24 deletions(-)

diff --git a/blkrawverify.c b/blkrawverify.c
index 2a3aa609581f..7ef3c075aeef 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -119,6 +119,52 @@ static void dump_trace(FILE *ofp, char *prefix, struct blk_io_trace2 *bit)
 						           MINOR(bit->device));
 }
 
+static int read_trace(FILE *ifp, struct blk_io_trace2 *bit)
+{
+	struct blk_io_trace bit1;
+	struct blk_io_trace2 bit2;
+	__u32 magic;
+	int version;
+	void *p;
+
+	if (fread(&magic, sizeof(magic), 1, ifp) != 1)
+		return 0;
+
+	if (data_is_native == -1)
+		check_data_endianness(magic);
+
+	version = (data_is_native ? magic : be32_to_cpu(magic)) & 0xff;
+
+	if (version == SUPPORTED_VERSION2) {
+		bit2.magic = magic;
+		p = (void *) ((u8 *)&bit2 + sizeof(__u32));
+		if (fread(p, sizeof(bit2) - sizeof(__u32), 1, ifp) != 1)
+			return 0;
+		bit2_trace_to_cpu(&bit2);
+		*bit = bit2;
+	} else {
+		bit1.magic = magic;
+		p = (void *) ((u8 *)&bit1 + sizeof(__u32));
+		if (fread(p, sizeof(bit1) - sizeof(__u32), 1, ifp) != 1)
+			return 0;
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
+	}
+
+	return 1;
+}
+
 static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 {
 #	define SWAP_BITS() do {						\
@@ -145,7 +191,6 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 	FILE *ifp, *ofp;
 	__u32 save_device = 0, save_sequence = 0;
 	__u64 save_time = 0;
-	struct blk_io_trace bit1;
 	struct blk_io_trace2 *bit_save = NULL;
 	struct blk_io_trace2 *bit = malloc(sizeof(struct blk_io_trace2));
 	unsigned int ngood = 0;
@@ -173,39 +218,18 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 	}
 
 	ofp = *fp;
-	while ((n = fread(&bit1, sizeof(struct blk_io_trace), 1, ifp)) == 1) {
+	while (read_trace(ifp, bit)) {
 		if (ferror(ifp)) {
 			clearerr(ifp);
 			perror("fread");
 			break;
 		}
-		if (data_is_native == -1)
-			check_data_endianness(bit1.magic);
-
-		bit_trace_to_cpu(&bit1);
-
-		bit->magic	= bit1.magic;
-		bit->sequence	= bit1.sequence;
-		bit->time	= bit1.time;
-		bit->sector	= bit1.sector;
-		bit->bytes	= bit1.bytes;
-		bit->action	= bit1.action;
-		bit->pid	= bit1.pid;
-		bit->device	= bit1.device;
-		bit->cpu	= bit1.cpu;
-		bit->error	= bit1.error;
-		bit->pdu_len	= bit1.pdu_len;
 
 		if (!CHECK_MAGIC(bit->magic)) {
 			INC_BAD("bad trace");
 			continue;
 		}
 
-		if ((bit->magic & 0xff) != SUPPORTED_VERSION) {
-			fprintf(stderr, "unsupported trace version\n");
-			break;
-		}
-
 		if (bit->pdu_len) {
 			char *pdu_buf;
 
@@ -258,7 +282,7 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 		SWAP_BITS();
 	}
 
-	if (n == 0 && !feof(ifp))
+	if (!feof(ifp))
 		fprintf(stderr,"%s: fread failed %d/%s\n",
 		        file, errno, strerror(errno));
 	fclose(ifp);
-- 
2.54.0

