Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BB32DAFBB;
	Tue, 25 Nov 2025 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057132; cv=none; b=gqdJOZa0SSkYBt4L3XtONv7ti67F90okWwBvG/OBGOYXgS8gBEtzqgpRKbauFJi9FLczE6r34CMWxF/K5puNKDI9zKsiRaatWc2XxD/3lwVR3VvNQ6Qa0gsyeOOXFM+mCXhGtC1yQRuSyA8xLh5WZZrY77PHgrX/W8tG7Uyo2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057132; c=relaxed/simple;
	bh=YfM+sir/wr1FkT4ZyvfjYV+a8N1LCekj9G5STlXNy2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lhn4DSn9w4SFAujFe57a65iXXhaqLJcxUnVSpgh9unCDAvlOO9voJ95eHHIFOUEQ6/7wpB4z5OnTYEBIobFn2U1I5JLBIKMeLUxskPp85pO3UC4T9xH5uuFQgxfOWt3c/1bBaGRAhZ0XVc+O6/hEsmGTu+lG9YABnjletWYvh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GYnb112g; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GYnb112g"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057131; x=1795593131;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YfM+sir/wr1FkT4ZyvfjYV+a8N1LCekj9G5STlXNy2U=;
  b=GYnb112g1Gxxy3MNV1jWvMhj0On0diqeKGRKNiHznsoe5ChloYn61Xr6
   Xb03AE2q2e4zeKvQIG/miGbWKQqDQ83cWM4lsRIh5/PljkDcRarIOcZQv
   3x+9K+XxRRF0sLQmd+fj+tkjR6MHZZBQe8xJcs3r9o8Bvhad7/wjHhm9M
   +7iUqXKvjlQ8Si4TUgDTgt2rHIQTYtKYZfUnamVyo0ANjyqy8GjyEznOm
   4gOcEOBRmQXNJWxl4vAN34jau4QOgIWL4EXJeB86mwmJwHGWW2TgH3Qlj
   aDbmoE77MPS+sIifwXl7ZNzRgx/q5YrkPDrS+UikWWId8dxfgpDxRMip8
   g==;
X-CSE-ConnectionGUID: Wb7FHjwjTVK0wtRGzFOXlQ==
X-CSE-MsgGUID: 10chDw+hQ+6LSyCOrVZtHg==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749773"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:10 +0800
IronPort-SDR: 6925602a_VEuWl+G30DlJi2E9wHyxjpfRKeiXr9aUiVmuRz6yOarurPX
 10H2TvskeFCm12BtLtfhtgwk6GvndsCaemLp0EQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:10 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:09 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-block@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 00/20] blktrace: Add user-space support for zoned command tracing
Date: Mon, 24 Nov 2025 23:51:46 -0800
Message-ID: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Aplogies if you recieve this series twice, my ISP effed up badly ]

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

