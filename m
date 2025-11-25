Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AF22F6180;
	Tue, 25 Nov 2025 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057157; cv=none; b=ACJBTai+PKuYPpHhNf/Bu4mK5gS3j8CU5Y+ylGnFNmrYXHnWgkXjblwb+jY/0Di6c4XFYF5ml1sOuopIO3WenFyPu+yVkBdSs2BWdJ8YgxC6vqDiJfWDB3w9AXeQulokIlreeJ8/X63u7RU9lnuqYCK66T60HgwZxLH8MKcS3YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057157; c=relaxed/simple;
	bh=oPqIJaGcja+MF+OKuawSaRjN29dqM+eqPnwV0ycYl1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSKWBIPS6o5V37JZ7Z1Q91MkuPmbG1W6GCDkz7VKoz/p04g7cr6bECv2EO2Ewd2S++JCkZbKFHAxp09PnGNeAM1nRrAzPAOnegThRo7sRk/jKAF2LYpZV515tMpp0iUggOyOBFDWLMBL0pMoWuy4Q7SxipVKf+Yb9/ASqnIuE5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JXLFSIRd; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JXLFSIRd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057156; x=1795593156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oPqIJaGcja+MF+OKuawSaRjN29dqM+eqPnwV0ycYl1A=;
  b=JXLFSIRdGzXIUEfLwj/ThQD6JEBPf0o/PKBYgpgzk/hzKxKANktOcNeS
   nduq2D3G53CXuUcSNV1umJ6EepZyra1E6ALc6Y8Caj3ZPRS7U6S3rAybA
   x2+0i4UAbgW46u729wJVDGr1mVHKnxQL9CmhBO/NNaaSGChvbX3Vf0UFU
   3YTXMNv8stMsmZLlL0U4aDIczq0k5pgBpyPq2Lgam+ghPQBeDSgpTEldM
   D3h0GWyP5yEJWJDVeumQyNrFjw4ejXZvPHPOt0ZdofjXAmtvQ6DbjNLGg
   Y+Zzkx+ATz1G/oVsppSWvrjiYCg07gh70e55jJitVDNhXcI6RoyC89U7+
   g==;
X-CSE-ConnectionGUID: lFjVLVXGSqKGmJXpPhtnIA==
X-CSE-MsgGUID: 5E7SregjRv+YRkvJZbp6zw==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749822"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:36 +0800
IronPort-SDR: 69256044_hkNeqUcSmXsFtoYOj0yEPijqf29SGjolYkZerX+1++1gG6S
 cmLZ7sl+ZLvXak/+4ciPA3nOQgmZTVLtwha1xYg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:36 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:35 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-block@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 17/20] blkparse: parse zone (un)plug actions
Date: Mon, 24 Nov 2025 23:52:03 -0800
Message-ID: <20251125075206.876902-18-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
References: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse Zone Write Plugging plug and unplug actions in blkparse.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c     |  7 +++++++
 blkparse_fmt.c | 18 ++++++++++++++++++
 blktrace_api.h |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/blkparse.c b/blkparse.c
index 2eec3a9..76c775b 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -1722,6 +1722,13 @@ static void dump_trace_fs(struct blk_io_trace2 *t, struct per_dev_info *pdi,
 			account_unplug(t, pci, 1);
 			log_unplug(pci, t, "UT");
 			break;
+		case __BLK_TA_ZONE_PLUG:
+			log_action(pci, t, "ZP");
+			break;
+		case __BLK_TA_ZONE_UNPLUG:
+			account_unplug(t, pci, 0);
+			log_unplug(pci, t, "ZU");
+			break;
 		case __BLK_TA_SPLIT:
 			log_track_split(pdi, t);
 			log_split(pci, t, "X");
diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index f93addb..80e02fc 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -301,6 +301,21 @@ static char *parse_field(char *act, struct per_cpu_info *pci,
 	return p;
 }
 
+static void process_zoned(char *act, struct blk_io_trace2 *t, char *name)
+{
+	switch (act[1]) {
+	case 'P': /* Zone Plug */
+		fprintf(ofp, "[%s]\n", name);
+		break;
+	case 'U': /* Zone Unplug */
+		fprintf(ofp, "[%s] %u\n", name, get_pdu_int(t));
+		break;
+	default:
+		fprintf(stderr, "Unknown zoned action %c\n", act[1]);
+		break;
+	}
+}
+
 static void process_default(char *act, struct per_cpu_info *pci,
 			    struct blk_io_trace2 *t, unsigned long long elapsed,
 			    int pdu_len, unsigned char *pdu_buf)
@@ -429,6 +444,9 @@ static void process_default(char *act, struct per_cpu_info *pci,
 		fprintf(ofp, "%*s\n", pdu_len, pdu_buf);
 		break;
 
+	case 'Z':	/* Zoned command */
+		process_zoned(act, t, name);
+		break;
 	default:
 		fprintf(stderr, "Unknown action %c\n", act[0]);
 		break;
diff --git a/blktrace_api.h b/blktrace_api.h
index 04e81de..8db24fc 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -60,6 +60,8 @@ enum {
 	__BLK_TA_REMAP,			/* bio was remapped */
 	__BLK_TA_ABORT,			/* request aborted */
 	__BLK_TA_DRV_DATA,		/* binary driver data */
+	__BLK_TA_ZONE_PLUG,		/* zone write plug was plugged */
+	__BLK_TA_ZONE_UNPLUG,		/* zone write plug was unplugged */
 	__BLK_TA_ZONE_MGMT,		/* zone management command was issued */
 	__BLK_TA_CGROUP = 1 << 8,
 };
-- 
2.51.1

