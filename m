Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F142E2F1F;
	Thu, 25 Sep 2025 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812588; cv=none; b=OeBJvej+ZYvR1lFN6y0fROrGTvlNyNOpdR4WefmWNOH4k7UCIIprNIdHOzMDNSdl6n4WDS7m4wEEwMLMMPsf72D7QKX7K5+JEjJ+ErbAANkTC7pT2xlLGEwvGrSeX09/fbShnTbvjF1aT6Od+Oe6c1NzoYSB6Xspxp0UWCjVkXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812588; c=relaxed/simple;
	bh=Q06ElkC1YeIS96B+gJruwG4okAMRndVsd4fhyoRMYtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6tl0PS19ehPh6zg14PwMRBPyrJQ6g673oJ+YFMzOnk8CgFflGDfVxCcz8gHxQOYsubAfm6hG+YHBX12tEvuVxgIMIU/MTG48o7yzlHL2n+6+dHfKsmWyQ9DSKfrmCRuHLGBasNDTucW/jeOlnfF3t2bZFJWqanypP1EPzKUsWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nCImdaYo; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nCImdaYo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812586; x=1790348586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q06ElkC1YeIS96B+gJruwG4okAMRndVsd4fhyoRMYtQ=;
  b=nCImdaYoMjPVwHwsPncd/QgmxR2yXrGTYLZnm6ArpaQs63JKicosxqEO
   ha03hHSFxoHFDM+FMrb1yFPJXVep7OLkISmRSNXCs2iy5NUkUOTiFgLDl
   /7SPOJ0uYeOdY0zAkgg0LkBGncdk1TQP7LrS1mvEfX1y/KalgzHdNiDQY
   5X3usUDme/Qq7pooAilO469whI50zvzScgharKMJDrixN3Ykvq/UhyTHc
   +neO+1Ra25dX8FgMZGTLnMmL7+Dy+ayShlFJkHGpSdn57J3omXsL2Ygq3
   dyGTBoGPYSjcdONl2SQ7q5No0g88nXwYpjNzGgwu2zfS5aqWpYxlQSTL4
   w==;
X-CSE-ConnectionGUID: XcRLgXtXSk6JGNHx7C1GHw==
X-CSE-MsgGUID: 6vjtBnesTJOsuMi1M6yD3g==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130347914"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:03:06 +0800
IronPort-SDR: 68d559aa_at7aBV5Gs3NYa+Z20PBAqQYeTzcdHg5kIXBZ3mQ0mdbGO5c
 EoGmM8KtRYml332OFr4vXz+4t42tnTbWpumAcSQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:03:06 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:03:03 -0700
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
Subject: [PATCH v2 07/15] blktrace: add definitions for blk_user_trace_setup2
Date: Thu, 25 Sep 2025 17:02:23 +0200
Message-ID: <20250925150231.67342-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add definitions for a version 2 of the blk_user_trace_setup ioctl. This
new will enable a different struct layout of the binary data passed to
user-space when using a new version of the blktrace utility requesting the
new struct layout.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 15 +++++++++++++++
 include/uapi/linux/fs.h           |  1 +
 2 files changed, 16 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 1bfb635e309b..a3b1f35ac026 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -143,4 +143,19 @@ struct blk_user_trace_setup {
 	__u32 pid;
 };
 
+/*
+ * User setup structure passed with BLKTRACESETUP2
+ */
+struct blk_user_trace_setup2 {
+	char name[32];		/* output */
+	__u64 act_mask;		/* input */
+	__u32 buf_size;		/* input */
+	__u32 buf_nr;		/* input */
+	__u64 start_lba;
+	__u64 end_lba;
+	__u32 pid;
+	__u32 flags;		/* currently unused */
+	__u64 reserved[7];
+};
+
 #endif /* _UAPIBLKTRACE_H */
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 0bd678a4a10e..a85d0b52a3f6 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -300,6 +300,7 @@ struct file_attr {
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
 /* 130-136 are used by zoned block device ioctls (uapi/linux/blkzoned.h) */
 /* 137-141 are used by blk-crypto ioctls (uapi/linux/blk-crypto.h) */
+#define BLKTRACESETUP2 _IOWR(0x12, 142, struct blk_user_trace_setup2)
 
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
-- 
2.51.0

