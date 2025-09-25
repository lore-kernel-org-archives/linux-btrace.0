Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1778530F537;
	Thu, 25 Sep 2025 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812684; cv=none; b=i4JsVFbbZ3z2oiycV38Fm6pBkddQg1vLQW0FQlFHmBgwk82aQnraO+6hSIH8LxrknPBSFLQrXqUQvjiqBicBBQXubS+QXx8XuQGdBacZqV6XguSKdlLhcJk1TVJVak1ud/rxPdPlp7JV/uYZpX6m/xYiiGWpmDThzZkSYX4fWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812684; c=relaxed/simple;
	bh=cSzMvT5tIX+eCTmIMd3u0CcszO46qSlWQOtvza30pv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMptNQ28svlcMmvpzMnU5hM6EP6EP3ZPLAX8kirw4fVBPi3+pLV7SzlHHSdGfBv0B7KphK3T+a2iWo3OKhHHfemq8jg0Dc9BQeqeVyB/SqPAk9LgWDwO0ykxBb+/Ap013/lVUeMQCxngvsb6ltYMcEIFeNYtUQyh/O/LNLPjDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hCLzznBO; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hCLzznBO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812682; x=1790348682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cSzMvT5tIX+eCTmIMd3u0CcszO46qSlWQOtvza30pv4=;
  b=hCLzznBOAJ6mPbWJAFCv4h5SmvITZRsmcuhqfNSUm6w0iivZB0L1PAtI
   01LlrVdK0Lm/yFD6X2BWTLHeafIjjakYvUir2cSZ/BGQitWLTo96LrKhH
   DIcraG7k1HU6exJEVA045/PvusAn5MG68vLKjP9Sztst4zafPzbNwO3jy
   73TwKAkuewJB7ijKn3G7uwrVs4p/41JdLqnKanbkW0sAQDGk3x3Qx0mo9
   lDIz1yI12V6HEbT37aM5ISGdffHQtgteYljnRBtcc0iEu+7FBvEl3CrA5
   rjG/Eap+Gxz2z4FFzmKFYg1sPeOwgUtBxlObRBelOD2Aqdpz5d2SaA+QU
   g==;
X-CSE-ConnectionGUID: DGks6rLIRTOrk6HfxT9DMQ==
X-CSE-MsgGUID: O03Knby5QOO2klrAtCTlfA==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130348702"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:04:42 +0800
IronPort-SDR: 68d55a0a_xxkCvME/vGK4+8Ihkoo3wTjHJdhu/obC+0VMSX4vyH4uDsX
 LYA4Uy/3mLVOx4fJeYnLQ2SXCHwWyH16azlPlEg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:04:43 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:04:39 -0700
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
Subject: [PATCH blktrace v2 02/22] blkparse: fix compiler warning
Date: Thu, 25 Sep 2025 17:04:07 +0200
Message-ID: <20250925150427.67394-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
References: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
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

