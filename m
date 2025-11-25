Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074813AA2D;
	Tue, 25 Nov 2025 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055665; cv=none; b=XcFa2BcH1xJo13vHVo5FQRkxPPMsEAkUfE0+su81gY1kj3floLj1YYMXFN8cAOpUaZs1hFN6t0Jcb6fWhaEfCe2spDTejxXfnznweGnc5zkQv1RrPE7cTKAPs+U3folBPjiblQc88WxS80ciHn0/r5K1x/jNcLW6Am/HseKeCdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055665; c=relaxed/simple;
	bh=WsRp4TEJWN2LmzlCCAwZ4cZnU/Lg0nHLyuedZ1l9UZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItwZVQSnO/WqBk2fBepkt5MDJldHEJAlg2MX1Ub21dSveZ/PbGfSfoWVwdvRj52KfBBIcWnStI8NdEpuwIA+H9SQOrgjgPZy9CyVWkvbfP+gJxOUIdSfCqXzQBdkzUOABAUIbK5PjPcl42Wc7M4aUKwHGy4q2DHoGMAOkMeOC9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ad7lltHb; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ad7lltHb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764055663; x=1795591663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WsRp4TEJWN2LmzlCCAwZ4cZnU/Lg0nHLyuedZ1l9UZs=;
  b=ad7lltHbZYdI5WaVc6V+kiQqtsam2AUegL3KRIIK4UP33TcgkEBU7rtv
   FtsvAyI8bxEyNhcsv5RWGqjZILHwkj37ePh+8Ja+kNh9e7qSYRCYDNGon
   nMKU8arcJHl+DEBiD3n4mh3GIEKrUphQUjNppd+fnQQ4kgTEptjJnpcTY
   hlYauO1/r6VKam6zv63SU/r/98vaN0TR4fSyaXhSPxQyBd77fBzZaZPD8
   QYFFViN/dnEOnGFlCk/8x8g3ohcz9/yDpksYbGbzcJEooJSKolOEvNYSi
   yhIdA/FGZTUwX6IAUIx0Uhewf4KgGNPqMk0A21ypF9CG+4BwKTo8Jxigo
   A==;
X-CSE-ConnectionGUID: 7b6Hzdh1QR+L5l8ZHFIjRw==
X-CSE-MsgGUID: 2ay1cGi9TYK1MKgDMB+NrQ==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135337508"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:27:43 +0800
IronPort-SDR: 69255a6f_zuz/56feFE44ovUgNQ90CboRKAIdIMA3jbPjAFxqanYHC1u
 csYa+fWrWOYkQFe+J1jTvsDGFheRNfOPnzkkdjQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:27:43 -0800
WDCIronportException: Internal
Received: from ft4m3x2.ad.shared (HELO neo.wdc.com) ([10.224.28.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2025 23:27:40 -0800
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
Subject: [PATCH v4 02/20] blkparse: fix compiler warning
Date: Tue, 25 Nov 2025 08:27:12 +0100
Message-ID: <20251125072730.39196-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125072730.39196-1-johannes.thumshirn@wdc.com>
References: <20251125072730.39196-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC (15.2.1) warns on about the following string truncation in blkparse.c

gcc -o blkparse.o -c -Wall -O2 -g -W -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 blkparse.c
blkparse.c: In function ‘main’:
blkparse.c:2103:68: warning: ‘):’ directive output may be truncated writing 2 bytes into a region of size between 1 and 41 [-Wformat-truncation=]
 2103 |                         snprintf(line, sizeof(line) - 1, "CPU%d (%s):",
      |                                                                    ^~
In function ‘show_device_and_cpu_stats’,
    inlined from ‘show_stats’ at blkparse.c:3064:3,
    inlined from ‘main’ at blkparse.c:3386:3:
blkparse.c:2103:25: note: ‘snprintf’ output between 9 and 49 bytes into a destination of size 47
 2103 |                         snprintf(line, sizeof(line) - 1, "CPU%d (%s):",
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2104 |                                  j, get_dev_name(pdi, name, sizeof(name)));
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
gcc -Wall -O2 -g -W -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64  -o blkparse blkparse.o blkparse_fmt.o rbtree.o act_mask.o

Add two more bytes to the string in order to mitigate the compiler warning.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blkparse.c b/blkparse.c
index d6aaa8b..3f4d827 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2023,7 +2023,7 @@ static void show_device_and_cpu_stats(void)
 	struct io_stats total, *ios;
 	unsigned long long rrate, wrate, msec;
 	int i, j, pci_events;
-	char line[3 + 8/*cpu*/ + 2 + 32/*dev*/ + 3];
+	char line[3 + 8/*cpu*/ + 2 + 32/*dev*/ + 3 + 2];
 	char name[32];
 	double ratio;
 
-- 
2.51.1

