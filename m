Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C5D28AAEB;
	Tue,  9 Sep 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415987; cv=none; b=GJwEbpIHO2uxDBOh6i6zP9k8GtE9TYQcGnvURqXxBu9VIoTamEAaYI3PYE8pOegxHOqCLCIJrwhQD49U1Qz7LWwnOwpB63LeOXZoAjKlJWRC61Mn2kVY8rXF47qBxGbTnpMFCkvm4lZ872fPZC9Fv7svV+bG23YH8u4XPkFKhdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415987; c=relaxed/simple;
	bh=BrQJkG3M6/o5DS3+3WjfFokEzXUDWFakzUkZ3U/06Oo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Io/XV9EVQ8RpgnepBXKD3yLcgKvef4NbHEphNQvi2/VAiuqM7Xu1Y2X9w4dLeywrVV6SnNCNj6j3W1X83OiFfRivbSjsH+NfgHoOVMnZo7tMNnomZ6zgnGMHP6Kq2hoM4Ep2a72tZHmxJ5VDanM2gLO8s5MJSh7d7d6G1Hamh9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SGYvA8fa; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SGYvA8fa"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757415985; x=1788951985;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BrQJkG3M6/o5DS3+3WjfFokEzXUDWFakzUkZ3U/06Oo=;
  b=SGYvA8faaofGFD0CY6ltpW9Uo7l2eqYLytRjMqFuB+0MDzbWzKJdnk9Y
   nvrum9uf99sRDVbRko+M0QdewFMMW5X34w1EpHTkQ6WTjfSBaSfCAUcT1
   m+OB9cXc85lu3+hmu0p+dbB5zkUMSuk7dgKERswrSfw/gQAUHl+HIrbHL
   +PSOwL++lNlJ/JEYPxetc15FsLWJJuW/Ou1BNGp8ty93RRNG+Egj9eyq0
   EMbSyeda2xWrACMmDixyL3jZYrDtaixBOsY7ACzoLlXwB5SZl73yi+Kxo
   +U6GGYgBXFQv9duhhG0puI0UqntDKRzdkaIptiC1yUlYsjxCMxQkhkvvk
   Q==;
X-CSE-ConnectionGUID: tGmk0HTjRvy9fzN/QsfGCQ==
X-CSE-MsgGUID: W3qatkL0QYGKRIJdE+k/gA==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="113316886"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:06:18 +0800
IronPort-SDR: 68c00a2a_ByTrFhvdo2Nx3oTJn/H2Ta9C+4RqJW89ZNAdwdUKQVOCImq
 U2R1fzwtFCel1pSbRuxwjGJz1iho+7qvA7GKy6A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:06:19 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:06:14 -0700
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
Subject: [PATCH 00/16] block: add blktrace support for zoned block device commands
Date: Tue,  9 Sep 2025 13:05:55 +0200
Message-Id: <20250909110611.75559-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
series to interpret and display the new trace events.

Johannes Thumshirn (16):
  blktrace: split do_blk_trace_setup into two functions
  blktrace: add definitions for blk_user_trace_setup2
  blktrace: pass blk_user_trace2 to setup functions
  blktrace: add definitions for struct blk_io_trace2
  blktrace: factor out recording a blktrace event
  blktrace: only calculate trace length once
  blktrace: split out relaying a blktrace event
  blktrace: change the internal action to 64bit
  blktrace: remove struct blk_io_trace from __blk_add_trace
  blktrace: differentiate between blk_io_trace versions
  blktrace: untangle if/else sequence in __blk_add_trace
  blktrace: add block trace commands for zone operations
  blktrace: expose ZONE APPEND completions to blktrace
  blktrace: trace zone management operations
  blktrace: trace zone write plugging operations
  blktrace: handle BLKTRACESETUP2 ioctl

 block/ioctl.c                     |   1 +
 include/linux/blktrace_api.h      |   3 +-
 include/uapi/linux/blktrace_api.h |  50 ++++
 include/uapi/linux/fs.h           |   1 +
 kernel/trace/blktrace.c           | 458 +++++++++++++++++++++++-------
 5 files changed, 404 insertions(+), 109 deletions(-)

-- 
2.51.0

