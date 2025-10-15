Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4781831DD86;
	Wed, 15 Oct 2025 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525838; cv=none; b=BvnfxPsvRbRupefAU8wLlg8bf5IsVYY0i7aZXMdog9MK4u7O/llUQVE7h2+vHEDXt36g+l2tRdstbW1luMThpYQ4YpRcJvXR2Yc9zBPE1qqpT8kkrNPA+oPF34QWVJBmVZyDpsciOJycX3oeB4MCQ4WPIL41IPUgjlQSaMahRe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525838; c=relaxed/simple;
	bh=l//icgwK/BzFifcSk69ckuVEkZhO4Ellum9Xl0D+k9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fp1wFZO5+yssyAZL9E9gzPZYBuZKXdliSfVbEe7pi85qQWFaAsV3s7iBsTctoVoKUavAcxjQhNzokfuSpBaU0at7ISuGTlroPV1eVwRulVJu7Q9Pmyiti/N/PfmfvPznkXBsaC7QGH6t5JKhi6+OAHNqgvOj6Z4cyzfxJYbj+vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=f7UZP6vr; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f7UZP6vr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525837; x=1792061837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l//icgwK/BzFifcSk69ckuVEkZhO4Ellum9Xl0D+k9I=;
  b=f7UZP6vrx+YfSWIGbqrHEBkltQ6Ilx3SCRRVCmW03RGi8faslVn0OxHy
   bIcPEMt80SUGjAtNrTU7KRnNITKV+xpYEVlwAE36lKCePEw5/wetpTqm5
   +2TLtppfIjJA75wztoJa4F4s6FXq6ddfBSzuS4AgPDOCtN2cuuuTbzkhD
   XM81YP2iRdBi/9nxQ9ovjwzLFxhCciFIJMxa/Vq6Kxpb2yWQcvQVuchiy
   ocSSu/qhW2L3VSN4TYO0stxQkcm/JcJQRv8n1tgCbBj/fpjGdULWc3PzZ
   19ssQ/Rxp5NpN1WnS9aGT2yeXSQHz7JkuP+KTw6Cq5nu/mDeoEIs+LWcd
   w==;
X-CSE-ConnectionGUID: vxCbEGWMQMqUNmPg1VqfRA==
X-CSE-MsgGUID: LcqRl23eR4K8sl6VUGQlzg==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935338"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:57:15 +0800
IronPort-SDR: 68ef7e0b_Nyzpo7UotLf+ezBd6FMNAr5vlxlxY2VXhmjccGP/p+jfwxo
 c45u8V9uxYmYau8BkARoknEuIDOxfbOzx1VWa0g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:57:15 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:57:11 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: axboe@kernel.dk
Cc: chaitanyak@nvidia.com,
	dlemoal@kernel.org,
	hare@suse.de,
	hch@lst.de,
	john.g.garry@oracle.com,
	linux-block@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	naohiro.aota@wdc.com,
	rostedt@goodmis.org,
	shinichiro.kawasaki@wdc.com,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH blktrace v3 02/20] blkparse: fix compiler warning
Date: Wed, 15 Oct 2025 12:56:40 +0200
Message-ID: <20251015105658.527262-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
References: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
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

