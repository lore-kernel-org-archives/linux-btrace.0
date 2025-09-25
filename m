Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8473019BE;
	Thu, 25 Sep 2025 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812689; cv=none; b=lIrjp7AUcTZ0XXqAK0bmLWJUVWGY0wjCRxbFAdOgjGEmnexm4Tpb72uOQOwfL7LtzBZR2OYOFcNfqlc5ZwIvc/A0ipjfNiA0Ed4CO/xbbJwjJ0jvz92//BPhEF/0ASqUbmYn28sjU33LsWbM7qpRFlmuv/8PYr8Lvhd8Ee3YEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812689; c=relaxed/simple;
	bh=f6tvFlwHmAwoccibdGr6sMVWUhdk0wCndBcjZ8yKj0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssogdzIfP2mX0uEvNIT2z5ub00WZUzb9QhTq75Y5nZkZ5atOT2pm9ulegZs6hz1pj/DSIs2SKSgndsvggdfIvUCOHo+DA1TPOosQUC/61ZhxtWRp+kgOc1nWu3JCOU7PY//y9WfaIph7ulTu+RKJhj7MdfARvXGp1gVeFo6Uz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fBqd+pEM; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fBqd+pEM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812687; x=1790348687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f6tvFlwHmAwoccibdGr6sMVWUhdk0wCndBcjZ8yKj0Q=;
  b=fBqd+pEMn1wkdyX6qwjb1wTQcKqyIwdrFu/IpOE5fs7SOrjVlaBPmEho
   GAu16Ot1g+cJesR21vSqw94Lyb9+LYxcB+OA28mCWFLUED4u9FoQpApXa
   AlskXMiiH2W+SJNYEm1rrCa0vQJ3gMWrZ52zgIewxsRXhLWJdNA1zRY2Z
   UunKws2ts2rwPmmdpd5NH+lXeYSUIxtL1f0y8YvoLr2C78oCx0unkNC0h
   I5Xc8RL0pES5VwquYl+UBEmw2hs93utfnghmnJRcn7pbTINA3lA3iS8YQ
   Gciz4MFoDkRqVmdcmwNNcPgOINF4dj045797OzNYNB42/7F2Q+rIIzyWJ
   w==;
X-CSE-ConnectionGUID: gs/8z8UGRHW91nq9EJJkiA==
X-CSE-MsgGUID: X6GQ+6jISqmMbFffBsmFuQ==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130348756"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:04:46 +0800
IronPort-SDR: 68d55a0e_cwzxfDJ2hXISdHrSVZr8fWhdIaQpK89taf/LW7Ej1B6vdgz
 1Z6e0XJODOQr7hW8xuwbEBAjlBh4Sstq+wdKXAg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:04:47 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:04:44 -0700
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
Subject: [PATCH blktrace v2 03/22] blktrace: add definitions for BLKTRACESETUP2
Date: Thu, 25 Sep 2025 17:04:08 +0200
Message-ID: <20250925150427.67394-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
References: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
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
 blktrace_api.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/blktrace_api.h b/blktrace_api.h
index 172b4c2..9f435a5 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -139,9 +139,24 @@ struct blk_user_trace_setup {
 	__u32 pid;
 };
 
+/*
+ * User setup structure passed with BLKTRACESETUP2
+ */
+struct blk_user_trace_setup2 {
+	char name[32];			/* output */
+	__u64 act_mask;			/* input */
+	__u32 buf_size;			/* input */
+	__u32 buf_nr;			/* input */
+	__u64 start_lba;
+	__u64 end_lba;
+	__u32 pid;
+	__u32 reserved;			/* for futute use */
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

