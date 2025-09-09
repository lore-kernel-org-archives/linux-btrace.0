Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E23314AD;
	Tue,  9 Sep 2025 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416070; cv=none; b=fJV0T119gYE34+Vn1yOBd5zNGBlewdStPhSBKZGhpl2J3vP2zS8mifl4eFrXvnFhss+/tTwWgU1VpzmSWtFM+AAk+qgqjLzHlukrh4/XNM3NKSDDWEzbQ7OtXqIX2AMFVHiB+4UmjieMehA1Hwc90QTDGLRIt0BbZpypLyYXxNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416070; c=relaxed/simple;
	bh=OaOG6CBFbCFh/f58UIDgubm2vvZ/Pg+y292vRg7wo5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o7YfO4e5wXfhUrE5/HoQzjteth1gKuU1eZa3YeP3rdoE8sMNa7bV5hxS6lX7Mg7Bb4sDeBYe5oW2PZnZ/9vER4+U2yUyaDTXDdmPz682fKHcXk7tgUhmK/W+W7OT4WHM0vvZ0TveDcgZbK/e1SM8QxCke5MTgeKo870h9FUMXcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JQ1ew2Bz; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JQ1ew2Bz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416068; x=1788952068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OaOG6CBFbCFh/f58UIDgubm2vvZ/Pg+y292vRg7wo5M=;
  b=JQ1ew2Bzv3eE3IZOE+U+hiMSGUUBxt1skz1gnmUU9CRPhqklvcqqFYrl
   wq6aGv1BT22Ec1JDEDH6j/86iFG6CIVPMU37GpdIa6NJa5Dyset506nt+
   yhuuUG9XyWIzoS7SRMLbFBw3bb17HyAiH47SgkNXD1FFCzT+rc6IwA5Gx
   SRkUOyMO+nKQdoUi987zaMPA63pCMN3pwXhvnY8QQgWYR6C45pPWDv/6h
   fSvpyr0VcjOs4e73ZlHqVt+A4eQrzK+/gddVsBBZ5y0f/Xr5550hSUKwt
   ZtX4zTntaA4iuz2TPlZ/mhEqo8pBEZfFE/EsYRSoS2bNyONb5ITm6mHHb
   A==;
X-CSE-ConnectionGUID: deJVU8bFQAiBG9ds8T07gg==
X-CSE-MsgGUID: Blrt4vuXSridT8rhvwJYGg==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810605"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:07:48 +0800
IronPort-SDR: 68c00a84_Zy2TWmxepq9cw6DKKKzdD8vQdzIC5GX5JzTAistQWX2auaU
 OkGlQ3zMWgRT5oFsV1A/K5qF471ss69Dqha+j6A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:07:48 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:07:44 -0700
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
Subject: [PATCH 04/21] blktrace: change size of action to 64 bits
Date: Tue,  9 Sep 2025 13:07:06 +0200
Message-Id: <20250909110723.75676-5-johannes.thumshirn@wdc.com>
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

In order to add the zoned commands to blktrace's actions, the storage size
needs to be increased to 64bits.

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
index d6aaa8b..c720af6 100644
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

