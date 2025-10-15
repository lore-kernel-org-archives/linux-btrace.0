Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D7E31CA57;
	Wed, 15 Oct 2025 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525828; cv=none; b=pNxWt+16OOOyAU8SA3HOQyfUd6MawivPaZ3ehGLCvy+LChMNidrsy7bcsozUC2ia9EOCBV4+J3twXSX2ShE0L+rZfG11DEhNEJ8N3SnsRF23ViyuOsGcNVslIiqOwhrMZXUgqNnjtiH8uizyFW2ph3aXqxZJpmve4gyomKRYQMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525828; c=relaxed/simple;
	bh=LmMGf4quz7NBnGs4HyPWNSchUYqmy7DYI3UEvX/BoOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L35dX8PX9BgWB5fZyxUtoE9BPMnV31Gmdw3yS3qK3Y6ZlxkEkiO5nnVzmhLrb2nwUhc2dCxbE/dPty86K3grXz9X5o5eJKw0MwIGdKhShMpTTgSYeCp1KhHgFzbi4KQIThBgQHCjbAUgnBirjpigHWqxJl4BaqiT25Mi+Kgw8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kdHrfg46; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kdHrfg46"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525826; x=1792061826;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LmMGf4quz7NBnGs4HyPWNSchUYqmy7DYI3UEvX/BoOw=;
  b=kdHrfg46jb+UxDOeOgaxd7C0UuzqcVVe9ylQIlrqiH2esdMspMmG8ZXS
   ZeqqefxDNnGvvQ8ZHpmFuva3eaFNn5Q9zTGB12GAJnD1LiIq1BSVQ3NGp
   ViQycomj9orXqRvlaUiuOEVYkyjtMqabGMYY16ixX0WQozkBBvJv3abEC
   W+3qMXg+YELAi9XsSARb/F5AuvvCKn7u4gYdZiZLMdx8l760IhsSIlg54
   5psusUSgWtUu7o8a9X4Sy80kiHMfbhpBqAZaLXKUd+AblGDRrbCKz6ed+
   aAPy+GjKBkpYRXiErwp9x2dBZ+4DjDcl6Hu+ePCIKe3XUMajlt+IheXKi
   A==;
X-CSE-ConnectionGUID: 9hI3gJAMTvuHsUvwNA+QsQ==
X-CSE-MsgGUID: 9O5NrKxXTVibfIzGMi+oUQ==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="133262221"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:57:04 +0800
IronPort-SDR: 68ef7e00_DOeNXL1CoGubV5gzOkNwzthLoKyGVPQsBn7hPjb2qvwLlUq
 n73pfdgNrnrUl7/tonHavtTK+iSVqkIxx7A2J0w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:57:05 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:57:01 -0700
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
Subject: [PATCH blktrace v3 00/20] blktrace: Add user-space support for zoned command tracing
Date: Wed, 15 Oct 2025 12:56:38 +0200
Message-ID: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
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

