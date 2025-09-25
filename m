Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD8305940;
	Thu, 25 Sep 2025 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812596; cv=none; b=Ixa4Ym+tkK3k/gKBvspDXUZNVOt3TENdvvzqW2KDUIT6RsSIHfE1O3y1epdf8E9Ue03Zdx/MkgmGx8cV9EJHx1eK1+DIrlKWGI+fnyNCk33VVSMZRDonAmHd1uAO61ldAOjzN7wLjs9a4wv1VrKONlI5bESdMnenKfrPUdXgE4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812596; c=relaxed/simple;
	bh=laaNMJDwh0WNtr81seJEl3CGE99wCzafeov1KMldloU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0IOVUEUqTRn1/OVFkdpvMaTRppF/IoKUz9i4IjuuejO2X53187HTlVFQZMFbtuqzY30t9hEsZr2UY+hdfOBhiRzTQA9srhRkw1zOH+k/8CnKdexEqOPtSk4jfpWC7xalwPCqUfkH65BpA6bAmqIaYF0n24yhv19MIiRrsl36ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V+RKDnKw; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V+RKDnKw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812594; x=1790348594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=laaNMJDwh0WNtr81seJEl3CGE99wCzafeov1KMldloU=;
  b=V+RKDnKwp76dh9RcwWnobyu+pbCkpMkyGaKSLPOQr0oDOczDDdu4sl/B
   9TKW3hzyaTAr8tkd795wXh/Gl+0Od/8XXye0+D1entMHCb3k4uwEHlSsJ
   ZK6Nkwjz/sXeLG4fbibyLQupNQZn9//Lcr/OnApLb3tyixi3VyDKhGLNj
   x86nexTExLyGf3If42TXS00Io4dw51cuoyanear/MicCyexaQU7/xWlS3
   vLv2l7t/NMFBThJpyCYszx/e3+ZWx5vH0jP4109LqgZlv9FhGqIYFRZ9z
   zOno+JNxO6wof9v2z4uAECmrYGahBPNfEgcReByKqu34nszfaocBaF2cv
   Q==;
X-CSE-ConnectionGUID: 6UErgIS+S/+op1hvtTsByg==
X-CSE-MsgGUID: TAM76/nsRZ69uOR8ZjTJtQ==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130347993"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:03:14 +0800
IronPort-SDR: 68d559b2_rn9andwwHHdOxSn8Mj9MCm3YZER169DiH1TMyd+LtnQ9S/v
 xPzulfifYmb63P+ARK0eWYjDcVgsTeMCUV8G3xA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:03:14 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:03:11 -0700
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
Subject: [PATCH v2 09/15] blktrace: add definitions for struct blk_io_trace2
Date: Thu, 25 Sep 2025 17:02:25 +0200
Message-ID: <20250925150231.67342-10-johannes.thumshirn@wdc.com>
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

Add definitions for the extended version of the blktrace protocol using a
wider action type to be able to record new actions in the kernel.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index a3b1f35ac026..d58ef484de49 100644
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
+	__u8 pad[8];
+	/* cgroup id will be stored here if exists */
+};
 /*
  * The remap event
  */
-- 
2.51.0

