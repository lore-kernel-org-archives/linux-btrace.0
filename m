Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F473218B4;
	Tue,  9 Sep 2025 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416052; cv=none; b=kmmzlThdNLi4rI+yYG8rtDPhodAU3Nk6t0t5RWeCGZfgMqerg33qccC9Fvt7er/0r+YrnjyitMkzDdfcXnIYgFMBKi4sazxcS2V8WD7+++pgtqP9H8m2v6hSPd4FVq8LD67TVWPDuY73tJ5UuDOglCFC4cajBt7JFy+v4f1lt7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416052; c=relaxed/simple;
	bh=CJ3G1wVnxv49/fvmTsL4eWGGuuImeFDwM8NEg9yz98E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kqe9lN2/wGqGZfZGZRQYt16GHHBRd260yldV9uHk0bbvw21ptdYL3qKKrfS7q+IHY31rUvFtewalc6PQ8PL5O4FHhI8DoCwFn0QcN2xxtniE9CzEqIL8MC6Ql4Qd3QovqTcQ6riokIL4KzY4is+TFnj7i5GxXTSwDH/Zt/tzD8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V2Xbl5dH; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V2Xbl5dH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416051; x=1788952051;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CJ3G1wVnxv49/fvmTsL4eWGGuuImeFDwM8NEg9yz98E=;
  b=V2Xbl5dHyslkH1yDLNrsfHmCsYPX2UkQldHUuMQM+2tuqPTlOcYP5n5B
   5w2WPq9bF5zzaIW7/bx5xHjBG9Kmkna1CEFZgGINS6tsIE5gCoJxpnlDy
   pByyx2ZVpAm4Epk2yPdpwXLgGvax+O3SRMa6y28c9CKLJMQlEprvSdVXf
   EVGOm7csqjmrOMQq3OeVcaWp1Y3zURK9iNZSZHPBcIQfhpCF5LQAJ65e7
   AB9vK/8QKRY1DrWGo5kgFWT2z5F0PdyLcUWgwGSOTyot9XRJysS17mw02
   uO/NmHFF7tbKLh2C1+epoPkebpk7V5ozrrvXaVSozLKSTe4nLHyfHDz9q
   A==;
X-CSE-ConnectionGUID: 4GQ2PeTPT1OiP8JfWqCqUw==
X-CSE-MsgGUID: q04WWpgfR0mo5S67zPrPXg==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810310"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:07:30 +0800
IronPort-SDR: 68c00a72_7RUJ8T7UsWDNMt2aY4u2Y/jjftHUrMm4a/W5WWzI/B4mhCK
 VF/8bFoQly3IHi6O0CgxvaEs+pRzIpMHH3sx7yw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:07:30 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:07:26 -0700
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
Subject: [PATCH 00/21] blktrace: Add user-space support for zoned command tracing
Date: Tue,  9 Sep 2025 13:07:02 +0200
Message-Id: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Johannes Thumshirn (21):
  fix comment for struct blk_trace_setup:
  add definitions for BLKTRACESETUP2
  call BLKTRACESETUP2 ioctl per default to setup a trace
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
  blkparse: parse zone management commands
  blkparse: parse zone append completions

 act_mask.c     |   4 +-
 blkiomon.c     |  15 +-
 blkparse.c     | 450 ++++++++++++++++++++++++++++++++++---------------
 blkparse_fmt.c | 105 +++++++++---
 blkrawverify.c |  14 +-
 blktrace.c     |  40 ++++-
 blktrace.h     |  64 +++++--
 blktrace_api.h |  54 +++++-
 8 files changed, 560 insertions(+), 186 deletions(-)

-- 
2.51.0

