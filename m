Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE652E3B16;
	Thu, 25 Sep 2025 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812756; cv=none; b=GjOm5BZnA+jg9rPn/p2CXvPZl6q8fr2hT2qEa/60DteRZx/Y07nJAlxIRdS1nnPigicU+8JnT/ja4M9ippIDcVw5viOVuTNuxpWKsgWTDEEVTZbtcxrf1UhxBmgdnq3iZ472Z0G5OenvBik2uPHd05Mfg5iLbGjCh6gMDIoD3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812756; c=relaxed/simple;
	bh=0rGeO4LjFLt4NYO1/jwlV1gV2d5eicuuveoHWszrAJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Er5y30YaY2JTgAxwI7A02L/w8BnOaDkb8ihncEdnLEYeorqs1ZXJ45a04JWKSfrV5pzS9cQqNSbrrsHK96YSICoch95P8d4yQkxSp1QbuboqFZqMJ80XsNP8WtSssCsPKX98C/MSdvd0vpprrwE8SBGnUDgFkciDMuUinX+5N5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UkkfFYMQ; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UkkfFYMQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812755; x=1790348755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0rGeO4LjFLt4NYO1/jwlV1gV2d5eicuuveoHWszrAJw=;
  b=UkkfFYMQ9pVNyYMloX8Z7Vrh/Lay14+7/CIKRDcexA18kKBRmGiR/VDt
   RO4GoMqBKCa7MjTnLHcUvQi1hLgl0qvnpCsJ3jfGZMhdBFOCxm1CJZ+lX
   mDiZGlhrzPEnUUopo+8Pl715xmwnRPCW6jJ1G63JZ8Tq1je65Uj1VIzhu
   aojeDiXMfnqvzyqWt/Kl5GETaPnP8n94LNdlHCp+sUFaqfwDg7HZPeoP9
   s2JiE7DzmDbbJ/Z67H2t/GHdUyftIx3yxdpDDPyC2+Bq8YgPba55EYwTk
   53AllyXDoVKADy0S1Y9EkPlt0EjTaJUqBjISvRnU5iIX+qC9WsG35RIpK
   g==;
X-CSE-ConnectionGUID: gB6KIVwmQkSsomesqrsXsA==
X-CSE-MsgGUID: 6Xwc4qm4TuiDI30G6KVQ9g==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130349592"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:05:54 +0800
IronPort-SDR: 68d55a52_QNqtsTqiHsWonTOK1cAplseMiMcy1JydSYrdu/GeAkVZWpg
 oH7ocM4dY9bVWulYP4A5VwCP53dGAxwJ3iqcieg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:05:54 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:05:51 -0700
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
Subject: [PATCH blktrace v2 19/22] blkparse: add zoned commands to fill_rwbs()
Date: Thu, 25 Sep 2025 17:04:24 +0200
Message-ID: <20250925150427.67394-20-johannes.thumshirn@wdc.com>
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

Parse zoned commands in blkparse.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse_fmt.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 80e02fc..2767edd 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -60,19 +60,45 @@ static inline void fill_rwbs(char *rwbs, struct blk_io_trace2 *t)
 	bool d = !!(t->action & BLK_TC_ACT(BLK_TC_DISCARD));
 	bool f = !!(t->action & BLK_TC_ACT(BLK_TC_FLUSH));
 	bool u = !!(t->action & BLK_TC_ACT(BLK_TC_FUA));
+	bool za = !!(t->action & BLK_TC_ACT2(BLK_TC_ZONE_APPEND));
+	bool zr = !!(t->action & BLK_TC_ACT2(BLK_TC_ZONE_RESET));
+	bool zra = !!(t->action & BLK_TC_ACT2(BLK_TC_ZONE_RESET_ALL));
+	bool zf = !!(t->action & BLK_TC_ACT2(BLK_TC_ZONE_FINISH));
+	bool zo = !!(t->action & BLK_TC_ACT2(BLK_TC_ZONE_OPEN));
+	bool zc = !!(t->action & BLK_TC_ACT2(BLK_TC_ZONE_CLOSE));
 	int i = 0;
 
 	if (f)
 		rwbs[i++] = 'F'; /* flush */
 
-	if (d)
+	if (d) {
 		rwbs[i++] = 'D';
-	else if (w)
+	} else if (za) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'A';
+	} else if (zr) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+	} else if (zra) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+		rwbs[i++] = 'A';
+	} else if (zf) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'F';
+	} else if (zo) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'O';
+	} else if (zc) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'C';
+	} else if (w) {
 		rwbs[i++] = 'W';
-	else if (t->bytes)
+	} else if (t->bytes) {
 		rwbs[i++] = 'R';
-	else
+	} else {
 		rwbs[i++] = 'N';
+	}
 
 	if (u)
 		rwbs[i++] = 'F'; /* fua */
-- 
2.51.0

