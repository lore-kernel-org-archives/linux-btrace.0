Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175502D593E;
	Mon, 20 Oct 2025 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967693; cv=none; b=NJvVBG1rRDO1R8XuArJgE+SS6HCntLCuv6I/ao8WI+dcmkgP5StQs8muQU5d9z0fO2GkUdGtoGfOpFRNsU7SQEoZ2nen2PiAKKlZm1bNR9zXmwTZ+pKr3GL2yIhNN8/JOasdFGClF7HnQUq7vCbX8v230t/uczRb+pOb4VG34qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967693; c=relaxed/simple;
	bh=FM+4CKgTqEHgRlGR+4+oa8m0FN4419G5jVgSyaZsHYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rNFZ2t9YrHcp90gjPW1CG7PHFXmk+W++VueNOLW4lcnoOnTeTervRL6rwRGEOaccZ4Aa35g13n1x+gKYDoLNlVar2vjW7pNk+/hjct5n8SeK8f/SeRBGE4DUXbyBq6gRG6iJ8zxXxWiOiZq77buqhq4nhWK4VdcHZGz5PiAystk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=I4ISK769; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I4ISK769"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760967691; x=1792503691;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FM+4CKgTqEHgRlGR+4+oa8m0FN4419G5jVgSyaZsHYs=;
  b=I4ISK769rsobIuUzBImx6VMH7OEig23aoFYlFRkM4yQe40spDMc/OpUu
   hnaRkX8rSToQHnemfvdD+NG19WlAIAyAWf7N+uxRbm2JATwP6ua/tCdRk
   ZyODzpN83+Vd5WrwEF6H+Jov1Vu4U+9DAFPiTpMdGWN+lytO6AW3AuzIk
   BV5I7FEIadZmR6updM4R0mhzfgZ9LF7sM09Hej7jqWqU2VaRUrlvbplSB
   4kCCypid05EmyrpZ9tKYAxIuz2ImuTssFy80a4zGauyfoHAiH4MusVj4F
   5FD+ked9RG9eBv0tfjEQoxfY2O3yPb2/BFSElsbBNmWWOV0cTEIN1BoHN
   w==;
X-CSE-ConnectionGUID: Sb/BBNxbTFG2ZT2YFUXHfQ==
X-CSE-MsgGUID: cnXYDQm2TUWVsenM5wIZQQ==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134518608"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 21:41:31 +0800
IronPort-SDR: 68f63c0a_IoWQddeiqbDJaFXlc8AbWPq7TqIbb9ZZ5mJAvL8pTnxYTDe
 RW86HDyxiGF6yj5k7X8PnLs2HW2gUSS3sepaqCQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2025 06:41:30 -0700
WDCIronportException: Internal
Received: from 1pgdl13.ad.shared (HELO neo.fritz.box) ([10.224.28.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Oct 2025 06:41:26 -0700
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
Subject: [PATCH v4 00/16]  block: add blktrace support for zoned block devies
Date: Mon, 20 Oct 2025 15:41:07 +0200
Message-ID: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
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

Changes to v3:
- Collect Reviewed-bys
- Add WARN_ON_ONCE() in case a too big command is passed in v1
- Use 'if (copy_from_user())'

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
 kernel/trace/blktrace.c           | 467 ++++++++++++++++++++++--------
 5 files changed, 404 insertions(+), 121 deletions(-)

-- 
2.51.0

