Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC492D3EF1;
	Tue, 25 Nov 2025 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056317; cv=none; b=fOxt5MrW7f/BlvSTIOl2a8f7E0z+kaE64NevWP5U0adI1vDLONH8+akX/mulLCGSIlypXfaZUjFlmQ5kc4pCfeFmshrt0rXsblWya+bii3VyJIjpL8Ve/sKZpbMXPsmzh5b57jJNpngE2TcljEO8PMTbraPlmJEf6ZrNVoDCzbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056317; c=relaxed/simple;
	bh=6ORQv00P74c1hMHwcg10I6DqMIFB2qZeDACkqBOIBSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIlmX60Eu9NalcRzcwMCwmXGgbEdThoxgEfG318klQMJb03ZM6OB/c6OhUkiurN4AwJ3joyMgG4zeqtwtP2WYKKXRTl6khOgfVfoIFYgKLFQGw77YciFppfM1Vf8xz65vqog8INxnhv1XfFa3vKy17LRqrpbPVTGLoVEHjwtC7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KA4VlGXI; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KA4VlGXI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764056315; x=1795592315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ORQv00P74c1hMHwcg10I6DqMIFB2qZeDACkqBOIBSk=;
  b=KA4VlGXIoIfE62A+iInErabf+sFdaj0oE/Lgxf7Md6JXKlwjA5sF8VQv
   CWLbrnVExR3sWEVdwzrEJ4f4j5ao4KSWFY7bCC224tseEhYY9iuarpq0s
   R2HqFXjSQ4fPOw07acuAVMM34t/ceJSpKkg15OOuL0xKj/9fceTfZZd+Z
   dNvYd+ztyEfpTnu8DaPzljVUOxWy+DFAEo1ywh9oQgfGFHik45s4QEY/+
   y9BLgxesiwF6Uvp6PtR32eV8gAK5XkIAmyL/Jq6FedDPS/IAwfQncxcKd
   8HvOGEQ2S3r/j3QvTJoiy+HK8wwr18nP310JlrS67lypGqE+E2+quRT5u
   g==;
X-CSE-ConnectionGUID: yUFCR7Z+Tq2fWrT5XGuE7A==
X-CSE-MsgGUID: mxFCls0OTRG1OcZDfK9zoQ==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="132688777"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:38:35 +0800
IronPort-SDR: 69255cfb_NU3KLezMgQTad8mqDK0TF6VF5HZLnHVZo8ROLVtHrHodF37
 AoXQ4xRZB5M0EV+1OP6cK8SM8/pzWXPqIZKXeyw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:38:35 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:38:32 -0800
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
Subject: [PATCH v4 18/20] blkparse: add zoned commands to fill_rwbs()
Date: Tue, 25 Nov 2025 08:38:04 +0100
Message-ID: <20251125073806.50762-8-johannes.thumshirn@wdc.com>
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

