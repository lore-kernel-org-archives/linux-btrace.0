Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92FA320A26;
	Wed, 15 Oct 2025 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525846; cv=none; b=Zr7K5HllXFmTm8EiNapT/Z1ZGHPQnD5LmB+5T2X4nX3zjWHuj3mEPLOiwMlQIn3BVl6kg3kmXXLLn/cedQVEe2j4ir4p0Dn54kmVJOOSmiQ+izD2+HIIkLhG79R4QOyl22TZoaUBSW0LXL3yCM0uVeQoRLD0JW2M5T8NOKtaBqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525846; c=relaxed/simple;
	bh=KoMUeiWewTGss5zqSMLGrUVVwjV9lDGVRiRUMVMFg1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0gO/8xinD9BCZaE1KiVayfUzWJ1Ph1ZS4Gq/m/526mW9LjOmbZIAg4djV9kjRmG0cd9FZe4Z6w7uoa85RtZakPUH9JOk+SXRIyjOk4Gnv2o24l0HwGMe39lab1bKAEvCnx7yrBG1NKQXZ8MwRhyrQBMGP89wtUN/b6LDj7fL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fF6R+ayt; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fF6R+ayt"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525844; x=1792061844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KoMUeiWewTGss5zqSMLGrUVVwjV9lDGVRiRUMVMFg1U=;
  b=fF6R+aytSnS2tuVBlAMabmYcJxzDuj2pyTqfypPBijD50lKpIWUQpQFK
   9UEN1LCies8Xk0uQ9+CJ6xsGyolL8ahCFT9RlM3wHUS3azCpnjfe7XTEE
   gn7RBlLZSg5kdEl0WEfMfBLdfAF/Pmexkh7zA13HYaWvWS4fKT9XNYWz2
   saZmGCsrEHy6PkquayQxgaMxK7JiySQcOcLwlZiA9Qf5q/Axf6WxxO/Bc
   5CWotMKLRmkijy0iE8NO75tCSelujUodzHt6/wYhr62WG1pZqAquauCbP
   aio/aALfx153XE173zyyFoCpE25gZk101eIXTAogr8jZze9p90hSVdP6J
   w==;
X-CSE-ConnectionGUID: /KH18UNaRFe7YBQPCKPyDA==
X-CSE-MsgGUID: ib/2/nu+Q8Ok9ORTYd0ROA==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935356"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:57:24 +0800
IronPort-SDR: 68ef7e14_M3yr0xQFa0PtoSyKw4xOQAVW9o48ZCT8ZodX0P8NVNzm9u+
 QdPsuL5gS4EL67hGDlXnn+kDCaBNUTKF0qlZsfg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:57:24 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:57:21 -0700
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
Subject: [PATCH blktrace v3 04/20] blktrace: change size of action to 64 bits
Date: Wed, 15 Oct 2025 12:56:42 +0200
Message-ID: <20251015105658.527262-5-johannes.thumshirn@wdc.com>
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

In order to add the zoned commands to blktrace's actions, the storage size
needs to be increased to 64bits.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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
2.51.0

