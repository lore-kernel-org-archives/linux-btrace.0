Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B0D2E2EEF;
	Thu, 25 Sep 2025 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812676; cv=none; b=qQC3FWQV7b37L5/QhJ/09rWAP6L2b0mK50ijwP+nxPMyCJMHU5BPIcjpsf46J6FczSk848ug0jOLJJHW7urxHoHXTfIoh+JedbWNeMQOu1LBAqzGIAOius9qcHALVCGKSm7QhcBcOR3E3XWijE+1Hmon2SYy/h62+6LFld0yXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812676; c=relaxed/simple;
	bh=J5c05JPLFQaQf493MRt52YrZ3USWRzmeRc0rCzn6SFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MRvPQkjGbl3/rMU9dQJSHBtbxvTTI4JikirMOc3DT3/lX1e/jRWD+i8by2rn9zmZUIQ9ihv0TAA/hbZeiWYdU6cejXxL/q2T84IvhYPa8OYFQxmh01srWPOcBOg321ZXr0tZXNln+XPME2k/xxrx6ml3c20D4Fi0C9K8CSZVwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=np/NfFDi; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="np/NfFDi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812674; x=1790348674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J5c05JPLFQaQf493MRt52YrZ3USWRzmeRc0rCzn6SFs=;
  b=np/NfFDi81pbkrlXpQSHSDYMMyvXX2Jm1QsxFbFhUyM2XQlRPNNGhzn2
   8WbgeiODQPwdH7Ej30dpthXrEZ09uxX/fuPopFww+bJvM0390LxDgsZGv
   M+zxyjJAarDqD4rY/wI/i9YzZqTxDiQ5GjnnnFcX2D1jWfaluvsJFJPsV
   GaHmizI0SphYpnPVVvTUAA3FV5niefaOrIJqSQPXrmvl+G1dlteO0upPw
   Uq7wXxDTCpEYmINlJGKfZvlP6FhCt72i2lIPuc2N70KOoHWMTSnaSkvYe
   mK8PBOoGIR1smquClIalAOWgb63x+iNZEeLcjY70flDHwIYvYMs2X2BYV
   A==;
X-CSE-ConnectionGUID: b/OwKdZGTBmaO3GUQ8K91g==
X-CSE-MsgGUID: ffHeo2hARgioC1jL1Ok+xg==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130348629"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:04:34 +0800
IronPort-SDR: 68d55a02_2pnq452OsCIEgVQSFys7UBv+lAU1PLVOErDaBOJZLTbdroj
 NRQ0ZTC5hv+hvYrQZwUiDKzVtY7sDc/3ZAd3s1w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:04:34 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:04:31 -0700
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
Subject: [PATCH blktrace v2 00/22] blktrace: Add user-space support for zoned command tracing
Date: Thu, 25 Sep 2025 17:04:05 +0200
Message-ID: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.50.1
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

Changes to v1:
- Incorporated feedback from Chaitanya
- Add patch fixing a compiler warning at the beginning

Johannes Thumshirn (22):
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
  blkparse: parse zone management commands
  blkparse: parse zone append completions
  blktrace: call BLKTRACESETUP2 ioctl per default to setup a trace

 act_mask.c     |   4 +-
 blkiomon.c     |  15 +-
 blkparse.c     | 452 ++++++++++++++++++++++++++++++++++---------------
 blkparse_fmt.c | 105 +++++++++---
 blkrawverify.c |  14 +-
 blktrace.c     |  40 ++++-
 blktrace.h     |  64 +++++--
 blktrace_api.h |  54 +++++-
 8 files changed, 561 insertions(+), 187 deletions(-)

-- 
2.51.0

