Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B2B13AA2D;
	Tue, 25 Nov 2025 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055658; cv=none; b=KhZlWUuvFCTT1Wmz4qtCRfPkEEeTTb4bXecmyOZGk0Y8/wn2p3SRci4xuw0HM8NgrtUBYTJc9HWXhHQiuIcqeo+XAi9Fb/CCkcpeFdAIqLTLrljvs0DhwR2zL2N+97nYIEVSvyBpUmp5PgOz/T8CdoFzLWsSyUHAW2cJWSeuxcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055658; c=relaxed/simple;
	bh=x58Lv3xROJ9erYhL8HQjspBsV6Z4cpBGpnI+bRWH4xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SuHsk9+lQoXYyFSjPP/5zGiTB+IiOpYKXKqeqLbHGm4eAsAivQ/wTXwf/rtiBRxbVYI87Uddj7RAKnz3IPKybtNtEDUq/uVyZCNjwOxxvxAMjVzMYi9rKCyHPTq3JVbfBGom6jLRZ8IANMFwwU7qlElHTpKGvjL+kb0vTJbZSFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KHyvYeeK; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KHyvYeeK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764055657; x=1795591657;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x58Lv3xROJ9erYhL8HQjspBsV6Z4cpBGpnI+bRWH4xQ=;
  b=KHyvYeeKVzw5/sQaMlrBfZCrjjxjBGURurySbcP0IGI9qHfyXlfJeYBA
   anTy0VqDcDAGvZsU8t1L59i0irCarAt82NLcCj0uMIPdyh7Ni5E1rZ17R
   oWZW6A5GKGvFGKVTm4Tt2YjGAsuEx3TUCoGsbN3rnH9IqakWZPbU3MM+3
   pXX9Jw05rlbI43RkIDzaMhXn3Q/7MdMt8jl6+Pv8hsbHbvqwzlR+uGWri
   z54mMzA/2+H/jtud2p+EdzuACvGHqBVm7qOrqa/ANdBD1CJiK09AXO9nM
   cr4YWF75XERpW5jWjOFh2OSqFvppwkqzorGa3Ds7cFaRj8UJUwBmQSgzM
   Q==;
X-CSE-ConnectionGUID: wajHUJYnQnGSBfEcnl4uxA==
X-CSE-MsgGUID: fvkP4X6OSHy8n9Mm3T6N8A==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135337501"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:27:36 +0800
IronPort-SDR: 69255a68_iIEP00Bji2IyyanSDf3Q665q+u9B9IgPrEUcO+b6ki7mdL1
 aidLINhkwsnP3HfhbEjclACK70CobzRfdzUz2VQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:27:36 -0800
WDCIronportException: Internal
Received: from ft4m3x2.ad.shared (HELO neo.wdc.com) ([10.224.28.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2025 23:27:33 -0800
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
Subject: [PATCH v4 00/20] blktrace: Add user-space support for zoned command tracing
Date: Tue, 25 Nov 2025 08:27:10 +0100
Message-ID: <20251125072730.39196-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


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

Link to v3: https://lore.kernel.org/linux-btrace/20251124073739.513212-1-johannes.thumshirn@wdc.com
Changes to v3:
- Move patch "blktrace: support protocol version 8" last in series
- Add Damien's and Martin's Reviewed-by
- Document patch "blktrace: rename trace_to_cpu to bit_trace_to_cpu"

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
  blktrace: support protocol version 8

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
2.51.1

