Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E52DC77F;
	Tue, 25 Nov 2025 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057135; cv=none; b=fOAgxUkzOLbmiaxioFH+oxyCC2Fm1EBmmOuPNufSijxO14SQq7SNspp/QjwNj5d55Vjy6dT7Z6yHTVhXo5NEpovmwp7cl3HqiLB4cisfYbSmFnNlfI2/SvnehGDrMW92nrhHugHSZqOXJ7zZhiKvGCKxmwcT3XOKDHeU6D0v+Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057135; c=relaxed/simple;
	bh=WsRp4TEJWN2LmzlCCAwZ4cZnU/Lg0nHLyuedZ1l9UZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f235nsOge+0DQl0Nn2/jU/cWwC1KPLiIoQd9MnBhRxMd9v12Y10ZY17RuQoTUGwM3SYPwE0nLU+xuWCG8iJVlT2/Ue+6B2w00AskG/7AAAh418CS9Z3oe5Hq/WSFLZgJ2z3zRvSU3qdONf5or+CLd69MK83JMrbeONMyz4Bm/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jlPojBmS; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jlPojBmS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057133; x=1795593133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WsRp4TEJWN2LmzlCCAwZ4cZnU/Lg0nHLyuedZ1l9UZs=;
  b=jlPojBmSDre14Ifc63AZLuqSIRjNy6OttLfmft5QFRx+D7Ds455nbScQ
   vREd4I8RDtCkik8Za6Kd5aCYQMKwTMitTfMc1pgBMhuTNthrPtQlnL9i+
   NN13uU8llNc5/F+ROboogF5oPH2NRYbm3VEf0B3B7GZcUdr3GMurmy+Ts
   hnIuI/uqKl3FEs0LKt0yn6+IAQISV/oZdMqtMnxStLyr9h8saHN+EfkVE
   R2lryVSz7YwjnKOyka3zVOAl/OXKWrtU2nvhxHrY7yfbaZOCCE4eVMBS8
   KcK6v3iaeq1/crvfZ6DnOjfrn+kJwDiTnepIU0Ci4usyDNbHTNHTYQu0d
   A==;
X-CSE-ConnectionGUID: NDPf0DeATgKFvurBr/ChSA==
X-CSE-MsgGUID: nUKICFjMR2OSCCA9s2Qjww==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749781"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:13 +0800
IronPort-SDR: 6925602d_oPMAY25NayrTktvP74UK2X2B93JbvTbFoqQQlxp6eTyhxPu
 3PWVd+h9tfRSlWE5jN+O9fY0B2DiF2HwlIWiyrw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:13 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:12 -0800
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
Subject: [PATCH v4 02/20] blkparse: fix compiler warning
Date: Mon, 24 Nov 2025 23:51:48 -0800
Message-ID: <20251125075206.876902-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
References: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
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

