Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8C6320CA3;
	Tue,  9 Sep 2025 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415995; cv=none; b=gfQtYUMnwapXcJStr81gepBM7KQPXZ6ECLn0w84nef8LswVUY3xp6PRH/9L8eVKSyUclZbStptIpas8TydWxtBIjCypeYXnzxV4wjatWw6GVAdpkZtHH6Do9fp9TQE9WQTTeGlUVoniJBrixJhXLxiSBWGfq9whLq1liDAv2QgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415995; c=relaxed/simple;
	bh=y4Wx9hgSIxxX7ur9cWGGUX2Fl+Ln/UCjFYkMh/i6XUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SYbx0QM8Q0yVQHUHfZ2iXRuwYHAeOzFSBtGB/BV1eccOsAEMlLeFGx33Gznis6rQiuEiGkBuW9gxAVjvUdTCs7cvol1K3otyDQ7boBPXURNA2nC6opD6pgO1CnMNSq3VXLm+8fXcIq3r2noduyMKnjlt5RQ04uBeHZQsyAFlKJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Htm2oaNi; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Htm2oaNi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757415994; x=1788951994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y4Wx9hgSIxxX7ur9cWGGUX2Fl+Ln/UCjFYkMh/i6XUk=;
  b=Htm2oaNiLumCcbnHZyOw53GAIFAcjfAhnCVLJxOvGyK4taZG9vTRY2A0
   ClM2/evoa6lhvPbzZUgOFH9uWPswZJS9tcxquVUX2ua8ho0fRoF1I87Ng
   O9UX5sfoRa53kPSMlSBZkMP51MVpuDIqmVSfLf2Ec2rc3Hp3uO0ajUse2
   +hRoGjdalXNXTn5agv9DS5m4IuX7oOyc23nQLkditkZ+R6t0r98h/TbGb
   IZzBoFOiSe9/vMGA76X9DLYr4NI5nVc4TLHEf7d3pR8FIOLpTjtjN+Ue0
   qdjQ7TcoqLD78EZ+1L+qllqY2zAht/1alZVn4LNdiURIt6III0EiZ66UX
   Q==;
X-CSE-ConnectionGUID: jHwpDBddRfCDlgJcCoPs+A==
X-CSE-MsgGUID: ol1UoUeYRamMYWSwqRm6+A==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112809916"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:06:30 +0800
IronPort-SDR: 68c00a35_3XLXE5aRqzZGI1Cw2Xzl+/TMGFaSy+etrnwM9CwzpACBupg
 ifTNFxXPVd8pl61J629M1t2P4SnvykD4xkvr63g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:06:30 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:06:25 -0700
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
Subject: [PATCH 02/16] blktrace: add definitions for blk_user_trace_setup2
Date: Tue,  9 Sep 2025 13:05:57 +0200
Message-Id: <20250909110611.75559-3-johannes.thumshirn@wdc.com>
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

Add definitions for a version 2 of the blk_user_trace_setup ioctl. This
new will enable a different struct layout of the binary data passed to
user-space when using a new version of the blktrace utility requesting the
new struct layout.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 14 ++++++++++++++
 include/uapi/linux/fs.h           |  1 +
 2 files changed, 15 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 1bfb635e309b..ba61374f90d8 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -143,4 +143,18 @@ struct blk_user_trace_setup {
 	__u32 pid;
 };
 
+/*
+ * User setup structure passed with BLKTRACESETUP2
+ */
+struct blk_user_trace_setup2 {
+        char name[32];                  /* output */
+        __u64 act_mask;                 /* input */
+        __u32 buf_size;                 /* input */
+        __u32 buf_nr;                   /* input */
+        __u64 start_lba;
+        __u64 end_lba;
+        __u32 pid;
+        __u32 reserved;                 /* for futute use */
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

