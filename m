Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9EA3F9F44;
	Mon, 20 Jul 2026 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546105; cv=none; b=D59j3IzVRLFpDbb6M418/Jr16yrlw+zisgJDIVEMX293aserl2kMoNMRzmprOFC+s7sBdVjODZnSFeaYYeIzthz/P1lOslevGIsjEJXovnB1SdWtB3g9oSCiE8PHquD9+9ff8jSYIUpVVE3XgIP43ieMVlMRGkA++I8KKuCPUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546105; c=relaxed/simple;
	bh=/DyLrrY/CkqhJc+Mn0RgRlyZoQjiDyXWOXsbF+FdFBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMvck3FrU9qcAzxIkxJJbVDr0+3NTFA2X/DfEIrWIvA42I6wy1I+BcO2dNLam5h4YBo+61E0W7T8e4ugDS05W97U80BiyIBSs70qM6PhoBIcje7KKN7yranpuQpuGdlk3O8UrFZ1TiuLEEXV8nKlKXkh9LuCeU2iM0qZC+GSSJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ky2whwJf; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ky2whwJf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784546103; x=1816082103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/DyLrrY/CkqhJc+Mn0RgRlyZoQjiDyXWOXsbF+FdFBs=;
  b=Ky2whwJfwn09utujUcyI/anUHTR8eP55P5KMCHlAamOZPUvmwSCb63qz
   VAoywTBOm6Wp5GhXMOr8xf9u+OPwEaADEEFll7VWiRGjqhzU7WXIjXne1
   LkqcUN1H/pDAtm9H2UjBcTdE9Vf3JnWOpfNvuGSzPKtX8BdqfuEluIY1/
   LBaxgA/0t1s4XJty+4m9QhSubWVkTKWSSUUVgAEMeDEjSFhS1R3YN7pBu
   V/lAF5vKvAEk76N9M3/OEDkgZ0LOxGCKvmDDicxN6g0xtoaoSH9ykna2D
   4aXKbUnYqZnw8vFHdUecCZQT0FdfFZSJ5/z2qy1ugBC1iGrdU0E2B8iLD
   A==;
X-CSE-ConnectionGUID: FLUpiVErQCKPSk7Z7yHBcQ==
X-CSE-MsgGUID: AvS4AqAsQsObBmiSaqbipw==
X-IronPort-AV: E=Sophos;i="6.25,174,1779120000"; 
   d="scan'208";a="151105451"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2026 19:14:51 +0800
X-CSE-ConnectionGUID: nvveRtazS2+hnMy20cch8g==
X-CSE-MsgGUID: pt8u4ZVJQYi2oer4mC5K4A==
IronPort-SDR: 6a5e031a_i4LvaV5Tci5RflRWwvGc1B5sJGojFEChkIT14ABla9EMezK
 a0WE7PA3nDeqYtw68wiCv8vHnEdoq9ZaW86KB+g==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jul 2026 04:14:34 -0700
X-CSE-ConnectionGUID: hnngsJ1dQ4qx6V25sbNCFw==
X-CSE-MsgGUID: KLndiMWhSeWoQvJUpWQIvg==
WDCIronportException: Internal
Received: from wdap-kyufgunycc.ad.shared (HELO neo.fritz.box) ([10.224.19.3])
  by uls-op-esai1-o.wdc.com with ESMTP; 20 Jul 2026 04:14:33 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 06/11] blkiomon: use blk_io_trace2 internally
Date: Mon, 20 Jul 2026 13:14:12 +0200
Message-ID: <20260720111417.1658507-7-johannes.thumshirn@wdc.com>
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
 blkiomon.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/blkiomon.c b/blkiomon.c
index 9defa2c3fd43..32580a435fc8 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -42,7 +42,7 @@
 #include "blkiomon.h"
 
 struct trace {
-	struct blk_io_trace bit;
+	struct blk_io_trace2 bit;
 	struct rb_node node;
 	struct trace *next;
 	long sequence;
@@ -105,7 +105,7 @@ static long leftover = 0, driverdata = 0, match = 0, mismatch = 0, sequence = 0;
 
 static void dump_bit(struct trace *t, const char *descr)
 {
-	struct blk_io_trace *bit = &t->bit;
+	struct blk_io_trace2 *bit = &t->bit;
 
 	if (!debug.fn)
 		return;
@@ -116,7 +116,7 @@ static void dump_bit(struct trace *t, const char *descr)
 	fprintf(debug.fp, "time     %16ld\n", (unsigned long)bit->time);
 	fprintf(debug.fp, "sector   %16ld\n", (unsigned long)bit->sector);
 	fprintf(debug.fp, "bytes    %16d\n", bit->bytes);
-	fprintf(debug.fp, "action   %16x\n", bit->action);
+	fprintf(debug.fp, "action   %16llx\n", (unsigned long long)bit->action);
 	fprintf(debug.fp, "pid      %16d\n", bit->pid);
 	fprintf(debug.fp, "device   %16d\n", bit->device);
 	fprintf(debug.fp, "cpu      %16d\n", bit->cpu);
@@ -128,8 +128,8 @@ static void dump_bit(struct trace *t, const char *descr)
 
 static void dump_bits(struct trace *t1, struct trace *t2, const char *descr)
 {
-	struct blk_io_trace *bit1 = &t1->bit;
-	struct blk_io_trace *bit2 = &t2->bit;
+	struct blk_io_trace2 *bit1 = &t1->bit;
+	struct blk_io_trace2 *bit2 = &t2->bit;
 
 	if (!debug.fn)
 		return;
@@ -143,7 +143,9 @@ static void dump_bits(struct trace *t1, struct trace *t2, const char *descr)
 	fprintf(debug.fp, "sector   %16ld %16ld\n",
 		(unsigned long)bit1->sector, (unsigned long)bit2->sector);
 	fprintf(debug.fp, "bytes    %16d %16d\n", bit1->bytes, bit2->bytes);
-	fprintf(debug.fp, "action   %16x %16x\n", bit1->action, bit2->action);
+	fprintf(debug.fp, "action   %16llx %16llx\n",
+		(unsigned long long)bit1->action,
+		(unsigned long long)bit2->action);
 	fprintf(debug.fp, "pid      %16d %16d\n", bit1->pid, bit2->pid);
 	fprintf(debug.fp, "device   %16d %16d\n", bit1->device, bit2->device);
 	fprintf(debug.fp, "cpu      %16d %16d\n", bit1->cpu, bit2->cpu);
@@ -305,8 +307,8 @@ static void *blkiomon_interval(void *data)
 
 #define BLK_DATADIR(a) (((a) >> BLK_TC_SHIFT) & (BLK_TC_READ | BLK_TC_WRITE))
 
-static int blkiomon_account(struct blk_io_trace *bit_d,
-			    struct blk_io_trace *bit_c)
+static int blkiomon_account(struct blk_io_trace2 *bit_d,
+			    struct blk_io_trace2 *bit_c)
 {
 	struct dstat *dstat;
 	struct blkiomon_stat *p;
@@ -371,7 +373,7 @@ static void blkiomon_store_trace(struct trace *t)
 	thash[i] = t;
 }
 
-static struct trace *blkiomon_fetch_trace(struct blk_io_trace *bit)
+static struct trace *blkiomon_fetch_trace(struct blk_io_trace2 *bit)
 {
 	int i = bit->sector % TRACE_HASH_SIZE;
 	struct trace *t, *prev = NULL;
@@ -428,7 +430,7 @@ static struct trace *blkiomon_do_trace(struct trace *t)
 	return t_old;
 }
 
-static int blkiomon_dump_drvdata(struct blk_io_trace *bit, void *pdu_buf)
+static int blkiomon_dump_drvdata(struct blk_io_trace2 *bit, void *pdu_buf)
 {
 	if (!drvdata.fn)
 		return 0;
@@ -451,8 +453,10 @@ failed:
 static int blkiomon_do_fifo(void)
 {
 	struct trace *t;
-	struct blk_io_trace *bit;
+	struct blk_io_trace2 *bit;
+	struct blk_io_trace bit1;
 	void *pdu_buf = NULL;
+	void *p;
 
 	t = blkiomon_alloc_trace();
 	if (!t)
@@ -468,13 +472,14 @@ static int blkiomon_do_fifo(void)
 					"blkiomon: could not read trace");
 			break;
 		}
-		if (fread(bit, sizeof(*bit), 1, ifp) != 1) {
+		bit1.magic = magic;
+		p = (void *) ((u8 *)&bit1 + sizeof(__u32));
+		if (fread(p, sizeof(bit1) - sizeof(__u32), 1, ifp) != 1) {
 			if (!feof(ifp))
 				fprintf(stderr,
 					"blkiomon: could not read trace");
 			break;
 		}
-		bit->magic = magic;
 		if (ferror(ifp)) {
 			clearerr(ifp);
 			fprintf(stderr, "blkiomon: error while reading trace");
@@ -487,7 +492,20 @@ static int blkiomon_do_fifo(void)
 		}
 
 		/* endianess */
-		bit_trace_to_cpu(bit);
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
+
 		if (verify_trace(bit->magic)) {
 			fprintf(stderr, "blkiomon: bad trace\n");
 			break;
-- 
2.54.0

