Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9437345CA1;
	Wed, 22 Oct 2025 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133386; cv=none; b=lImxGnm5cANyzVgkXqN8God0g0U4QeBVC3JIail5+PQDxOQ5LAOxspEWAAfkQsk4HR0VG9PesiPiydtd/X9WE8QzWWbZwbz0ZoX7MdKY8hv5kBGYclR+zy4VC2pEFPk2I3+3+4YGgEA4NMVGFdhAtKDNdETx65IwqZybEP2O2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133386; c=relaxed/simple;
	bh=nuPM7Ims9XfiDccmx6xBBK0GR6s3US0OLE3P/QcDg8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4C3wHkWt2hp6fn+YUf56tbtl865s8oaagGTck3LmvMn3j+HSvQmCLt1ZwrfoixkQ4bt3FraTMxAszmm80xLV10Tv1xl64QNcJtIhiJbyIUr6ap4dD+9EqKCUA14f7n7QeAcbmhK9HwvOV2gwwgG8x4WAxAJO7BXawR8bs+5CfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nDtYjm93; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nDtYjm93"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761133385; x=1792669385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nuPM7Ims9XfiDccmx6xBBK0GR6s3US0OLE3P/QcDg8k=;
  b=nDtYjm93VotPlPhT3wqXMHWYGQRgKtAhaTK8nJBF+ZR4UptDiVms/HUB
   MJQsgNQ9agPy6ptQ9CKywndizOe1+dyI4/YOvWAMpXz0bjvbw675dLHdr
   0OWIuk6m3hNfgXYUWTJRncS0YLGNlbn9JOuBcHdsxrYwSErlfmjCjT0CZ
   07EKj/TqneJV8AiILj4ixjDGE5uhn5hfb/VqsM19UyBz1CHvLe8v+ITU1
   KGkL3fjGb2af41zO5/es7nVH3I0o5NJFgvweVfpTknwH3byU72tjt1/hK
   rZyH+8E/ZfiAgVtV+gRsUbdJoYh0/INu32ICYuTqVUCDdVlsXMEFINytP
   A==;
X-CSE-ConnectionGUID: gMo9gPvEQryJP+s2By3lWw==
X-CSE-MsgGUID: 0notKVw1QA+n7QTV6ixlzg==
X-IronPort-AV: E=Sophos;i="6.19,247,1754928000"; 
   d="scan'208";a="130696134"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 19:43:05 +0800
IronPort-SDR: 68f8c348_5Sf2xFUuJuRopBsy7lCYperkU2r40Juu9MuPn64eu8EBK5H
 8OoKuuGUh2QkALvPneSSg5AebWCaaLuvcBjyjeA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 04:43:04 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 04:42:59 -0700
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
Subject: [PATCH v5 16/16] blktrace: handle BLKTRACESETUP2 ioctl
Date: Wed, 22 Oct 2025 13:41:15 +0200
Message-ID: <20251022114115.213865-17-johannes.thumshirn@wdc.com>
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

Handle the BLKTRACESETUP2 ioctl, requesting an extended version of the
blktrace protocol from user-space.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/ioctl.c           |  1 +
 kernel/trace/blktrace.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index d7489a56b33c..3927ca4707d0 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -691,6 +691,7 @@ long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 
 	/* Incompatible alignment on i386 */
 	case BLKTRACESETUP:
+	case BLKTRACESETUP2:
 		return blk_trace_ioctl(bdev, cmd, argp);
 	default:
 		break;
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 6bfe1b36a1d3..6ad3807a5b73 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -749,6 +749,38 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 }
 EXPORT_SYMBOL_GPL(blk_trace_setup);
 
+static int blk_trace_setup2(struct request_queue *q, char *name, dev_t dev,
+			    struct block_device *bdev, char __user *arg)
+{
+	struct blk_user_trace_setup2 buts2;
+	struct blk_trace *bt;
+
+	if (copy_from_user(&buts2, arg, sizeof(buts2)))
+		return -EFAULT;
+
+	if (!buts2.buf_size || !buts2.buf_nr)
+		return -EINVAL;
+
+	if (buts2.flags != 0)
+		return -EINVAL;
+
+	mutex_lock(&q->debugfs_mutex);
+	bt = blk_trace_setup_prepare(q, name, dev, buts2.buf_size, buts2.buf_nr,
+				     bdev);
+	if (IS_ERR(bt)) {
+		mutex_unlock(&q->debugfs_mutex);
+		return PTR_ERR(bt);
+	}
+	blk_trace_setup_finalize(q, name, 2, bt, &buts2);
+	mutex_unlock(&q->debugfs_mutex);
+
+	if (copy_to_user(arg, &buts2, sizeof(buts2))) {
+		blk_trace_remove(q);
+		return -EFAULT;
+	}
+	return 0;
+}
+
 #if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
 static int compat_blk_trace_setup(struct request_queue *q, char *name,
 				  dev_t dev, struct block_device *bdev,
@@ -839,6 +871,10 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	char b[BDEVNAME_SIZE];
 
 	switch (cmd) {
+	case BLKTRACESETUP2:
+		snprintf(b, sizeof(b), "%pg", bdev);
+		ret = blk_trace_setup2(q, b, bdev->bd_dev, bdev, arg);
+		break;
 	case BLKTRACESETUP:
 		snprintf(b, sizeof(b), "%pg", bdev);
 		ret = blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
-- 
2.51.0

