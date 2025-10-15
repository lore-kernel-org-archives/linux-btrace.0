Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525CB315D4B;
	Wed, 15 Oct 2025 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525723; cv=none; b=fOOwnd4QUfoPZLqun80+bn/Vyx1ayddQEdUuK68bgWHeZpDkdULPoU/zZOfFZdWks8360pToYUbcWU3P/lEugBJM7M+4CPcOcbZDIah7gwwadAsqD/55+rpnSw67tfGlJCNfvnUl3G4oK+3q2fZGHnBDCsHhHgXlfUhio9cEURM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525723; c=relaxed/simple;
	bh=unBG/7a9qyOjLgd1M3SeF78k23JU38BsIJnhxE/jOTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2XUPinM1ekrS9a/5VTOj38/SmZO16JYM5rOHqc13JQtW6nmHgzwnP2gWzWZy7ICEJfRYLsLcng64eDmi/D8ImZDZT79lAAFGZ5eG/UQQ40sCqi4+VPE1T/6cYfGoMyRZaxZfhLtP8C/Pn8DNC20m+pMXu4cTXFXEh/qkPb+fhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fuVDfn2l; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fuVDfn2l"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525722; x=1792061722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=unBG/7a9qyOjLgd1M3SeF78k23JU38BsIJnhxE/jOTc=;
  b=fuVDfn2l6KtLxOU9utKvDytVvG7XCxhM13u8G6w74e1ADltvaY7VeOA1
   mEI2b486o8hbwUNibvTYpVnhvBvyWq+DA4ZbFlQDT5ofqZZpgLwVJqf6i
   IOhrFtwi9+ADlNZRvywF4meVCODWhZiTTsWIC1RQDlMW7q9BMDWgJIu+b
   xNYCQU0O6hXic+xqdUAOQSo9J0sx0aGACLAWyHQ61O7pDJJ5hlc+Lqpe9
   lQfRdIrqhYvv9TZIzJZEbcCpPRXVFdGOmqquhUYWVW98KjqiswLm9heY0
   JjwmZqT2CWyroEWx5Frv2URzf42OTegHwnNShAAhdbm/1i6Ly5KJbzbAP
   A==;
X-CSE-ConnectionGUID: zTlgyekDRcyn4WRkboj8QA==
X-CSE-MsgGUID: J/U23uzxQjG0MMpzPoMxxQ==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="134197634"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:55:22 +0800
IronPort-SDR: 68ef7d99_qBJdLfCyojIEzY7mEbdqbn+x2j7wnJcf4ScefUa8/wOtPdD
 r1HdrU/gEYp+Cwv9KPEac522iZI0EbPPAI3kkuA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:55:22 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:55:16 -0700
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
Subject: [PATCH v3 07/16] blktrace: add definitions for blk_user_trace_setup2
Date: Wed, 15 Oct 2025 12:54:26 +0200
Message-ID: <20251015105435.527088-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015105435.527088-1-johannes.thumshirn@wdc.com>
References: <20251015105435.527088-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add definitions for a version 2 of the blk_user_trace_setup ioctl. This
new ioctl will enable a different struct layout of the binary data passed
to user-space when using a new version of the blktrace utility requesting
the new struct layout.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 16 ++++++++++++++++
 include/uapi/linux/fs.h           |  1 +
 kernel/trace/blktrace.c           |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 1bfb635e309b..a6958708d477 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -129,6 +129,7 @@ enum {
 };
 
 #define BLKTRACE_BDEV_SIZE	32
+#define BLKTRACE_BDEV_SIZE2	64
 
 /*
  * User setup structure passed with BLKTRACESETUP
@@ -143,4 +144,19 @@ struct blk_user_trace_setup {
 	__u32 pid;
 };
 
+/*
+ * User setup structure passed with BLKTRACESETUP2
+ */
+struct blk_user_trace_setup2 {
+	char name[BLKTRACE_BDEV_SIZE2];		/* output */
+	__u64 act_mask;				/* input */
+	__u32 buf_size;				/* input */
+	__u32 buf_nr;				/* input */
+	__u64 start_lba;
+	__u64 end_lba;
+	__u32 pid;
+	__u32 flags;		/* currently unused */
+	__u64 reserved[11];
+};
+
 #endif /* _UAPIBLKTRACE_H */
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index beb4c2d1e41c..957ce3343a4f 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -300,6 +300,7 @@ struct file_attr {
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
 /* 130-136 are used by zoned block device ioctls (uapi/linux/blkzoned.h) */
 /* 137-141 are used by blk-crypto ioctls (uapi/linux/blk-crypto.h) */
+#define BLKTRACESETUP2 _IOWR(0x12, 142, struct blk_user_trace_setup2)
 
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index df90422ae613..c31b8f433116 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1601,6 +1601,9 @@ static int __init init_blk_tracer(void)
 		return 1;
 	}
 
+	BUILD_BUG_ON(__alignof__(struct blk_user_trace_setup2) %
+		     __alignof__(long));
+
 	return 0;
 }
 
-- 
2.51.0

