Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B39540A957;
	Thu, 16 Jul 2026 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784199926; cv=none; b=eDD58oOOoe57cLwXjsPBfIzTeyJ2bhCxC8mzgE8O+gd6Y6FuQVltujVIg8e1+g3gAk0+zIJAHmAbqGR/x47mifAfK8wuhq/RMVAqj+MrzralqtwIzLd/j80OEanWJmVB1pi7HLh0bS5lq/SrKolNRdmZ9V/jH4o+VkaBTjFTT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784199926; c=relaxed/simple;
	bh=7Wy9bNDCQbGUAs2qYqaAljowfeHpz1RilKxphThe8E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsdJjrQE/ogzv5uG3Axpqjs/ZnPtL7KKHkiHb1jzP7LLjc903G4hizrsCKlQb1rQzwwRo5nqwaw6iMxhAPfvbfCuWmaM2udHJagCUYKt6I1VDEXZLkvVbVCWwd214X/2q21fEZBL51Dtnzi2YisDuaZRbKtWhZg6ahq7sXkQI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=r7TJpSue; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r7TJpSue"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784199924; x=1815735924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Wy9bNDCQbGUAs2qYqaAljowfeHpz1RilKxphThe8E8=;
  b=r7TJpSuem+C9ajHfVR83cIZu4141HD6btRNRevFRmgt4bTBZ/lCxOoQH
   Ldr3QS+M1zr2hTbwiWCK1LL/f6uFnGqDvboD4Iy4ihdwnYQU9iqmkjZTA
   8HflYyrlGJER4tVERHT18W/UiIMrcD0SBj9wakRCKuk1XPc02VXyzYltQ
   JgOnSd5ejL0KNeWTJwDHdKqKwKisWfGQvb59h31Y9r1avmAPuWkG9hX1p
   hPOOnyRHIe2bmMxq8DOXlHV4NTQZmjmFeUgD+6wB/PEvS1dULyCexS0uv
   tEd5WI6UJpn+dMGQ8TukgL9MeQNp0CNVV9s3YUb/Y1w2/PkXRNIwGf0ML
   A==;
X-CSE-ConnectionGUID: LAgMG0rlTumyEzqTrOrR5w==
X-CSE-MsgGUID: Pl0JQ+K2R2ulNIldiZMPCQ==
X-IronPort-AV: E=Sophos;i="6.25,167,1779120000"; 
   d="scan'208";a="146986479"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2026 19:05:19 +0800
X-CSE-ConnectionGUID: 6PsaAv1YT+uDT71mNd2O9Q==
X-CSE-MsgGUID: SoKbV1fTTdK8Tc712T4wiw==
IronPort-SDR: 6a58badd_BkXj+sgksHPhbc3bSsTJjC1gom20G1dj3mMsL6kStqQMS/N
 mUf5IHws3aIh5cjoKzZTyTbJ2QqJPVR4ta+zt4g==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2026 04:05:01 -0700
X-CSE-ConnectionGUID: Xm6st+KEQ0S1DUIL4W/4Yw==
X-CSE-MsgGUID: 4yw6JrGxTcG/1fWMjoYSoA==
WDCIronportException: Internal
Received: from wdap-fln31fg1cp.ad.shared (HELO neo.wdc.com) ([10.224.28.153])
  by uls-op-esai1-o.wdc.com with ESMTP; 16 Jul 2026 04:04:59 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 06/11] blkiomon: use blk_io_trace2 internally
Date: Thu, 16 Jul 2026 13:04:37 +0200
Message-ID: <20260716110442.1291010-7-johannes.thumshirn@wdc.com>
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

