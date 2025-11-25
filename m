Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A412DF13A;
	Tue, 25 Nov 2025 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057136; cv=none; b=czWuZkqOAuiIuwY43N0pWpA4Foe3HjMqn3wDK8U6rhb9K4AwGi6aOSzgPRVFrU1KxFNTnb3pwky1IZFLy4coxqqxDXnr4mNMaWNFf53+AfVpXQTqm1AZkyPPFZSj57aFrXGgcA4kIx69hTd6kyR+eR2tbyrDR6P3eQhTn0Tg+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057136; c=relaxed/simple;
	bh=1fpsUTq6wS+69n/GhYTAUNkyfMfZLj5j/5qqrqyUNfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZ9w6Gx2lDuYaQ76m5gzRJTd1QFqtfvuLwDBYQZKgc3LRLH28idCpMqVozjwc8Yx61r4pJarWMAsMS4vat3Xr7Tg38vzeojSYfCUH5xOHljoaYs9ug3SMW7bHtP3mhINNaproZKtIV5Uyc1kJ6Je+TP1mAWOfKJRtqzBdRcpA0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OXw7WaC2; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OXw7WaC2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764057135; x=1795593135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1fpsUTq6wS+69n/GhYTAUNkyfMfZLj5j/5qqrqyUNfo=;
  b=OXw7WaC2/Otg6rXWNF/m2kALorhvoRj27bOlUuXKCXc29G+mOEW5MRrw
   M3WWoI5/GAifHfeL4GtPJ1Z7MaRVlFbZwzSvAloKBBMVW/cb62RlppRHH
   VAwv0RctqEyBmJ9gn6/Bok/NJXC1K2IPEF1CnZoUbEttfgU+afLzVpVNu
   hd20N5ZxwzwP7M8DHlHQQTWeWHMsqF3WqM7j4KpMDBmlErP+kY9Kgv7HR
   8a6tbMt6F0firVHsf25QDE2P5j457x0lnhT5WLOkgINDBhbSFTMyMzj1C
   cVzwuWwrAZLwwJRgc26UnPhv6YBzf9/jdxjzhfs07wFWkXfNMzf17zrIC
   g==;
X-CSE-ConnectionGUID: W9ChEoKrTYWfelM+yqV3uQ==
X-CSE-MsgGUID: xQjmbKYISTCCiemAGH77LQ==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135749783"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:52:14 +0800
IronPort-SDR: 6925602e_KQBN9isSqGYVmL9SaDMspr2xLZSg6Hop/xFHhU6WwLW7R2r
 AZ+D2b8KL3KMDYuSFRY4CwHkvVzlMpXDhLIkNkw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:52:14 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:52:14 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-block@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 03/20] blktrace: add definitions for BLKTRACESETUP2
Date: Mon, 24 Nov 2025 23:51:49 -0800
Message-ID: <20251125075206.876902-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
References: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
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

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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
2.51.1

