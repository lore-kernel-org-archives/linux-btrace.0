Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA822D6E4B;
	Tue, 25 Nov 2025 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056314; cv=none; b=iBJVmR4FYPhB3Bbb22kbiQHNbB66RG4KuYB+HWiOJqEGYKO1HUcLgWBESMwyFi5IcOERwZKGduLvim+qqBfJZpKRfY0YD3CYyRTd3/CA05XO19/wfqpXvRe2M+d2HiQKX2XeeYKIfFrfzurnVWOmAAOzDEcpLF5nSwqPgrPWVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056314; c=relaxed/simple;
	bh=oPqIJaGcja+MF+OKuawSaRjN29dqM+eqPnwV0ycYl1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrGxn/YAxpPpp8R+kbGq5nCkLsYYlzIVLPASB3ugJl6ZgjXK5scdMqWsSX06sei9N5RfgZ7p9ri8cFXcyCkcNepvFRunoePW3AtYLSRP1e4R9DEMyPAvMUCmexrsnD9zUlDxeBUREJX0KiAPhFWK3gQ9kseN3QeymkcMX12azHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mVlmSuCg; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mVlmSuCg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764056312; x=1795592312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oPqIJaGcja+MF+OKuawSaRjN29dqM+eqPnwV0ycYl1A=;
  b=mVlmSuCgV5dCpwKjPHdmlDhmd6GFfWUgFfdg/Cbg/084MNL+ukkN0EjL
   jvJy2pmaBo1mpP1/5iPLacZBR3W12pJl3ZWorZWEj9Z4uVBdS6jjuKC3w
   pPlH8zyzSmqUaprVrBIGW9Ff/WmeIBn33YXDdHQdONXJcVkU149ISGRYe
   i3vzP6lpxJdony+se0GGl6LAO6G8bo4jzR967c8ILdaDlHDUVDcmI9kKg
   /PtPcebQcOdmiTRBPVDy0JW6y1p+ce7ANvkV5b0BJA5zJT/Of1uFe12uQ
   2XwfvL1g1eMj9XDLYo2ChasF1+SJZ1KequjyP/L6Nb91XtblQuoe8C5Ir
   A==;
X-CSE-ConnectionGUID: e6Ar4C3TRqWQmjXHTr2VnA==
X-CSE-MsgGUID: 2ATOq9ZdRA2hPcJAPfyX2g==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="132688774"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:38:32 +0800
IronPort-SDR: 69255cf8_uFMlS0tGl4N8iGLIOlAhzcZnxbS33gvEGDxNAy6RwVUv0xL
 ToIqLdr26lKJnvgRhBmCamvoTVIs77FV1fx+J5Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:38:32 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:38:29 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-btrace@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 17/20] blkparse: parse zone (un)plug actions
Date: Tue, 25 Nov 2025 08:38:03 +0100
Message-ID: <20251125073806.50762-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125073806.50762-1-johannes.thumshirn@wdc.com>
References: <20251125073806.50762-1-johannes.thumshirn@wdc.com>
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

