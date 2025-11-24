Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D542E92BC;
	Mon, 24 Nov 2025 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969931; cv=none; b=SSCRDRQ7ULYt8ek7JIPMFWcrxjhm8vwNs5wKftVBU+IIXlDUo8f/3WP4Huql5nLhKX1V0E0aSkHt/n1ZmhT5u5YABqeehFSsTMvWBKDKb9H52+Lbwu2SdJjLKcnpOkd7JJZ+OEnQvZ8bh2zaaPfRbGlU6coX+Wjhc9XKnvYesAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969931; c=relaxed/simple;
	bh=3PwlDnU+EAqKj9sMbbYEs+RX83QTF/OGjCgZmULSM0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVZ67FTh9VlxsViDRlmmNVDtRURqW/YvXf8AaqnsFZqbmamyAe0qaazyrrJ+aIKfXS718DLFie0q3OxLTX3OfZX8THWLyusae/eK5A4Tpo/Pr6p+dVJLft3s9pMI9XiikN918N/eFeb3bH1xWQbrg/6xj61pYaT3lRufn0B3Ihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WAz9V+sZ; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WAz9V+sZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969930; x=1795505930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3PwlDnU+EAqKj9sMbbYEs+RX83QTF/OGjCgZmULSM0E=;
  b=WAz9V+sZA/Gu379bjLakxSFRysbDhtpk0KndIQZXBRweAMmt6KaElhvF
   NmryyXBHcyphhSFxsMaLn/TPPAv9+zkUsyR40zVxyf9mVaY+t1I7M/e3y
   cHRVFhUHVSqY1ou0xfbqcheA9+wdeNr8KDKqnvopAOAI/fN5itD4WFQ7Z
   Zg521ZLqbcptiJocfwfto62JyfWEQsZCMftfHxVYwnMthmflwBTf2E38l
   bgVQAdYnA01ebp9Jbxr3UGng2ap4WLd19hiKxTkXX+EjclSkmEEVksN9l
   HxKSCdN+j2hISPK7A/XXInbrkaRykUv+wNFuJNvCvHGgsCy7Zws8bCXNx
   g==;
X-CSE-ConnectionGUID: TqmloI9JRI2GsxGwSVwfgw==
X-CSE-MsgGUID: bbwUjtO4Q7m14qcC+mxVDQ==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619391"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:38:50 +0800
IronPort-SDR: 69240b8a_me+ZcSYIKOD5oTcrhtPC0vkyHZK1IYvLe5oUgZR7whWV0rI
 kk/vFVtabIlxZLvhOlJKBU5j9EU4NRdzwy/v5yg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:38:50 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:38:47 -0800
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
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RESEND PATCH blktrace v3 18/20] blkparse: parse zone (un)plug actions
Date: Mon, 24 Nov 2025 08:37:37 +0100
Message-ID: <20251124073739.513212-19-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
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

