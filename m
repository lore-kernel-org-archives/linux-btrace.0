Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A833FE30;
	Wed, 22 Oct 2025 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133348; cv=none; b=oknzKJ71gEwYAu69zNxgPcYw5uJlowz4Csg7TBtZczr4+QBCaollNmGwdw3/FFpG/dBEo3Nw5Q6skzMmi6MquemV7u8nzS6TfvAdiSe9IepMOS6jW9ngzSUicaJMib/BMF25daBpbvrcves26HjTXKSxWLWl5bKqU0/3gvHSeaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133348; c=relaxed/simple;
	bh=AuIHhNtYt14BLpZyopQ9lNncTR/cskfIc/vi+rtUyXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlURIbACYYo6ksko3RuNZGy5Y9N7oGJYIRBfzLNdqgElFj+u7lf5bwkuOVlOBkkPlNfgONtxAy/j0eit+4QjA6uePUTajxzWdK5mNjVDQQvrGZA1MiMnHVNgcBY5nTj1tlNCW8sIN7UEfGKoTTDYGzpo02iuHHoL5zzaUO00rLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mDQkV9o9; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mDQkV9o9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761133347; x=1792669347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AuIHhNtYt14BLpZyopQ9lNncTR/cskfIc/vi+rtUyXQ=;
  b=mDQkV9o9by74JRFr32pC2ko1DeHRylIszlsjAQ1/CucHMnYKSS/s8ULu
   StTJG9lISD92V7Ex6/b0ZsCPww8FERvWrl7wcCnjiFyOi/U3tfpGCmfbW
   3/zsi0uAM8gIlhm+OXx1GElcj10sa78v9SQsDQtYA3IRdNMX5xY+Jj0U9
   1tPTkhCuz5JhCpvJ9JlgWFV4sW3PET6fSoI7mHMgXN7eWdnB4tpVVLuTO
   qW3Trp2pn+o4W4wAEEUPNxtyZxaSTU2oiVlSXDU79p6v/G9rvhL65JXOv
   SSokRJWCvcLu0OEAMS+t3qzwBzPb3s3Dk0/oMagunyAxQfoGC5efZQ6Ja
   g==;
X-CSE-ConnectionGUID: ACheWtIERxOCH8WRufAp6w==
X-CSE-MsgGUID: WJkgUl/4SimyjQfAGPRCOQ==
X-IronPort-AV: E=Sophos;i="6.19,247,1754928000"; 
   d="scan'208";a="130696092"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 19:42:21 +0800
IronPort-SDR: 68f8c31c_DEq8zXQGo6h4wh/QUewre8MIlaW0s4l3B/p8PoYCzq1giu4
 Y5nWwVapXNqNMDFfTk2L/WV5n6M1gY/Po9ftSbA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 04:42:20 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 04:42:14 -0700
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
Subject: [PATCH v5 09/16] blktrace: add definitions for struct blk_io_trace2
Date: Wed, 22 Oct 2025 13:41:08 +0200
Message-ID: <20251022114115.213865-10-johannes.thumshirn@wdc.com>
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

Add definitions for the extended version of the blktrace protocol using a
wider action type to be able to record new actions in the kernel.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 16 ++++++++++++++++
 kernel/trace/blktrace.c           |  1 +
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index a6958708d477..9f9834d76e00 100644
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
+	/* cgroup id will be stored here if it exists */
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

