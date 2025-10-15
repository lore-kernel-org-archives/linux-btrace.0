Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17DD3233E8;
	Wed, 15 Oct 2025 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525919; cv=none; b=Xf5qSdcaHRUsl3NrmbMGZG1Vyu8Sq9hZOX/ExQ2LPNi+LuWIh+PvUvcVWuB4Gdu36M00rRDpFdYk9CGJba9QlaMed2cOIsHtI7z2oJNGMiGkGTfVU32H9L9z0qap6dGshLKD57/KKsfRKXCM1CU6n29BFSTRMkpjGoYQNc+Mlno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525919; c=relaxed/simple;
	bh=2H5LFMNPaYyglNMEHb+f7AgkaPYbc1RUaom07P26U+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EP50M9vqCNOPIJQOnUlJKjwdyulw87DwUPP2qZ1DMGnQJ/s96t+8lfaxNNbHoU4ZqL7mO/2Kg4wVjFWezuMCQdV25XDif3hMhygef6CMqX5icJqYFRmQgO1xeSJN6CXkwWkgGX5wIGlKz0sCKq0BIrSSoEiZ3CKvHJ0tedzsN88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rCG6bhFc; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rCG6bhFc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525917; x=1792061917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2H5LFMNPaYyglNMEHb+f7AgkaPYbc1RUaom07P26U+A=;
  b=rCG6bhFcA7DW2cU/gAFQy7+iMMLBlaSrpcOzE4l3pVWb/ATVP1szFxXP
   DmJh+OQRz/xNNoOgmjh7E0B6D7JlmGEwXBePUS7aMGwdJo8TLHgDVwzGu
   Z/to9Adf7gnGQ3K4PeXY32dZ/5J+siy5PIowW+vPXXx/VeCUtfTNGcH9S
   HtXeCmnyek4VErsHisfnauVyWROZf+NdKQ9W8R1NNrDqHkuEhx3TH+g8S
   gU2ujxWOHo5OTITF7bG7ara70dUjX/FdEGuTwMy1Jy87EKyEWXYsjMHJm
   PvR6s7uq6fBqu721yI5RWGp2i3VaaEwYru6kncadyL11DWTbLgc0qHAev
   g==;
X-CSE-ConnectionGUID: FAeD6Hi4Rae0JDcgS6++AQ==
X-CSE-MsgGUID: OKXP52c2RkqiqSkjqx2xkA==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935428"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:58:37 +0800
IronPort-SDR: 68ef7e5d_v4mgOAv+euj3JcQIQsuWloXTgmJUG2dtPDUj8kf4Co1Madu
 9FujGPt8xkSR1Mv5pe6+YIfyO8Zo8HA2S9WQY/g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:58:37 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:58:34 -0700
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
Subject: [PATCH blktrace v3 20/20] blktrace: call BLKTRACESETUP2 ioctl per default to setup a trace
Date: Wed, 15 Oct 2025 12:56:58 +0200
Message-ID: <20251015105658.527262-21-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
References: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call BLKTRACESETUP2 ioctl per default and if the kernel does not support
this ioctl because it is too old, fall back to calling BLKTRACESETUP.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blktrace.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index 038b2cb..72562fd 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -279,7 +279,7 @@ static int max_cpus;
 static int ncpus;
 static cpu_set_t *online_cpus;
 static int pagesize;
-static int act_mask = ~0U;
+static unsigned long long act_mask = ~0U;
 static int kill_running_trace;
 static int stop_watch;
 static int piped_output;
@@ -1067,6 +1067,36 @@ static void close_client_connections(void)
 	}
 }
 
+static int setup_buts2(void)
+{
+	struct list_head *p;
+	int ret = 0;
+
+	__list_for_each(p, &devpaths) {
+		struct blk_user_trace_setup2 buts2;
+		struct devpath *dpp = list_entry(p, struct devpath, head);
+
+		memset(&buts2, 0, sizeof(buts2));
+		buts2.buf_size = buf_size;
+		buts2.buf_nr = buf_nr;
+		buts2.act_mask = act_mask;
+
+		if (ioctl(dpp->fd, BLKTRACESETUP2, &buts2) >= 0) {
+			dpp->ncpus = max_cpus;
+			dpp->buts_name = strdup(buts2.name);
+			dpp->setup_done = 1;
+			if (dpp->stats)
+				free(dpp->stats);
+			dpp->stats = calloc(dpp->ncpus, sizeof(*dpp->stats));
+			memset(dpp->stats, 0, dpp->ncpus * sizeof(*dpp->stats));
+		} else {
+			ret++;
+		}
+	}
+
+	return ret;
+}
+
 static int setup_buts(void)
 {
 	struct list_head *p;
@@ -2684,9 +2714,11 @@ static int run_tracers(void)
 	if (net_mode == Net_client)
 		printf("blktrace: connecting to %s\n", hostname);
 
-	if (setup_buts()) {
-		done = 1;
-		return 1;
+	if (setup_buts2()) {
+		if (setup_buts()) {
+			done = 1;
+			return 1;
+		}
 	}
 
 	if (use_tracer_devpaths()) {
-- 
2.51.0

