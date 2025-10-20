Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482AB320CC9;
	Mon, 20 Oct 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967762; cv=none; b=dT7CEgFYty41L1ZbxqtDWGwW1WM+NO2TlxkIOwJ2zbjzD+6zagUQrxb66W6CyorATNY2kNuzix9f/1s3JPV9AAcFEd7HQ7pMKeD+XsEoXmkbOSGEDhjICZRIB/8q5IMat5S6IuIroXCn600lIV+QjcF7i8SBsMfXD/N3qFM5CFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967762; c=relaxed/simple;
	bh=NYIcWPB3HB87TMKzTL0Sak6CDFuBEJcCgrUOwcRT2ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsIByOcOw5HCNVAyBZBFZ6rZje64d6SNPSnHbWyydhep9TMiKLKY42oTjUFStKCrL63oepys5KHNhUwuc6O9M7W7AkFlNbnhiq2OZgg2fK03Eu6dqDCV95osJ3TMd0L4G1FopfZAEKcvW5huMwy9sOU6RsoTo0JlsDBrsUhCqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jlN+RZE9; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jlN+RZE9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760967762; x=1792503762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NYIcWPB3HB87TMKzTL0Sak6CDFuBEJcCgrUOwcRT2ss=;
  b=jlN+RZE9BDBd3mWVEhKUFyW//oYwVy/TmUczXOWBKHzoD5nrPf3uIKoQ
   oC1quyn9Wk2w+u93BoL9vK/yRBsEhDpF35jOnayZSLnljRReHWGzj3/fv
   07kfaUnAjWUKffRHRdruFzswFQIPlWCYQPCALLyBuP0NRC2WmH09ugZHF
   q2dwwnjtbjLl7DtUkfEXv5DhWKQnF1HyOdW3gcdtyDK3/7j6gI1wOQ5+g
   noKCligjOb+kk1GvnX8UchRNHcKXhgIkQACwoDXrJhBfyTh5QLhDAmon5
   YTy3n2JvR++3UL4cHPpIPID7s+8BW7JNBjR7Ewxwasmaf/EJUKJ4bs2yR
   A==;
X-CSE-ConnectionGUID: 3MUKF46ORVi4889FyiVJlg==
X-CSE-MsgGUID: jL2x8eHaSpOBPi37QVUnAg==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134518687"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 21:42:41 +0800
IronPort-SDR: 68f63c50_2OxoRKbsNO9+K43s5AxCyO2gry8KeD4uyHUV/lDBjW+sFS3
 aBDYdHzrpzU9sj1JMjF0IHc3DLtL9JEOR8ymuNA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2025 06:42:41 -0700
WDCIronportException: Internal
Received: from 1pgdl13.ad.shared (HELO neo.fritz.box) ([10.224.28.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Oct 2025 06:42:37 -0700
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
Subject: [PATCH v4 16/16] blktrace: handle BLKTRACESETUP2 ioctl
Date: Mon, 20 Oct 2025 15:41:23 +0200
Message-ID: <20251020134123.119058-17-johannes.thumshirn@wdc.com>
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

Handle the BLKTRACESETUP2 ioctl, requesting an extended version of the
blktrace protocol from user-space.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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
index 75994671d7ee..c4f0b84482ca 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -748,6 +748,38 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
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
@@ -838,6 +870,10 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
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

