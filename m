Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689B32A3FF;
	Tue,  9 Sep 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416053; cv=none; b=RV4UHYvluizxPAiVyFPeBqp7HBLp5I9D+mLIB02AWSuzmhUF4LyDjIeN+QxcS7hNlQKJa9eK+cLo0QwfRz6obNACJ3BGzR1l2j50qeZ6KMPYiqsLyYRvV4yuraWINcIA+StrJ4pN50oGINsHyTCkYUd8SSz+PjYBGevc9/HFlro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416053; c=relaxed/simple;
	bh=L1r/8uxRlM/kp1r+xQYQKLRaeaIZcG+wTHH1zLo1dPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=baGgpJMNEAFiSn6/rT2VC48uchz2Lr1la9sV4OzbhDHtnSAHqAOdAe2VfpCdNZyrrXG7cJRrdtWWjB2iDS6Mk6ZVHtMpAV4Q11On7wYzkP+syw7glDcKom0KNnB2ehhe9Ibd2P29pV7xWYm7JUe3hPcfA4MkaLI4gjPuEyZuBMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BSSKVvD3; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BSSKVvD3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416052; x=1788952052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L1r/8uxRlM/kp1r+xQYQKLRaeaIZcG+wTHH1zLo1dPg=;
  b=BSSKVvD3bgWUaZJXlhBfnRdDvXPYdFXqPCjcOSW1fu0g+63+rS/klvSJ
   2IZzLX/sdqzzPyR16O3MdZc+foqjyv0XHeVfaMX/SBTsNt8x2hBveCOje
   TgCk3cllr2+B/QymgPfO5wsQ6lvhRu+cdx5hE9GBpb4vCJg1RcANVe4P4
   OJpeMPaWwrU/z5lEofpsD82VAadJwMvSGoSuS6P1z0KCQuOVyde+7H494
   vBMTHy+BIRYfi20mFw/utqH2RADtxtxoiHcfAI/E4M2vax5Std/ADVSOQ
   7YanslDibrs/ITWw2BRXYTOsrxBirKA5clzvTkPf+sEbHeJmPWN58WnzF
   w==;
X-CSE-ConnectionGUID: x3xD8wRbTliz9SXpduLUCg==
X-CSE-MsgGUID: QeMNkhffSuOi+4QBud7Qnw==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810311"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:07:31 +0800
IronPort-SDR: 68c00a73_h+NRTEx8IiwGfKL24sEiNYZUcelO5W7AB4BIzq42ezMBB0o
 q6KgDFSlRgG6TD570bsRJABHD/JDn/3381Gk5SQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:07:31 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:07:27 -0700
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
Subject: [PATCH 16/16] blktrace: handle BLKTRACESETUP2 ioctl
Date: Tue,  9 Sep 2025 13:06:11 +0200
Message-Id: <20250909110611.75559-17-johannes.thumshirn@wdc.com>
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

Handle the BLKTRACESETUP2 ioctl, requesting an extended version of the
blktrace protocol from user-space.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/ioctl.c           |  1 +
 kernel/trace/blktrace.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index f7b0006ca45d..e7f83a58c8ae 100644
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
index 3e7cd8f46c0c..e16a3dbed527 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -742,6 +742,38 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
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
+	bt->version = 2;
+	blk_trace_setup_finalize(q, name, bt, &buts2);
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
@@ -833,6 +865,10 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
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

