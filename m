Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D169D2E92DA;
	Mon, 24 Nov 2025 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969938; cv=none; b=GhzNmzkzhEXfIuNqYCrx4aoxmyZrNIZJxJvSAotNBk8QgaS+egyeA+RecCAlHrkMnjEpIdjhuAcI4mpx4FIPcGqWByJ3VVuc3QWtjMAGQ5zZvTEPmZhmQl+FWMNdCqgiw8vf7njRRV3c5BWlDtl4SlFGahSpSDn84SzEgaR0+No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969938; c=relaxed/simple;
	bh=2H5LFMNPaYyglNMEHb+f7AgkaPYbc1RUaom07P26U+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2EUvIZVtX7ueD79K4k7Ce2p5g/Y+6z2y8raTE8ttG1YAYm3VV9DGvtHbW7gbm38QgRC2Xakq0eU0pOAljJchBoOUk+ux5hAN6B+Wmyb7ep/pS1+LNk1Am7qDc/BN6pP9VgPNtYlpil+zvX8ycmViyG0GrrcQhkxh8BXtdr2gfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SY6qeDxb; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SY6qeDxb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969937; x=1795505937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2H5LFMNPaYyglNMEHb+f7AgkaPYbc1RUaom07P26U+A=;
  b=SY6qeDxbX0LTRhcRu13DIfAqR+4bcyNKbB49was7JwE3zhPFJDQ+gDQI
   Dywt/t38BU6kuUZmUcSsqB17XW5QyrhGs8XvQa0kQrD5v6Tf7rIvYjPPx
   0fKuAvF9Blrg1Jd/sSV7yIUHmd0Y53UNuprxEum2eSoOlXZvQvxzuwzMf
   LPLmg/tm8WWIbrI+9zkVe+wFAW+qFAqBPKl7oXGmnplkjn9PDR7w3u0go
   A/hCCBSKTCgT2dB0hg1EQnaJMEJ5zDaWxMjbUKudPmoruYQWbJbhfjNbj
   a/ISVnjXyMVBxrFZNjjamtS0wke1E/TFVeH6KyFUJtX7cbLYyFM7mdZmW
   w==;
X-CSE-ConnectionGUID: BZRhbhxdSXizD3IHGnzdhQ==
X-CSE-MsgGUID: oO5APRzdS0alBF8MNZD8pw==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619411"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:38:56 +0800
IronPort-SDR: 69240b90_TBJkxY2nx+VD/aAe42kRKMxgdcVZAc7qHnczxf2wlHQ7uhK
 pFEGmToBxCWMefJwWDAMqPiaB4TlsBofDuW5GRg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:38:57 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:38:54 -0800
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
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RESEND PATCH blktrace v3 20/20] blktrace: call BLKTRACESETUP2 ioctl per default to setup a trace
Date: Mon, 24 Nov 2025 08:37:39 +0100
Message-ID: <20251124073739.513212-21-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
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

