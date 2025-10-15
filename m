Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A35D32143E;
	Wed, 15 Oct 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525766; cv=none; b=PtlBEssLeFNRAqRjSvL2VEyPbK94YCP41EIxxpoJBvb+A3aEC38zdjsRmPyATKW83EPRdCX+CCYB0M7ahqnlx5nc64rK+LlfZNYnsMhcOJtQXebF/6o2qNkfDfdVwUziDqkzi9NdyRDDq4dCJOA+J/Et2Z3L+W0TdLX10t9398M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525766; c=relaxed/simple;
	bh=rNATSFNMRVLFKBzFHs5H8bpHJoxzyUIh0tKWv5JZntc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4WlUW54fMw6CIDtQXquSbQbvzCNy3hftaXA86BZbPaBY44TNY3Xfm9ls+kT9fw1vCSmrvQEo+uP0W8OrlN2LJkJMvu783dqrabM1iHEfpZbp2dayrbyJvnvez8RQlO3H0mX90er06lfMKkRhsLfOMf/KgoJ07ZWOhyMTgncrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Xyhtw8ww; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xyhtw8ww"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525764; x=1792061764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rNATSFNMRVLFKBzFHs5H8bpHJoxzyUIh0tKWv5JZntc=;
  b=Xyhtw8wwGg6nVYrs5w/VSNMXtdEtbcW1CJRzrwDMtkCAc/xKvekVZZXT
   v482LDDFboZjsBerHHsYW5EMDAyNmVUYnsoGrA9XdbEdl9PWJCF54C9mN
   cRMTjfmY8fiDtyGvoM7Os4iJ1LcMlXWWhfcJ6/42AKq5kvIx6aRi2RcYJ
   kHP37gHPdTM7Lp9V+Ex9xOAEZYSOS9anc3GSTKTlYOTdopglj4m3FO9R6
   0nbEA3fU1VOc8BumRNaygkZNzZ0wbApwbzLi6004d4ov4A4/HAOrJynTc
   tcLCYIqF/Af3rkJ40cFOJ30CxWlpddUbxa4WXhCs+jfczKQgEvdB1D9tV
   g==;
X-CSE-ConnectionGUID: KKquLGYPQx+6KvhE4wOQRQ==
X-CSE-MsgGUID: Spo7XF/aRLqcPcMYgE0oxw==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="133262139"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:56:04 +0800
IronPort-SDR: 68ef7dc4_JGxcOCP02J7+XAkiFffbHJwTdqX8EnAcZdP5aNDqkPzp1RB
 /30uFxkraDLtxEzKwWE+jySEfcWhCfuOtUt+AwA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:56:04 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:56:01 -0700
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
Subject: [PATCH v3 16/16] blktrace: handle BLKTRACESETUP2 ioctl
Date: Wed, 15 Oct 2025 12:54:35 +0200
Message-ID: <20251015105435.527088-17-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015105435.527088-1-johannes.thumshirn@wdc.com>
References: <20251015105435.527088-1-johannes.thumshirn@wdc.com>
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
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/ioctl.c           |  1 +
 kernel/trace/blktrace.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

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
index d659fed0650d..0719f9b76082 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -745,6 +745,37 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 }
 EXPORT_SYMBOL_GPL(blk_trace_setup);
 
+static int blk_trace_setup2(struct request_queue *q, char *name, dev_t dev,
+			    struct block_device *bdev, char __user *arg)
+{
+	struct blk_user_trace_setup2 buts2;
+	struct blk_trace *bt;
+	int ret;
+
+	ret = copy_from_user(&buts2, arg, sizeof(buts2));
+	if (ret)
+		return -EFAULT;
+
+	if (!buts2.buf_size || !buts2.buf_nr)
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
@@ -835,6 +866,10 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
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

