Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE03F8EB7;
	Thu, 16 Jul 2026 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784199924; cv=none; b=dc41C8BWxmWOlfqSNVnVEEc2+yr7XKLHITO1fKMZxNudIpSQahO/e5XHTsAsDnkaks3SiUiZmu4pVqTR5xH+NN4Grsb6mlM81PvDokUt4gjBkB8PmDASkcs3E/U/1pOEPXzGNkfsbCx1DlXqThKV0dJrb7MXjiR6ls1rO/xVOKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784199924; c=relaxed/simple;
	bh=EGMYaEGHd0tCnWGW3/6rmhcGHRbuQGqFBEpYZdm7Rrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elWTTR7GkR+/a7a9ea1uYQ/PqPqC576otlMlydUIWZl4IYbQvvH2j0HcpmrQRUq4k+qXl/HgoJJ1osqqjHEffdlfChVr8HUk59p4uyKufsJAngp8vWoPgFMYV93AuSi+vqVtWAQrEQ6KX8rlN3wRaLxDdXOX35YW4j3ReRlof6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=C11Rc3j6; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C11Rc3j6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784199923; x=1815735923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EGMYaEGHd0tCnWGW3/6rmhcGHRbuQGqFBEpYZdm7Rrc=;
  b=C11Rc3j6lY3LwhzpgeiRMM1wfjR70F3wJSyxNW/pH7i0XkH2ZOaIFat0
   5X48oRNTyncHTRa4KD6V+TuwXd7yXlGfL4iQ8s2dgSbxiWZIsaSESeaD7
   nrK9NufjKrTVdVvGMm9zR4AZGLe2G4icE27dT2hU587EZ8HafiZAq48NN
   Zlc/wuzLP0OhN+RknDftusxOMmscSbNCAw91Z4qz7heie2sDd/TiHQBC9
   faLZW3r7bpamta5mNr1fEF8eJd/qHC702Or8OK/Dgx2I9pmtSkSbGXdai
   +DX7AkBP5vR60wSYoEBFBL37faM3krQoVdqs3HeB/x1OK6weETOUdltdu
   g==;
X-CSE-ConnectionGUID: /ht4uC9qRnSGwHdrKSQudw==
X-CSE-MsgGUID: 7k3Wv+2iT5i/pBmlndzgLQ==
X-IronPort-AV: E=Sophos;i="6.25,167,1779120000"; 
   d="scan'208";a="146986478"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2026 19:05:19 +0800
X-CSE-ConnectionGUID: iGiVeGhLS+OV2VHNYOJLcQ==
X-CSE-MsgGUID: 2zP3h4LMRJyZk/E4+em91w==
IronPort-SDR: 6a58bada_ryZQ9ahFdiyvOYqdlaJ0HvZUeEjmwV3gwnDhTX589yyJNxj
 wvBsJzQFNyWJcO/86dF+hQ6l/W6Fe8DwDU8eEig==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2026 04:04:58 -0700
X-CSE-ConnectionGUID: 2GFHgivATj28cj1hDCTwAQ==
X-CSE-MsgGUID: wBJQRYBASiahbaW8GXQ/wQ==
WDCIronportException: Internal
Received: from wdap-fln31fg1cp.ad.shared (HELO neo.wdc.com) ([10.224.28.153])
  by uls-op-esai1-o.wdc.com with ESMTP; 16 Jul 2026 04:04:56 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/11] blkrawverify: natively parse blk_io_trace2
Date: Thu, 16 Jul 2026 13:04:36 +0200
Message-ID: <20260716110442.1291010-6-johannes.thumshirn@wdc.com>
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

Natively parse 'struct blk_io_trace2' from a blktrace binary.

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

