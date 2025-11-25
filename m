Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E5C2D94A4;
	Tue, 25 Nov 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057159; cv=none; b=PIrBIFoRChqUPR698uaFwJ+VB9kO0P2EnSH3B8Eb33R7yGD9gaGxUP4GF9FGQSEAavMJWfy7TlNeoL8J460/N+LLrUjAte+/bmELE7ZPHWlmtH/kF2+HogwAVNvp3977C7KrJ66lO11McMqKxs8rCbaBplheYi/u6pz0TfItXB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057159; c=relaxed/simple;
	bh=6ORQv00P74c1hMHwcg10I6DqMIFB2qZeDACkqBOIBSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrJChjUKBzomi0X87xVMJ0xyp624mu+TjJcvh1qwbNfmcge2OY+Zt9ZB1kcHsb7/P0WrSBGd/gLnhtBxTIZhgKmaLz0WLQ13mT6Bng3LU+Jym38SCCdlhyATHvwHNFjTYn8a5+w8pTShizkpFdcT55OJGIAZrPghaUq5+ip+AJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OxHhrnOE; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OxHhrnOE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057158; x=1795593158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ORQv00P74c1hMHwcg10I6DqMIFB2qZeDACkqBOIBSk=;
  b=OxHhrnOEYmzshqvFkHRK2StziNKD+eIyjfOShKevtbnnU0Hg4XH6TjFV
   tJDJ9xe2XJvFry9rJB14bQBDOHMZWx8NwvDk77ri36gMsJ4cC3gZs1wkW
   NXP2tF5BF0u72X1kDQ2D329yKUKapLJUUmCS6sq7YcI+fdUnoN+EQdn9z
   wV/7X+NO+DNz8PX5fQPkL8ECQ6wBsDoLssV0bzqFtRiFjayVsspV+useO
   h0Duq3QVfmumYskr8XJVOKAWHzBFCNZA9b90bKrVBIZfZlMTaiRQ4JTyG
   RzGtXrycfbLo+56aS+vxmnjtNuXpgpOqB8GJe3jvXSC9Gl0y9qB3o/TPi
   A==;
X-CSE-ConnectionGUID: LEfgj5v5QgSZIXQbJ54ERg==
X-CSE-MsgGUID: d75RDRjPRdax+BtuX8ZTKg==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749824"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:37 +0800
IronPort-SDR: 69256045_6jUWWiffAX9WWezUedX68d9bAVu82jF4MK1FZ19SeNIxmDz
 AuvrlukIOqizL0MbrVks1LQsQur1DjF09EPf4UQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:37 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:37 -0800
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
Subject: [PATCH v4 18/20] blkparse: add zoned commands to fill_rwbs()
Date: Mon, 24 Nov 2025 23:52:04 -0800
Message-ID: <20251125075206.876902-19-johannes.thumshirn@wdc.com>
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

Parse zoned commands in blkparse.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse_fmt.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 80e02fc..06b055b 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -60,19 +60,45 @@ static inline void fill_rwbs(char *rwbs, struct blk_io_trace2 *t)
 	bool d = !!(t->action & BLK_TC_ACT(BLK_TC_DISCARD));
 	bool f = !!(t->action & BLK_TC_ACT(BLK_TC_FLUSH));
 	bool u = !!(t->action & BLK_TC_ACT(BLK_TC_FUA));
+	bool za = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_APPEND));
+	bool zr = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_RESET));
+	bool zra = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_RESET_ALL));
+	bool zf = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_FINISH));
+	bool zo = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_OPEN));
+	bool zc = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_CLOSE));
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
2.51.1

