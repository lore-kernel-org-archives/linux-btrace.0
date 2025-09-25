Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A9531DD99;
	Thu, 25 Sep 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812768; cv=none; b=OwX4kllyrSsPo4JCansv1oGtl4M7HXHmf7cprAQx6LzcDsKFLyJggGBIddPR6U6LcZTtGtVMHJRLuS2VlkQLFNz9E0Js5ydX4mP7GzM5W7/FJo/YpmHnr3EZWjnjp7DhErkH2HmIVPYgmIkA2ZMV17aQfkS9Xel0YwXtqj5xMx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812768; c=relaxed/simple;
	bh=2H5LFMNPaYyglNMEHb+f7AgkaPYbc1RUaom07P26U+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/frVVJf47H22ywWmWeMoIdQXLM2CkmLh7l9jaJ9GzS/7ouee/pd/xpjsKkzpvxxV9ZFJ9f11svLZx74hYTWmxqeMtm/npC454qOkCtiiXx9zEsO83FevnIlOZsDXyjiLauRetZxiyWlGNJAnYBPEXh4airOIAammH/RV4Zp0DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WzL+p2sR; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WzL+p2sR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812767; x=1790348767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2H5LFMNPaYyglNMEHb+f7AgkaPYbc1RUaom07P26U+A=;
  b=WzL+p2sRSKbELmihQXapu6wGuUSsSFN2EkmDN2C5MrAhcuK7wna05CzA
   9mqXZTuZqNTiXSssq6VDb8kSHQgxjEFq6JsLg4iAPOd1QX0Ivh9zWTC3p
   Z5A9kWflk0avWx0ck1UNlGNhioLwE3xJAUADX0rdnG5GuMqBmQpOKRWQY
   ytwbhky7fctbblCphLJC0/zmZQYjF+TTGSzHybWqDPVfXMQAdrkl9yO/C
   bJsx7FoMr+r84MQe9PcwRjJ9ddawE9bxlqVw0MywnEkVGeX1Or5mOKuX7
   IG+WlHUPA0+1mtg53V48Hdx6LVwfdfSG2TnPfl4A7HJlvXaPpXo4J8KEh
   Q==;
X-CSE-ConnectionGUID: kPlDyPBgSxS3jNNW0YtWoQ==
X-CSE-MsgGUID: fX20N8MbTqqQKwHDl2CF5w==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130349707"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:06:06 +0800
IronPort-SDR: 68d55a5e_T8gB1/PsG4vK6nAR6phwO6tux+LG7PvNIOKDOk29HwqCV8L
 nBbhamMsd8x0J0nuEiADMLDE1xSqPnpttNfkLqg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:06:07 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:06:04 -0700
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
Subject: [PATCH blktrace v2 22/22] blktrace: call BLKTRACESETUP2 ioctl per default to setup a trace
Date: Thu, 25 Sep 2025 17:04:27 +0200
Message-ID: <20250925150427.67394-23-johannes.thumshirn@wdc.com>
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

