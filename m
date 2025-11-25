Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE29213AA2D;
	Tue, 25 Nov 2025 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055661; cv=none; b=RUJJvvBeFp+mDnOJ0z9BPEGxT2QqVJ6CC1MTwsogvXhr4m9Kwr9vuhfnNOfdbzQpXypvuHBg2D0OdtwLE4PnQ+GERbxHyOkCiEXMtPzYOQMttj2y2612TY+O5MjTM2O9hpW2G+GTE10f6zKHPK+6b4WnpAWTxuMecqAOFtzxZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055661; c=relaxed/simple;
	bh=mWa4RFBwSUNQmjQ/szlgQNRVFZpgfzLAIm6f+LJRWVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDOV/F3Ju0SzZguC1N7dwL139F6r+0G8ULhC0PqZtXDFvC9iRorQw6jAMmMtltuqKzjUq6BmFq0wrAN/9W7sn6K/l3bheOzmwc579FoEIkSBrRYJIHy3BTkuElWDkzUNbe16H8Yq+ka1vGH5Ld5n4iRBLUG1liqqQ+xn0ECTYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mVugmr6W; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mVugmr6W"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764055659; x=1795591659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mWa4RFBwSUNQmjQ/szlgQNRVFZpgfzLAIm6f+LJRWVM=;
  b=mVugmr6Wjp0jB1TZNb++//jhsJN601UcZov3xWSgCrzNYDN6lX4aiM5I
   +7izhjUbNfsy27hI6dSMf5S+14TrCQ7bu336Gl1DIA9FeWI/ml9RtlL90
   S2unYlUIw86nciEnxG5elPrHme2zl1V/0l9qvVqobWpyHBKpio+3qdBNC
   MqCih6SvA3gV0iOSuqTQgPNeqhHOauHF444YRKSTKJ6ar03FiDqlqEJGI
   zcGo7ZI6nijzpJfBSadPGfLQfzh8g5z1CcPstlitZQuF0vlvQOiRE2zxP
   5AxI+h0JvUUD1buTsSevX/tGCkUZW3NG/5//mjsKl0DpQhHAp2mFoaRhJ
   g==;
X-CSE-ConnectionGUID: tpE5IcWpShilujuli9PiGg==
X-CSE-MsgGUID: 12OMW7f3RzaDi/8k+JI0zQ==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135337504"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:27:39 +0800
IronPort-SDR: 69255a6b_N6cDAimA1SlLDIURvbOzSzWVyuZ54Fs1ousLGuiX31OWQWE
 UHJic6yPN+vHBGq3eq3fRah2rYELSEWDVipJDlw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:27:40 -0800
WDCIronportException: Internal
Received: from ft4m3x2.ad.shared (HELO neo.wdc.com) ([10.224.28.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2025 23:27:37 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-btrace@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v4 01/20] blktrace: fix comment for struct blk_trace_setup:
Date: Tue, 25 Nov 2025 08:27:11 +0100
Message-ID: <20251125072730.39196-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125072730.39196-1-johannes.thumshirn@wdc.com>
References: <20251125072730.39196-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a comment misnaming the ioctl(2) passing struct blk_trace_setup.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blktrace_api.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blktrace_api.h b/blktrace_api.h
index 8c760b8..172b4c2 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -127,7 +127,7 @@ struct blk_io_cgroup_payload {
 };
 
 /*
- * User setup structure passed with BLKSTARTTRACE
+ * User setup structure passed with BLKTRACESETUP
  */
 struct blk_user_trace_setup {
 	char name[32];			/* output */
-- 
2.51.1

