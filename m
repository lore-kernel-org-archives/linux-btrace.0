Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC3C2E7F03;
	Mon, 24 Nov 2025 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969874; cv=none; b=VWmdjSj8/popNII2++CPNxj7L8LW/kfcOyTGn4wlelpAipqQ7q3mKFwCcIdk6AQCqOoOL663j4FMvrg16GVTDtgGsAHtEc/DPqOWFVxQ4iuxW9yLV2jC457wQpxX66cVfagG0NUAqJprqJcmkhfr5+dDg9j4togf0bcfc6T7TUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969874; c=relaxed/simple;
	bh=1SpWX58sERu+du9es459Odt2e8YrfncgCem8BromfA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZaVIVlutfcyVfuewY2Tt+hKwGrQMzEpc8A/Yp01Ch8sMQbcs0LrIWu/FL+DChOI5Whfx2Bcdk8nX6uEl/RvcOz0zNZT9BYBZJsbLNr86yXz7MKixwigcDLotqVXa18cKmWpf8tr/AGa/mBWPG2sN6eEv0DOR4aByXO3iXUiYG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iO6WEzp3; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iO6WEzp3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969872; x=1795505872;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1SpWX58sERu+du9es459Odt2e8YrfncgCem8BromfA8=;
  b=iO6WEzp3OonOEOiZSd5X7fU9nMEYSKS/UaPb8E1NSd4Cvi6ByJnhYBSB
   TVZ8yn8jWN8CuIrph51X3UJg3pa5cWuwkh8YA8tiNMDPDe4jhkp+cAvLx
   7W3sKqweV+ZVJNZ0D9i9emBPEHy3xxvPBjbnC4bsSqte3mLgbZYsbraCt
   jMj5Tx+0b077IeOhHKEhOqg5/NZweOqZQdntLf7fnvbg8VV+I9ibADeQv
   YD1vJciDViA31fcg72G7HSYNCCHoGtL4r8c5EKn/7vZ0Eonl4Exf6eKkL
   lxbwoxboq2ss1Z2rqe7UsvQdU9vl9yXrmpuVMn+1JtW1Jec8Pcnp8bOIk
   A==;
X-CSE-ConnectionGUID: 8vIblotCS5y++24Uj8IaVA==
X-CSE-MsgGUID: /iKxxBK1QUyPmZz6SoblwA==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619308"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:37:45 +0800
IronPort-SDR: 69240b49_zDn5lTyS/Cy75I4hsQv/WATzJeKtb2nUapa7v6QrBOZsce7
 2FdyU37sGGepRrR2Jy+48TSfYczkSy4OXCqy/9Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:37:46 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:37:42 -0800
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
Subject: [RESEND PATCH blktrace v3 00/20] blktrace: Add user-space support for zoned command tracing
Date: Mon, 24 Nov 2025 08:37:19 +0100
Message-ID: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[The original submission can be found here: https://lore.kernel.org/linux-btrace/20251015105658.527262-1-johannes.thumshirn@wdc.com]

This patch series extends the user-space blktrace tools to support the new
trace events for zoned block device commands introduced in the corresponding
kernel patch series.

The updates include:

- Introduction of a new ioctl requesting the v2 version of the trace
- Definitions for new zoned operation trace events.
- Parsing support in blkparse for these events.
- Display of the new events with clear labeling (e.g., ZO, ZA, ZR).
- Backward-compatible changes that do not affect existing functionality.

These changes complement the kernel patches and allow full visibility into
zone management commands in blktrace output, enabling better analysis and
debugging of zoned storage workloads.

The updated blktrace utility will first issue the BLKTRACESETUP2 ioctl and if
it fails transpartently fall back to BLKTRACESETUP allowing backwards
compatibility.

Feedback and testing on additional device types are appreciated.

Changes to v2:
- Sync with kernel changes
- Drop the Zone Management trace action

Changes to v1:
- Incorporated feedback from Chaitanya
- Add patch fixing a compiler warning at the beginning

Johannes Thumshirn (20):
  blktrace: fix comment for struct blk_trace_setup:
  blkparse: fix compiler warning
  blktrace: add definitions for BLKTRACESETUP2
  blktrace: change size of action to 64 bits
  blktrace: add definitions for blk_io_trace2
  blktrace: support protocol version 8
  blkparse: pass magic to get_magic
  blkparse: read 'magic' first
  blkparse: factor out reading of a singe blk_io_trace event
  blkparse: skip unsupported protocol versions
  blkparse: make get_pdulen() take the pdu_len
  blkiomon: read 'magic' first
  blktrace: pass magic to CHECK_MAGIC macro
  blktrace: pass magic to verify_trace
  blktrace: rename trace_to_cpu to bit_trace_to_cpu
  blkparse: use blk_io_trace2 internally
  blkparse: natively parse blk_io_trace2
  blkparse: parse zone (un)plug actions
  blkparse: add zoned commands to fill_rwbs()
  blktrace: call BLKTRACESETUP2 ioctl per default to setup a trace

 act_mask.c     |   4 +-
 blkiomon.c     |  15 +-
 blkparse.c     | 446 +++++++++++++++++++++++++++++++++----------------
 blkparse_fmt.c |  83 ++++++---
 blkrawverify.c |  14 +-
 blktrace.c     |  40 ++++-
 blktrace.h     |  64 +++++--
 blktrace_api.h |  58 ++++++-
 8 files changed, 535 insertions(+), 189 deletions(-)

-- 
2.51.0

