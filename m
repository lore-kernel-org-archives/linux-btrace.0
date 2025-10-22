Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C733FE2E;
	Wed, 22 Oct 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133336; cv=none; b=sErDKJHhNYSIxwv/mm8PENRAH5hObBZBJ9gVMyaqeOpAMm5SiT8iiLDD9rx22mc5MEDi8iIRWcW0XmYlI6I3d9ecku28QC8Gnls1SCKTPTOLn8RSgC3SAEKhAXYkWySYTLjFZmlveRk8wcdsXSvGtqzW4nPCTCqYqdFTYv7vJ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133336; c=relaxed/simple;
	bh=168ia+hdpRO/sFAwkDBCIsxq3ROnt6Lp/jc2ZZmovJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrjtyX53YlfBlq3HU7QDzw/nAYLCyEsKiQFsrjW1lzkscmFmlpOMdIbHgHoYDu5S6WdETYdeWKXQmJE8TYCNqNkfIA+V1oE9r9Y4Dzo4J2INESF3smOon1WvQ1cLXgUq935bjcezDAyJHCLjPXC0ym5WOaZKpyiqPk5C+Z6tnJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oBwTlm3/; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oBwTlm3/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761133334; x=1792669334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=168ia+hdpRO/sFAwkDBCIsxq3ROnt6Lp/jc2ZZmovJ8=;
  b=oBwTlm3/Mq6+RW9AYMDb5ClmmFdGKOEvcbb8AVmEhYsaLg4KYG6tLTwo
   7J80AUye9STR7dZdSQpBTGXWsTT7GkhpwSmRYrvOZuDSCnjHBMGuCl8A5
   4DAY3fBQJLDBsyQojaAe2wAYAwGNCFWWuN13BTK6/Pvx3a63/KpOPuExX
   kQN3DsDgApXVoBH56CSNZ5dQ9gdcndWyvsjjfpWa3Wz/LLEMTMhjDKxxc
   5pfJzG4yc54reJt2drYOLePJbAVfkwVZnAWzlEJ1Vm5aSM7MRGihSDVn0
   LIS6/6HHko2/dLDxP4nPrf9wVRkc51CegJj1LkJ+quBSav3gOHM8CrVw0
   g==;
X-CSE-ConnectionGUID: J8126GWaS026rNoRFxR2nA==
X-CSE-MsgGUID: VPSO+7GjT9qFeEqqYVIgtw==
X-IronPort-AV: E=Sophos;i="6.19,247,1754928000"; 
   d="scan'208";a="134941231"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 19:42:13 +0800
IronPort-SDR: 68f8c315_HAab86HSQTie9NFQKxWzlNtGwOZQOl9+SVhCrAyeHWmWwgD
 sADrW9HRUGpvcQpv4WiF8f5eIFYm8nUo7GEvuWA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 04:42:14 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 04:42:07 -0700
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
Subject: [PATCH v5 08/16] blktrace: pass blk_user_trace2 to setup functions
Date: Wed, 22 Oct 2025 13:41:07 +0200
Message-ID: <20251022114115.213865-9-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
References: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass struct blk_user_trace_setup2 to blktrace_setup_finalize(). This
prepares for the incoming extension of the blktrace protocol with a 64bit
act_mask.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/blktrace_api.h |  3 ++-
 kernel/trace/blktrace.c      | 31 ++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 122c62e561fc..05c8754456aa 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -14,11 +14,12 @@
 #include <linux/sysfs.h>
 
 struct blk_trace {
+	int version;
 	int trace_state;
 	struct rchan *rchan;
 	unsigned long __percpu *sequence;
 	unsigned char __percpu *msg_data;
-	u16 act_mask;
+	u64 act_mask;
 	u64 start_lba;
 	u64 end_lba;
 	u32 pid;
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index c31b8f433116..d1532df84cc8 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -597,11 +597,12 @@ static struct blk_trace *blk_trace_setup_prepare(struct request_queue *q,
 }
 
 static void blk_trace_setup_finalize(struct request_queue *q,
-				     char *name, struct blk_trace *bt,
-				     struct blk_user_trace_setup *buts)
+				     char *name, int version,
+				     struct blk_trace *bt,
+				     struct blk_user_trace_setup2 *buts)
 
 {
-	strscpy_pad(buts->name, name, BLKTRACE_BDEV_SIZE);
+	strscpy_pad(buts->name, name, BLKTRACE_BDEV_SIZE2);
 
 	/*
 	 * some device names have larger paths - convert the slashes
@@ -609,6 +610,7 @@ static void blk_trace_setup_finalize(struct request_queue *q,
 	 */
 	strreplace(buts->name, '/', '_');
 
+	bt->version = version;
 	bt->act_mask = buts->act_mask;
 	if (!bt->act_mask)
 		bt->act_mask = (u16) -1;
@@ -630,6 +632,7 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		    struct block_device *bdev,
 		    char __user *arg)
 {
+	struct blk_user_trace_setup2 buts2;
 	struct blk_user_trace_setup buts;
 	struct blk_trace *bt;
 	int ret;
@@ -641,6 +644,15 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!buts.buf_size || !buts.buf_nr)
 		return -EINVAL;
 
+	buts2 = (struct blk_user_trace_setup2) {
+		.act_mask = buts.act_mask,
+		.buf_size = buts.buf_size,
+		.buf_nr = buts.buf_nr,
+		.start_lba = buts.start_lba,
+		.end_lba = buts.end_lba,
+		.pid = buts.pid,
+	};
+
 	mutex_lock(&q->debugfs_mutex);
 	bt = blk_trace_setup_prepare(q, name, dev, buts.buf_size, buts.buf_nr,
 				     bdev);
@@ -648,7 +660,8 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		mutex_unlock(&q->debugfs_mutex);
 		return PTR_ERR(bt);
 	}
-	blk_trace_setup_finalize(q, name, bt, &buts);
+	blk_trace_setup_finalize(q, name, 1, bt, &buts2);
+	strcpy(buts.name, buts2.name);
 	mutex_unlock(&q->debugfs_mutex);
 
 	if (copy_to_user(arg, &buts, sizeof(buts))) {
@@ -664,7 +677,7 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 				  dev_t dev, struct block_device *bdev,
 				  char __user *arg)
 {
-	struct blk_user_trace_setup buts;
+	struct blk_user_trace_setup2 buts2;
 	struct compat_blk_user_trace_setup cbuts;
 	struct blk_trace *bt;
 
@@ -674,7 +687,7 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 	if (!cbuts.buf_size || !cbuts.buf_nr)
 		return -EINVAL;
 
-	buts = (struct blk_user_trace_setup) {
+	buts2 = (struct blk_user_trace_setup2) {
 		.act_mask = cbuts.act_mask,
 		.buf_size = cbuts.buf_size,
 		.buf_nr = cbuts.buf_nr,
@@ -684,16 +697,16 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 	};
 
 	mutex_lock(&q->debugfs_mutex);
-	bt = blk_trace_setup_prepare(q, name, dev, buts.buf_size, buts.buf_nr,
+	bt = blk_trace_setup_prepare(q, name, dev, buts2.buf_size, buts2.buf_nr,
 				     bdev);
 	if (IS_ERR(bt)) {
 		mutex_unlock(&q->debugfs_mutex);
 		return PTR_ERR(bt);
 	}
-	blk_trace_setup_finalize(q, name, bt, &buts);
+	blk_trace_setup_finalize(q, name, 1, bt, &buts2);
 	mutex_unlock(&q->debugfs_mutex);
 
-	if (copy_to_user(arg, &buts.name, ARRAY_SIZE(buts.name))) {
+	if (copy_to_user(arg, &buts2.name, ARRAY_SIZE(buts2.name))) {
 		blk_trace_remove(q);
 		return -EFAULT;
 	}
-- 
2.51.0

