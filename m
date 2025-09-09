Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E964321F35;
	Tue,  9 Sep 2025 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416001; cv=none; b=Ts0JnGkd2mRuU/RFZBSDic/6PzUAufLQwqkpKhWTH7mXwBWcxGEBgNYSlN1rnSomU5Bh3aHbYim0diDEF6SRvnhVpS5JB/0nWIZlKFiwj7FR82DAsz90ycnVCx/khjW2rgK+RbBeeRGF5hLFye0JzPS677R9j2UpYWIwTsd7w7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416001; c=relaxed/simple;
	bh=iHbRXJL+pjCtcFNPtwYgii21etYlwhHNJfWRGyj9F60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qB3GbBoSrUQG8d3/Pt+XmVkOxyBXbm4C2h5nYUMkL0jwAPrmoW7fZTfL2WPGMiPJ2iENmUtGO1l7fQ/L2Sd3zQMgwWykkuNbOpDokPJCukrwjcMLgq8G+G7kxTNvn1j5lmTdHTUa7pyrSzEnKAdK4ioHV/mUDI8gv28DtrpytU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PuIGvXfm; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PuIGvXfm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757415999; x=1788951999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iHbRXJL+pjCtcFNPtwYgii21etYlwhHNJfWRGyj9F60=;
  b=PuIGvXfm6gT/jR25dzv334D0Ix3oe+i3lohDzrTc2IGKY1JJiaFyhtR9
   gl8bsadGDZEw19Nx6eyIqalba37BXklezcl06ybruW56uQEfMzhusKLwK
   zwFutbLqKUy7MaJPhU6fxCox0fZq8pNH0RIDf7Szh+/5yPbuprpzjiCHV
   fAQeBoi7ndcSHKQl8taClc6u1NWMf+P+2WeWlMJ0ULX69Z9V0zlrVcpxY
   ToOs7v/tFPe0p6/J3NYseLMdrKKF5SKHloGaosU8wpYotbgC7dXtheFdh
   K/epSZ2wOJf5tt9yzsiVESn7vKFvAWvMqASR+RBAlRxSZxiZDBpMxnq8i
   g==;
X-CSE-ConnectionGUID: eTWn5WowSDWlK9tyhOOC0g==
X-CSE-MsgGUID: OkOvDxZ+R4yULHA/39N/PQ==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112809930"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:06:39 +0800
IronPort-SDR: 68c00a3e_1kGDdowEdFvJxUMK/a06tLaRQg/vbk7ZO5UpugXl+9sSNIx
 puaQwVJr2dgBFGAWoYYsIERt0g6SUXuYvCkbAAw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:06:39 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:06:34 -0700
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
Subject: [PATCH 04/16] blktrace: add definitions for struct blk_io_trace2
Date: Tue,  9 Sep 2025 13:05:59 +0200
Message-Id: <20250909110611.75559-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909110611.75559-1-johannes.thumshirn@wdc.com>
References: <20250909110611.75559-1-johannes.thumshirn@wdc.com>
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
 include/uapi/linux/blktrace_api.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index ba61374f90d8..01779f84d09f 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -94,6 +94,7 @@ enum blktrace_notify {
 
 #define BLK_IO_TRACE_MAGIC	0x65617400
 #define BLK_IO_TRACE_VERSION	0x07
+#define BLK_IO_TRACE2_VERSION	0x08
 
 /*
  * The trace itself
@@ -113,6 +114,20 @@ struct blk_io_trace {
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
+	/* cgroup id will be stored here if exists */
+};
 /*
  * The remap event
  */
-- 
2.51.0

