Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AE933EB01;
	Wed, 22 Oct 2025 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133286; cv=none; b=ggDo9lqTk0WoiaQWvZ+xQDdrkdOKEf7VU1LpbHrlEhnYV4KU1Afpw9A+EW+j8zomanxiMu0lcolc5buXLWGwP1C3q+Nb8dWfcvJRHYecJ+EeXnIr2vFiPjtg/2DzxDlbEXgUHFr3OAgOt043Vk/So7u6wLNiOYdyP74V6sHZNu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133286; c=relaxed/simple;
	bh=Pycf+qTTqYqWAPp5ojlxbydUTMBdFmouHwknGtVpqS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OZKA6WE5b9AA0bC3No9U4hkW2oMxuU2xjsYn1UO+uXZ1/3XJVLqxe11ZZJSdToM+iNVES1pArP5tnAN/Odp8kd9Xxjd90H9ycQqAHm4fd6od2CgVMNvuHJMjsTh3iB3n4WDx+itcVORHmgFho5GhCP5we4M/q1DI2mawoAOzbFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GgOcD8lP; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GgOcD8lP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761133284; x=1792669284;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pycf+qTTqYqWAPp5ojlxbydUTMBdFmouHwknGtVpqS0=;
  b=GgOcD8lPr58rf9PjWEu0p6GVPBMkGy0u8N2htglpoRVxe06IpgHlPqlb
   yhiVACIol7o6LUvw18eAKvR3Ft1BM+K8FH9L6mzFBTnvvak8KM2voTw+G
   zvkkMQ1aBqu9WdXSb8DJ9STfiJyZG8gI45ySS0LT+V2l5xdKR4ZDI2WcF
   HhXXrNp4tVTktoEy8DjMvh6zyUlZCRS16Hd9nxFKuuTtfwCGFrr12o2EO
   p+o/YJeLjxYHQh9BftKZRf6OczTO39GTFRy5DKcCiI/03B8KTfLDhHrTH
   X/Anyq2POWFOqR5XtyKO6Al1k06u+LlgBIKTRQqkisCPpPO1YGGXcJ0v1
   w==;
X-CSE-ConnectionGUID: kGA3FXepSF+L8FdELoJ/+Q==
X-CSE-MsgGUID: ph3o0JYPQ/aXxSsHJQ+Udw==
X-IronPort-AV: E=Sophos;i="6.19,247,1754928000"; 
   d="scan'208";a="133361397"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 19:41:23 +0800
IronPort-SDR: 68f8c2e3_Rc2zOgfTVJFx4Alp5viqMbE+RyL0a0cB6IBLRlulGRRqIua
 QrUiz2ufY/w0SEU1qgnXpZeGxQVBQhYGGbpqzfA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 04:41:24 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 04:41:18 -0700
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
Subject: [PATCH v5 00/16] block: add blktrace support for zoned block devies
Date: Wed, 22 Oct 2025 13:40:59 +0200
Message-ID: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
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

Changes to v4:
- Fix grammar mistake in comment
- Remove unneeded formating churn in trace_note()
- Return after WARN_ON_ONCE()

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
 kernel/trace/blktrace.c           | 468 ++++++++++++++++++++++--------
 5 files changed, 405 insertions(+), 121 deletions(-)

-- 
2.51.0

