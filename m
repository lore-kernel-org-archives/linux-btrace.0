Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFFE2E7F08;
	Mon, 24 Nov 2025 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969876; cv=none; b=ESLwgTqaxcR4u70K92ztg5bxePQP7qfmBpUgKj2WW/02JOD/RgK5sGVBc3t2aZEtgL52Fd7oztftFog6njrfMgw3P6wocVg7sgu/UE1+c/aMuCJ01VtfvdSrqHGmY85OjgG/aAmTtIJp0Kbc42FqlXZmW0noRn8aswSBKyOsUKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969876; c=relaxed/simple;
	bh=l//icgwK/BzFifcSk69ckuVEkZhO4Ellum9Xl0D+k9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHq9DSSkyw7PSbO3a/v7xMfEXXJ5o9+sodIJFiTrkmt+nliQTNSayY2dyYUgnpnfw+3ZmTyf09uRxuiwcqY0w3esZDDgs+fLAEOfcrn583mOAoyRLiWClG7siDb5bcWIfM1B/vjco2r9SsYPhX/gWcENCw3+SzDuZnsnH855nIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=K3/s7E2E; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K3/s7E2E"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969875; x=1795505875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l//icgwK/BzFifcSk69ckuVEkZhO4Ellum9Xl0D+k9I=;
  b=K3/s7E2EUNtxpmM4E14H31YZpd6nJjUsDe4dc75bxKtz+EIMK+1X+A21
   6RlS6c9lhoZU3TuGq54VzOXVqFT9rf41OKqy1FRis6NkARu0ySB8Dggzy
   mdDBfMJpnAvxQMNvYucV8cuJME65TIvVLLf8WuGjTESAboBz4j/TvroMJ
   VQFybE2xlH1aiaRuo8KBgrJbMa7NJGS0Pcm6fO2wmB1E2v+aibyGN86CQ
   uZ6xlyB6PyJN6KBVGT4Y2VogXyq7OFS/NnNf1eWb1UKY/FwmR00d/DTF0
   hvtehzY6wcMzbV642BHpL4qfrsO2xg6KC01lc/qmGZB9cv20SorZneC8k
   g==;
X-CSE-ConnectionGUID: nMZHupYpRxOlO2K8lQZNxg==
X-CSE-MsgGUID: +6wS5XyhTbWv6yLjgXaRog==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619312"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:37:53 +0800
IronPort-SDR: 69240b51_DqO92j6gdHBnZQ4avx82M+C7p2J2QI8WKpLhbdxG1v0RmB8
 sPQx0w8ORIFedqSDYyef1cBqLtaJxSpjI0GAsqA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:37:53 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:37:50 -0800
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
Subject: [RESEND PATCH blktrace v3 02/20] blkparse: fix compiler warning
Date: Mon, 24 Nov 2025 08:37:21 +0100
Message-ID: <20251124073739.513212-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
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
2.51.0

