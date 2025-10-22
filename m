Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675EA341665;
	Wed, 22 Oct 2025 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133322; cv=none; b=WeNxKLc6NLqruTUfz3QTXFWH8ZAPftqOQPdi5IjdLcG2djoTCx+iGdL+bTMU+ZTPUWSN901BzMYAHxC79EQGPUoPWzEM96ntgdavoARnB3p7mZu1/SdJ5TjRl9bDrlgbv2yqHeEOLrY5s5fKOXwjX09/PN65T38vySuLF9W3AhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133322; c=relaxed/simple;
	bh=CMWz8k5N389mFEAOrl+B0ZkalXYJ8znl0A0OMErx4Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6s5ojuTBvrypmEsWc4yg337nn+jTaC0nFv8rxx9m/lgKVx90OnD0dnS09v2IWFcF9Uo0gvLx9oSDBOe3szR1et0/8k5/AAaUmOLfc1xuRpTZS3ek43sSaLH91WwakfyN4UJzQm5y8Q63FLgFz5BVJr+RGjHCeCG/x5U8MjLbzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kRGizCFY; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kRGizCFY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761133320; x=1792669320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CMWz8k5N389mFEAOrl+B0ZkalXYJ8znl0A0OMErx4Wo=;
  b=kRGizCFYPVw50J+T/HE4U/ZJ0Cwjiwk1QIEabv9FcYWl+JHcup65fEIe
   WXMJJha7Az5Re+iZ/kzZWVhguMLAwGh3Hm0PphgICXY/AnkWv+9gd1d7T
   0g1bNy5IhZ26PqiiBPqQ6MTaUfffKY/AizZrdrrXtxss87zX95gBE9ozC
   lDLvwCq/cDAR76xKyWlnX+Q6RcL8zzl0fvWDyPyHsPLLuaxRwC1b80Uur
   Bhtep0haDQdkx0BTcBZ6q2CVCHJXJ/XOigsL9dw2XoJHTy/QkOUnoErE3
   UpKnlFqMdtRJOZCCRqTgrSQ/cFM3Hy4HsAcx8p98716MM9s6xR891RdK4
   g==;
X-CSE-ConnectionGUID: OAGcVelvRZOmExYvAxXuvQ==
X-CSE-MsgGUID: Dks3DyA1SkeXodDH0wETCg==
X-IronPort-AV: E=Sophos;i="6.19,247,1754928000"; 
   d="scan'208";a="133361431"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 19:42:00 +0800
IronPort-SDR: 68f8c308_cQO1Mf9y23lFoPdXlkckSWnEVK8WMLwvv3flBdlBNoNNcTT
 nkNbKMxHf/5AL2MK3lAwNXFYS1Qe6eJAmBQDzJg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 04:42:00 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 04:41:56 -0700
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
Subject: [PATCH v5 06/16] blktrace: split do_blk_trace_setup into two functions
Date: Wed, 22 Oct 2025 13:41:05 +0200
Message-ID: <20251022114115.213865-7-johannes.thumshirn@wdc.com>
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

Split do_blk_trace_setup into two functions, this is done to prepare for
an incoming new BLKTRACESETUP2 ioctl(2) which can receive extended
parameters from user-space.

Also move the size verification logic to the callers in preparation for
using a new internal structure later.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 94 ++++++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 38 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 15d6788700ca..df90422ae613 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -518,9 +518,10 @@ static void blk_trace_setup_lba(struct blk_trace *bt,
 /*
  * Setup everything required to start tracing
  */
-static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
-			      struct block_device *bdev,
-			      struct blk_user_trace_setup *buts)
+static struct blk_trace *blk_trace_setup_prepare(struct request_queue *q,
+						 char *name, dev_t dev,
+						 u32 buf_size, u32 buf_nr,
+						 struct block_device *bdev)
 {
 	struct blk_trace *bt = NULL;
 	struct dentry *dir = NULL;
@@ -528,31 +529,19 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	lockdep_assert_held(&q->debugfs_mutex);
 
-	if (!buts->buf_size || !buts->buf_nr)
-		return -EINVAL;
-
-	strscpy_pad(buts->name, name, BLKTRACE_BDEV_SIZE);
-
-	/*
-	 * some device names have larger paths - convert the slashes
-	 * to underscores for this to work as expected
-	 */
-	strreplace(buts->name, '/', '_');
-
 	/*
 	 * bdev can be NULL, as with scsi-generic, this is a helpful as
 	 * we can be.
 	 */
 	if (rcu_dereference_protected(q->blk_trace,
 				      lockdep_is_held(&q->debugfs_mutex))) {
-		pr_warn("Concurrent blktraces are not allowed on %s\n",
-			buts->name);
-		return -EBUSY;
+		pr_warn("Concurrent blktraces are not allowed on %s\n", name);
+		return ERR_PTR(-EBUSY);
 	}
 
 	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
 	if (!bt)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	ret = -ENOMEM;
 	bt->sequence = alloc_percpu(unsigned long);
@@ -572,7 +561,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (bdev && !bdev_is_partition(bdev))
 		dir = q->debugfs_dir;
 	else
-		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
+		bt->dir = dir = debugfs_create_dir(name, blk_debugfs_root);
 
 	/*
 	 * As blktrace relies on debugfs for its interface the debugfs directory
@@ -580,8 +569,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	 * files or directories.
 	 */
 	if (IS_ERR_OR_NULL(dir)) {
-		pr_warn("debugfs_dir not present for %s so skipping\n",
-			buts->name);
+		pr_warn("debugfs_dir not present for %s so skipping\n", name);
 		ret = -ENOENT;
 		goto err;
 	}
@@ -593,17 +581,38 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	debugfs_create_file("dropped", 0444, dir, bt, &blk_dropped_fops);
 	debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
 
-	bt->rchan = relay_open("trace", dir, buts->buf_size,
-				buts->buf_nr, &blk_relay_callbacks, bt);
+	bt->rchan = relay_open("trace", dir, buf_size, buf_nr,
+			       &blk_relay_callbacks, bt);
 	if (!bt->rchan)
 		goto err;
 
+	blk_trace_setup_lba(bt, bdev);
+
+	return bt;
+
+err:
+	blk_trace_free(q, bt);
+
+	return ERR_PTR(ret);
+}
+
+static void blk_trace_setup_finalize(struct request_queue *q,
+				     char *name, struct blk_trace *bt,
+				     struct blk_user_trace_setup *buts)
+
+{
+	strscpy_pad(buts->name, name, BLKTRACE_BDEV_SIZE);
+
+	/*
+	 * some device names have larger paths - convert the slashes
+	 * to underscores for this to work as expected
+	 */
+	strreplace(buts->name, '/', '_');
+
 	bt->act_mask = buts->act_mask;
 	if (!bt->act_mask)
 		bt->act_mask = (u16) -1;
 
-	blk_trace_setup_lba(bt, bdev);
-
 	/* overwrite with user settings */
 	if (buts->start_lba)
 		bt->start_lba = buts->start_lba;
@@ -615,12 +624,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	rcu_assign_pointer(q->blk_trace, bt);
 	get_probe_ref();
-
-	ret = 0;
-err:
-	if (ret)
-		blk_trace_free(q, bt);
-	return ret;
 }
 
 int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
@@ -628,17 +631,25 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		    char __user *arg)
 {
 	struct blk_user_trace_setup buts;
+	struct blk_trace *bt;
 	int ret;
 
 	ret = copy_from_user(&buts, arg, sizeof(buts));
 	if (ret)
 		return -EFAULT;
 
+	if (!buts.buf_size || !buts.buf_nr)
+		return -EINVAL;
+
 	mutex_lock(&q->debugfs_mutex);
-	ret = do_blk_trace_setup(q, name, dev, bdev, &buts);
+	bt = blk_trace_setup_prepare(q, name, dev, buts.buf_size, buts.buf_nr,
+				     bdev);
+	if (IS_ERR(bt)) {
+		mutex_unlock(&q->debugfs_mutex);
+		return PTR_ERR(bt);
+	}
+	blk_trace_setup_finalize(q, name, bt, &buts);
 	mutex_unlock(&q->debugfs_mutex);
-	if (ret)
-		return ret;
 
 	if (copy_to_user(arg, &buts, sizeof(buts))) {
 		blk_trace_remove(q);
@@ -655,11 +666,14 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 {
 	struct blk_user_trace_setup buts;
 	struct compat_blk_user_trace_setup cbuts;
-	int ret;
+	struct blk_trace *bt;
 
 	if (copy_from_user(&cbuts, arg, sizeof(cbuts)))
 		return -EFAULT;
 
+	if (!cbuts.buf_size || !cbuts.buf_nr)
+		return -EINVAL;
+
 	buts = (struct blk_user_trace_setup) {
 		.act_mask = cbuts.act_mask,
 		.buf_size = cbuts.buf_size,
@@ -670,10 +684,14 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 	};
 
 	mutex_lock(&q->debugfs_mutex);
-	ret = do_blk_trace_setup(q, name, dev, bdev, &buts);
+	bt = blk_trace_setup_prepare(q, name, dev, buts.buf_size, buts.buf_nr,
+				     bdev);
+	if (IS_ERR(bt)) {
+		mutex_unlock(&q->debugfs_mutex);
+		return PTR_ERR(bt);
+	}
+	blk_trace_setup_finalize(q, name, bt, &buts);
 	mutex_unlock(&q->debugfs_mutex);
-	if (ret)
-		return ret;
 
 	if (copy_to_user(arg, &buts.name, ARRAY_SIZE(buts.name))) {
 		blk_trace_remove(q);
-- 
2.51.0

