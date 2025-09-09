Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DE3203BE;
	Tue,  9 Sep 2025 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415993; cv=none; b=U1qQEo/tnO3tfQ+XkSX+U7/tJMgW23KJgHMCOBBtVIZzRJ5ifrqaiClfpCx7+C5DWroD42/7LPvG7FfZMTTwdWnRr/ajUR7h5DKbfsxVcC2kQCWksS6C1WZmN76HHU07W3F/jF33rn0KLsTPbl8Ls0tB81+7rp5eCsRX3Ic0ZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415993; c=relaxed/simple;
	bh=HzysL1uoh3uD6F6WLzvJxD9tgkDObgbIpDWKS8Ugh2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NwGK79yVV9/Grp7eS2075kOByyEplhWAezVqMaiELALs0HF34mPj5yHMT5RcbeN6xarGCQ+3Xgi3OEa5XsD3NN92Wy71jMSWnv/d57AnomSe9cZead7Smn+UBJKlOZdpOTcakF0VP5lVQAFYtF4cfp0LPOPkrI0t6Ok1/PmhIOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eFmGkdrP; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eFmGkdrP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757415992; x=1788951992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HzysL1uoh3uD6F6WLzvJxD9tgkDObgbIpDWKS8Ugh2E=;
  b=eFmGkdrPNUV1fEEu8Du711hMjbc5tdnY0S2sPokPwPM5s0a+QSOJtWKg
   2aaw0CWeZWEa7AxuBBHL+8RhLYAUGwTW39erx5kfKhgBN8fwP4NWuQXtX
   6UUoUJ0z6/FvWIDvaJmoTKBGHTMIgDvFoZGadjAh3UOPTyJ2s4Xq1Ig6d
   QEiBrHRd9ZiQhj9d+OXl0V9pwAV8dV86kv7an8yW6gvX4ohVbnl+8OXSK
   uUKMrtYccyjIzPfLsbqEdt9UcyPMEbM2VF3TrBa8emNYFo41KY90YLvW3
   y5WnDdBTGaEUhZZvsZakplxIP2d8HVrY8O0Zh9kIM/BAVtyyE3fPoKPQU
   Q==;
X-CSE-ConnectionGUID: mjtCr5ZnRx+wxmw+R7EaIA==
X-CSE-MsgGUID: MUru3q9JSUC0CRNohJuZcA==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112809869"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:06:25 +0800
IronPort-SDR: 68c00a31_74gRUzFskXdv+0ZPfFEQHvUt2T6+hRSgiE2n8uu/7H5mq19
 LOeP439GyEhWrPBJqc3ngGQ0Pv8y8CzDp0tyPNg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:06:25 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:06:21 -0700
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
Subject: [PATCH 01/16] blktrace: split do_blk_trace_setup into two functions
Date: Tue,  9 Sep 2025 13:05:56 +0200
Message-Id: <20250909110611.75559-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909110611.75559-1-johannes.thumshirn@wdc.com>
References: <20250909110611.75559-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split do_blk_trace_setup into two functions, this is done to prepare for
an incoming new BLKTRACESETUP2 ioctl(2) which can receive extended
parameters form user-space.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 95 ++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 38 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 6941145b5058..487eabfaf70e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -494,9 +494,10 @@ static void blk_trace_setup_lba(struct blk_trace *bt,
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
@@ -504,31 +505,19 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
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
@@ -548,7 +537,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (bdev && !bdev_is_partition(bdev))
 		dir = q->debugfs_dir;
 	else
-		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
+		bt->dir = dir = debugfs_create_dir(name, blk_debugfs_root);
 
 	/*
 	 * As blktrace relies on debugfs for its interface the debugfs directory
@@ -556,8 +545,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	 * files or directories.
 	 */
 	if (IS_ERR_OR_NULL(dir)) {
-		pr_warn("debugfs_dir not present for %s so skipping\n",
-			buts->name);
+		pr_warn("debugfs_dir not present for %s so skipping\n", name);
 		ret = -ENOENT;
 		goto err;
 	}
@@ -569,17 +557,39 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
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
+	if (ret)
+		blk_trace_free(q, bt);
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
@@ -591,12 +601,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
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
@@ -604,17 +608,25 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
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
@@ -631,11 +643,14 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
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
@@ -646,10 +661,14 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
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

