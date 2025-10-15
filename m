Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2724322DA0;
	Wed, 15 Oct 2025 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525910; cv=none; b=YO+RNpvjo3xAF/zb9jMV5FTAdXE8zmDg6kaf7diMcdzGVhuL/qJTBJraJs5HludJSInJSgigox2HvO93bLqOIkzIzbk7+CQOzFMS9REVCqGiGxOiZPySAZZTgeTL6MYSwp34QbytYYo+o1VUOyLkbyUrgZb8thOmpCuhKLbyvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525910; c=relaxed/simple;
	bh=3PwlDnU+EAqKj9sMbbYEs+RX83QTF/OGjCgZmULSM0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bi1raOxbtYNXsokUVAC9zYCDqyKsjSrP8H2iVS03xB1vL2GAqlzwJGEP3Dr1DqfF9N6ClOJSd4MGu0+B2+C9cKnoJLhHpwKlD8IWr4jwKBobyMZ+c/H1Wg7ePKBQAFkG+LRwq73z6QnnMF8fbwduOKLjh+dkDS6tbeunRWQ6eHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Lg8CEiSv; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lg8CEiSv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525908; x=1792061908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3PwlDnU+EAqKj9sMbbYEs+RX83QTF/OGjCgZmULSM0E=;
  b=Lg8CEiSvNkIRc5I3mI1OqqRhI15uVfkFrsNJVowC/NWNK5xQzJlAx0sB
   KtPa5JvK3/Y0yHDLWQHJ9OcEg0XP+QhhqZ75gfDIjxAEqZSOt4nIrV15S
   K9z/VFRNYFJQj6XuVKG0YsPb7aCt+KB73sSfHaAxoWmFWtZJos/1xD3i+
   HyLn+vGOiziZuHu8IRh4ehrVt9Yz6Wg15mJFLgEQfINU9nyq5xwiQEMQA
   E37IJikYis6qGqKedJCCWrPuGIdg4VkbWX0a/9DXAUHVaIBDQyOm0G1DG
   g3N+2tWKvk5EiDU8kZDCEGQleA6ow6+vg4G2NPjV3pMGwLDc5OMZ4mojJ
   g==;
X-CSE-ConnectionGUID: prFjiMSJQoqR2RHIZETAZA==
X-CSE-MsgGUID: ERvUshQOSYOnwy5TGOaQGg==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935424"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:58:28 +0800
IronPort-SDR: 68ef7e54_OTSmKiIbos6OHUbZbwES9NqvOcqkD3URq6XQeg36AZ/UTcE
 Ckb/68d2FU1qONsggUjxfIvsrpFbskhBVvX+hzw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:58:29 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:58:25 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: axboe@kernel.dk
Cc: chaitanyak@nvidia.com,
	dlemoal@kernel.org,
	hare@suse.de,
	hch@lst.de,
	john.g.garry@oracle.com,
	linux-block@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	naohiro.aota@wdc.com,
	rostedt@goodmis.org,
	shinichiro.kawasaki@wdc.com,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH blktrace v3 18/20] blkparse: parse zone (un)plug actions
Date: Wed, 15 Oct 2025 12:56:56 +0200
Message-ID: <20251015105658.527262-19-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
References: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse Zone Write Plugging plug and unplug actions in blkparse.

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
2.51.0

