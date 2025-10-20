Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D68322740;
	Mon, 20 Oct 2025 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967723; cv=none; b=bZ+8c1Sm/D6VHeZEFx88P6BN+4vEzMvds74wkrTgJ0NwPiL2HKj5r3odOA88Hv9ZlTlzf5arKLTqjvotdKjMQOWgLlExocTu2oiWnjA8Acz4S5s8aZJ/oA8K7FCD4QN5tqhTGQvMQ8CprsVtbC4Ix02Ff8YUkuA4zJ859z/0Nfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967723; c=relaxed/simple;
	bh=2pV7GzYdMScrmif7cvlowSHBO8110VklUY8PhnhIh1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/yVGfNc/6ZxTgu3bYqOPpUhi9P6MLxnzOEJR0hp7rrFjl5B4ObzunQZN31Ab1QcVOb8YeDYtFF5LCphCiBNYuWrJdjQdqnAu1lVQa6hmrIkGzAxCpXIonTnnC9K7rZ8J9RO8L493pTccGr7bkMGPi++c74D6ien08LyzwYdRJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ies3WJm7; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ies3WJm7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760967722; x=1792503722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2pV7GzYdMScrmif7cvlowSHBO8110VklUY8PhnhIh1Q=;
  b=Ies3WJm7rW9ecYAChNJDDclbe3jlLvB8CmLRGHSB/TRPmNBsiHl6oPdP
   ycyEdcQVdlflP03w8NIXeYsVjLpstOoECgo1SgLPTcFZYqFzCqZRw7Gx/
   /2IMGo0EHKB1BEunxWKMpeVZIubxRv55eKYXaWPuaoJKj0RQNJ2QHQ3p+
   yyfK+Z9alGfaH/Ud7dKWb+2PrOLsRuprcV5nqwjt2/WeV9g8dYDcl6uvV
   UlhM6ysbo0rqqi9b36/CUQOG3vK6kpsuw+dc33Hq3FizT1J/fPOQPZ/xE
   EOFBhi+bSqrP3doyebJkdgKUWEUmFXidxgYBV3Uu5Nth/jvpGKfRqoCYy
   A==;
X-CSE-ConnectionGUID: EdNidgTGSWehrqm8cm2Jsw==
X-CSE-MsgGUID: 5y0jXk1wQbOkubX5amTNMg==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134518643"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 21:42:02 +0800
IronPort-SDR: 68f63c29_j7u0UNhYfOpwQqC1XQhqV1FMW4Ls9KB06cs2hzdgleZzAPe
 CsYA51nDR9UkHp6w04hIOgWGYb4ndf7ame4lJ3A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2025 06:42:01 -0700
WDCIronportException: Internal
Received: from 1pgdl13.ad.shared (HELO neo.fritz.box) ([10.224.28.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Oct 2025 06:41:57 -0700
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
Subject: [PATCH v4 07/16] blktrace: add definitions for blk_user_trace_setup2
Date: Mon, 20 Oct 2025 15:41:14 +0200
Message-ID: <20251020134123.119058-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
References: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

