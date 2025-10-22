Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49E33F8DC;
	Wed, 22 Oct 2025 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133334; cv=none; b=X7MKrcXfq6BhHdeG0DrULmqxY83EtdSGoFzGdP/Fn9JmjG1bbiEgv35xXZTq7zq9KxB9BryafLx8S4w6zMUCZowxYO/lMjlnLY3yDyXoPQTj/d6oIL48mQ1jzCW6TMiNDdwjhsbzvWBR5UEyrLwNn/OWe9dqh5SbA40FqxcgZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133334; c=relaxed/simple;
	bh=iq2X3nOgnodZJ+8DGg7jgGlCzZQ9MPo4YQTwgSs3PUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dmtqr4sc/ge6a1FRG8PRqoRp8yUxIeX/xWxLHWzL5RJAmNSc8Yh9tziolZsl6n9fj92IsAxI77+D45sLMXcw7Y/nEOcWkYZcuzvdp1iPhETPhFjZ/72bF6wNiDvLi8nKgweQoViDooK6frXPfG9OG+Nfr9C//HW0prVMfHVLTBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=j7Ziv9R9; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j7Ziv9R9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761133333; x=1792669333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iq2X3nOgnodZJ+8DGg7jgGlCzZQ9MPo4YQTwgSs3PUw=;
  b=j7Ziv9R9mu1hpugb61dzqHUxV2iKN2nTDDZsLZz8U8OMQt/UK/ajWRpN
   rcKaTceEyDWxdLdutXwwgiHILY5GrUslC3d3b5uAfxk0nqMMhX3g7Y0Bp
   FwIeEM+EqP1TUjT1eoQ27YD3IxaR1UVXH/1fWSYFYOw5z6qB9pokS5fdE
   +PaHH0PPtQP9L1wvuEGA0/U6uOkqdkXkFU9ZUrezPqmcyOevsW3uUMmCN
   pO2wvwFUzjxbmwlJq8zqPZiACM5dvC7+A+/hDS9nlmDya+IZvKJGIGAsa
   jJqg9ufa3NDZ2c4r/n3qmaFb9hi11UVVfdMLIv+Rv1zHnW+JgLKv3Ph+A
   g==;
X-CSE-ConnectionGUID: 8e1Lg5WwTxWGWi8wTjv5HQ==
X-CSE-MsgGUID: so8vYTkZSQq7G3s96BLwIw==
X-IronPort-AV: E=Sophos;i="6.19,247,1754928000"; 
   d="scan'208";a="134645048"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 19:42:07 +0800
IronPort-SDR: 68f8c30e_l9Eyavs5yy3th084WWVfCb0Yta9BVigben/0R/smoCUSYnZ
 VLrWXLDIOgol8ES/FgT/lnTQW50Mp1zdTkTALqw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 04:42:06 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 04:42:01 -0700
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
Subject: [PATCH v5 07/16] blktrace: add definitions for blk_user_trace_setup2
Date: Wed, 22 Oct 2025 13:41:06 +0200
Message-ID: <20251022114115.213865-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
References: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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

