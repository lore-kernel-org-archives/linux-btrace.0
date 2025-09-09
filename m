Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B672A3218DF;
	Tue,  9 Sep 2025 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416035; cv=none; b=VIwSEXFUrEU1i/iY6tDhHA13ryJYBjv+it12nuxpvYb5j/itmu/W7zvOPoBGBj3Ht/0X+wLtCKL90pb8I/zHTgtRcYDymAQFDHA3qn0JmN7NqYcljjmrpJLv/0yl2RxOj8KcB3dreqM6VRWXP5dOjthxRbCdLRclZzp8XR2iA6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416035; c=relaxed/simple;
	bh=+QFmlXVEpiW4JKH1FtB3NrBB+lEsmo15zfarP+RRCds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uqj9s4t1HbySoMZQiJM+STuE5jwpjBoo5VAfBLvHiO74IhT/t3FjAiGTjtXZwutGNdvKakOyhqgcp5l9gOLA96/PIdqb+I6m4Jwn+xNkU+L4Q46kxjrPV7uqA2R6XkZZ69LKeabA9cWCfQkx2KY8fPd97OmJLIqj5NYkDtmEDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V/zW033b; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V/zW033b"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416034; x=1788952034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+QFmlXVEpiW4JKH1FtB3NrBB+lEsmo15zfarP+RRCds=;
  b=V/zW033ba0cD0//Yg7ziBo471BcGjxH84nxVE0OOUMznB9T4kX/lBIGE
   VkXiz3F8yLnuPm1BB1fnWFYEgWitmw2ZeW524FNRC7+VYZd7UTi13N9Yx
   wgrbT/qV+pm9ZP7pIQAZwCOaUxtyYlN/IANwETT0UksQ30LOSVZMD7j4s
   sIdHk7ovSQFk9IziZHnUomuNVsxVfuaempjj7wIxYWMWKTYKd1ofcO8ii
   LCsnzeChv0VVnUR73Jmitm2NOR39WMgtNH72cvqfvGYk6rhOG0SQQISN3
   D6j1hLPMXW3Qb926l7ZIMx+OnkkQaakuU6i67+jXqnHU9fyJerJi5NRa+
   Q==;
X-CSE-ConnectionGUID: 34GzjRi8QCep+5PjuRBN0w==
X-CSE-MsgGUID: KqC6FBqfT+6tJn3xSWxRSA==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810173"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:07:13 +0800
IronPort-SDR: 68c00a61_sdBWZzDU61BYMdy3EnRaR0OAJ5m8JFx1rNKQxv05bP4DrfZ
 3XMgUSHP+xCxeX28RMpvtxP2jXQHa9ecjapct/w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:07:13 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:07:09 -0700
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
Subject: [PATCH 12/16] blktrace: add block trace commands for zone operations
Date: Tue,  9 Sep 2025 13:06:07 +0200
Message-Id: <20250909110611.75559-13-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909110611.75559-1-johannes.thumshirn@wdc.com>
References: <20250909110611.75559-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add block trace commands for zone operations. These are added as a
separate set of 'block trace commands' shifted by 32bit so that they do
not interfere with the old 16bit wide trace command field in 'struct
blk_io_trace' action.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 11 +++++++++++
 kernel/trace/blktrace.c           | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 01779f84d09f..d5047467c8ee 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -29,8 +29,19 @@ enum blktrace_cat {
 	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
 };
 
+enum blktrace_cat2 {
+	BLK_TC_ZONE_APPEND	= 1 << 1ull,   	/* zone append */
+	BLK_TC_ZONE_RESET	= 1 << 2ull,	/* zone reset */
+	BLK_TC_ZONE_RESET_ALL	= 1 << 3ull,	/* zone reset all */
+	BLK_TC_ZONE_FINISH	= 1 << 4ull,	/* zone finish */
+	BLK_TC_ZONE_OPEN	= 1 << 5ull,	/* zone open */
+	BLK_TC_ZONE_CLOSE	= 1 << 6ull,	/* zone close */
+};
+
 #define BLK_TC_SHIFT		(16)
 #define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)
+#define BLK_TC_SHIFT2		(32)
+#define BLK_TC_ACT2(act)	((u64)(act) << BLK_TC_SHIFT2)
 
 /*
  * Basic trace actions
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 82ad626d6202..62f6cfcee4f6 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -333,6 +333,24 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	case REQ_OP_FLUSH:
 		what |= BLK_TC_ACT(BLK_TC_FLUSH);
 		break;
+	case REQ_OP_ZONE_APPEND:
+		what |= BLK_TC_ACT2(BLK_TC_ZONE_APPEND);
+		break;
+	case REQ_OP_ZONE_RESET:
+		what |= BLK_TC_ACT2(BLK_TC_ZONE_RESET);
+		break;
+	case REQ_OP_ZONE_RESET_ALL:
+		what |= BLK_TC_ACT2(BLK_TC_ZONE_RESET_ALL);
+		break;
+	case REQ_OP_ZONE_FINISH:
+		what |= BLK_TC_ACT2(BLK_TC_ZONE_FINISH);
+		break;
+	case REQ_OP_ZONE_OPEN:
+		what |= BLK_TC_ACT2(BLK_TC_ZONE_OPEN);
+		break;
+	case REQ_OP_ZONE_CLOSE:
+		what |= BLK_TC_ACT2(BLK_TC_ZONE_CLOSE);
+		break;
 	default:
 		break;
 	}
-- 
2.51.0

