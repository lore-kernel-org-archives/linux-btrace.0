Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683F32CF95;
	Tue,  9 Sep 2025 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416065; cv=none; b=P84GkmiMrzAxJPNpYSUkq7bUVWzsCDwDNWahWYsZH5JOG2grMjwk3JQHMum+PPEthLndl6gobu7CUkP+kKaE5pTaD5EGYHfRTYSy91/dFb/IrEDrzSTaEe9gVCivahf7B7AMm5SemQzB9CgVjYyALFfd00++BkF4hunc1YchO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416065; c=relaxed/simple;
	bh=2H5LFMNPaYyglNMEHb+f7AgkaPYbc1RUaom07P26U+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLINH3BTJY5eDR40fqTqw8tLIZXZNV8Kyd4syCVlzU7tJXXbDlzktvyAogtHgmRfqJrumKa1rd6ngaG1aMssSlMIovzfFgl3PlAX2WXKQ91dBAzHFSibAHOwFR6dbtuzqJUff/YTDK3Aq7FOpOtMzl9r9t6BFYMD18zEmdjzlXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=l6IP5PTS; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l6IP5PTS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416064; x=1788952064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2H5LFMNPaYyglNMEHb+f7AgkaPYbc1RUaom07P26U+A=;
  b=l6IP5PTSZSgkHlIAlwism547Fltn3tc9q6zDjiU7hB6sRbJMyRG/dIiN
   pIirlcb0V1nSYE4O+wkd28b7XQSpI3tgIwd8+kteYIbJyUlWj0i2Ma0Jq
   X2cb80T5xaT9yVlkgjiWLHThrxO3PsWaP97O6jpHFX9jnY/0T22LlaHNX
   JrLjpF543WyKG3ftl4xHMF1rixYmmBlHFJcXdrEkVlZWXdpObz8RgmS7u
   GEBfsTgpK6fCfgfS0Wk0wPY+DDo09tVXrIWMDTzgmyZNcqf//TzJGp9TE
   ivX79df2uVJwakNkGYCv2GS2tUE212zoomw/fMsEs17c5i+KaG2XnUamy
   g==;
X-CSE-ConnectionGUID: YlhBCWg7SN6lLYKM5upt0w==
X-CSE-MsgGUID: Mimb9AQCSFa92FBLyW9Ynw==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810532"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:07:44 +0800
IronPort-SDR: 68c00a7f_b8CgpwimZL3PhbN7vW7Zv2RuBB863xS0bZA24wpBDivkIZK
 olBoYIoU+SGyImyVOANitipBI88LjLQlNOJKLmw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:07:44 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:07:39 -0700
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
Subject: [PATCH 03/21] call BLKTRACESETUP2 ioctl per default to setup a trace
Date: Tue,  9 Sep 2025 13:07:05 +0200
Message-Id: <20250909110723.75676-4-johannes.thumshirn@wdc.com>
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

