Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CB4314B96;
	Thu, 25 Sep 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812722; cv=none; b=HLeJKNeVMjlkO6ca+zkm9YHc7qlTQ45jQbmN4L86Y/eHgCw0vVpIO9eBl83poGbPgf/Q9DjGftQlmA02tr3WrbXVLxpxMolnas5JJw1gRmUdXvB2O3r0jHCFYkMPl6keSkiFM+tSMP8R5Y0gAIkTXPS4xZviqyPyf3AOQUam7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812722; c=relaxed/simple;
	bh=nrVNfhwCQTLkgVxk9oq1vWA9GizwOPAGrwaJjZXIj0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyeOXdosOtSjg5q8MSMYL7XYwpil6Fwbg24A0d4YtuQRfz8t0j54StAZJGG1oP/gdfpDEseE5vp0UkJC3UtLgoAdbYgOXDu4PPwH+odT9gvt3alC8RoGByqm6rtA4+DRJVXWAXLB3DCJVkeid1qCIIgvFabTnTFZ85JCWpeLXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=H53h2O8t; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H53h2O8t"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812720; x=1790348720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nrVNfhwCQTLkgVxk9oq1vWA9GizwOPAGrwaJjZXIj0A=;
  b=H53h2O8tq1hkWxDcmh3ebVkmbp3lTiXypGXowOnof9L1W10pg66e6Y8/
   RZsXLojuOJBrjM7PvR7Z15kZuMx9Mhc7JRF6b5GoIg1ixblkSdXLg8qWL
   xZjpa1J7W15vDCUoj5TX7yiBLKwRQu3QYw+g6iNfQ5yj212nDDZogfGAi
   Wd/7sVi+nXOtimnOOJbwgT31e9QXWuvaDfOSIh03qHup0yRUxKOWFGRdy
   sEPEajQ64TMh8Ji1q47Ww1uVbo6YB/IzaHr3214KXl2ovrVLt83JncdX7
   /HDJaBi0IcPKbBibZrXPWPckA9miHIKwsOfIdi2+zkKBPaBTf3EzUih/f
   g==;
X-CSE-ConnectionGUID: MWfd0beOSbaTTd68KjFWIw==
X-CSE-MsgGUID: Wu5ELZHcRlSND82HQwRnmQ==
X-Ironport-Invalid-End-Of-Message: True
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130349092"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:05:20 +0800
IronPort-SDR: 68d55a30_Q4k9vEOUxLgiqAaF6etfwlvs/YQIEufTWrbO78fXx4i5Rn6
 OXp/9gtmmtBgpsFRE/C1rjXlYsHusLgOOeBUmYA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:05:20 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:05:17 -0700
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
Subject: [PATCH blktrace v2 11/22] blkparse: make get_pdulen() take the pdu_len
Date: Thu, 25 Sep 2025 17:04:16 +0200
Message-ID: <20250925150427.67394-12-johannes.thumshirn@wdc.com>
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

Directly pass in the pdu_len into get_pdulen() and only care about the
byte swapping in get_pdulen().

This enables us to use the function for different versions of the
protocol.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 163da73..0402e81 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2412,12 +2412,12 @@ static int read_data(int fd, void *buffer, int bytes, int block, int *fdblock)
 	return 0;
 }
 
-static inline __u16 get_pdulen(struct blk_io_trace *bit)
+static inline __u16 get_pdulen(__u16 pdu_len)
 {
 	if (data_is_native)
-		return bit->pdu_len;
+		return pdu_len;
 
-	return __bswap_16(bit->pdu_len);
+	return __bswap_16(pdu_len);
 }
 
 static inline __u32 get_magic(__u32 magic)
@@ -2439,7 +2439,7 @@ static int read_one_bit(int fd, struct blk_io_trace *bit, int block,
 	if (ret)
 		return ret;
 
-	pdu_len = get_pdulen(bit);
+	pdu_len = get_pdulen(bit->pdu_len);
 	if (pdu_len) {
 		void *ptr = realloc(bit, sizeof(*bit) + pdu_len);
 
-- 
2.51.0

