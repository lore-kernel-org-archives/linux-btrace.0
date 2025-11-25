Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F613AA2D;
	Tue, 25 Nov 2025 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055671; cv=none; b=HaBgHq2cVRcvGk5+GyGmxlKpCKVZIb/VwxwEVchg5SKIeOJSmAL66JwDFMjM5x/3Mtn77qpZqupvh6m3PcvRCuHZidFoX6NxDxRjd3/GFH8r/zczTRR7jKIimZeuOyJ65dbEfloWtW2lZR59AB9Tv8kGrn/qAIbdqrHe421A6aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055671; c=relaxed/simple;
	bh=8ISfg1okfY9gYJ19YEiLkBEVsv1bvX6qgrh+5Xrip30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JF4Yps9oYGbabsR5eWNrxqxyLKd89fvxSiaGLTt/Stxqe/c6VFEI5n5WV64CLNY0HTC2ct/9Xyn8Mo+DeUB+ofkIEDzt5Q0n5Wl62+ioKabOe4rsUOFYC2GmNPrl0GUt23isgrhQh6LFvnraKP/a6LRRZUR7UXvzznWyx2UyYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e//+JnU/; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e//+JnU/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764055670; x=1795591670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8ISfg1okfY9gYJ19YEiLkBEVsv1bvX6qgrh+5Xrip30=;
  b=e//+JnU/lGFyQOQ7l+o1+qzAaZEOHTQlzYM8eGRZ/9kPPWEvZlzhNz+M
   ha/sYu9QAtIQY9FWU/G7SBVm5D6/KU2ROKKYkpO77WrKxJb2jyXaEKSfQ
   75UGI+FlN76uuyxFjh+QNJJZcSNimNPIFyTPicWWhPqYJh0lKjjo8UVuK
   lFGJkQbBBCNskIbKXwMWDiwYX7JO1Qbl7n6LQmi8tpojr6JeZeSbnteox
   8CkaUh0YTCOIATbOxBjJUpYFiKaG1FLqC2XhiwBETPCsM7XJJQeM6+bUQ
   xtaksomkaIcTS7EM/7RVWF/tf718z+kLTSPUYg1Ps8h5G8tdcTvMgtBZI
   A==;
X-CSE-ConnectionGUID: qLYlJJ5hRY2OT37QjG851w==
X-CSE-MsgGUID: VGL6EGHbSomlHOv1YMU9pQ==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="135337522"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:27:49 +0800
IronPort-SDR: 69255a75_oa+vLNDd6eam5X4/woC2u8iNpba20Sq1MYbxKalAVQnA1lI
 g07CHaAEklAeGHnFPk8Gofcu+tOI7/XGxxp8aPg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:27:50 -0800
WDCIronportException: Internal
Received: from ft4m3x2.ad.shared (HELO neo.wdc.com) ([10.224.28.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2025 23:27:47 -0800
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
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 04/20] blktrace: change size of action to 64 bits
Date: Tue, 25 Nov 2025 08:27:14 +0100
Message-ID: <20251125072730.39196-5-johannes.thumshirn@wdc.com>
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

In order to add the zoned commands to blktrace's actions, the storage size
needs to be increased to 64bits.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 act_mask.c     |  4 ++--
 blkparse.c     |  2 +-
 blkparse_fmt.c | 15 ++++++++-------
 blkrawverify.c | 10 +++++-----
 blktrace.h     |  2 +-
 5 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/act_mask.c b/act_mask.c
index 8f1b8d7..510c7e0 100644
--- a/act_mask.c
+++ b/act_mask.c
@@ -42,7 +42,7 @@ int find_mask_map(char *string)
 	return -1;
 }
 
-int valid_act_opt(int x)
+unsigned long long valid_act_opt(unsigned long long x)
 {
-	return (1 <= x) && (x < (1 << BLK_TC_SHIFT));
+	return (1ull <= x) && (x < (1ull << BLK_TC_SHIFT));
 }
diff --git a/blkparse.c b/blkparse.c
index 3f4d827..512a2d2 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -299,7 +299,7 @@ static int per_device_and_cpu_stats = 1;
 static int track_ios;
 static int ppi_hash_by_pid = 1;
 static int verbose;
-static unsigned int act_mask = -1U;
+static unsigned long long act_mask = -1U;
 static int stats_printed;
 static int bin_output_msgs = 1;
 int data_is_native = -1;
diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 9b83d1d..02c5a3c 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -8,6 +8,7 @@
 #include <unistd.h>
 #include <ctype.h>
 #include <time.h>
+#include <stdbool.h>
 
 #include "blktrace.h"
 
@@ -52,13 +53,13 @@ int add_format_spec(char *option)
 
 static inline void fill_rwbs(char *rwbs, struct blk_io_trace *t)
 {
-	int w = t->action & BLK_TC_ACT(BLK_TC_WRITE);
-	int a = t->action & BLK_TC_ACT(BLK_TC_AHEAD);
-	int s = t->action & BLK_TC_ACT(BLK_TC_SYNC);
-	int m = t->action & BLK_TC_ACT(BLK_TC_META);
-	int d = t->action & BLK_TC_ACT(BLK_TC_DISCARD);
-	int f = t->action & BLK_TC_ACT(BLK_TC_FLUSH);
-	int u = t->action & BLK_TC_ACT(BLK_TC_FUA);
+	bool w = !!(t->action & BLK_TC_ACT(BLK_TC_WRITE));
+	bool a = !!(t->action & BLK_TC_ACT(BLK_TC_AHEAD));
+	bool s = !!(t->action & BLK_TC_ACT(BLK_TC_SYNC));
+	bool m = !!(t->action & BLK_TC_ACT(BLK_TC_META));
+	bool d = !!(t->action & BLK_TC_ACT(BLK_TC_DISCARD));
+	bool f = !!(t->action & BLK_TC_ACT(BLK_TC_FLUSH));
+	bool u = !!(t->action & BLK_TC_ACT(BLK_TC_FUA));
 	int i = 0;
 
 	if (f)
diff --git a/blkrawverify.c b/blkrawverify.c
index ed5d258..9c5d595 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -55,7 +55,7 @@ static struct trace_info traces[] = {
 #define N_TRACES (sizeof(traces) / sizeof(struct trace_info))
 
 struct act_info {
-	__u32 val;
+	__u64 val;
 	char *string;
 };
 
@@ -80,12 +80,12 @@ static struct act_info acts[] = {
 };
 #define N_ACTS (sizeof(acts) / sizeof(struct act_info))
 
-static char *act_to_str(__u32 action)
+static char *act_to_str(__u64 action)
 {
 	static char buf[1024];
 	unsigned int i;
-	unsigned int act = action & 0xffff;
-	unsigned int trace = (action >> BLK_TC_SHIFT) & 0xffff;
+	unsigned long long act = action & 0xffffffff;
+	unsigned long long trace = (action >> BLK_TC_SHIFT) & 0xffffffff;
 
 	if (act < N_ACTS) {
 		sprintf(buf, "%s ", acts[act].string);
@@ -97,7 +97,7 @@ static char *act_to_str(__u32 action)
 			}
 	}
 	else
-		sprintf(buf, "Invalid action=%08x", action);
+		sprintf(buf, "Invalid action=%016llx", action);
 
 	return buf;
 }
diff --git a/blktrace.h b/blktrace.h
index 944fc08..74dfb48 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -144,7 +144,7 @@ extern void set_all_format_specs(char *);
 extern int add_format_spec(char *);
 extern void process_fmt(char *, struct per_cpu_info *, struct blk_io_trace *,
 			unsigned long long, int, unsigned char *);
-extern int valid_act_opt(int);
+extern unsigned long long valid_act_opt(unsigned long long);
 extern int find_mask_map(char *);
 extern char *find_process_name(pid_t);
 
-- 
2.51.1

