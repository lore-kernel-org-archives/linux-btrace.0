Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4233233F4;
	Mon, 20 Oct 2025 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967728; cv=none; b=u7RNU/QlJxCmm5VQUa8lCmW+j9ZFCF9Ex2Z5WBFRLrl0auwiQdB+/iZwdLcioLywvuKqxE0nDseN1sSRcuxkY4UiJoie/Podi4hzOSK186FNdh90QWbBHpTtgkYwxnVYFMyOmEhIVx0W5TjEt5LGTPgqS8aQzUohQnx8jhn9+BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967728; c=relaxed/simple;
	bh=R5PB1bbLFZ2JbMWYAnMJ4DTuf+ynX10cGzq4pq6nXpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+rviUo+8yWtQbVmaDAojY+CuxGLN5H6PJhjzJjS09XZaT2VyocbZqSLWe1v3sCY7xe99T9CfJOcZnsemQjtPgmpSJUyo3d1ROI7QZISjwVmVYa0gZGXwme4PKSr+X6voh+InlM0jRFSULp+fXjFtolygqWu82K5kWoy9cPLfKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=i7Gg78pp; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i7Gg78pp"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760967727; x=1792503727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R5PB1bbLFZ2JbMWYAnMJ4DTuf+ynX10cGzq4pq6nXpk=;
  b=i7Gg78pp+C0X22dXO8z7I07r6Nor6INyt8W1/ybJDnHM/pvRnwyjnZvV
   MX1b20YZfrUjf7savorw7HNjK8lkW7pQEyIrg4i1Rh2ONJo5CmbQYQTdd
   w26rvbdLpSTsq+4G/HSWmjJxXmA83aYQNQQn5PYS5VNvez1a3x5Lxaaww
   kfnnxVxoo4XuTo731gHTgWubcOGtgevmrSxO2eaZ8xPlj56Sdlb9Z+MEF
   2fHKIMGpBdzvRVdhiqaaimBUMiK2xnsCHD4GDEEjyMpa5bAdV2FBqraiA
   NohkKY5QJH7Ql3BqXq7UqpjA76U4+JFu50ZGZwSmIF4zmgTue8ob3+kGt
   A==;
X-CSE-ConnectionGUID: n0m2XdHRSn6DWK8v0QIMEg==
X-CSE-MsgGUID: drqEj5kdRP+TsAbodQ1EDw==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134518646"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 21:42:06 +0800
IronPort-SDR: 68f63c2e_4IJWXwFGzS1KW5zkNkx8CdRDVXCPRtrQpPf4j5xSEeIHxaB
 L8wtK5melpp6EEpC4zCTCY+PLjE2B8msiXMED2Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2025 06:42:06 -0700
WDCIronportException: Internal
Received: from 1pgdl13.ad.shared (HELO neo.fritz.box) ([10.224.28.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Oct 2025 06:42:02 -0700
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
Subject: [PATCH v4 08/16] blktrace: pass blk_user_trace2 to setup functions
Date: Mon, 20 Oct 2025 15:41:15 +0200
Message-ID: <20251020134123.119058-9-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
References: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
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

