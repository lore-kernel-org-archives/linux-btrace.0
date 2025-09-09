Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E8B33CEB5;
	Tue,  9 Sep 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416131; cv=none; b=bA/H0F5MGjs3XV677L3TMqvIsFuifM2PGoi11WAx0D5RM5KvV5m0S+EctDa5VZrTXdK7KxxXPoAJmQP5E2JmVQcba24Fx+XQwGXWkWNwXHMIZOx1q2Fdr4db1eF21bsDLdm0ficXA8oNRMzO0/x8eegEsS7TBjHe2VHv/T8Nai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416131; c=relaxed/simple;
	bh=Ta3Q1aiMxCrK6xGgJ9dr0qYg2RbzxnCFYqcNkItW+fU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bJ6LmKBNZjra+lWVBPlo1Rsk4hljUvOzWLtzJHDL3YXSLL7fywoGQfMwOx5N2uHaBscnZ0TD0z+NSM4IDRwXSPJt1ccA4ZpZCKw+kgllADD0JkTGwTzogftPymvut1ZzRC2FDZe3iVJt0zq9vuqmD24yvO28JM3dy8UXNERS4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JEJ24fzL; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JEJ24fzL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416130; x=1788952130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ta3Q1aiMxCrK6xGgJ9dr0qYg2RbzxnCFYqcNkItW+fU=;
  b=JEJ24fzLb5VpGIGvPoqQ66JzeF6cLQA+bxmjA5qCWouHPgHnoXPpuk69
   a8Kn14r4AjG/yQzY4nzgrGYfcTjDpBAAfy6pFAQouYqQu5htjbhr9TuhY
   je1LIJJ1qKBBil1dffzIPbzTBErtZ5rU28JjiltLz1HXufgTJIMpL8QQa
   Hn5uWoGaLPVv3aGSogo2aH20o0wZke/Ztyg5uyAhLSD3TKp02+jc9hhj9
   rBsr8aodSWhKm9xlYv2cv4D3qJ5SrSLioIs7i2hxbdtk9ildckb5iT0lF
   eZpBQ2qfNVz3KWbJI88IpOFH8Es0NsoMX33+hXoYgm7U3YhUdxA5i+GkK
   g==;
X-CSE-ConnectionGUID: SMskXhaPSCepwI5CdYl/vg==
X-CSE-MsgGUID: /IjuY4d0RQykAIRIyNeiLw==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810937"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:08:50 +0800
IronPort-SDR: 68c00ac1_9ldOyKYbMZ0Zu+nBemBISLCBh1BpQBFe4AWeU1GTVptwb3g
 YmfUScBaSpNcgbusa0BB4rdMakO8iNJDvLBi+Ew==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:08:50 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:08:45 -0700
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
Subject: [PATCH 18/21] blkparse: parse zone (un)plug actions
Date: Tue,  9 Sep 2025 13:07:20 +0200
Message-Id: <20250909110723.75676-19-johannes.thumshirn@wdc.com>
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

Parse Zone Write Plugging plug and unplug actions in blkparse.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c     |  7 +++++++
 blkparse_fmt.c | 19 +++++++++++++++++++
 blktrace_api.h |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/blkparse.c b/blkparse.c
index e702356..1a372e5 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -1722,6 +1722,13 @@ static void dump_trace_fs(struct blk_io_trace2 *t, struct per_dev_info *pdi,
 			account_unplug(t, pci, 1);
 			log_unplug(pci, t, "UT");
 			break;
+		case __BLK_TA_ZONE_PLUG:
+			log_action(pci, t, "ZP");
+			break;
+		case __BLK_TA_ZONE_UNPLUG:
+			account_unplug(t, pci, 0);
+			log_unplug(pci, t, "ZU");
+			break;
 		case __BLK_TA_SPLIT:
 			log_track_split(pdi, t);
 			log_split(pci, t, "X");
diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index f93addb..a5f721f 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -301,6 +301,22 @@ static char *parse_field(char *act, struct per_cpu_info *pci,
 	return p;
 }
 
+static void process_zoned(char *act, struct blk_io_trace2 *t,
+			  unsigned long long elapsed, char *name)
+{
+	switch (act[1]) {
+	case 'P': /* Zone Plug */
+		fprintf(ofp, "[%s]\n", name);
+		break;
+	case 'U': /* Zone Unplug */
+		fprintf(ofp, "[%s] %u\n", name, get_pdu_int(t));
+		break;
+	default:
+		fprintf(stderr, "Unknown zoned action %c\n", act[1]);
+		break;
+	}
+}
+
 static void process_default(char *act, struct per_cpu_info *pci,
 			    struct blk_io_trace2 *t, unsigned long long elapsed,
 			    int pdu_len, unsigned char *pdu_buf)
@@ -429,6 +445,9 @@ static void process_default(char *act, struct per_cpu_info *pci,
 		fprintf(ofp, "%*s\n", pdu_len, pdu_buf);
 		break;
 
+	case 'Z':	/* Zoned command */
+		process_zoned(act, t, elapsed, name);
+		break;
 	default:
 		fprintf(stderr, "Unknown action %c\n", act[0]);
 		break;
diff --git a/blktrace_api.h b/blktrace_api.h
index bbf075f..3966e1a 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -62,6 +62,8 @@ enum {
 	__BLK_TA_REMAP,			/* bio was remapped */
 	__BLK_TA_ABORT,			/* request aborted */
 	__BLK_TA_DRV_DATA,		/* binary driver data */
+	__BLK_TA_ZONE_PLUG,		/* zone write plug was plugged */
+	__BLK_TA_ZONE_UNPLUG,		/* zone write plug was unplugged */
 	__BLK_TA_ZONE_MGMT,		/* zone management command was issued */
 	__BLK_TA_CGROUP = 1 << 8,
 };
-- 
2.51.0

