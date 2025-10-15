Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027FA31BCB0;
	Wed, 15 Oct 2025 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525737; cv=none; b=fPM3Qj/E1wnJJpr7ZoGcxcq7NL4qBoJdPiaAFwCHFdg7dQJOIVqhKQ4J4f0KS5o32YdsLc3rq+vJXsmky8RfrdUYE4VekjYYZzgXatsKS43IlQiCo48g+eQ8tuivehhAj5wyBvQp/TKIBBuxpHJ3NaAReTRpmv/xb0m6WJJU3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525737; c=relaxed/simple;
	bh=eDwoupc6QWZlcgoUS9oBxojZ1uzI64mwjU6J2kmlWK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOjQK/XqznduPCPysu+AKD1TuDGRprI/lExI+YuPXdXrUNGIztxbA+VPu3vU4Nhx13s3ff7KD7AozlBDRBlg7bMkz2m3+4qNohHrIc3lwKK3Zc1M93i++MRdda1kfZn7/3upulNXxDNjCy31rAXQrCM2tYZ2PcEa1RFMj+gUT7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cn89P+f9; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cn89P+f9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525734; x=1792061734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eDwoupc6QWZlcgoUS9oBxojZ1uzI64mwjU6J2kmlWK8=;
  b=cn89P+f9KTRft/89Wf1qs+pO7oCMK6UIWa/F1LaUO2kdeu1ioxwEbTCz
   E+PYnYpmHGkQTWWcTVWhgFhA7tO2ShzCKYlT6aqe9d+br8Gjlv1s4DN5Z
   McooRyTjNHM7oR7ZGBpfRzDnzWMlv2rfV+Ug818NpEX6+batOpchghBx9
   Mg7pTbA+kTu65ADNFcqX7AtKtPiPRmYAn25Fz/BZ4BREm1whycD4dpF6O
   1gHRYuF47iTt/MCBrdj2USE490ZibBMWAuNsM7YouIDEQXylwTrKxdHcY
   2xPtSoEIowcnQreEDmE8VomNiApYs8oG9JXlru+g0gu8cNQPqgOJBOdws
   g==;
X-CSE-ConnectionGUID: q3g6JzekSbOamRsRfNm/Zg==
X-CSE-MsgGUID: 5QCkrsKdTB63fXnI/rwbzg==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="134197665"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:55:33 +0800
IronPort-SDR: 68ef7da5_sHDFxwKJGHCRGKeSm1OwKWZX4mstq11FDB9iY2y4lLuEhZw
 3NMZ6lFw7VubZ1fo6fnjdgKZQGEFMCdx/dGMfbA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:55:33 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:55:29 -0700
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
Subject: [PATCH v3 09/16] blktrace: add definitions for struct blk_io_trace2
Date: Wed, 15 Oct 2025 12:54:28 +0200
Message-ID: <20251015105435.527088-10-johannes.thumshirn@wdc.com>
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

Add definitions for the extended version of the blktrace protocol using a
wider action type to be able to record new actions in the kernel.

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

