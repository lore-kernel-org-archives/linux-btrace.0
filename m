Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33B2315D4B;
	Wed, 15 Oct 2025 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525690; cv=none; b=LVl1ctdcDwFJFcbpg1fCyJwi7uLrLi+SdvuT/eXTCEtlxwuZrpPvjj2gIM2d78ErMCpXwYoZwqFxaJFR+YEM1jO58NsvmITC6/rJfxkCIEGamikuinLnCZw9tS0kBVvOXMwTyEVc3r4feNfgUfiYNkkdGF3MZMOXfzrXufxjJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525690; c=relaxed/simple;
	bh=g/iLYh2IpnYDwqIk7mIZMhBVwOhAH5CIKI1bcGikEp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n11uoFMgSSOku/7HCJ8Q8/N6wAgeexDKUOO5H8ILD/rxmh3TDN/msUqP1sCQZVczsu2Ul+vtlHdJqotOMnjokCisi3wUK+WMTb3004WpnJYhkJznr/s46wrkYaIxbO+t05Vu/tqZ5TqdQw4bFh9lnQ0YxkdKLl7ouP7IvAviPLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GVIPKyqG; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GVIPKyqG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525688; x=1792061688;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g/iLYh2IpnYDwqIk7mIZMhBVwOhAH5CIKI1bcGikEp0=;
  b=GVIPKyqGQeqjCsC6wlSw+K3jZI1u0JGCfRpwgjU36wVQHz/n5JXGVksQ
   Snksq1nKheMoUwkmr/k0TkBb6z4eNXzDCf1w9pr5H2ZC8ddrfZ4ZxJnYH
   +RzEdt5utAaEW2fVzMZjU5ZuEfQnqo3sqcr0V6EIxBDOf4QA7rKUdCgyc
   PVH8cn8YRtUjetz1hSUhH0zNSQbVTx+Op771Y8HifBpdAscD0Tj50vHF6
   C7lGCRVFdsKirsepQsB9McmkLAQ+Zd2MKxQPxvX2eOqwxQId02VKdWz3K
   LzbkctAQECv2SZrlftADgVE+yebsFFhUxtGel3NFvt9o6gMfuN9kKG1cT
   w==;
X-CSE-ConnectionGUID: c7CrrGV/TmO6ga+ikI2pvA==
X-CSE-MsgGUID: xoL1fy1RRTabcBnUoX3c7Q==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="133261942"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:54:41 +0800
IronPort-SDR: 68ef7d71_hc9hL4PVLg1DAufmuX8cOZGUDg0PdKjPOJcY/zrw2PqdI0i
 AWNIPhFDsHCmg/vgvJo/53suvqJbS5BBaveWEnA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:54:42 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:54:38 -0700
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
Subject: [PATCH v3 00/16] block: add blktrace support for zoned block devi
Date: Wed, 15 Oct 2025 12:54:19 +0200
Message-ID: <20251015105435.527088-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series extends the kernel blktrace infrastructure to support
tracing zoned block device commands. Zoned block devices (e.g., ZAC/ZBC and
ZNS) introduce command types such as zone open, close, reset, finish, and zone
append. These are currently not visible in blktrace, making it difficult to
debug and analyze I/O workloads on zoned devices.

The patches in this series utilize the new trace points for these zone
management operations, and propagate the necessary context to the blktrace
logging path. These additions are designed to be backward-compatible, and are
only active when zoned devices are in use.

In order to not break the user-space ABI, a new ioctl was introduced to
request the new version of the blk_io_trace with extended 'action' field.

The user-space tools in the blktrace suite are updated in a separate patch
series to interpret and display the new trace events.This patch series extends
the kernel blktrace infrastructure to support tracing zoned block device
commands. Zoned block devices (e.g., ZAC/ZBC and ZNS) introduce command types
such as zone open, close, reset, finish, and zone append. These are currently
not visible in blktrace, making it difficult to debug and analyze I/O
workloads on zoned devices.

The patches in this series utilize the new trace points for these zone
management operations, and propagate the necessary context to the blktrace
logging path. These additions are designed to be backward-compatible, and are
only active when zoned devices are in use.

In order to not break the user-space ABI, a new ioctl was introduced to
request the new version of the blk_io_trace with extended 'action' field.

The user-space tools in the blktrace suite are updated in a separate patch
series to interpret and display the new trace events.

I've tested on SMR drives, TCMU emulated SMR drives and zloop, with both XFS
and BTRFS as filesystems on top of the hardwdare. Testing of different
hardware/setups is highly encouraged.

Changes to v2:
- Collect Reviewed-bys
- Convert trace_note and ftrace's blk_io_tracer to blk_io_trace2
- Don't play games with the layout of the 'action' field
- Fix structure alignments
- Drop Zone Management trace action, it's a command not an action

Johannes Thumshirn (16):
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
  blktrace: move trace_note to blk_io_trace2
  blktrace: move ftrace blk_io_tracer to blk_io_trace2
  blktrace: add block trace commands for zone operations
  blktrace: expose ZONE APPEND completions to blktrace
  blktrace: trace zone write plugging operations
  blktrace: handle BLKTRACESETUP2 ioctl

 block/ioctl.c                     |   1 +
 include/linux/blktrace_api.h      |   3 +-
 include/uapi/linux/blktrace_api.h |  53 +++-
 include/uapi/linux/fs.h           |   1 +
 kernel/trace/blktrace.c           | 463 ++++++++++++++++++++++--------
 5 files changed, 400 insertions(+), 121 deletions(-)

-- 
2.51.0

