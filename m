Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E17340D9A;
	Tue,  9 Sep 2025 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416140; cv=none; b=aosFBaO+BcPL+I+H4bFHNsuphaKx0I+cTig8876GhBj29fhyWWHoeSyMduauo3pkTUw+UVS8u7VIMJSjyTFZ2F/Q/ENnzZxMq7H3+B08pcKw6NygVR02gdx+1EhvADs+4uQzFVAaPuHacYpax7wum6bYZMtEfaQ+MEWxnIxUIWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416140; c=relaxed/simple;
	bh=sjy38NosnkftCFgQpo0IL2SdDw0IwlgiBVJt2eW9nh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nX5n6P7lwUtVQjS0XTr9zp2q7Hs5qgswWhWLr70VF7+ZSfTaK+3gEjlcS2Il055vhgJgJUlOYiQuCAk9H826CML//hTRywKjVNmLxOMBjsfSe0JHmQ159KE9VvFXrYQiQBLZ4OTiQQwiYfX7+me2PH13LGxgMH4b8KwY+bYfKdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JzdqHa/l; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JzdqHa/l"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416139; x=1788952139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sjy38NosnkftCFgQpo0IL2SdDw0IwlgiBVJt2eW9nh0=;
  b=JzdqHa/l4bRRELodtVi7GNNmPnapRz20kLzorRyN3WB/PDR1szXYXLVe
   qX+qoPvG4c8lxNZUiWGmsZB6SHrJky7pzdsWAI0WDzeGkoFcFTxL7DAvE
   sD4sWk6aw+X2eUww6b0jDtzteafwAHTNSmWYCRp06FrjIUw2GP1iyHOed
   ctxBvZaQG5SXP6qa+CK5jDdHQ94muAB40uvpnkdozm8E65V8YExNBgHgD
   o0Mrtm87JoJMOtVW73HExkwLGtSUGycz3dScb3cdaU5ehJHIh6xx9sgwU
   aVRAkfsEw+o4jnFokWziRKhZpYrpWfMDBgium4w4vCzJBshkZYQx+SXOf
   w==;
X-CSE-ConnectionGUID: AJN5zDhbT8uymMklZ/lssw==
X-CSE-MsgGUID: +q5IZHMnTlWfrnosM3LO1w==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810950"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:08:59 +0800
IronPort-SDR: 68c00aca_MHIqvl1aNDPXfPdRMjTwkMjkpCrB3qPC6t00OIkEV2jry/n
 kzK1hrDzGxgafn8h09rn/zLwoaFe2LreCxDlTaA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:08:59 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:08:54 -0700
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
Subject: [PATCH 20/21] blkparse: parse zone management commands
Date: Tue,  9 Sep 2025 13:07:22 +0200
Message-Id: <20250909110723.75676-21-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
References: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse management commands in blkparse.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/blkparse.c b/blkparse.c
index 1a372e5..1e3718b 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -1651,6 +1651,9 @@ static void dump_trace_pc(struct blk_io_trace2 *t, struct per_dev_info *pdi,
 		case __BLK_TA_INSERT:
 			log_pc(pci, t, "I");
 			break;
+		case __BLK_TA_ZONE_MGMT:
+			log_action(pci, t, "ZM");
+			break;
 		default:
 			fprintf(stderr, "Bad pc action %x\n", act);
 			break;
@@ -1729,6 +1732,9 @@ static void dump_trace_fs(struct blk_io_trace2 *t, struct per_dev_info *pdi,
 			account_unplug(t, pci, 0);
 			log_unplug(pci, t, "ZU");
 			break;
+		case __BLK_TA_ZONE_MGMT:
+			log_action(pci, t, "ZM");
+			break;
 		case __BLK_TA_SPLIT:
 			log_track_split(pdi, t);
 			log_split(pci, t, "X");
-- 
2.51.0

