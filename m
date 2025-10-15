Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7195D32038E;
	Wed, 15 Oct 2025 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525842; cv=none; b=Qb9KbZ1Kr+oY7BtpUhDx5KPNGEv7t9K5rEHA+DY82j1qUGsnKa30EXjepxc7KZSglX+E8fyGmK5oO8rS/P6cuP5ZzdyzOZ5ZmWlCbXkN57E/nxhPyHFJ60MK9JLIClLE17VjhDw2zJvHQyUBjSnjHETSRY/OIZxZFG/GTPVN++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525842; c=relaxed/simple;
	bh=A9i/EQhJi0Ow9YEwo+10DFKddH+N3wGL4JtkApNzI1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DE5qxbklZok8DPfvYIUZWpuAp9hlzA4P/uW0upnM1B7LKxeqNMLF6fFlSxjz4ZLcKRxylMqiSNokCg+9T1iVc5mrcNtPn74hX3hImrU9rgiXitzSn6/LqKq/wLnIBLNHWQov7qSQFseBx45YdxrmZNmRzvGlR+n+4tmQrGWqANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rmJuq/5W; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rmJuq/5W"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525840; x=1792061840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A9i/EQhJi0Ow9YEwo+10DFKddH+N3wGL4JtkApNzI1g=;
  b=rmJuq/5Wh9qyYhHTs74IbcoZ+2IoDy0Hf6MODxYQb52hjvLGmVbgqOni
   bOU7dP8JvNKy6vKG8GPfJGX0ZtMrOn0z7FnyxAZ5MFbTWwF6E2o5UhgeQ
   3dIZKxjKoztbT4OeUnF0XlpPOnvN1yimkaNyuDI3CCg+NvWHUtb60Ni1Q
   fdh1z3xyFEHtySFzkcjcDJQjgd/5YW/B6WPM0bza5FIvOQtXu3mw0Nf3t
   iK2uNoyeBFW2/qBDTlR1dL9eAAcYrK54BxlJ8oNAff0qIwXD5qKOVkBsA
   +5nw5b0IrMF9Q8ZodL60lGHgLmCeHs7QSFUbOH7+25nzM4WwTjPfe6lej
   g==;
X-CSE-ConnectionGUID: 5vkaTIi6QwmoFGYlVKJFbg==
X-CSE-MsgGUID: r73njTaGTca/bF+07HD5nA==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935349"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:57:20 +0800
IronPort-SDR: 68ef7e10_OITH0oHN5F1l9oUPfcLwzuOFqE8YCkKX1ta4j23R8K+GUH9
 7pW2N+/S4njGZ0+gjE78s0Upte+Ih7PEv3avDdg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:57:20 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:57:16 -0700
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
Subject: [PATCH blktrace v3 03/20] blktrace: add definitions for BLKTRACESETUP2
Date: Wed, 15 Oct 2025 12:56:41 +0200
Message-ID: <20251015105658.527262-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
References: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add definitions for a new BLKTRACESETUP2 ioctl(2).

This new ioctl(2) will request a new, updated structure layout from the
kernel which enhances the storage size of the 'action' field in order to
store additional tracepoints.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blktrace_api.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/blktrace_api.h b/blktrace_api.h
index 172b4c2..ecffe6e 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -139,9 +139,25 @@ struct blk_user_trace_setup {
 	__u32 pid;
 };
 
+/*
+ * User setup structure passed with BLKTRACESETUP2
+ */
+struct blk_user_trace_setup2 {
+	char name[64];			/* output */
+	__u64 act_mask;			/* input */
+	__u32 buf_size;			/* input */
+	__u32 buf_nr;			/* input */
+	__u64 start_lba;
+	__u64 end_lba;
+	__u32 pid;
+	__u32 flags;			/* currently unused */
+	__u64 reserved[11];
+};
+
 #define BLKTRACESETUP _IOWR(0x12,115,struct blk_user_trace_setup)
 #define BLKTRACESTART _IO(0x12,116)
 #define BLKTRACESTOP _IO(0x12,117)
 #define BLKTRACETEARDOWN _IO(0x12,118)
+#define BLKTRACESETUP2 _IOWR(0x12, 142, struct blk_user_trace_setup2)
 
 #endif
-- 
2.51.0

