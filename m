Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A07631D39A;
	Thu, 25 Sep 2025 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812760; cv=none; b=j4sRIHMntgoEmsVYlg7M2LczqPU7JgyMYQwGGfH+rvCXTpvUK0KuFV7c0AsY6icoWkazPet2VlNhABWKKFsWX5Z5Rk0m+peee5dsmqCx24aXWmY7oNRKAE2nW4h19QJPF8D3h3PL4bs/ZVk835SlSas2scUiNCLmQ+T1c3EkRn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812760; c=relaxed/simple;
	bh=PP1z3XV18Cqf1vF1xaMFZk9p40Bg62sHd4FSn7J7hGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXOsZp/cOyZ/WHxCEWGWf9k+n7a8khkALt9ZPf6DdBG82sTwhJHH0q1gypAPpAzSDzGARfXc0CF2SkyJrMlpgKr7ZSBV4T+oUjNYGfUvVx8ujo5cY/PIMvwdU3J2Nc18d9ONIUUOnm9Uk+s4DQ0h9rSlt895Qo31lADIg0kKKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KyAqppxX; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KyAqppxX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812759; x=1790348759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PP1z3XV18Cqf1vF1xaMFZk9p40Bg62sHd4FSn7J7hGA=;
  b=KyAqppxXHU1TK3yjU9wYYcXpVYXcwIaY+X+LFf0LBQqAHrQO226wfT+q
   elBXB5dftUywb+atUQWJJBC3ya+qVm9Az8wFa4bjRlENBcoj316dOP303
   jFbAMzAcm24GrZ4UK+hNaVgPWshqQRn7JmZR8AG8TsAhw1Oo49/wWfQMD
   kZSA4Ii1q5+QKAq7hegoy29WTw0RiZ9zuV3oxxFQPX4yZTgY7rfBQpkfy
   z0M4FtsTQQD+wegNLtNmb0KphV/ferU9zJ4I71tlbna7EUYAGiVhgaVa/
   uvSGCp4T1q/oGgIKf1SnRLNsZJ1ycQ7mjJJ38OwW4yh8ik3zEB9SU4yrV
   w==;
X-CSE-ConnectionGUID: z1jywLqyR3uNR5SFQrtm8g==
X-CSE-MsgGUID: W1E7bzNLSHmEbJCudKQVSQ==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130349641"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:05:58 +0800
IronPort-SDR: 68d55a56_fMWFmg7XX/EmtuZb7MtXAULqR+C94BzIZJq8Nwz4iP10yfI
 MrbuygQYZZRoQ/1bWvLxQGXt2ZiD78Zu0jmmF9Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:05:58 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:05:55 -0700
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
Subject: [PATCH blktrace v2 20/22] blkparse: parse zone management commands
Date: Thu, 25 Sep 2025 17:04:25 +0200
Message-ID: <20250925150427.67394-21-johannes.thumshirn@wdc.com>
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

Parse management commands in blkparse.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/blkparse.c b/blkparse.c
index 76c775b..af6f0d7 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -1651,6 +1651,9 @@ static void dump_trace_pc(struct blk_io_trace2 *t, struct per_dev_info *pdi,
 		case __BLK_TA_INSERT:
 			log_pc(pci, t, "I");
 			break;
+		case __BLK_TA_ZONE_MGMT:
+			log_action(pci, t, "ZM");
+			break;
 		default:
 			fprintf(stderr, "Bad pc action %x\n", act);
 			break;
@@ -1729,6 +1732,9 @@ static void dump_trace_fs(struct blk_io_trace2 *t, struct per_dev_info *pdi,
 			account_unplug(t, pci, 0);
 			log_unplug(pci, t, "ZU");
 			break;
+		case __BLK_TA_ZONE_MGMT:
+			log_action(pci, t, "ZM");
+			break;
 		case __BLK_TA_SPLIT:
 			log_track_split(pdi, t);
 			log_split(pci, t, "X");
-- 
2.51.0

