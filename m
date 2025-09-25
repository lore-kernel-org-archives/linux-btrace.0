Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F322E2EF1;
	Thu, 25 Sep 2025 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812584; cv=none; b=oYHv6L1P0yQxWdpqFt6eFBmpcjx1VznPqo/9wKMq8smikVv7Yn0h0WI3oHdjkgYnXrM+5qnRzy6c9p44IZCgL+pX/nrCUrfcnDfoCcke9G3hlqrZJvFHkDR5lDfstJ9yGWdURIEHN8M2GkYdIJnnnI1z4lareeA8ePmc507A7dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812584; c=relaxed/simple;
	bh=dSPTV7shWs8QOyqDcRIgVOAEn91OVl4zHbuoP17n3qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBTxDhc64GzLVwaNHHoElXMGQ+1iLbKNG2/8AbSAEWxNl9BSJAABbe4mr66bCop0U8NM2ENxx3+OOjy3gMfi/WXXmhPR3Npq5waoFy8tJHMEo6TnS5KaYbUFQcAQghwbxiQGlicE6dgo3GCYrAia8w071m06FfvY2oq2h13ZcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mKU/klP0; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mKU/klP0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812582; x=1790348582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dSPTV7shWs8QOyqDcRIgVOAEn91OVl4zHbuoP17n3qQ=;
  b=mKU/klP06Uew2tgRkmBRDAXS3kFs2rPGqiA0ak93VgnT9M3BgovwdbJk
   +1zAbRADfs8VkHGRuxwp/2fYLDLRzbJseF4LrVj4dcMDryQiHfvxhfrRP
   9+YwG25oGaJGSP7dTVzPZmP0YVJ5loEQgf6UmrmScy6B8TQBVKdud2hYR
   8P9r5UWtHwebK+YuYMkPHSdBcBBVXjlp1l1ckyB4HKb9umgqVkW4eOJ3Y
   vnmUzxO89bvB9QslqomZleZyZCUaznDbNCy/b1LtNi+J9j2vFFj3rdQSS
   MEyYkVeoD/cgiQtBXQQw2WD0fgezdSQSmimp6J7GhL/54Iv88tJS8zGxu
   Q==;
X-CSE-ConnectionGUID: T3ZvBEkBQVWTi9kh3OrHJg==
X-CSE-MsgGUID: dLbDBkatSGmehTBkO4IPGQ==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130347848"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:03:02 +0800
IronPort-SDR: 68d559a6_Gf46M0zg3cml6UE16hW4GjXUfa1baQqRlCOKvtCUj8mGrR/
 hvX9IMd7H1Xpm7TObmp07kThdaFIE/vU1FR/2OA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:03:02 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:02:59 -0700
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
Subject: [PATCH v2 06/15] blktrace: split do_blk_trace_setup into two functions
Date: Thu, 25 Sep 2025 17:02:22 +0200
Message-ID: <20250925150231.67342-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
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

Also move the size verification logic to the callers.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 95 ++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 38 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 51c001e4981c..f6a41e9510f6 100644
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
@@ -593,17 +581,39 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
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
@@ -615,12 +625,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
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
@@ -628,17 +632,25 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
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
@@ -655,11 +667,14 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
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
@@ -670,10 +685,14 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
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

