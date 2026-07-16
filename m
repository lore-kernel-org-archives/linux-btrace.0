Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830D22EA154;
	Thu, 16 Jul 2026 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784199920; cv=none; b=NLBJ/JIXFgrfVLa9NuT5s+oyv+8hIowAXjbTFa4suTY3EaNunTMrLxyCbCF/iITLhNeMowwRX2+LSW/Q0IheozsoKS9v5E30YGx8ZjgiBVxbvqYWlw9WfmRGlALZYPpBMDrrVhkuNZiPYCwMSgDF+V9GRgmFsb1tfmGuTKvRqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784199920; c=relaxed/simple;
	bh=NKstsgAl3hfSkDCVsS9Ci6Tqswod1v8YL7G/+n5II2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHDZLgTB87wCz52Q6bAAMNOPV9ErWdokcplL2jJzzRmBZ2mntrPprYoRzaysIXjzSl2nyOt6uspMfDMNdF7Yu+ZnsoY9q8lbw6FPKy6HExh3EHKz7pMWTUstCxyOiSIrWv+VAz6Wyw1ZSbIXRYJpxHlKRCCd1H0ebRC+AwTZiUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lHoVeqZH; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lHoVeqZH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784199919; x=1815735919;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NKstsgAl3hfSkDCVsS9Ci6Tqswod1v8YL7G/+n5II2s=;
  b=lHoVeqZHWFatU3jLDrYS1qOXcgYqX8xuG6hdWOy+zm0a6REMMgfDBfIh
   V9aCDbJbd40JIj7OhGptl2uk9fWsL4zGIpJYMl4QYSiFuTEiAOSRf6W0q
   sA99hJ1e+bpAxkM3kjRAUAZH1xZffwQMF2aNUHmpwNEL38NlzjVm2sEhG
   brei8tQnUuSQeqF13Aly36gVrkfYS2HXrqamvGguan7xFr/wcoacwQIaP
   mxzY6IUZAhU9NmOYYdVGawFsymDs9UHJ19BUzmEO9TGei8LiIxGVpRTcD
   JyQtguGhcyHA63iQK2OibLdLTia0co3v3+SR9yHmpUwVJ6uTEnuqE8dQ8
   w==;
X-CSE-ConnectionGUID: /wmDU3y9SY6DHLTMWvZSXw==
X-CSE-MsgGUID: 1zN4yA+aQiyvyBT1RrcCBA==
X-IronPort-AV: E=Sophos;i="6.25,167,1779120000"; 
   d="scan'208";a="146986473"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2026 19:05:18 +0800
X-CSE-ConnectionGUID: rPU4GWwxR/2SPre4fisZhA==
X-CSE-MsgGUID: wkn2XGnbTVy0B+CLygcmww==
IronPort-SDR: 6a58bacf_wj0mnzCckzXio6H/+HME/a8f+ghAsYs/d3wTX718c+gFWR4
 g4Q1CKC4IRsrzbmI15hUD300O06C1sDXBce7jSg==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2026 04:04:47 -0700
X-CSE-ConnectionGUID: 4DXxS/xvQpy5Cajb8Dd4ug==
X-CSE-MsgGUID: woijz5CUSxipB8WuKfEUXw==
WDCIronportException: Internal
Received: from wdap-fln31fg1cp.ad.shared (HELO neo.wdc.com) ([10.224.28.153])
  by uls-op-esai1-o.wdc.com with ESMTP; 16 Jul 2026 04:04:45 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 00/11] blktrace: parse blk_io_trace2 in btt and iowatcher
Date: Thu, 16 Jul 2026 13:04:31 +0200
Message-ID: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
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
 blkparse.c           |  66 ++++++++++++++++---
 blkrawverify.c       |  69 +++++++++++++++-----
 blktrace.c           |  30 ++++++++-
 blktrace.h           |  20 ++++++
 btreplay/btrecord.c  |  83 +++++++++++++++++++-----
 btt/globals.h        |   4 +-
 btt/mmap.c           | 134 ++++++++++++++++++++++++++++++++++++--
 doc/blkparse.1       |   7 ++
 doc/blktrace.8       |   7 ++
 iowatcher/blkparse.c | 150 ++++++++++++++++++++++++++++++++-----------
 iowatcher/blkparse.h |   3 +-
 12 files changed, 551 insertions(+), 115 deletions(-)

-- 
2.54.0

