Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CBD40EBA7;
	Thu, 16 Jul 2026 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784199928; cv=none; b=RsN3GpuUr43k/lUp11UJSW6Uy+d9nzrqXndAq0FVNq/EOrYeq4+nViH/NJmLcE2onfRnBcVQ+4o7U1lOfP+IK06wkMimOEPHcRNn5Vr5LjHYR1MxKsNWaCvWy7/x5ef5v+OarMcTExJnKayLDGJ6BuhnSci1K1xqMJ7dSeGuImo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784199928; c=relaxed/simple;
	bh=qJkDWzWUkPh8Kwy7gH1FUGy+kR5J9DAJnKd8+CKSORY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqHhF/E/T6khyXXw+ZsgWNyiSs5APqVrizYUo/Tn7kVfZoKCGO5C57Lo+7Ne7njMk1y5MkGY0c9DX9wXepscr+xFoJUAQam+8l+W6by67kOtgTn4LO+xQk2cysBHap+FDzNMVjzf0Zz7NbCDDhj3/fDZJzyhTZsqsIIjP1zP7tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OUEahc0V; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OUEahc0V"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784199926; x=1815735926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qJkDWzWUkPh8Kwy7gH1FUGy+kR5J9DAJnKd8+CKSORY=;
  b=OUEahc0V8BcbfOj4pQZbn5QdBsJ4sbx+e7cFquKxd4Bz6YghTicswCF8
   cEiKZZGA9O0uImypyU2YVvuqerBqvZ1wCv0ZhAcZ39t60YjjE3MzmelZg
   9HMyKQ81v9oClMYXJWuiNL4IScLr3xHD57thlTA1kDE+HkkSUy/TDAAZ8
   xJ27kQC9GhK7HtMjoaBKcyAGSAMPLgejMDu/z+ddYzx8lveFUveyeL1+o
   IHuVsQMvEjlfLjpMtT4w46/51VxWbRTxZlMIgDjxXXw4bAmAwYry59wLn
   IpYJNyrv5dcyLGNQ42N2//oY0de9qnyeRgO5MaM1C1/CcD2j58Qojs3j3
   Q==;
X-CSE-ConnectionGUID: LdXsinLvRUSKujFIMiD8Pw==
X-CSE-MsgGUID: 365sRzdtTSSdC8SRxSyl4A==
X-IronPort-AV: E=Sophos;i="6.25,167,1779120000"; 
   d="scan'208";a="146986483"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2026 19:05:19 +0800
X-CSE-ConnectionGUID: KR/tYmwpRBCw5BSCrGCGSw==
X-CSE-MsgGUID: ogCx8M7jTWmDWQjnUFRewA==
IronPort-SDR: 6a58bae6_0EMN8Sio05kdMGcuoEI89NRJMaYzSfbyfhbSYX24jxGta9t
 uccWyg77hlcRZZopXIU+FfAxS6+CwntcvCwo8sA==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2026 04:05:10 -0700
X-CSE-ConnectionGUID: 7YuM/MtISyyDHDhbvk7O3g==
X-CSE-MsgGUID: CqjpgpF1SyyrjB/kgS3Uqw==
WDCIronportException: Internal
Received: from wdap-fln31fg1cp.ad.shared (HELO neo.wdc.com) ([10.224.28.153])
  by uls-op-esai1-o.wdc.com with ESMTP; 16 Jul 2026 04:05:08 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 10/11] btreplay: support blk_io_trace2 in btrecord
Date: Thu, 16 Jul 2026 13:04:41 +0200
Message-ID: <20260716110442.1291010-11-johannes.thumshirn@wdc.com>
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

Read the 'magic' portion of the trace first and then parse either 'struct
blk_io_trace' or 'struct blk_io_trace2' depending on the protocol version
of the trace, so btrecord can process both trace file versions.

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

