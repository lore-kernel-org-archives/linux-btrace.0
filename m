Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD442E8B75;
	Mon, 24 Nov 2025 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969882; cv=none; b=Ti7BpjwpB5YsgBMx35rNW+GRqwL3q1mDieSRRQfjWMOxlanNv17eSrn/NqhdJdt6VEM3nAHjV/0J4981aXoOqCHfdjWjyYxaZzRBBRLQYYe7P6ptOb5/yT6EiVko+9Ps1eqhmpNe/GiE5EZPQHxX+pR8aNYD6BsX6X3GmUv8LXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969882; c=relaxed/simple;
	bh=KoMUeiWewTGss5zqSMLGrUVVwjV9lDGVRiRUMVMFg1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeFFkuzqztNofXNSHfqQs/DPJypn06n9uJ+drERojxemYh4nAn3J8KNDE5g2z0Nfz1khMM70ar9uZs13ZeJlXNE+x38s9BnuAq4BMHTwNczo6MT3csEtLM2k6MPyZV0yZaix7P5ntaQb5r1Nj8WUz0Yy6Cmw698fw6UHkfWFBEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RsyKReOP; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RsyKReOP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763969881; x=1795505881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KoMUeiWewTGss5zqSMLGrUVVwjV9lDGVRiRUMVMFg1U=;
  b=RsyKReOPuuCgm+bzwBdPBttrozQL13uRjvLKNODfx2R5x7yslcPeKxnY
   0ySbmREiJ5xzXZTNLMLnbvNg1OAaPFBTdbEkvTr3Lak7jpV9egjxiUTUX
   gBdWiGF/wjzGo3fFzfgZrrx9MY9bBAfJAVdHhzfHSCT0sVCxbQF0zeTUH
   XlZXqT7L3EU9XAJ5TCcZoNCIFkDgqn3XZOX6UHApFffH0C97+AgEBXbsf
   nbtapUUJtH3/VVIqAs+g0oPyOfrau8d2Pc/ebRQr8e3Tb9jNkBUqEmuiJ
   rV4WPkxLpHeJ924TyxQ+UokcNFaKeJvSD/+H6DoLmdjKM2Y8aHbJ+kFln
   w==;
X-CSE-ConnectionGUID: n3MATPNfTUWEKAh/8y4umA==
X-CSE-MsgGUID: ZWIPrOtVS66VG5pfm1P6eA==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132619330"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2025 15:38:00 +0800
IronPort-SDR: 69240b58_vjRO6R1O8yYNLHUPi22t2CwgjH8JCEizgUJVvfxg8hMRyLE
 Rhtn78oK6jA7sKTzMmUA3zGQlNY8TA40NQtmlEg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2025 23:38:01 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2025 23:37:58 -0800
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
Subject: [RESEND PATCH blktrace v3 04/20] blktrace: change size of action to 64 bits
Date: Mon, 24 Nov 2025 08:37:23 +0100
Message-ID: <20251124073739.513212-5-johannes.thumshirn@wdc.com>
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

