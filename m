Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F91DE4EF;
	Thu, 25 Sep 2025 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812565; cv=none; b=B0XwhQvGSlqLqXmruBqxS+YqE71RuCPhTKEQjGH/D5Mz6S+IMBJE6MS5yrZZgLaWEpiuhbIWwjGOnRHbWz0BE30k9G2jguPTChD0Tl3HGgp95eRm8Rpmzef/HhBbQTHYHsWH1uTwWWjkfNQn+MgHMBOt9Q8ElaH9B5vwMLUcD78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812565; c=relaxed/simple;
	bh=+d6LqvxvOyA5QrNNpnhsaaZJfZ2boT2CGXN4kc0lyBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cKdcqZw+urNOnPd+ZzdqlB7ZyJu8bZVxOOaBe8FVbR81unbu6UZaKAHs5tV/MWImP0d9R+hlRS9kXv4m191dr92BdPY2fHCzHuWaw5TFDMW6T1oYiqvXXll/Xb1of95/BqgC1BwOkaz+G3z8N9fYukne4FnSBva+yqK16hSEUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QS1QVJN9; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QS1QVJN9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812563; x=1790348563;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+d6LqvxvOyA5QrNNpnhsaaZJfZ2boT2CGXN4kc0lyBE=;
  b=QS1QVJN9LvWZwtQLfdd/Z2t1wpWZFkSy1huqFrR4IoNw0z9F4qVKGe3y
   0Q4AinOQujRx2SQxVh4gLZyxuexj1b7IUwH1/j1fmsjxYSloKBqlXSI+T
   TR7xsnx72k8fzKI7mFlb3yjkBkKRrM5WGAB35VpVBE7q68vy9vmzS8Uyp
   Gkc1huXcGYnZ1B0V2CpxOe5PqcdSF86TMuXF0br5oJjxjpPL37IPwZtpw
   h0+7yqm2Qb0APqtDNrNVC0VvGWFtr8F/WyChb8Fbu5bWXvuFkQV2PzZ/R
   6w+OM7tyBsSvSA+RMMEwRn0WGlG4g1IZeZ2dd3bla0NyhQQ3SOTaRgl/H
   A==;
X-CSE-ConnectionGUID: pCIXRGq4RLaQlMfuzz7Z0A==
X-CSE-MsgGUID: PzjpbetARuy+IkghyZ5AGQ==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130347466"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:02:38 +0800
IronPort-SDR: 68d5598e_j4OH3DPNfAaURVIMPgMwPq/qz2xPSDPJnpwLHWqG2MZsiAO
 2Lk58YM3Gepp0M+/COXRbtwTAIcIOIE/ZwrdmtA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:02:38 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:02:35 -0700
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
Subject: [PATCH v2 00/15] block: add blktrace support for zoned block device commands
Date: Thu, 25 Sep 2025 17:02:16 +0200
Message-ID: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series extends the kernel blktrace infrastructure to support
tracing zoned block device commands. Zoned block devices (e.g., ZAC/ZBC and
ZNS) introduce command types such as zone open, close, reset, finish, and
zone append. These are currently not visible in blktrace, making it difficult
to debug and analyze I/O workloads on zoned devices.

The patches in this series utilize the new trace points for these zone
management operations, and propagate the necessary context to the blktrace
logging path. These additions are designed to be backward-compatible, and are
only active when zoned devices are in use.

In order to not break the user-space ABI, a new ioctl was introduced to request
the new version of the blk_io_trace with extended 'action' field.

The user-space tools in the blktrace suite are updated in a separate patch
series to interpret and display the new trace events.This patch series extends the kernel blktrace infrastructure to support
tracing zoned block device commands. Zoned block devices (e.g., ZAC/ZBC and
ZNS) introduce command types such as zone open, close, reset, finish, and
zone append. These are currently not visible in blktrace, making it difficult
to debug and analyze I/O workloads on zoned devices.

The patches in this series utilize the new trace points for these zone
management operations, and propagate the necessary context to the blktrace
logging path. These additions are designed to be backward-compatible, and are
only active when zoned devices are in use.

In order to not break the user-space ABI, a new ioctl was introduced to request
the new version of the blk_io_trace with extended 'action' field.

The user-space tools in the blktrace suite are updated in a separate patch
series to interpret and display the new trace events.

Changes to v1:
- Incroporate feedback from Christoph

Johannes Thumshirn (15):
  blktrace: only calculate trace length once
  blktrace: factor out recording a blktrace event
  blktrace: split out relaying a blktrace event
  blktrace: untangle if/else sequence in __blk_add_trace
  blktrace: change the internal action to 64bit
  blktrace: split do_blk_trace_setup into two functions
  blktrace: add definitions for blk_user_trace_setup2
  blktrace: pass blk_user_trace2 to setup functions
  blktrace: add definitions for struct blk_io_trace2
  blktrace: differentiate between blk_io_trace versions
  blktrace: add block trace commands for zone operations
  blktrace: expose ZONE APPEND completions to blktrace
  blktrace: trace zone management operations
  blktrace: trace zone write plugging operations
  blktrace: handle BLKTRACESETUP2 ioctl

 block/ioctl.c                     |   1 +
 include/linux/blktrace_api.h      |   3 +-
 include/uapi/linux/blktrace_api.h |  54 +++-
 include/uapi/linux/fs.h           |   1 +
 kernel/trace/blktrace.c           | 458 +++++++++++++++++++++++-------
 5 files changed, 407 insertions(+), 110 deletions(-)

-- 
2.51.0

