Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761C31A072;
	Mon, 20 Oct 2025 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967732; cv=none; b=lhRda2KzizCpy0I9NsDoFRSnI1l6HiFF249+l2yqTOiIBSwEaslxMtngy51aBpMamUSKozu0JEct7XanzZCkFFxVFM3LOqW49rd8R7OJuUdz3ygpMVDgZ8rrOe1BgBckKfD0pRj2o6/E5Q0URCg5KuffdAu+sXzVloYzjimf/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967732; c=relaxed/simple;
	bh=iZB/n1Ds7E99ZFQKBXaAj5GJS2t+No+GlM3Q5V3jT+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KU5IJQRTJra0n7yltduNOTffeUZ3PtWBjTKjoXztUB3mYHQdQPf9Npj8AgXz6dlbY94dnmFCwhx1BppERTKGxlZzaCL0GnR32se8TyGqlk4aIPUF6wLzZC96qIfuGATty62XxthpOnS1kOO7QG6QLSRg6cVT1af4DAk5r7gUFT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KH8czoig; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KH8czoig"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760967731; x=1792503731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iZB/n1Ds7E99ZFQKBXaAj5GJS2t+No+GlM3Q5V3jT+0=;
  b=KH8czoigtBZl1mJJTJMpKjBcY3NJnfhDJBP6UtdJhA3V5cW2d7OHWGkr
   milGDJg6wFcGrF2O8BQb59sHpNdcaKk/+cid5Z1ijSl4d2uL7lQ/tVlmU
   MvdjUT3fxEafcygZcEMcGiDB/cjnzU9JSkyq2jl38vdnstppcongGfQpq
   BBgelu+HE7qTojPLxt5zw9XT80ugJQxcysqHf7zlzJpjlzMTiO3AXlK6e
   ZGEWEvrI9Vv8v/OI3DFLZ6Rpmf1g8bMsIbRFVor3+qR5vPm3aoK0WFyYO
   5fnL6uBML62Jhisuet1fyi/c/ctV8Del2Zzw4mxKLyLfBt3tc+LPuJmPJ
   g==;
X-CSE-ConnectionGUID: /JpE5pm8Tnyu4rX9ZkeJHg==
X-CSE-MsgGUID: qCdOPnOHTv6ia6SUDKe56g==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134518651"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 21:42:11 +0800
IronPort-SDR: 68f63c32_Rj82fTvz8BtTBul00RQfz0+wr593tLOFPc5wSDiNCY0k6nW
 +f2g2OxXwZt4CCJLxS1+rgjXicx+CYw5sSTgOag==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2025 06:42:10 -0700
WDCIronportException: Internal
Received: from 1pgdl13.ad.shared (HELO neo.fritz.box) ([10.224.28.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Oct 2025 06:42:06 -0700
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
Subject: [PATCH v4 09/16] blktrace: add definitions for struct blk_io_trace2
Date: Mon, 20 Oct 2025 15:41:16 +0200
Message-ID: <20251020134123.119058-10-johannes.thumshirn@wdc.com>
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

Add definitions for the extended version of the blktrace protocol using a
wider action type to be able to record new actions in the kernel.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 16 ++++++++++++++++
 kernel/trace/blktrace.c           |  1 +
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index a6958708d477..3a771b9802aa 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -94,6 +94,7 @@ enum blktrace_notify {
 
 #define BLK_IO_TRACE_MAGIC	0x65617400
 #define BLK_IO_TRACE_VERSION	0x07
+#define BLK_IO_TRACE2_VERSION	0x08
 
 /*
  * The trace itself
@@ -113,6 +114,21 @@ struct blk_io_trace {
 	/* cgroup id will be stored here if exists */
 };
 
+struct blk_io_trace2 {
+	__u32 magic;		/* MAGIC << 8 | BLK_IO_TRACE2_VERSION */
+	__u32 sequence;		/* event number */
+	__u64 time;		/* in nanoseconds */
+	__u64 sector;		/* disk offset */
+	__u32 bytes;		/* transfer length */
+	__u32 pid;		/* who did it */
+	__u64 action;		/* what happened */
+	__u32 device;		/* device number */
+	__u32 cpu;		/* on what cpu did it happen */
+	__u16 error;		/* completion error */
+	__u16 pdu_len;		/* length of data after this trace */
+	__u8 pad[12];
+	/* cgroup id will be stored here if exists */
+};
 /*
  * The remap event
  */
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d1532df84cc8..185f19c9f772 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1616,6 +1616,7 @@ static int __init init_blk_tracer(void)
 
 	BUILD_BUG_ON(__alignof__(struct blk_user_trace_setup2) %
 		     __alignof__(long));
+	BUILD_BUG_ON(__alignof__(struct blk_io_trace2) % __alignof__(long));
 
 	return 0;
 }
-- 
2.51.0

