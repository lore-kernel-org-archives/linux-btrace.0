Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F2E31BC85;
	Thu, 25 Sep 2025 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812752; cv=none; b=sahYWaS2+Sg6ZebyPUchs/fehiT+QAhfzMCKaMXllNS9culbD1EKJjjZylK+WaC78vM+tNq9tSA19CKoSrj0VN1U3gYNn/vyq11G7IBb2UHaJ6p89PszGlI5klXUwhzqUI2d4PVkbRl+KsSCa7zyc7qm7LaBUuakurGNRS3SOEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812752; c=relaxed/simple;
	bh=dwSC2RUaoe2h7mxl9M76u72coZTYQrXJJJUqu250P/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiyyTAqgLD20mPtWkTGDh1xDcg5/B3dwExWs0cgNUsBr0qVehk+SKv+zSLvGxHo6qwKxggwe2vda2p/h/SetKlAYbIBXfRk/fdtNvRH1QhmTuxJQXuYKkl6iDwJDvmvsJNahU0Q4obaqwMOqx+NYU2pJ6yYfGeFmd9wHZCZAc/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UdbUER4r; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UdbUER4r"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812750; x=1790348750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dwSC2RUaoe2h7mxl9M76u72coZTYQrXJJJUqu250P/g=;
  b=UdbUER4ry63au2FFClkCYfj7lxkrznXF7kqI3cIeYPXOFMckajYM19ru
   NewKWPcs3LvJk0s4XJSY+cELNFRllNPlf4npBSO/GiYxAGSlnZ7aV0vu0
   Q9kS4Wq6TGyxzDvOVXgfKC5UZYD+/DP9XV+/MNY9A6WHwot5P2wsD4q0o
   ijsQRzUbtlePH1iZSHe0WzzZpuwFucObFEvcNdD3KRxKEQoXJtBc5xMxc
   q4MI37MsW/UxrpqkYqp2DmKl4y2VDPDkBsYYWz4BBo7P5s42O7tVs9Rl1
   qwAzy21+2dbEmtq5jqs15EkKTYFQH8R+kAYw9ms3oj7gjV0lkY9UlAzi+
   Q==;
X-CSE-ConnectionGUID: 0LEPHdu4QNq3KTVH/CwfkQ==
X-CSE-MsgGUID: ID4meerNSqC49VrJb1lpNw==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130349532"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:05:49 +0800
IronPort-SDR: 68d55a4e_/3DSHwPxmqzYkBKFtk5LXa5c1pJAvsvGZj+Q9SIMnAyyaGw
 AJiUh35DkbDKFS8Ctqw2F+PWuYLONglFa68d6Vg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:05:50 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:05:47 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH blktrace v2 18/22] blkparse: parse zone (un)plug actions
Date: Thu, 25 Sep 2025 17:04:23 +0200
Message-ID: <20250925150427.67394-19-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
References: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
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
index bbf075f..3966e1a 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -62,6 +62,8 @@ enum {
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

