Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E132CF7B;
	Tue,  9 Sep 2025 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416061; cv=none; b=CiPZsBnZJaafdCm/rjKoMRpk+WtxBqt7K7WeZzzTZFOQ7AgXNVEZm3JRd39Pm3LL9fb0yJdOAJejD3CEZHhXZivQ73Tc1WCmDHpP0UiKgq5s76MONX6QY4QCwZtNa9X16ckqKVDxJUaVcp00CjiVbE+BfEDVTIFpDEbgyApfTaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416061; c=relaxed/simple;
	bh=A6y+pTXsNEjykg3IaiXa6pw7Li2TWLqIkGIrn9bRUy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uygFkwe0UNRWd3nNgFb6Oc8XRBFfOF297HFDKEFSAymtNTZAyuRC5XM623287R4rNw6xg04eIzqSfAEmW7CxDP7h+hoEWSRRPMuGUwqVVwh3uEMHETeroKV3gOThhS40K7vHkKd8hwzZ7cyQL52cKTjvWVnALdQaNJ49hmPpeWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=U81Xu+QY; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U81Xu+QY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416059; x=1788952059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A6y+pTXsNEjykg3IaiXa6pw7Li2TWLqIkGIrn9bRUy0=;
  b=U81Xu+QY15PQPdZdSylkMUoMbAVrqWXFO1UkWX9TTQUiY40FTh7pj3Et
   pr/7p4a5mlVh9HQsyP0eJsBk4AwFlE3oqYwHKHrR5FF9Plr5/c68SpZBa
   J4L3J8fC5dWAEEFiJngZpEttmCdYcGSIeBr9ewCApaZsIuZgmzx2vK7bC
   daYEEnfzcS5eI02db0pL3UDdLgI0WfsV0u3W7lJm9FuAwO8m4WITiC7ns
   iy6KdNhoH8GXHSbV7mwPL8cvbu78/dLhPw2cDUbU4z68KdIBJXYH9rcbi
   M9S+xcAUWup364AKt0iVtYpiSjIx01p2iIux5BXMFFUGnBDDAboJtZEIi
   w==;
X-CSE-ConnectionGUID: lNFzdYd5TXiOXxEcVzuw2Q==
X-CSE-MsgGUID: I9Bo6BGFRUODWZzTR8px6w==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810448"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:07:39 +0800
IronPort-SDR: 68c00a7b_/6r5pI0IXPGatTaNPAYQjpQkjbZnzpJQKkZf6vcVf8BDapH
 S7qLtBvGiF8oJKm8+wVTupJK7MwF0JYSHNYaFKA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:07:39 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:07:35 -0700
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
Subject: [PATCH 02/21] add definitions for BLKTRACESETUP2
Date: Tue,  9 Sep 2025 13:07:04 +0200
Message-Id: <20250909110723.75676-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
References: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

