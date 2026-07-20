Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EE83F8715;
	Mon, 20 Jul 2026 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546099; cv=none; b=DOS2yawIk+ZQf0eDgjF7CxWoPd5w1sXBh4OwS1kRZ56GX4NHNKWdHMrRQnepmyBkxUfknPXSyU8B0qY5B5EKCI/Wg3bN9FUstVCi8O4Wm2dYmb5NnhMxADMg/K3Jwy0BhVUOrv3GVAwfBdSa+4K+gavpw3QsYi2Md02+2jkft6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546099; c=relaxed/simple;
	bh=sRFmjYc/nJiNM4rbrNBuHaIuthtsTICelAtHUsBjMDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ipp0rLZji/3LsThetE8p5HNR1XIw0VFcVZpt1QIznTMvd4FdYTL5ELBGMGnNiF91fJexM2OaZU/sKhl8scjWmWOllhpm4cs7VmDwWRmeaMWn5NBKAn0cH2cIvr9iY/y14E7NGjNvOqonVQyx85lq4huVz81V8Av61usL2lW39Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MX5EYI96; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MX5EYI96"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784546097; x=1816082097;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sRFmjYc/nJiNM4rbrNBuHaIuthtsTICelAtHUsBjMDg=;
  b=MX5EYI96tNR3naVX3kVcpljNbDIxFOu6WtZOB8LE05IwcBiyHTonkF0q
   TgX65ZS9eKCXKSlZpoqUKShDaErqCer6fXUzBRRenCFOSYsYkks3cOquq
   bhcS+LnELq7/dscaMnUasaA0MNJmW+DyOCeQ8YhiHOjhfyZNdQPRIemBd
   cJYHcX0oatfFysrDhZH4YMmBS71mjxQb0HOzQeUXSAnUdzY2Fd76yZLuP
   +k7HYr42t44aN6LwZIjqt0RVg3FL3r4+EAr50bkBCKF7/C2QWir1d7jPE
   eCdIcgDNzrts5JyGqNI5Jdy3sCEPm/ljVXlDL0RPfmr+QbXAQwvzOBahe
   w==;
X-CSE-ConnectionGUID: kOoELZnfRhWEJxLGvwjQ4Q==
X-CSE-MsgGUID: EgXtb+2tTH2qz7Mpig6m3w==
X-IronPort-AV: E=Sophos;i="6.25,174,1779120000"; 
   d="scan'208";a="151105444"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2026 19:14:50 +0800
X-CSE-ConnectionGUID: 37TUTg51TJy8k9lOgQzDZQ==
X-CSE-MsgGUID: wfDahKuFR9C4BhClnLIGfQ==
IronPort-SDR: 6a5e030d_tkjfNmkrtf25XfFo/OoohlWVtScNhAZKvFs/6XlwseSNs3B
 QQ4T6dOOtkNK76NnpkSBAIXw180drZ+OqPRKgng==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jul 2026 04:14:21 -0700
X-CSE-ConnectionGUID: FaaWFJPLQ4ivqTna7J6nSA==
X-CSE-MsgGUID: okX54QNPRK+eeiazmaR66A==
WDCIronportException: Internal
Received: from wdap-kyufgunycc.ad.shared (HELO neo.fritz.box) ([10.224.19.3])
  by uls-op-esai1-o.wdc.com with ESMTP; 20 Jul 2026 04:14:19 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 00/11] blktrace: parse blk_io_trace2 in btt and iowatcher
Date: Mon, 20 Jul 2026 13:14:06 +0200
Message-ID: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We had an internal report that the new blktrace format does not work
with the btt tool.

This is because I simply forgot to update these tools. Do so now and
sorry for all the inconvenience it might have brought.

Johannes Thumshirn (11):
  btt: use blk_io_trace2 internally
  btt: natively parse blk_io_trace2
  blktrace: add option to request a specific trace protocol version
  blkrawverify: use blk_io_trace2 internally
  blkrawverify: natively parse blk_io_trace2
  blkiomon: use blk_io_trace2 internally
  blkiomon: natively parse blk_io_trace2
  iowatcher: use blk_io_trace2 internally
  iowatcher: natively parse blk_io_trace2
  btreplay: support blk_io_trace2 in btrecord
  blkparse: add option to emit a specific trace protocol version

 blkiomon.c           |  93 +++++++++++++++++++--------
 blkparse.c           |  64 +++++++++++++++---
 blkrawverify.c       |  69 +++++++++++++++-----
 blktrace.c           |  24 ++++++-
 blktrace.h           |  20 ++++++
 btreplay/btrecord.c  |  83 +++++++++++++++++++-----
 btt/globals.h        |   4 +-
 btt/mmap.c           | 134 ++++++++++++++++++++++++++++++++++++--
 doc/blkparse.1       |   7 ++
 doc/blktrace.8       |   7 ++
 iowatcher/blkparse.c | 150 ++++++++++++++++++++++++++++++++-----------
 iowatcher/blkparse.h |   3 +-
 12 files changed, 543 insertions(+), 115 deletions(-)

-- 
2.54.0

