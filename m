Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04653FB073;
	Mon, 20 Jul 2026 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546107; cv=none; b=ocWALZ/8YItjx9u25kOrRFAJuWd5MlNSfAyr7eJs0Jpj+MtVpP4BLAH2/bRHZYN4Tw26ux/ecqMnNyqejvaiQInnYUKGArDGo3w9n4ZUNTR/324N6zZT7bQ1zYAmv7VFXKc7dB9CVddUSvv4fE6eQ0DhmDAN1Lo/NapY4BdO0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546107; c=relaxed/simple;
	bh=KzpL2t2ju9FlYvfHupx7D+7Mz3s+pWgzl0rY4bxSQxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qY2x1drJ0Tk6GyB/XszKdndj7WKLvaC2aeWGNdbkLrS7HCShP3XcyGmEbk/AS7YdcYHAcggvRZ608U+7AxNavocMncFbraAWovT+jhAdm8hbraG47NPB13CGxiin0wWOKC4kw6r3QCBqy/wMDVhooPBMNDrpuKe5+RW09q+pMyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Sgfm4mXd; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Sgfm4mXd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784546105; x=1816082105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KzpL2t2ju9FlYvfHupx7D+7Mz3s+pWgzl0rY4bxSQxk=;
  b=Sgfm4mXdrknxMmMG7tUVU9+SWEgCeQYg15UyRVsTg0JsYJMBnM4hcRG1
   vWcfQxb8Y7cn9FNZQk/upCplNJZVs2+a5Bn50SkqNNIDuFFJdUKkUMxuF
   aJ9x4lw8RGHeavkpI1RRWwhh828kMghAlmC+5oWIVEgXIRHQJD13uJeB6
   12YPpQOTWZ37/7SU/fv8/8LjUxXo1jhwNMPh4RYc1iLCvNt21MT9XIdVn
   m4FGmzLJ1xp1W2ISxxmqt3KN10K1pXlQBAdVIyN8f2+k27mqnuyfF4P7U
   BB0Gu5o9DTsqO8tjAJX4yRJ0mAjfx3tQHXskmrK3056r+JwOdHbKJwVrx
   w==;
X-CSE-ConnectionGUID: i0UzzHD6ShOJIHXP28GCOg==
X-CSE-MsgGUID: oCgZVPkjQ5C9xjc9igNS5A==
X-IronPort-AV: E=Sophos;i="6.25,174,1779120000"; 
   d="scan'208";a="151105457"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2026 19:14:52 +0800
X-CSE-ConnectionGUID: sV9Uw/I3RVKhOU9DfpwMFg==
X-CSE-MsgGUID: OZ8w7r7TQw21h9Wd33LnRA==
IronPort-SDR: 6a5e0326_rqyfTUHotHUxz8gs/cOj8VBscyJk4A6CgW26TXR5qvud5CB
 hrWvlTg2rDSOlwKZc0BghHkReG1JF99nMKkISRA==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jul 2026 04:14:46 -0700
X-CSE-ConnectionGUID: 2mN/CW9UQVWUbN6Ems4UBA==
X-CSE-MsgGUID: OcScQk9MQC6m77LmjRdY7w==
WDCIronportException: Internal
Received: from wdap-kyufgunycc.ad.shared (HELO neo.fritz.box) ([10.224.19.3])
  by uls-op-esai1-o.wdc.com with ESMTP; 20 Jul 2026 04:14:44 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 11/11] blkparse: add option to emit a specific trace protocol version
Date: Mon, 20 Jul 2026 13:14:17 +0200
Message-ID: <20260720111417.1658507-12-johannes.thumshirn@wdc.com>
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

Add the '--trace-version=<1|2>' command line option to select the trace
protocol version of the binary output file. Requesting version 1 emits
the legacy 'struct blk_io_trace', while version 2 (the default) emits
'struct blk_io_trace2'.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c     | 64 +++++++++++++++++++++++++++++++++++++++++++-------
 blktrace.h     | 20 ++++++++++++++++
 doc/blkparse.1 |  7 ++++++
 3 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 76c775bfe30d..88ef019fba59 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -119,6 +119,10 @@ static struct per_process_info *ppi_hash_table[PPI_HASH_SIZE];
 static struct per_process_info *ppi_list;
 static int ppi_list_entries;
 
+enum {
+	OPT_TRACE_VERSION = 256,
+};
+
 static struct option l_opts[] = {
  	{
 		.name = "act-mask",
@@ -234,6 +238,12 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 'V'
 	},
+	{
+		.name = "trace-version",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = OPT_TRACE_VERSION
+	},
 	{
 		.name = NULL,
 	}
@@ -306,6 +316,7 @@ int data_is_native = -1;
 
 static FILE *dump_fp;
 static char *dump_binary;
+static int dump_trace_version = 2;
 
 static unsigned int t_alloc_cache;
 static unsigned int bit_alloc_cache;
@@ -349,14 +360,40 @@ static void io_warn_unless(struct blk_io_trace2 *t, int condition,
 
 static void output_binary(void *buf, int len)
 {
-	if (dump_binary) {
-		size_t n = fwrite(buf, len, 1, dump_fp);
-		if (n != 1) {
-			perror(dump_binary);
-			fclose(dump_fp);
-			dump_binary = NULL;
+	if (!dump_binary)
+		return;
+
+	/*
+	 * The traces are kept as 'struct blk_io_trace2' internally. When a
+	 * version 1 dump is requested, convert them back into the legacy
+	 * 'struct blk_io_trace' before writing them out.
+	 */
+	if (dump_trace_version == 1) {
+		struct blk_io_trace2 *bit2 = buf;
+		struct blk_io_trace *bit;
+
+		len = sizeof(*bit) + bit2->pdu_len;
+		bit = malloc(len);
+		if (!bit)
+			goto err;
+
+		bit2_to_bit(bit2, bit);
+
+		if (fwrite(bit, len, 1, dump_fp) != 1) {
+			free(bit);
+			goto err;
 		}
+		free(bit);
+		return;
 	}
+
+	if (fwrite(buf, len, 1, dump_fp) != 1)
+		goto err;
+	return;
+err:
+	perror(dump_binary);
+	fclose(dump_fp);
+	dump_binary = NULL;
 }
 
 static void resize_cpu_info(struct per_dev_info *pdi, int cpu)
@@ -3175,7 +3212,8 @@ static char usage_str[] =    "\n\n" \
 	"[ -w <time>         | --stopwatch=<time> ]\n" \
 	"[ -M                | --no-msgs\n" \
 	"[ -v                | --verbose ]\n" \
-	"[ -V                | --version ]\n\n" \
+	"[ -V                | --version ]\n" \
+	"[ --trace-version=<1|2> ]\n\n" \
 	"\t-a Only trace specified actions. See documentation\n" \
 	"\t-A Give trace mask as a single value. See documentation\n" \
 	"\t-b stdin read batching\n" \
@@ -3201,7 +3239,8 @@ static char usage_str[] =    "\n\n" \
 	"\t   If 'start' isn't given, blkparse defaults the start time to 0\n" \
 	"\t-M Do not output messages to binary file\n" \
 	"\t-v More verbose for marginal errors\n" \
-	"\t-V Print program version info\n\n";
+	"\t-V Print program version info\n" \
+	"\t--trace-version Emit a version 1 or 2 (default) binary trace\n\n";
 
 static void usage(char *prog)
 {
@@ -3298,6 +3337,15 @@ int main(int argc, char *argv[])
 		case 'M':
 			bin_output_msgs = 0;
 			break;
+		case OPT_TRACE_VERSION:
+			dump_trace_version = atoi(optarg);
+
+			if (dump_trace_version != 1 &&
+			    dump_trace_version != 2) {
+				usage(argv[0]);
+				return 1;
+			}
+			break;
 		default:
 			usage(argv[0]);
 			return 1;
diff --git a/blktrace.h b/blktrace.h
index ba062372f2c2..370e9218837a 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -129,6 +129,26 @@ static inline void bit_to_bit2(struct blk_io_trace *old,
 		       old->pdu_len);
 }
 
+static inline void bit2_to_bit(struct blk_io_trace2 *new,
+			       struct blk_io_trace *old)
+{
+	old->magic	= BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
+	old->sequence	= new->sequence;
+	old->time	= new->time;
+	old->sector	= new->sector;
+	old->bytes	= new->bytes;
+	old->action	= new->action;
+	old->pid	= new->pid;
+	old->device	= new->device;
+	old->cpu	= new->cpu;
+	old->error	= new->error;
+	old->pdu_len	= new->pdu_len;
+
+	if (old->pdu_len)
+		memcpy(((u8 *) old + sizeof(*old)), ((u8 *)new + sizeof(*new)),
+		       new->pdu_len);
+}
+
 static inline void bit2_trace_to_cpu(struct blk_io_trace2 *t)
 {
 	if (data_is_native)
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index 93aa44911142..80e7019fe771 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -151,6 +151,13 @@ Do \fInot\fR produce text output, used for binary (\fB\-d\fR) only
 Binary output file
 .RE
 
+\-\-trace\-version=\fI1|2\fR
+.RS
+Selects the trace protocol version of the binary output file (\fB\-d\fR).
+Version 1 emits the legacy \fBstruct blk_io_trace\fR, while version 2 (the
+default) emits \fBstruct blk_io_trace2\fR.
+.RE
+
 \-q
 .br
 \-\-quiet
-- 
2.54.0

